highlight_md_syntax :: (using buffer: *Buffer) {
    tokenizer: Tokenizer = ---;
    tokenizer.buf   = to_string(bytes);
    tokenizer.max_t = bytes.data + bytes.count;
    tokenizer.t     = bytes.data;
    highlight_md_syntax(buffer, *tokenizer, true);
}

highlight_md_syntax :: (using buffer: *Buffer, start_index: s32, count: s32) {
    tokenizer: Tokenizer = ---;
    tokenizer.buf   = to_string(bytes);
    tokenizer.max_t = bytes.data + start_index + count;
    tokenizer.t     = bytes.data + start_index;

    highlight_md_syntax(buffer, *tokenizer, false);
}

highlight_md_syntax :: (using buffer: *Buffer, using tokenizer: *Tokenizer, reset_regions: bool) {
    if reset_regions  reset_buffer_regions(buffer);

    blockquotes : [64] s32;
    blockquote_index := 0;

    token : Token;
    token.type = .eol;

    while true {
        prev_token = token;
        if prev_token.type == .eol
            indent = eat_white_space(tokenizer);
        else
            indent = 0;

        is_start_of_line = prev_token.type == .eol || prev_token.type == .blockquote;

        token = get_next_token(tokenizer);

        if token.type == .eof  break;

        if token.type == .blockquote || blockquote_index > 0 {
            new_level := ifx token.type == .blockquote then token.sublen else 0;
            while blockquote_index < new_level && blockquote_index < blockquotes.count - 1 {
                blockquotes[blockquote_index] = token.start;
                blockquote_index += 1;
            }
            while blockquote_index > new_level && blockquote_index > 0 {
                blockquote_index -= 1;
                end := ifx token.type == .blockquote then token.start else prev_token.start;
                add_buffer_region(buffer, blockquotes[blockquote_index], end, true);
            }
        }

        color := COLOR_MAP[token.type];
        memset(colors.data + token.start, xx color, token.len);

        if token.type == .code { // @TODO @Speed don't write above if we're going to write below
            identifier := strings.substring(buf, token.start + 3, token.sublen);
            maybe_highlight_inner_language(buffer, identifier, token.start + 3 + token.sublen, token.len - 6 - token.sublen, true);
            add_buffer_region(buffer, token.start, token.start + token.len, false);
        }
    }
}

#scope_file

get_next_token :: (using tokenizer: *Tokenizer) -> Token {
    token: Token;
    token.start = cast(s32) (t - buf.data);
    token.type  = .eof;
    if t >= max_t  return token;

    start_t = t;

    // @TODO \

    if t.* == #char "\n" {
        token.type = .eol;
        t += 1;
    }
    else if is_start_of_line {
        if t.* == {
            case #char "#";
            parse_header(tokenizer, *token);

            case #char ">";
            parse_blockquote(tokenizer, *token);

            case #char "`";
            parse_codeblock(tokenizer, *token);

            case;
            token.type = .default;
            eat_until_newline(tokenizer);
        }
    }
    else {
        eat_white_space(tokenizer);

        start_t = t;

        if t.* == {
            case;
            token.type = .default;
            eat_until_newline(tokenizer);
        }
    }

    if t >= max_t then t = max_t;
    token.len = cast(s32) (t - start_t);

    return token;
}

parse_header :: (using tokenizer: *Tokenizer, token: *Token) {
    t += 1;
    header_level := 1;
    while t < max_t && t.* == #char "#" && header_level < 6 {
        header_level += 1;
        t += 1;
    }

    if <<t != #char " " {
        token.type = .error;
    }
    else if header_level == {
        case 1; token.type = .header1;
        case 2; token.type = .header2;
        case 3; token.type = .header3;
        case 4; token.type = .header4;
        case 5; token.type = .header5;
        case 6; token.type = .header6;
    }

    eat_until_newline(tokenizer);
}

parse_blockquote :: (using tokenizer: *Tokenizer, token: *Token) {
    t += 1;
    blockquote_level : s32 = 1;
    while t < max_t && t.* == #char ">" {
        blockquote_level += 1;
        t += 1;
    }

    if !is_whitespace(t.*) && t.* != #char "\n" {
        token.type = .error;
        eat_until_newline(tokenizer);
    }
    else {
        token.type = .blockquote;
        token.sublen = blockquote_level;
        t += 1;
    }
}

parse_codeblock :: (using tokenizer: *Tokenizer, token: *Token) {
    t += 1;
    backticks := 1;
    while t < max_t && t.* == #char "`" && backticks < 3 {
        backticks += 1;
        t += 1;
    }

    if backticks == 4 {
        token.type = .error;
        eat_until_newline(tokenizer);
        return;
    }

    if backticks < 3 {
        token.type = .default;
        eat_until_newline(tokenizer);
        return;
    }

    terminator :: "\n```";
    end := find_index_from_left(buf, terminator, start_index = t - buf.data);
    if end < 0 {
        t = max_t;
        token.type = .error;
        return;
    }

    token.sublen = 0;
    while t < max_t && !is_whitespace(t.*) && t.* != #char "\n" {
        t += 1;
        token.sublen += 1;
    }

    t = buf.data + end + terminator.count;
    token.type = .code;
}

eat_until_newline :: (using tokenizer: *Tokenizer) {
    while t < max_t && t.* != #char "\n" {
        t += 1;
    }
}

is_whitespace :: inline (char: u8) -> bool {
    return char == #char " " || char == #char "\t" || char == #char "\r";
}

eat_white_space :: (using tokenizer: *Tokenizer) -> s32 {
    count : s32 = 0;
    while t < max_t && is_whitespace(<< t) {
        count += 1;
        t += 1;
    }
    return count;
}

Tokenizer :: struct {
    buf: string;
    max_t:   *u8;
    start_t: *u8;  // cursor when starting parsing new token
    t:       *u8;  // cursor

    is_start_of_line: bool;
    indent : s32 = 0;

    prev_token : Token;
}

Token :: struct {
    start, len: s32;
    type: Type;
    sublen: s32;

    Type :: enum u16 {
        eof;
        eol;
        blockquote;

        error;
        default;

        header1;
        header2;
        header3;
        header4;
        header5;
        header6;

        ordered_list;
        unordered_list;

        code;

    }

}

// Must match the order of the types in the enum above
COLOR_MAP :: Code_Color.[
    .COMMENT,       // eof - obviously not used
    .COMMENT,       // eol - obviously not used
    .COMMENT,       // blockquote - not colored directly; turned into a region

    .ERROR,         // error
    .DEFAULT,       // default

    .DIRECTIVE,     // header1
    .JUMP_KEYWORD,  // header2
    .VALUE_KEYWORD, // header3
    .KEYWORD,       // header4
    .KEYWORD,       // header5
    .KEYWORD,       // header6

    .OPERATION,     // ordered_list
    .FUNCTION,      // unorderer_list

    .STRING,        // code
];

#run assert(enum_highest_value(Token.Type) == COLOR_MAP.count - 1);