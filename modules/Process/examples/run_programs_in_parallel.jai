main :: () {
    args := get_command_line_arguments();
    if args.count == 1 {
        run_as_parent(args);
    } else {
        run_as_child(args[1]);
    }
}

run_as_parent :: (args: [] string) {
    child_processes: [10] Process.Process;
    for * child_processes {
        success := Process.create_process(it, args[0], tprint("child %", it_index), capture_and_return_output = true);
        if !success {
            log_error("Could not launch child process %", it_index);
            exit(1);
        }
    }
    defer {
        for * child_processes {
            Process.deinit(it);
        }
    }

    for * child_processes {
        log("Greeting child %...", it_index);
        message := "Hello child\n";
        remaining: [] u8;
        remaining.data = message.data;
        remaining.count = message.count;
        while remaining.count {
            success, bytes_written := Process.write_to_process(it, remaining);
            if !success {
                log_error("Couldn't write message to child %", it_index);
                exit(1);
            }
            remaining.data += bytes_written;
            remaining.count -= bytes_written;
        }
    }

    log("Waiting for children to respond…");

    // We wait for the children one by one, but you could also interleave the handling here.
    for * child_processes {
        BUFFER_SIZE :: 1024;
        output_buffer: [BUFFER_SIZE] u8;
        error_buffer: [BUFFER_SIZE] u8;
        output_string: string;
        output_string.data = output_buffer.data;

        while true {
            // We only care about capturing stdout here. We just keep overwriting the stderr buffer
            remaining_buffer := array_view(output_buffer, output_string.count, output_buffer.count - output_string.count);
            success, output_bytes, error_bytes := Process.read_from_process(it, remaining_buffer, error_buffer, timeout_ms = -1);
            if output_bytes {
                output_string.count += output_bytes;
                if contains(output_string, "\n") {
                    log("Child % greeted us back: %", it_index, output_string);
                }
            }

            if it.output.eof && it.error.eof    break;
        }
    }

    for * child_processes {
        success, process_result := Process.get_process_result(it, timeout_ms = -1);
        log("Process result of child %: % %", it_index, success, process_result);
    }
}

// The child reads (blocking) until it receives a greeting and then responds and exits.
run_as_child :: (name: string) {
    BUFFER_SIZE :: 1024;
    buffer: [BUFFER_SIZE] u8;
    input: string;
    input.data = buffer.data;

    while true {
        // @Incomplete: Jai doesn't have an abstraction for reading from stdin yet...
        #if OS == .WINDOWS {
            handle := GetStdHandle(STD_INPUT_HANDLE);
            bytes_read: u32;
            success := ReadFile(handle, buffer.data + input.count, cast(u32) (buffer.count - input.count), *bytes_read, null);
        } else {
            bytes_read := read(STDIN_FILENO, buffer.data + input.count, cast(u64) (buffer.count - input.count));
            if bytes_read < 0 {
                log_error("Couldn't read from stdin");
                exit(1);
            }
        }

        if bytes_read {
            input.count += bytes_read;
            if begins_with(input, "Hello child") {
                print("Hello parent from %\n", name);
                break;
            }
        }
    }
}

Process :: #import "Process";

#import "Command_Line";
#import "Basic";
#import "String";
#if OS == .WINDOWS {
    #import "Windows";
} else {
    #import "POSIX";
}
