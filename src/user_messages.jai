add_user_error :: inline (message: string, link_file := "", dismiss_in_seconds: float64 = -1, origin := User_Message.Origin.general) {
    add_user_message(message, .error, link_file, cast(Time) dismiss_in_seconds, origin);
}

add_user_warning :: inline (message: string, link_file := "", dismiss_in_seconds: float64 = 10, origin := User_Message.Origin.general) {
    add_user_message(message, .warning, link_file, cast(Time) dismiss_in_seconds, origin);
}

add_success_message :: inline (message: string, link_file := "", dismiss_in_seconds: float64 = 10, origin := User_Message.Origin.general) {
    add_user_message(message, .success, link_file, cast(Time) dismiss_in_seconds, origin);
}

add_user_message :: (message: string, level: User_Message.Level, link_file: string, dismiss_in_seconds: Time, origin := User_Message.Origin.general) {
    if user_messages.count >= MAX_MESSAGES then cleanup_old_messages();

    array_add(*user_messages, User_Message.{
        message            = copy_string(message),
        level              = level,
        origin             = origin,
        time               = cast(Time) get_time(),
        dismiss_in_seconds = cast(Time) dismiss_in_seconds,
        link_file          = copy_string(link_file),
    });
}

get_user_messages :: (current_time: Time) -> [] User_Message {
    count := 0;

    for < user_messages {
        if it.dismiss_in_seconds >= 0 && current_time - it.time > it.dismiss_in_seconds break;
        count += 1;
        if count >= 5 break;
    }

    return array_view(user_messages, user_messages.count - count, count);
}

clear_user_messages :: () {
    for user_messages free(it.message);
    array_reset_keeping_memory(*user_messages);
}

clear_user_messages :: (origin: User_Message.Origin) {
    for < user_messages {
        if it.origin == origin {
            free(it.message);
            array_ordered_remove_by_index(*user_messages, it_index);
        }
    }
}

#scope_file

cleanup_old_messages :: () {
    // TODO: fix the leak (message)
    COUNT :: 10;
    last_messages := array_view(user_messages, user_messages.count - COUNT, COUNT);
    memcpy(user_messages.data, last_messages.data, COUNT * size_of(User_Message));
    user_messages.count = COUNT;
}

user_messages: [..] User_Message;

User_Message :: struct {
    message: string;
    level: Level;
    origin: Origin;
    time: Time;
    link_file: string;
    dismiss_in_seconds: Time;
    dismissed: bool;

    Level :: enum { warning; error; success; };
    Origin :: enum { general; build; };
}

MAX_MESSAGES    :: 64;  // need to cleanup after that
