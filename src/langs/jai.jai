highlight_jai_syntax :: (using buffer: *Buffer) {
    tokenizer: Tokenizer = ---;
    tokenizer.the_buffer = buffer;
    tokenizer.buf   = to_string(bytes);
    tokenizer.max_t = bytes.data + bytes.count;
    tokenizer.t     = bytes.data;

    color: Code_Color;

    // @Autoindent
    //array_reset_keeping_memory(*line_starts);
    //array_add(*line_starts, 0);  // first line
    //line_start_index := 0;
    current_indent_level : s8 = 0;
    is_new_line := false;

    while true {
        token := get_next_token(*tokenizer);
        if token.type == .eof break;

        // @Autoindent
        //while line_starts.count > line_start_index + 1 {
        //    line_start_index += 1;
        //    indent_level[line_starts[line_start_index] - 1] = current_indent_level;
        //    is_new_line = true;
        //}

        using tokenizer;

        // Maybe retroactively highlight a function
        is_dedent := false;
        if token.type == .punctuation {
            if token.punctuation == .l_paren {
                current_indent_level += 1;
                // Handle "func :: ("
                if prev.type == .identifier {
                    memset(colors.data + prev.start, xx Code_Color.FUNCTION, prev.len);
                }
                else if before_prev.type == .identifier && prev.type == .operation && prev.operation == .double_colon {
                    memset(colors.data + before_prev.start, xx Code_Color.FUNCTION, before_prev.len);
                }
            }
            else if token.punctuation == .l_brace || token.punctuation == .l_bracket {
                current_indent_level += 1;
            }
            else if token.punctuation == .r_brace || token.punctuation == .r_bracket || token.punctuation == .r_paren {
                is_dedent = true;
            }
        }
        else if token.type == .keyword {
            if token.keyword == .kw_inline {
                // Handle "func :: inline"
                if before_prev.type == .identifier && prev.type == .operation && prev.operation == .double_colon {
                    memset(colors.data + before_prev.start, xx Code_Color.FUNCTION, before_prev.len);
                    // @TODO next token should be l_paren, and should start scope
                }
            }
        }

        if is_dedent {
            current_indent_level -= 1;
            if current_indent_level < 0  current_indent_level = 0;
            //if is_new_line  indent_level[line_starts[line_start_index] - 1] = current_indent_level; @Autoindent
        }
        else {
            is_new_line = false;
        }

        // Remember last 2 tokens
        before_prev = prev;
        prev = token;

        color := COLOR_MAP[token.type];
        memset(colors.data + token.start, xx color, token.len);
    }

    // @Autoindent
    //array_add(*line_starts, cast(s32) bytes.count);  // last line
}

jai_is_keyword_which_can_braceless_indent :: (buffer: *Buffer, first_token_pos: s64, cursor_pos: s64) -> bool {
    assert(cursor_pos > first_token_pos);
    #run {
        // Check that the short-circuit assumptions we use below still hold
        assert(array_count_starts_with(KEYWORDS, "f") == 1);
        assert(array_count_starts_with(KEYWORDS, "w") == 1);
        assert(array_count_starts_with(KEYWORDS, "el") == 1);
        assert(array_count_starts_with(KEYWORDS, "th") == 1);
    }

    i := first_token_pos;
    length := cursor_pos - i;
    if buffer.colors[i] == xx Code_Color.KEYWORD {
        if length >= 2 && buffer.bytes[i] == #char "i" && buffer.bytes[i+1] == #char "f" && buffer.bytes[i+2] != #char "x" // if
        || length >= 3 && buffer.bytes[i] == #char "f" // for
        || length >= 5 && buffer.bytes[i] == #char "w" // while
            return true;
    }

    i = cursor_pos - 1;
    while i > first_token_pos && is_whitespace_char(buffer.bytes[i])
        i -= 1;

    if buffer.colors[i] == xx Code_Color.KEYWORD {
        while i > first_token_pos && buffer.colors[i - 1] == xx Code_Color.KEYWORD
            i -= 1;
        length = cursor_pos - i;
        return length >= 4 && buffer.bytes[i] == #char "e" && buffer.bytes[i+1] == #char "l" // else
            || length >= 4 && buffer.bytes[i] == #char "t" && buffer.bytes[i+1] == #char "h"; // then
    }

    return false;
}

