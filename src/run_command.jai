output_buffer : s64 = -1;

init_output_buffer :: () {
    output_buffer = find_or_create_an_empty_buffer();
    buffer := *open_buffers[output_buffer];
    buffer.readonly = true;
}

show_output :: (output: string) {
    if output_buffer < 0  init_output_buffer();
    assert(output_buffer >= 0 && open_buffers.count > output_buffer);
    buffer := *open_buffers[output_buffer];
    insert_string_raw(buffer, buffer.bytes.count, output, false);
    rescan_for_lines(buffer);
    editors_open_buffer(output_buffer, .floating);
}

clear_output :: () {
    if output_buffer < 0  init_output_buffer();
    assert(output_buffer >= 0 && open_buffers.count > output_buffer);
    buffer := *open_buffers[output_buffer];
    clear_buffer(buffer);
    rescan_for_lines(buffer);
    editors_open_buffer(output_buffer, .floating);
}

Build_Mode :: enum {
    DEBUG;
    RELEASE;
}

build :: (mode : Build_Mode) {
    clear_output();

    task := New(Run_Command_Task);
    task.task_type = .RUN_COMMAND;
    task.args = .["jai.exe", "build.jai"];
    task.working_directory = "c:\\repos\\skel";

    add_work(*thread_group, task, "skel");
}

run_command_threadproc :: (group: *Thread_Group, thread: *Thread, work: *void) -> Thread_Continue_Status {
    using task := cast(*Run_Command_Task) work;
    assert(task.task_type == .RUN_COMMAND);

    result, output, error, timed_out := run_command(
        .. task.args,
        working_directory = task.working_directory,
        capture_and_return_output=true, output_callback = show_output, error_callback = show_output);
    defer { free(output); free(error); }

    return .STOP;
}

Run_Command_Task :: struct {
    using base : Task;
    args : [] string;
    working_directory : string;
}