output_buffer : s64 = -1;

show_output :: (output: string) {
    if output_buffer < 0  output_buffer = find_or_create_an_empty_buffer();
    assert(output_buffer >= 0 && open_buffers.count > output_buffer);
    buffer := *open_buffers[output_buffer];
    clear_buffer(buffer);
    insert_string_raw(buffer, 0, output, false);
    rescan_for_lines(buffer);
    editors_open_buffer(output_buffer, .floating);
}

Build_Mode :: enum {
    DEBUG;
    RELEASE;
}

build :: (mode : Build_Mode) {
    result: Process_Result;
    output : string;
    error : string;
    timed_out : bool;
    {
        push_allocator(temp);
        result, output, error, timed_out = run_command(
            "jai.exe", "first.jai",
            working_directory="c:\\repos\\focus", capture_and_return_output=true);
        if output.count > 80
            output = split_by_count(output, 80);
    }
    show_output(output);
}


split_by_count :: (s: string, count: int) -> string {
    builder : String_Builder;
    _s := s;
    while _s.count > count {
        append(*builder, slice(_s, 0, count));
        _s = slice(_s, count, s.count - count);
    }
    append(*builder, _s);
    return builder_to_string(*builder);
}