jai_jump_to_definition :: (editor: *Editor, buffer: Buffer) {
    cursor := *editor.cursors[editor.main_cursor];

    // @TODO don't select, just get the word at the cursor
    select_word(buffer, cursor);
    selected_text := get_selected_string(cursor, buffer);

    /*
    pos, found := declaration_pos_for_word(buffer.file.full_path, cursor.pos, selected_text);
    print("% % %\n", line_col(cursor.pos), line_col(pos), found);
    if found {
        cursor.pos = pos;
        cursor.sel = pos + cast(s32)word.count;
        cursor.col_wanted = -1;
        editor.cursor_moved = .jumped;
    }
    */

    if selected_text && selected_text != to_string(finder.input.text) && offset_to_line(buffer, cursor.pos) == offset_to_line(buffer, cursor.sel) {
        definition := tprint("%:", selected_text);
        finder_open(definition);
    }

}

jai_parse_file :: (file_info: File_Info, files: *Table(string, []*Node) = null) {
    if !files  files = *jai_files;

    _, found := table_find(files, file_info.full_path);
    if found  return;

    parser : Parser(Node_Visit_Data);
    parser.user_data = .{
        files=files,
        file_info=file_info,
    };
    parser.node_visit = node_visit;
    parser.lexer = *create_lexer(read_entire_file(file_info.full_path), file_info.full_path);

    nodes: [..]*Node;

    table_set(*jai_files, file_info.full_path, nodes);

    while !end(parser.lexer) {
        node := parse(*parser, null);
        if !node continue;
        array_add(*nodes, node);
    }

    table_set(*jai_files, file_info.full_path, nodes);

    for file, path: jai_files {
        print("%:\n", path);
        for node: file
            print("%\n", node.*);
        print("\n");
    }
}


#scope_file


get_next_token :: (using tokenizer: *Tokenizer) -> Token {
    t = eat_white_space(t, max_t, tokenizer.the_buffer);

    token: Token;
    token.start = cast(s32) (t - buf.data);
    token.type  = .eof;
    if t >= max_t return token;

    start_t = t;

    // Assume ASCII, unless we're in the middle of a string.
    // UTF-8 characters elsewhere are a syntax error.
    char := << t;

    if is_alpha(char) || char == #char "_" {
        parse_identifier(tokenizer, *token);
    } else if is_digit(char) {
        parse_number(tokenizer, *token);
    } else if char == {
        case #char ":";  parse_colon             (tokenizer, *token);
        case #char "=";  parse_equal             (tokenizer, *token);
        case #char "-";  parse_minus             (tokenizer, *token);
        case #char "+";  parse_plus              (tokenizer, *token);
        case #char "*";  parse_asterisk          (tokenizer, *token);
        case #char "<";  parse_less_than         (tokenizer, *token);
        case #char ">";  parse_greater_than      (tokenizer, *token);
        case #char "!";  parse_bang              (tokenizer, *token);
        case #char "#";  parse_compiler_directive(tokenizer, *token);
        case #char "\""; parse_string_literal    (tokenizer, *token);
        case #char "\t"; parse_tab               (tokenizer, *token);
        case #char "/";  parse_slash_or_comment  (tokenizer, *token);
        case #char "&";  parse_ampersand         (tokenizer, *token);
        case #char "|";  parse_pipe              (tokenizer, *token);
        case #char "%";  parse_percent           (tokenizer, *token);
        case #char "@";  parse_note              (tokenizer, *token);
        case #char "^";  parse_caret             (tokenizer, *token);

        case #char ";";  token.type = .punctuation; token.punctuation = .semicolon; t += 1;
        case #char ",";  token.type = .punctuation; token.punctuation = .comma;     t += 1;
        case #char ".";  token.type = .punctuation; token.punctuation = .period;    t += 1;
        case #char "{";  token.type = .punctuation; token.punctuation = .l_brace;   t += 1;
        case #char "}";  token.type = .punctuation; token.punctuation = .r_brace;   t += 1;
        case #char "(";  token.type = .punctuation; token.punctuation = .l_paren;   t += 1;
        case #char ")";  token.type = .punctuation; token.punctuation = .r_paren;   t += 1;
        case #char "[";  token.type = .punctuation; token.punctuation = .l_bracket; t += 1;
        case #char "]";  token.type = .punctuation; token.punctuation = .r_bracket; t += 1;
        case #char "$";  token.type = .punctuation; token.punctuation = .dollar;    t += 1;

        case #char "~";  token.type = .operation;   token.operation   = .tilde;     t += 1;
        case #char "`";  token.type = .operation;   token.operation   = .backtick;  t += 1;

        case;            token.type = .invalid; t += 1;
    }

    if t >= max_t then t = max_t;
    token.len = cast(s32) (t - start_t);
    return token;
}

