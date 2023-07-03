init_run_command :: () {
    run_command_thread_group = Thread_Group.{};
    init(*run_command_thread_group, 1, group_proc = run_command_threadproc);
    run_command_thread_group.name = "Run Command";
    run_command_thread_group.logging = false;
    for * run_command_thread_group.worker_info { it.thread.starting_context.logger_data = context.logger_data; }

    start(*run_command_thread_group);

    init_output_buffer();
}

init_output_buffer :: () {
    output_buffer = find_or_create_an_empty_buffer();
    buffer := *open_buffers[output_buffer];
    buffer.readonly = true;
    buffer.ignore = true;
}

print_to_output :: (output: string) {
    assert(output_buffer >= 0 && open_buffers.count > output_buffer, "output_buffer: %  buffer count: %", output_buffer, open_buffers.count);
    buffer := *open_buffers[output_buffer];
    insert_string_raw(buffer, buffer.bytes.count, output, false);
    rescan_for_lines(buffer);
    editors_open_buffer(output_buffer, .floating);
}

clear_output :: (header := "") {
    assert(output_buffer >= 0 && open_buffers.count > output_buffer, "output_buffer: %  buffer count: %", output_buffer, open_buffers.count);
    buffer := *open_buffers[output_buffer];
    clear_buffer(buffer);
    if header  insert_string_raw(buffer, buffer.bytes.count, header, false);
    rescan_for_lines(buffer);
    editors_open_buffer(output_buffer, .floating);
}

build :: (mode : Build_Mode) {
    using config := *build_configs[mode];
    if !enabled {
        add_user_error(tprint("You must supply a % section in your project config.", workspace_subsection_from_build_mode(mode)));
        return;
    }

    save_all_raw();

    task := New(Run_Command_Task);
    task.title = sprint(build_mode_labels[mode], name);
    task.build_config = build_configs[mode];

    add_work(*run_command_thread_group, task, task.title);
}

run_command_threadproc :: (group: *Thread_Group, thread: *Thread, work: *void) -> Thread_Continue_Status {
    using task := cast(*Run_Command_Task) work;

    if error_exists  free(*last_error);
    error_exists = false;
    store_next_error = true;

    clear_output(task.title);

    successful := true;

    for command: task.build_config.commands {
        result, output, error, timed_out := run_command(
            .. break_command_into_strings(command),
            working_directory = task.build_config.working_directory,
            capture_and_return_output=true, output_callback = print_to_output, error_callback = on_error);
        defer { free(output); free(error); }

        if result.exit_code {
            successful = false;
            break;
        }
    }

    if successful {
        add_success_message(task.title);
    }
    else {
        if error_exists
            add_user_error(tprint("%\n%", task.title, last_error.message), last_error.file.full_path);
    }

    return .CONTINUE;
}

on_error :: (s: string) {
    print_to_output(s);
    if store_next_error {
        error, ok := make_error(s);
        if ok {
            last_error = error;
            store_next_error = false;
            error_exists = true;
        }
    }
}

last_error : Error;
store_next_error := false;
error_exists := false;

Error :: struct {
    file : File_Info;
    coords : Coords;
    message : string;
}

make_error :: (s: string) -> Error, ok: bool {
    result : Error = ---;
    sentinel :: ": Error: ";
    if !contains(s, sentinel) return result, false;

    line := strings.trim(s);

    location, message := strings.split_into_two(line, sentinel);

    coord_start := strings.last_index(location, #char ":");
    coords := strings.slice(location, coord_start + 1);
    ok : bool;
    result.coords, ok = coords_from_string(coords);
    if !ok  return result, false;

    path := strings.slice(location, 0, coord_start);
    result.file = get_file_info_from_full_path(path);
    result.message = copy_string(message);

    return result, true;
}

free :: (error: *Error) {
    // @Leak
    //free(*error.file);
    //free(*error.message);
}


Build_Config :: struct {
    name : string;
    working_directory : string;
    commands : [..] string;
    enabled : bool;
}

Build_Mode :: enum {
    DEBUG;
    RELEASE;
    DEBUG_AND_RUN;
    RELEASE_AND_RUN;
}

build_configs : [4] Build_Config;
build_mode_labels :: string.["Build: Debug  |  %\n", "Build: Release  |  %\n", "Build: Debug and Run  |  \n", "Build: Release and Run  |  %\n"];

reset_configs :: () {
    // @TODO @Leak should free strings if they exist
    for * config: build_configs {
        config.name = "";
        config.working_directory = "";
        array_reset(*config.commands);
        config.enabled = false;
    }
}

validate_build_configs :: () -> error: string {
    for config: build_configs {
        if !config.enabled  continue;
        if !config.name  return "Must provide  name:";
        if !config.working_directory  return "Must provide  dir:";
        if config.commands.count == 0  return "Must provide one or more  command:";
    }
    return "";
}

#scope_file

Run_Command_Task :: struct {
    title : string;
    build_config : Build_Config;
}

run_command_thread_group : Thread_Group;

output_buffer : s64 = -1;
