
Process :: #import "Process";
#import "Basic";
#import "String";
#import "Command_Line";

Args :: struct {
    timeout := -1;
}

main :: () {
    success, args, is_set, free_args := parse_arguments(Args);
    if free_args.count < 1 {
        string_args := get_command_line_arguments();
        log("Usage: % [-timeout <ms>] <command to run>", string_args[0]);
        exit(1);
    }

    {
        command := Process.get_quoted_command_string(free_args);
        log("Running command: %", command);
        if args.timeout >= 0 log("Timeout is set to %ms", args.timeout);
        process_result, output_string, error_string, timeout_reached := Process.run_command(..free_args, working_directory="", capture_and_return_output=true, timeout_ms = args.timeout);

        if process_result.type == .FAILED_TO_LAUNCH {
            log_error("Could not run command: \"%\"", command);
            return;
        }

        log("Exit code: % (timeout reached: %)", process_result.exit_code, timeout_reached);
        log("stdout:\n%", output_string);
        log("stderr:\n%", error_string);
    }
}