parse_identifier :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .identifier;

    mark := get_temporary_storage_mark();
    defer   set_temporary_storage_mark(mark);

    identifier_str := read_identifier_string_tmp(tokenizer);

    // Maybe it's a keyword
    if identifier_str.count <= MAX_KEYWORD_LENGTH {
        kw_token, ok := table_find(*KEYWORD_MAP, identifier_str);
        if ok { token.type = kw_token.type; token.keyword = kw_token.keyword; return; }
    }

    // Check for here-string
    if last_tokens[1].type == .compiler_directive && last_tokens[1].compiler_directive == .directive_string {
        token.type = .here_string;
        end := find_index_from_left(buf, identifier_str, start_index = t - buf.data);
        if end < 0 { t = max_t; return; }
        t = buf.data + end + identifier_str.count;
    }
}

parse_number :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .number;

    t += 1;
    if t >= max_t return;

    if is_digit(<< t) || << t == #char "_" {
        // Decimal
        t += 1;
        seen_decimal_point := false;
        while t < max_t && (is_digit(<< t) || << t == #char "_" || << t == #char ".") {
            if << t == #char "." {
                if seen_decimal_point break;
                seen_decimal_point = true;
            }
            t += 1;
        }
    } else if << t == #char "x" || << t == #char "h" {
        // Hex
        is_hex :: inline (c: u8) -> bool {
            return is_digit(c) || (c >= #char "a" && c <= #char "f") || (c >= #char "A" && c <= #char "F");
        }

        t += 1;
        while t < max_t && (is_hex(<< t) || << t == #char "_") t += 1;
    } else if << t == #char "b" {
        // Binary
        t += 1;
        while t < max_t && (<< t == #char "1" || << t == #char "0" || << t == #char "_") t += 1;
    }
}

parse_compiler_directive :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .identifier;

    t += 1;
    t = eat_white_space(t, max_t, tokenizer.the_buffer);  // there may be spaces between the # and the name
    if !is_alpha(<<t) return;

    mark := get_temporary_storage_mark();
    defer   set_temporary_storage_mark(mark);

    directive_str := read_identifier_string_tmp(tokenizer);

    while t < max_t && is_alnum(<< t) t += 1;
    if t >= max_t return;

    // Check if it's one of the existing directives
    if directive_str.count > MAX_DIRECTIVE_LENGTH return;
    directive, ok := table_find(*COMPILER_DIRECTIVES_MAP, directive_str);
    if ok {
        token.type = .compiler_directive;
        token.compiler_directive = directive;
    }
}

