highlight_md_syntax :: (using buffer: *Buffer) {
    tokenizer: Tokenizer = ---;
    tokenizer.buf   = to_string(bytes);
    tokenizer.max_t = bytes.data + bytes.count;
    tokenizer.t     = bytes.data;
    highlight_md_syntax(buffer, *tokenizer);
}

highlight_md_syntax :: (using buffer: *Buffer, start_index: s32, count: s32) {
    tokenizer: Tokenizer = ---;
    tokenizer.buf   = to_string(bytes);
    tokenizer.max_t = bytes.data + start_index + count;
    tokenizer.t     = bytes.data + start_index;

    highlight_md_syntax(buffer, *tokenizer);
}

highlight_md_syntax :: (using buffer: *Buffer, using tokenizer: *Tokenizer) {
    indent := 0;
    token : Token;
    token.type = .eol;

    while true {
        if token.type == .eol {
            indent = eat_white_space(tokenizer);
            token = get_next_token(tokenizer);
            if token.type == .eol  continue;
        }

        if token.type == .eof break;

        color := COLOR_MAP[token.type];
        memset(colors.data + token.start, xx color, token.len);

        token = get_next_token(tokenizer);
    }
}

#scope_file

get_next_token :: (using tokenizer: *Tokenizer) -> Token {
    token: Token;
    token.start = cast(s32) (t - buf.data);
    token.type  = .eof;
    if t >= max_t return token;

    eat_white_space(tokenizer);

    start_t = t;

    if t.* == {
        case #char "\n";
        token.type = .eol;
        t += 1;

        case #char "#";
        parse_header(tokenizer, *token);

        case;
        token.type = .default;
        eat_until_newline(tokenizer);
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

    if header_level == {
        case 1; token.type = .header1;
        case 2; token.type = .header2;
        case 3; token.type = .header3;
        case 4; token.type = .header4;
        case 5; token.type = .header5;
        case 6; token.type = .header6;
    }

    eat_until_newline(tokenizer);
}

eat_until_newline :: (using tokenizer: *Tokenizer) {
    while t < max_t && <<t != #char "\n" {
        t += 1;
    }
}

eat_white_space :: (using tokenizer: *Tokenizer) -> s32 {
    count : s32 = 0;
    while t < max_t && is_space(<< t) {
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
}

Token :: struct {
    start, len: s32;
    type: Type;
    sublen: s32;

    Type :: enum u16 {
        eof;
        eol;

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

    .ERROR,         // error
    .DEFAULT,       // default

    .DIRECTIVE,     // header1
    .COMMENT,       // header2
    .PUNCTUATION,   // header3
    .JUMP_KEYWORD,  // header4
    .VALUE_KEYWORD, // header5
    .KEYWORD,       // header6

    .OPERATION,     // ordered_list
    .FUNCTION,      // unorderer_list

    .STRING,        // code
];

#run assert(enum_highest_value(Token.Type) == COLOR_MAP.count - 1);