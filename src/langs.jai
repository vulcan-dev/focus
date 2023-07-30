maybe_highlight_inner_language :: (using buffer: *Buffer, identifier: string, start_index: s32, count: s32, use_jai_by_default := false) -> bool {
    highlight_proc : #type (*Buffer, s32, s32);

    matches :: (postfix: string) -> bool #expand {
        return strings.ends_with(identifier, postfix, strings.ignore_case);
    }

    // @TODO generate this code at compile time
    if matches("jai")
        highlight_proc = highlight_jai_syntax;
    else if matches("cs") || matches("csharp") || matches("c#")
        highlight_proc = highlight_csharp_syntax;
    else if matches("cpp") || matches("c++") || matches("c") || matches("h") || matches("h++") || matches("hpp")
        highlight_proc = highlight_c_syntax;
    else if matches("vert") || matches("frag") || matches("geom") || matches("tess") || matches("glsl")
        highlight_proc = highlight_glsl_syntax;
    else if matches("md") || matches("markdown")
        highlight_proc = highlight_md_syntax;
    else if use_jai_by_default
        highlight_proc = highlight_jai_syntax;
    else
        return false;

    highlight_proc(buffer, start_index, count);
    return true;
}

is_lang_which_likes_to_line_wrap :: (lang: type_of(Buffer.lang)) -> bool {
    return lang == .Plain_Text
        || lang == .Focus_Config
        || lang == .Markdown
        || lang == .Worklog;
}

is_lang_which_likes_to_indent :: (lang: type_of(Buffer.lang)) -> bool {
    return lang == .Jai
        || lang == .C
        || lang == .CSharp
        || lang == .Glsl;
}


#scope_file


is_whitespace :: inline (char: u8) -> bool {
    return char == #char " " || char == #char "\t" || char == #char "\r" || char == #char "\n";
}