parse_colon :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .colon;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char ":";  token.operation = .double_colon;  t += 1;
        case #char "=";  token.operation = .colon_equal;   t += 1;
    }
}

parse_equal :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .equal;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";  token.operation = .equal_equal; t += 1;
    }
}

parse_minus :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .minus;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .minus_equal;
            t += 1;
        case #char ">";
            token.operation = .arrow;
            t += 1;
        case #char "-";
            t += 1;
            if t < max_t && << t == #char "-" {
                token.operation = .triple_dash;
                t += 1;
            } else {
                token.operation = .unknown;  // -- is not a valid token
            }
        case;
            if is_digit(<< t) parse_number(tokenizer, token);
    }
}

parse_plus :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .plus;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .plus_equal;
            t += 1;
    }
}

parse_asterisk :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .asterisk;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .asterisk_equal;
            t += 1;
    }
}

parse_bang :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .bang;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .bang_equal;
            t += 1;
    }
}

parse_percent :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .percent;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .percent_equal;
            t += 1;
    }
}

parse_caret :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .caret;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .caret_equal;
            t += 1;
    }
}

parse_note :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .punctuation;
    token.punctuation = .note;

    t += 1;
    while t < max_t && is_alnum(<< t) t += 1;
    if t >= max_t return;
}

parse_ampersand :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .ampersand;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .ampersand_equal;
            t += 1;
        case #char "&";
            token.operation = .double_ampersand;
            t += 1;
    }
}

parse_pipe :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .pipe;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .pipe_equal;
            t += 1;
        case #char "|";
            token.operation = .double_pipe;
            t += 1;
    }
}

parse_less_than :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .less_than;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .less_than_equal;
            t += 1;
        case #char "<";
            token.operation = .double_less_than;
            t += 1;
    }
}

parse_greater_than :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .greater_than;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .greater_than_equal;
            t += 1;
    }
}

parse_tab :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .comment;
    t += 1;
    while t < max_t && << t == #char "\t" t += 1;
}

parse_slash_or_comment :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .operation;
    token.operation = .slash;

    t += 1;
    if t >= max_t return;

    if << t == {
        case #char "=";
            token.operation = .slash_equal;
            t += 1;
        case #char "/";
            token.type = .comment;
            t += 1;
            while t < max_t && << t != #char "\n" t += 1;
        case #char "*";
            token.type = .multiline_comment;
            t += 1;
            num_open_comments := 0;
            while t + 1 < max_t {
                if << t == #char "*" && << (t + 1) == #char "/" {
                    if num_open_comments == 0 {
                        t += 2;
                        break;
                    } else {
                        num_open_comments -= 1;
                    }
                } else if << t == #char "/" && << (t + 1) == #char "*" {
                    num_open_comments += 1;
                    t += 1;
                }
                t += 1;
            }
    }
}

parse_string_literal :: (using tokenizer: *Tokenizer, token: *Token) {
    token.type = .string_literal;

    escape_seen := false;

    t += 1;
    while t < max_t && << t != #char "\n" {
        if <<t == #char "\"" && !escape_seen break;
        escape_seen = !escape_seen && <<t == #char "\\";
        t += 1;
    }
    if t >= max_t return;

    t += 1;
}

read_identifier_string_tmp :: (using tokenizer: *Tokenizer) -> string /* temp */ {
    identifier: [..] u8;
    identifier.allocator = temp;

    array_add(*identifier, <<t);

    t += 1;
    slash_mode := false;

    while t < max_t {
        c := <<t;
        if is_alnum(c)      { t += 1; slash_mode = false; array_add(*identifier, c); continue; }
        if c == #char "\\"  { t += 1; slash_mode = true;  continue; }
        if slash_mode && is_white_space(c) { t += 1; continue; }
        break;
    }
    if t >= max_t then t = max_t;

    return to_string(identifier);
}

