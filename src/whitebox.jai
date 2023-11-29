#scope_export
whitebox_disconnect :: () {
    if whitebox_sock == socket.INVALID_SOCKET then return;

    #if OS == .WINDOWS {
        socket.WSACleanup();
        socket.closesocket(whitebox_sock);
    } else {
        close(whitebox_sock);
    }
    
    whitebox_connected = false;
}

whitebox_connect :: () {
    // Check if we're already connected
    if whitebox_connected {
        log("Already connected to Whitebox, disconnecting...\n");
        whitebox_disconnect();
    }

    #if OS == .WINDOWS {
        wsa: socket.WSADATA;
        socket.WSAStartup(socket.WINSOCK_VERSION, *wsa);
    }

    s_addr: socket.sockaddr_in;
    whitebox_sock, s_addr = net_create_sockaddr(WHITEBOX_ADDRESS, WHITEBOX_PORT, socket.AF_INET, .SOCK_STREAM);
    
    { // Set Non-Blocking
        mode: u32 = 1;
        socket.ioctlsocket(whitebox_sock, socket.FIONBIO, *mode);
    }

    // Connect
    result := socket.connect(whitebox_sock, xx *s_addr, size_of(type_of(s_addr)));
    if result == socket.SOCKET_ERROR {
        if socket.WSAGetLastError() == socket.WSAEWOULDBLOCK {
            write, err: socket.fd_set;
            memset(*write, 0, size_of(socket.fd_set));
            memset(*err, 0, size_of(socket.fd_set));
            
            socket.FD_SET(whitebox_sock, *write);
            socket.FD_SET(whitebox_sock, *err);
            
            tv: socket.timeval;
            tv.tv_sec = 0;
            tv.tv_usec = 100;
            
            result := socket.select(0, null, *write, *err, *tv);
            if result == 0 {
                socket.closesocket(whitebox_sock);
                add_user_error("[Whitebox] Timed out whilst connecting", 1.5);
                log_error("Timeout while connecting.\n");
                whitebox_connected = false;
                return;
            }
            
            if (socket.FD_ISSET(whitebox_sock, *err)) {
                socket.closesocket(whitebox_sock);
                value, s := get_error_value_and_string();
                
                err := tprint("[Whitebox] Failed connecting to whitebox: % {%, %}\n", result, value, s);
                add_user_error(err, 1.5);
                log_error(err);
            }
        } else {
            value, s := get_error_value_and_string();
            err := tprint("[Whitebox] Failed connecting to whitebox: % {%, %}\n", result, value, s);
            add_user_error(err, 1.5);
            log_error(err);
            
            whitebox_disconnect();
            return;
        }
        
        add_success_message("[Whitebox] Successfully Connected!", 2);
    }
    
    whitebox_connected = true;
}

whitebox_tick :: () {
    active_editor, active_buffer := get_active_editor_and_buffer();
    if !active_editor || !active_buffer then return;

    cursor: Cursor = active_editor.cursors[0];
    coords := get_cursor_coords(active_editor, active_buffer, cursor).pos;

    if line_wrap_is_active(active_editor) then coords = get_real_cursor_coords(active_buffer, cursor).pos;    
    if !active_buffer.has_file then return; // I mean, you don't have to return, but that wouldn't be very good

    filename := active_buffer.file.full_path;
    whitebox_data := tprint(#string END
{
    "editor": "Focus",
    "path": "%1",
    "selection": [
        { "line": %2, "column": %3 },
        { "line": %2, "column": %3 }
    ],
    "dirty": [%4],
    "ack_pkt": 0,
    "supports": {
        "receiving_data": false,
        "setting_cursor": false
    }
}
    END, active_buffer.file.full_path, coords.line + 1, coords.col + 1, ifx active_buffer.modified then "\"unsaved\"" else "\"\"");

    written := socket.send(whitebox_sock, whitebox_data.data, xx whitebox_data.count, 0);
    if written <= 0 {
        add_user_error("[Whitebox] Failed sending data to Whitebox, disconnecting...", 1);
        whitebox_disconnect();
    }
}

#scope_file
net_create_sockaddr :: (addr: $T, port: u16, family: socket.ADDRESS_FAMILY, type: socket.SOCK, protocol: socket.IPPROTO = 0) -> (sock: socket.Socket, s_addr: socket.sockaddr_in) #modify {
    return T == string ||
           T == u32;
} {
    s_addr: socket.sockaddr_in = .{
        sin_family = family,
        sin_port = socket.htons(port)
    };
    
    convert_ip_to_long :: (addr: $T) -> u32 #modify {
        return T == string || T == u32;
    } {
        #if type_of(addr) == string {
            return socket.inet_addr(to_c_string(addr));
        } else {
            #assert type_of(addr) == u32;
            return socket.htonl(addr);
        }
    }
    
    #if OS == .WINDOWS {
        s_addr.sin_addr.S_un.S_addr = convert_ip_to_long(addr);
    } else {
        s_addr.sin_addr.s_addr = convert_ip_to_long(addr);
    }
    
    return socket.socket(s_addr.sin_family, type, protocol), s_addr;
}

#scope_file
#import "System";
socket :: #import "Socket";

#if OS == .WINDOWS {
    #import "Windows";
}

WHITEBOX_ADDRESS :: "127.0.0.1";
WHITEBOX_PORT    :: 19013;