Task :: struct {
    task_type : enum s64 {
        SEARCH;
        RUN_COMMAND;
    }
}

thread_group: Thread_Group;

all_threadproc :: (group: *Thread_Group, thread: *Thread, work: *void) -> Thread_Continue_Status {
    task := cast(*Task) work;
    if #complete task.task_type == {
        case .SEARCH;       return search_threadproc(group, thread, work);
        case .RUN_COMMAND;  return run_command_threadproc(group, thread, work);
        case;               return .STOP;
    }
}