Tokenizer :: struct {
    the_buffer : *Buffer;
    buf: string;
    max_t:   *u8;
    start_t: *u8;  // cursor when starting parsing new token
    t:       *u8;  // cursor

    last_tokens: [2] Token;  // to retroactively highlight functions
    #place last_tokens;
    prev : Token;
    before_prev : Token;
}

Token :: struct {
    start, len: s32;
    type: Type;

    // Additional info to distinguish between keywords/punctuation
    union {
        keyword:            Keyword;
        punctuation:        Punctuation;
        operation:          Operation;
        compiler_directive: Compiler_Directive;
    }

    Type :: enum u16 {
        eof;

        identifier;
        string_literal;
        here_string;
        number;
        comment;
        multiline_comment;
        operation;
        punctuation;
        modifier_keyword;
        keyword;
        type_keyword;
        jump_keyword;
        value_keyword;
        compiler_directive;
        invalid;
    }
}

print_token :: (buffer: *Buffer, using token: Token) {
    b : String_Builder;
    print_to_builder(*b, "% % ", start, type);
    if type == {
        case .keyword; print_to_builder(*b, ": %", keyword);
        case .punctuation; print_to_builder(*b, ": %", punctuation);
        case .operation; print_to_builder(*b, ": %", operation);
        case .compiler_directive; print_to_builder(*b, ": %", compiler_directive);
    }
    append(*b, " ");
    append(*b, to_string(buffer, token));
    print("%\n", builder_to_string(*b));
}

to_string :: (buffer: *Buffer, token: Token) -> string {
    result : string = ---;
    result.data = *buffer.bytes[token.start];
    result.count = token.len;
    return result;
}

// Must match the order of the types in the enum
COLOR_MAP :: Code_Color.[
    .COMMENT,       // eof - obviously not used
    .DEFAULT,       // identifier
    .STRING,        // string_literal
    .STRING,        // here_string
    .VALUE,         // number
    .COMMENT,       // comment
    .COMMENT,       // multiline_comment
    .OPERATION,     // operation
    .PUNCTUATION,   // punctuation
    .KEYWORD,       // keyword
    .KEYWORD,       // modifier_keyword
    .TYPE,          // type_keyword
    .JUMP_KEYWORD,  // jump_keyword
    .VALUE_KEYWORD, // value_keyword
    .DIRECTIVE,     // compiler_directive
    .ERROR,         // invalid
];

PUNCTUATION :: string.[
    "dollar", "semicolon", "l_paren", "r_paren", "l_brace", "r_brace", "l_bracket", "r_bracket",
    "period", "comma", "note",
];

OPERATIONS :: string.[
    "arrow", "bang", "backtick", "pipe", "double_pipe", "pipe_equal", "equal", "equal_equal", "bang_equal",
    "percent", "percent_equal", "less_than", "double_less_than", "less_than_equal", "greater_than", "greater_than_equal",
    "minus", "minus_equal", "triple_dash", "asterisk", "asterisk_equal", "colon", "colon_equal", "double_colon", "slash",
    "plus", "plus_equal", "slash_equal", "ampersand", "double_ampersand", "ampersand_equal", "tilde", "unknown",
    "caret", "caret_equal",
];

KEYWORDS :: string.[
    "align_of", "case", "cast", "code_of", "else", "enum", "enum_flags", "for",
    "if", "ifx", "is_constant", "inline", "push_context", "size_of", "struct", "then", "type_info", "type_of",
    "union", "using", "while", "xx", "operator", "remove",
];

JUMP_KEYWORDS :: string.[
    "break", "continue", "defer", "return",
];

TYPE_KEYWORDS :: string.[
    "__reg", "bool", "float", "float32", "float64", "int", "reg", "s16", "s32", "s64", "s8", "string",
    "u16", "u32", "u64", "u8", "void",
];

VALUE_KEYWORDS :: string.[
    "context", "it", "it_index", "null", "true", "false", "temp",
];

COMPILER_DIRECTIVES :: string.[
    "add_context", "align", "as", "asm", "assert", "bake_arguments", "bake_constants", "bytes", "c_call", "caller_code",
    "caller_location", "char", "code", "compiler", "complete", "cpp_method", "cpp_return_type_is_non_pod", "deprecated",
    "dump", "dynamic_specialize", "elsewhere", "expand", "file", "filepath", "foreign", "library", "system_library",
    "if", "ifx", "import", "insert", "insert_internal", "intrinsic", "line", "load",
    "location", "modify", "module_parameters", "must", "no_abc", "no_aoc", "no_alias", "no_context", "no_padding", "no_reset",
    "place", "placeholder", "poke_name", "procedure_of_call", "program_export", "run", "runtime_support",
    "scope_export", "scope_file", "scope_module", "specified", "string", "symmetric", "this", "through", "type",
    "type_info_no_size_complaint", "type_info_none", "type_info_procedures_are_void_pointers",
    "compile_time", "no_debug",
];

// TODO: implement
MODIFIERS :: string.[
    "isa", "distinct",  // type
    "only", "except", "map",  // using
    "no_check", "truncate",  // cast
    "file", "dir", "string",  // import
    "scope",  // insert
];

#insert -> string {
    b: String_Builder;
    init_string_builder(*b);

    define_enum :: (b: *String_Builder, enum_name: string, prefix: string, value_lists: [][] string) {
        print_to_builder(b, "% :: enum u16 {\n", enum_name);
        for values : value_lists {
            for v : values print_to_builder(b, "    %0%;\n", prefix, v);
        }
        print_to_builder(b, "}\n");
    }

    define_enum(*b, "Punctuation",        "",           .[PUNCTUATION]);
    define_enum(*b, "Operation",          "",           .[OPERATIONS]);
    define_enum(*b, "Keyword",            "kw_",        .[KEYWORDS, TYPE_KEYWORDS, JUMP_KEYWORDS, VALUE_KEYWORDS]);
    define_enum(*b, "Compiler_Directive", "directive_", .[COMPILER_DIRECTIVES]);

    return builder_to_string(*b);
}

Keyword_Token :: struct {
    type: Token.Type;
    keyword: Keyword;
}

KEYWORD_MAP :: #run -> Table(string, Keyword_Token) {
    table: Table(string, Keyword_Token);
    size := 2 * (KEYWORDS.count + TYPE_KEYWORDS.count + JUMP_KEYWORDS.count + VALUE_KEYWORDS.count);
    init(*table, size);

    #insert -> string {
        b: String_Builder;
        for KEYWORDS        append(*b, sprint("table_add(*table, \"%\", Keyword_Token.{ type = .keyword,       keyword = .kw_% });\n", it, it));
        for TYPE_KEYWORDS   append(*b, sprint("table_add(*table, \"%\", Keyword_Token.{ type = .type_keyword,  keyword = .kw_% });\n", it, it));
        for JUMP_KEYWORDS   append(*b, sprint("table_add(*table, \"%\", Keyword_Token.{ type = .jump_keyword,  keyword = .kw_% });\n", it, it));
        for VALUE_KEYWORDS  append(*b, sprint("table_add(*table, \"%\", Keyword_Token.{ type = .value_keyword, keyword = .kw_% });\n", it, it));
        return builder_to_string(*b);
    }

    return table;
}

COMPILER_DIRECTIVES_MAP :: #run -> Table(string, Compiler_Directive) {
    table: Table(string, Compiler_Directive);
    size := 2 * COMPILER_DIRECTIVES.count;
    init(*table, size);

    #insert -> string {
        b: String_Builder;
        init_string_builder(*b);
        for COMPILER_DIRECTIVES {
            print_to_builder(*b, "table_add(*table, \"%1\", .directive_%1);\n", it);
        }
        return builder_to_string(*b);
    }

    return table;
}

MAX_KEYWORD_LENGTH :: #run -> s32 {
    result: s64;
    for KEYWORDS       { if it.count > result then result = it.count; }
    for TYPE_KEYWORDS  { if it.count > result then result = it.count; }
    for VALUE_KEYWORDS { if it.count > result then result = it.count; }
    return xx result;
}

MAX_DIRECTIVE_LENGTH :: #run -> s32 {
    result: s64;
    for COMPILER_DIRECTIVES { if it.count > result then result = it.count; }
    return xx result;
}


eat_white_space :: inline (start: *u8, max_t: *u8, using buffer: *Buffer) -> *u8 {
    t := start;
    while t < max_t && is_white_space(t.*) {
        //if t.* == #char "\n"  array_add(*line_starts, cast(s32)(t - buffer.bytes.data) + 1); @Autoindent
        t += 1;
    }
    return t;
}

is_white_space :: inline (c: u8) -> bool {
    return c == #char " " || c == #char "\r" || c == #char "\n";
}

declaration_pos_for_word :: (path: string, word_pos: s32, word: string, v : Vector3 = .{}) -> pos: s32, found: bool {
    print("Searching for declaration in %\n", path);
    /*
    jai_file := get_jai_file(path);
    if !jai_file  return -1, false;

    pos : s32 = -1;

    for jai_file.declarations {
        if it.pos > word_pos
            break;

        if it.name == word {
            scope := jai_file.scopes[it.scope_index];
            if scope.start <= word_pos && word_pos <= scope.end {
                pos = it.pos;
            }
        }
    }

    return pos, pos >= 0;
    */
    return 0, false;
}


jai_files : Table(string, []*Node);

// @TODO no lol
JAI_PATH :: #run find_current_jai_path();
JAI_MODULES_PATH :: #run tprint("%/modules", JAI_PATH);

Node_Visit_Data :: struct {
    file_info: File_Info;
    files: *Table(string, []*Node);
}

node_visit :: (node: *Node, data: Node_Visit_Data) {
    if node.kind == .DIRECTIVE_IMPORT {
        _import := cast(*Directive_Import) node;

        file_info : File_Info = ---;

        if _import.import_kind == {
            case .MODULE;
                module_path := tprint("%/%", JAI_MODULES_PATH, _import.module);
                //print("----------\n% %\n", module_path, get_module_entry(module_path));
                file_info = get_file_info_from_path_plus_filename(module_path, get_module_entry(module_path));
            case .FILE;
                file_info = file_info_for_adjacent_file(_import.module, data.file_info);
            case .DIR;
                file_info =  file_info_for_adjacent_file(get_module_entry(_import.module), data.file_info);
            case .STRING;
                // @TODO: Do we wanna parse the string here?
                return;
        }

        jai_parse_file(data.file_info, data.files); // @TODO: Run this in another thread?
    }

    if node.kind == .DIRECTIVE_LOAD {
        _load := cast(*Directive_Load) node;
        //print("----------\n% %\n", data.file_info.path, _load.file);
        jai_parse_file(get_file_info_from_path_plus_filename(tprint("c:/repos/%", data.file_info.path), _load.file), data.files); // @TODO: Run this in another thread?
    }
}

get_module_entry :: (root: string) -> string {
    uri := tprint("%/module.jai", root);
    if !file_exists(uri) {
        uri = tprint("%.jai", root);
    }

    return uri;
}

find_current_jai_path :: () -> string {

    remove_trailing_slash :: (path: string) -> string {
        result := path;
        if path[path.count - 1] == #char "/" result.count -= 1;
        return result;
    }

    Compiler :: #import "Compiler";
    options := Compiler.get_build_options();
    for options.import_path {
        if find_index_from_left(to_lower_copy(it), "jai/modules") != -1 {
            modules_path := remove_trailing_slash(it);
            base_path := remove_trailing_slash(path_strip_filename(modules_path));
            return base_path;
        }
    }

    return "";
}

#import "jai_parser";
#import "Hash_Table";
