Disassembly of 'update_mouse_state' in Workspace 3 at c:/repos/focus/src/main.jai:463
- Stack size 32

-------- Basic Block 0 -------- defines v1-22 --------

           (no dominating)

   0|   stack_node
   1|          mov   v4, [bss+a270] :8b                                window
   2|     constant   v5 = 0                                            false
   3|         call   get_mouse_pointer_position (v4, v5) -> v1, v2, v3 x, y, success
   4|         copy   v6 = v1                                           x         unnecessary copy
   5|         copy   v7 = v2                                           y         unnecessary copy
   6|  cast_number   v8 (float), v6 (int)                              float x
   7|          mov   [bss+9cc0], v8 :4b                                mouse.pointer.x = ^
   8|          mov   v9, [bss+318] :8b                                 window_height
   9|        binop   v10, v9 - v7                                      window_height - y
  10|  cast_number   v11 (float), v10 (s64)                            float^
  11|          mov   [bss+9cc4], v11 :4b                               mouse.pointer.y = ^
  12|          lea   v13, bss+9cc0                                     *mouse.pointer
  13|          lea   v14, bss+9cc0+8                                   *mouse.previous_position
  14|         call   == (v13, v14) -> v12                              == : above are :8b, could be passed directly as values
  15|          not   v15, v12                                          !=
  16|          mov   [bss+9cd0], v15 :1b                               mouse.moved_this_frame =
  17|        binop   v16, v13 + 8                                      calculate address of mouse.previous_position - could use v14
  18|       memcpy   v16, v13 {size 8}                                 mouse.previous_position = mouse.pointer - why can't we just do mov [bss+9cc0+8], v13 :8b?
  19|         call   shift_pressed () -> v17
  20|         jump   1 if v17 == 0                                     if shift_pressed()
  21|          mov   v18, [bss+280] :8b                                Input.mouse_delta_z
  22|  cast_number   v19 (float), v18 (int)                            float^
  23|     constant   v21 = 0x3f800000                                  WHEEL_SENSITIVITY
  24|        binop   v20, v19 * v21                                    *
  25|  cast_number   v22 (s32), v20 (float)                            s32^
  26|          mov   [bss+9cd4], v22 :4b                               mouse.scroll_x_delta =
  27|         jump   2

-------- Basic Block 1 -------- defines v23-27 --------

           ... dominating: block 0 instruction 20
1 predecessor: 0                                                       else
  28|          mov   v23, [bss+280] :8b                                Input.mouse_delta_z
  29|  cast_number   v24 (float), v23 (int)                            float^
  30|     constant   v26 = 0x3f800000                                  WHEEL_SENSITIVITY
  31|        binop   v25, v24 * v26                                    *
  32|  cast_number   v27 (s32), v25 (float)                            s32^
  33|          mov   [bss+9cd8], v27 :4b                               mouse.scroll_y_delta =

-------- Basic Block 2 -------- defines v28-32 --------

           ... dominating: block 0 instruction 20
1 predecessor: 1
  34|          mov   v28, [bss+9cd8] :4b                               mouse.scroll_y_delta
  35|     constant   v30 = 0x78                                        120
  36|        binop   v29, v28 % v30                                    %
  37|      compare   v31 = (v29 == 0)                                  ==
  38|          mov   [bss+9cdc], v31 :1b                               mouse.smooth_scroll =
  39|          mov   v32, [data+79a] :1b                               config.settings.smooth_scrolling
  40|         jump   3 if v32 != 0                                     if !config.settings.smooth_scrolling
  41|          mov   [bss+9cdc], v5 :1b                                mouse.smooth_scroll = false

-------- Basic Block 3 -------- defines v33-38 --------

           ... dominating: block 2 instruction 40
1 predecessor: 2
  42|          lea   v33, bss+9cc0+20                                  *mouse.left
  43|     constant   v34 = 0xa8                                        .MOUSE_BUTTON_LEFT
  44|         call   update_button (v33, v34)
  45|          lea   v35, bss+9cc0+40                                  *mouse.right
  46|     constant   v36 = 0xaa                                        .MOUSE_BUTTON_RIGHT
  47|         call   update_button (v35, v36)
  48|          lea   v37, bss+9cc0+60                                  *mouse.middle
  49|     constant   v38 = 0xa9                                        .MOUSE_BUTTON_MIDDLE
  50|         call   update_button (v37, v38)
  51|       return
Internal compiler error: Unable to find the procedure '__arithmetic_overflow' in Runtime_Support.

This happened outside compile-time execution, so it is likely the compiler's fault.

Stack trace of the compiler:


In Workspace 3 ("focus_debug"):
Error: Jai encountered an exception running the program and is terminating.

Command line arguments:
  jai.exe first.jai
  unknown(8B2E7614) : BaseThreadInitThunk


  Disassembly of 'increase_font_size' in Workspace 3 at C:/Repos/focus/src/main.jai:509
  - Stack size 32

  -------- Basic Block 0 -------- defines v1-6 --------

             (no dominating)

     0|   stack_node
     1|          mov   v1, [data+1a0] :8b                   font_size
     2|        binop   v2, v1 + 1                           font_size + 1
     3|     constant   v3 = 0x1e                            MAX_FONT_SIZE
     4|         jump   1 if v2 > v3                         if <=
     5|          lea   v4, data+1a0                         *font_size
     6|          mov   v5, [v4] :8b                         v5 = font_size
     7|        binop   v6, v5 + 1                           v6 = font_size + 1
     8|          mov   [v4], v6 :8b                         font_size += 1
     9|         call   init_fonts_and_dependent_things ()

  -------- Basic Block 1 --------

             ... dominating: block 0 instruction 4
  1 predecessor: 0
    10|       return


  Disassembly of 'update_window_size' in Workspace 3 at C:/Repos/focus/src/main.jai:572
  - Stack size 48

  -------- Basic Block 0 -------- defines v3-12 --------

             (no dominating)

     0|   stack_node
     1|          mov   [bss+2c8], v1 :8b                            window_width = w
     2|          mov   [bss+2c0], v2 :8b                            window_height = h
     3|          mov   v3, [bss+a270] :8b                           window
     4|         call   update_window (v3)
     5|     constant   v5 = 0
     6|          mov   v6, [bss+2c8] :8b                            window_width
     7|          mov   v7, [bss+2c0] :8b                            window_height
     8|         call   make_rect (v5, v5, v6, v7) -> v4{big 16}
     9|          lea   v8, bss+9778                                 *screen
    10|       memcpy   v8, v4 {size 16}                             screen = make_rect
    11|          mov   v11, [bss+a270] :8b                          window
    12|         call   platform_get_dpi_scale (v11) -> v10
    13|         copy   v9 = v10                                     new_dpi_scale
    14|          mov   v12, [data+11c] :4b                          dpi_scale
    15|         jump   1 if v9 == v12                               if !=
    16|          mov   [data+11c], v9 :4b                           dpi_scale = new_dpi_scale
    17|         call   init_fonts_and_dependent_things ()

  -------- Basic Block 1 --------

             ... dominating: block 0 instruction 15
  1 predecessor: 0
    18|       return



  Disassembly of 'main' in Workspace 3 at C:/Repos/focus/src/main.jai:3
  - Stack size 1536

  -------- Basic Block 0 -------- defines v1-58 --------

             (no dominating)

     0|   stack_node
     1|         call   get_cpu_info () -> v1{big 48}
     2|          lea   v2, bss+9740                          *cpu_info
     3|       memcpy   v2, v1 {size 48}
     4|         call   platform_setup ()
     5|         call   platform_config_dir () -> v3{big 16}
     6|          lea   v4, bss+308                           *config_dir
     7|       memcpy   v4, v3 {size 16}
     8|         call   platform_data_dir () -> v5{big 16}
     9|          lea   v6, bss+2f8                           *data_dir
    10|       memcpy   v6, v5 {size 16}

    11|          mov   v7, [bss+308] :8b                     config_dir.count
    12|      compare   v8 = (v7 > 0)                         assert arg
    13|          lea   v9, stack+70                          assert *message
    14|     constant   v10 = 0x10                            message.count = 16
    15|          mov   [v9], v10 :8b
    16|       string   v11, "Empty config dir"
    17|          mov   [v9+8], v11 :8b                       message.data
    18|          lea   v12, stack+80                         v12 : *[] Any
    19|        clear   v12+0 {size 16}                       v12.count+.data = 0
    20|          lea   v13, rdata+1c298                      #caller_location
    21|         call   assert (v8, v9, v12, v13)

    22|          lea   v15, stack+90                         *"/"
    23|     constant   v16 = 1                               "/".count
    24|          mov   [v15], v16 :8b
    25|       string   v17, "/"
    26|          mov   [v15+8], v17 :8b                      "/".data
    27|         call   ends_with (v4, v15) -> v14
    28|          not   v18, v14                              assert arg
    29|          lea   v19, stack+a0                         assert *message
    30|     constant   v20 = 0x2e
    31|          mov   [v19], v20 :8b                        message.count
    32|       string   v21, {long string, 46 bytes}
    33|          mov   [v19+8], v21 :8b                      message.data
    34|          lea   v22, stack+b0                         v22 : *[] Any
    35|          mov   [v22], v16 :8b                        v22.count = 1
    36|          lea   v23, stack+c0                         *Any (any)
    37|    emit_type   v24, string
    38|          mov   [v23], v24 :8b                        any.type = string
    39|          mov   [v23+8], v4 :8b                       any.value_pointer = *config_dir
    40|          mov   [v22+8], v23 :8b                      v22.data = any
    41|          lea   v25, rdata+1c2b8                      #caller_location
    42|         call   assert (v18, v19, v22, v25)

    43|          mov   v26, [bss+2f8] :8b                    data_dir.count
    44|      compare   v27 = (v26 > 0)                       assert arg
    45|          lea   v28, stack+d0                         assert *message
    46|     constant   v29 = 0xe
    47|          mov   [v28], v29 :8b                        message.count = 14
    48|       string   v30, "Empty data dir"
    49|          mov   [v28+8], v30 :8b                      message.data
    50|          lea   v31, rdata+1c2d8                      #caller_location
    51|         call   assert (v27, v28, v12, v31)

    52|         call   ends_with (v6, v15) -> v32
    53|          not   v33, v32                              assert arg
    54|          lea   v34, stack+e0                         assert *message
    55|     constant   v35 = 0x2c
    56|          mov   [v34], v35 :8b                        message.count
    57|       string   v36, {long string, 44 bytes}
    58|          mov   [v34+8], v36 :8b                      message.data
    59|          lea   v37, stack+f0                         *Any (any)
    60|          mov   [v37], v24 :8b                        any.type = string
    61|          mov   [v37+8], v6 :8b                       any.value_pointer = *data_dir
    62|          mov   [v22+8], v37 :8b                      args.data = any
    63|          lea   v38, rdata+1c2f8                      #caller_location
    64|         call   assert (v33, v34, v22, v38)

    65|          lea   v40, stack+100                        sprint *format_string
    66|     constant   v41 = 6
    67|          mov   [v40], v41 :8b                        format_string.count = 6
    68|       string   v42, "%/temp"
    69|          mov   [v40+8], v42 :8b                      format_string.data
    70|          lea   v43, stack+110                        *Any (any)
    71|          mov   [v43], v24 :8b                        any.type = string
    72|          mov   [v43+8], v6 :8b                       any.value_pointer = *data_dir
    73|          mov   [v22+8], v43 :8b                      sprint args.data = any
    74|         call   sprint (v40, v22) -> v39{big 16}
    75|          lea   v44, bss+2e8                          *temp_dir
    76|       memcpy   v44, v39 {size 16}                    temp_dir =

    77|          lea   v46, stack+130                        sprint *format_string
    78|     constant   v47 = 0xa
    79|          mov   [v46], v47 :8b                        format_string.count = 10
    80|       string   v48, "%/projects"
    81|          mov   [v46+8], v48 :8b                      format_string.data
    82|          lea   v49, stack+140                        *Any (any)
    83|          mov   [v49], v24 :8b                        any.type = string
    84|          mov   [v49+8], v4 :8b                       any.value_pointer = *config_dir
    85|          mov   [v22+8], v49 :8b                      sprint args.data = any
    86|         call   sprint (v46, v22) -> v45{big 16}
    87|          lea   v50, bss+2d8                          *projects_dir
    88|       memcpy   v50, v45 {size 16}                    projects_dir =

    89|         call   file_exists (v50) -> v52
    90|         copy   v51 = v52                             projects_dir_existed :=
    91|     constant   v54 = 0
    92|         call   make_directory_if_it_does_not_exist (v50, v54) -> v53
    93|         jump   1 if v53 != 0                         if !make_directory_if_it_does_not_exist
    94|          lea   v55, stack+160                        panic_messagebox *format_string
    95|     constant   v56 = 0x34
    96|          mov   [v55], v56 :8b                        format_string.count = 52
    97|       string   v57, {long string, 52 bytes}
    98|          mov   [v55+8], v57 :8b                      format_string.data
    99|          lea   v58, stack+170                        *Any (any)
   100|          mov   [v58], v24 :8b                        any.type = string
   101|          mov   [v58+8], v50 :8b                      any.value_pointer = *projects_dir
   102|          mov   [v22+8], v58 :8b                      sprint args.data = any
   103|         call   panic_messagebox (v55, v22)

  -------- Basic Block 1 -------- defines v59-64 --------

             ... dominating: block 0 instruction 93
  1 predecessor: 0
   104|         call   make_directory_if_it_does_not_exist (v44, v54) -> v59
   105|         jump   2 if v59 != 0                         if !make_directory_if_it_does_not_exist
   106|          lea   v60, stack+180                        panic_messagebox *format_string
   107|     constant   v61 = 0x48
   108|          mov   [v60], v61 :8b                        format_string.count = 72
   109|       string   v62, {long string, 72 bytes}
   110|          mov   [v60+8], v62 :8b                      format_string.data
   111|          mov   [v22], v16 :8b                        sprint args.count = 1
   112|          lea   v63, stack+190                        *Any (any)
   113|    emit_type   v64, string                           !!!
   114|          mov   [v63], v64 :8b                        any.type = string
   115|          mov   [v63+8], v44 :8b                      any.value_pointer = *temp_dir
   116|          mov   [v22+8], v63 :8b                      sprint args.data = any
   117|         call   panic_messagebox (v60, v22)

  -------- Basic Block 2 -------- defines v65-74 --------

             ... dominating: block 1 instruction 105
  1 predecessor: 1
   118|         jump   3 if v51 != 0                         if !projects_dir_existed
   119|          lea   v67, stack+1a0                        tprint *format_string
   120|     constant   v68 = 0x1e
   121|          mov   [v67], v68 :8b                        format_string.count = 31
   122|       string   v69, "%/Example Project.focus-config"
   123|          mov   [v67+8], v69 :8b                      format_string.data
   124|          mov   [v22], v16 :8b                        tpring.args.count = 1
   125|          lea   v70, stack+1b0                        *Any (any)
   126|    emit_type   v71, string
   127|          mov   [v70], v71 :8b                        any.type = string
   128|          mov   [v70+8], v50 :8b                      any.value_pointer = *projects_dir
   129|          mov   [v22+8], v70 :8b                      tprint args.data = any
   130|         call   tprint (v67, v22) -> v66{big 16}      write_entire_file name
   131|          lea   v72, stack+1d0                        write_entire_file *data
   132|     constant   v73 = 0x301                           EXAMPLE_PROJECT_FILE_DATA.count
   133|          mov   [v72], v73 :8b                        data.count
   134|       string   v74, {long string, 769 bytes}
   135|          mov   [v72+8], v74 :8b                      data.data
   136|         call   write_entire_file (v66, v72) -> v65

  -------- Basic Block 3 -------- defines v75-83 --------

             ... dominating: block 2 instruction 118
  1 predecessor: 2
   137|         call   init_file_watcher ()
   138|     constant   v78 = 1                               true
   139|         call   load_global_config (v78) -> v75, v76, v77
   140|         call   init_workspace ()
   141|         call   init_buffers ()
   142|         call   init_console ()
   143|          mov   v79, [data+782] :1b
   144|         jump   4 if v79 == 0                         if config.settings.open_on_monitor_one
   145|     constant   v80 = 0x779
   146|          mov   [data+128], v80 :8b                   window_x
   147|     constant   v81 = 0
   148|          mov   [data+120], v81 :8b                   window_y
   149|     constant   v82 = 0x60d
   150|          mov   [bss+2c0], v82 :8b                    window_width
   151|     constant   v83 = 0x418
   152|          mov   [bss+2b8], v83 :8b                    window_height
   153|         jump   5

  -------- Basic Block 4 -------- defines v84-92 --------    else

             ... dominating: block 3 instruction 144
  1 predecessor: 3
   154|          mov   v88, [data+781] :1b                   config.settings.open_on_the_biggest_monitor
   155|         call   platform_get_centered_window_dimensions (v88) -> v84, v85, v86, v87
   156|  cast_number   v89 (s64), v84 (s32)
   157|          mov   [data+128], v89 :8b                   window_x
   158|  cast_number   v90 (s64), v85 (s32)
   159|          mov   [data+120], v90 :8b                   window_y
   160|  cast_number   v91 (s64), v86 (s32)
   161|          mov   [bss+2c0], v91 :8b                    window_width
   162|  cast_number   v92 (s64), v87 (s32)
   163|          mov   [bss+2b8], v92 :8b                    window_height

  -------- Basic Block 5 -------- defines v93-96 --------

             ... dominating: block 3 instruction 144
  1 predecessor: 4
   164|         jump   6 if v54 == 0                         ifx DEBUG (v54 is the 0/false, DEBUG is the 0 literal here)
   165|          lea   v94, stack+1e0                        *string
   166|     constant   v95 = 0x12
   167|          mov   [v94], v95 :8b                        string.count = 18
   168|       string   v96, "Focus (debug mode)"
   169|          mov   [v94+8], v96 :8b                      string.data
   170|         copy   v93 = v94                             v93 is ifx result
   171|         jump   7

  -------- Basic Block 6 -------- defines v97-99 --------

             ... dominating: block 5 instruction 164
  1 predecessor: 5
   172|          lea   v97, stack+1f0                        *string
   173|     constant   v98 = 5
   174|          mov   [v97], v98 :8b                        string.count = 5
   175|       string   v99, "Focus"
   176|          mov   [v97+8], v99 :8b                      string.data
   177|         copy   v93 = v97                             v93 is ifx result

  -------- Basic Block 7 -------- defines v100-117 --------

             ... dominating: block 5 instruction 164
  1 predecessor: 6
   178|          lea   v100, bss+2c8                         *window_generic_title
   179|       memcpy   v100, v93 {size 16}                   window_generic_title =

   180|         call   platform_create_window ()
   181|         call   get_command_line_arguments () -> v101{big 16}
   182|          lea   v102, stack+200                       *args
   183|       memcpy   v102, v101 {size 16}                  args :=
   184|          mov   v103, [stack+200] :8b                 args.count
   185|     constant   v104 = 2
   186|         jump   11 if v103 != v104                    if args.count == 2
   187|          mov   v107, [v102] :8b                      args.count
   188|  array_check   v16, v107                             v16 is 1
   189|          mov   v108, [v102+8] :8b                    args.data
   190|        binop   v110, v16 * 16                        1 * sizeof(args[0])
   191|        binop   v109, v108 + v110                     *args.data[1]
   192|         call   is_directory (v109) -> v105, v106
   193|         jump   8 if v105 == 0                        if is_directory(args[1])
   194|         call   start_fresh_session () -> v111{big 152}
   195|          lea   v112, data+2dd8                       *session
   196|       memcpy   v112, v111 {size 152}                 session =
   197|          mov   v113, [v102] :8b                      args.count
   198|  array_check   v16, v113                             v16 is 1
   199|          mov   v114, [v102+8] :8b                    args.data
   200|        binop   v116, v16 * 16                        1 * sizeof(args[0])
   201|        binop   v115, v114 + v116                     *args.data[1]
   202|     constant   v117 = 0
   203|         call   add_directory_to_workspace (v115, v117)
   204|         jump   10

  -------- Basic Block 8 -------- defines v118-129 --------  else

             ... dominating: block 7 instruction 193
  1 predecessor: 7
   205|          mov   v119, [v102] :8b                      args.count
   206|  array_check   v16, v119                             v16 is 1
   207|          mov   v120, [v102+8] :8b                    args.data
   208|        binop   v122, v16 * 16                        1 * sizeof(args[0])
   209|        binop   v121, v120 + v122                     *args.data[1]
   210|         call   file_exists (v121) -> v118
   211|         jump   9 if v118 == 0                        if file_exists(args[1])
   212|         call   start_fresh_session () -> v123{big 152}
   213|          lea   v124, data+2dd8
   214|       memcpy   v124, v123 {size 152}                 session =
   215|          mov   v125, [v102] :8b                      args.count
   216|  array_check   v16, v125                             v16 is 1
   217|          mov   v126, [v102+8] :8b                    args.data
   218|        binop   v128, v16 * 16                        1 * sizeof(args[0])
   219|        binop   v127, v126 + v128                     *args.data[1]
   220|     constant   v129 = 0
   221|         call   editors_open_file (v127, v129)
   222|         jump   10

  -------- Basic Block 9 -------- defines v130-147 --------  else

             ... dominating: block 8 instruction 211         init_session_with_no_guidance macro
  1 predecessor: 8
   223|         call   maybe_load_previous_session () -> v130{big 152}
   224|          lea   v131, data+2dd8
   225|       memcpy   v131, v130 {size 152}                 session =
   226|          lea   v132, data+2dd8+10
   227|          mov   v134, [v132] :8b                      session.project
   228|      compare   v133 = (v134 != 0)
   229|         jump   10 if v133 == 0                       if session.project
   230|         call   load_project_config (v132) -> v136, v137, v138
   231|         copy   v135 = v136                           success :=
   232|         jump   10 if v135 != 0
   233|          lea   v139, stack+3e8                       log_error *format_string
   234|     constant   v140 = 0x20
   235|          mov   [v139], v140 :8b                      format_string.count = 32
   236|       string   v141, {long string, 32 bytes}
   237|          mov   [v139+8], v141 :8b                    format_string.data
   238|          mov   [v22], v16 :8b                        log_error args.count = 1
   239|          lea   v142, stack+3f8                       *Any (any)
   240|    emit_type   v143, string
   241|          mov   [v142], v143 :8b                      any.type = string
   242|          mov   [v142+8], v132 :8b                    any.value_pointer = *session.project
   243|          mov   [v22+8], v142 :8b                     log_error args.data = *any
   244|          lea   v144, rdata+1c318                     #caller_location
   245|     constant   v145 = 0                              log_error flags
   246|     constant   v146 = 0                              log_error user_flags
   247|     constant   v147 = 0                              log_error section
   248|         call   log_error (v139, v22, v144, v145, v146, v147)

  -------- Basic Block 10 --------

             ... dominating: block 7 instruction 193
  4 predecessors: 9, 9, 9, 8
   249|         jump   12

  -------- Basic Block 11 -------- defines v148-165 --------

             ... dominating: block 7 instruction 186         init_session_with_no_guidance macro
  1 predecessor: 7
   250|         call   maybe_load_previous_session () -> v148{big 152}
   251|          lea   v149, data+2dd8
   252|       memcpy   v149, v148 {size 152}                 session =
   253|          lea   v150, data+2dd8+10
   254|          mov   v152, [v150] :8b                      session.project
   255|      compare   v151 = (v152 != 0)
   256|         jump   12 if v151 == 0                       if session.project
   257|         call   load_project_config (v150) -> v154, v155, v156
   258|         copy   v153 = v154                           success :=
   259|         jump   12 if v153 != 0
   260|          lea   v157, stack+4a0                       log_error *format_string
   261|     constant   v158 = 0x20
   262|          mov   [v157], v158 :8b                      format_string.count = 32
   263|       string   v159, {long string, 32 bytes}
   264|          mov   [v157+8], v159 :8b                    format_string.data
   265|          mov   [v22], v16 :8b                        log_error args.count = 1
   266|          lea   v160, stack+4b0                       *Any (any)
   267|    emit_type   v161, string
   268|          mov   [v160], v161 :8b                      any.type = string
   269|          mov   [v160+8], v150 :8b                    any.value_pointer = *session.project
   270|          mov   [v22+8], v160 :8b                     log_error args.data = *any
   271|          lea   v162, rdata+1c318                     #caller_location
   272|     constant   v163 = 0                              log_error flags
   273|     constant   v164 = 0                              log_error user_flags
   274|     constant   v165 = 0                              log_error section
   275|         call   log_error (v157, v22, v162, v163, v164, v165)

  -------- Basic Block 12 -------- defines v166-170 --------

             ... dominating: block 7 instruction 186
  3 predecessors: 11, 11, 11
   276|         call   refresh_code_color_map () -> v166{big 208}
   277|          lea   v167, bss+a454                        *CODE_COLOR_MAP
   278|       memcpy   v167, v166 {size 208}                 CODE_COLOR_MAP =
   279|          lea   v168, data+6e0+3d8                    *config.platform
   280|         call   platform_apply_config (v168)
   281|          mov   v169, [data+780] :1b
   282|         jump   13 if v169 == 0                       if config.settings.maximize_on_start
   283|          mov   v170, [bss+a270] :8b                  *window
   284|         call   platform_maximize_window (v170)

  -------- Basic Block 13 -------- defines v171-189 --------

             ... dominating: block 12 instruction 282
  1 predecessor: 12
   285|          mov   v171, [bss+a270] :8b                  *window
   286|         call   platform_enable_drag_and_drop (v171)
   287|          mov   v174, [bss+a270] :8b                  *window
   288|         call   get_render_dimensions (v174) -> v172, v173
   289|  cast_number   v175 (s64), v172 (s32)
   290|          mov   [bss+2c0], v175 :8b                   window_width =
   291|  cast_number   v176 (s64), v173 (s32)
   292|          mov   [bss+2b8], v176 :8b                   window_height =
   293|     constant   v178 = 0
   294|          mov   v179, [bss+2c0] :8b                   window_width
   295|          mov   v180, [bss+2b8] :8b                   window_height
   296|         call   make_rect (v178, v178, v179, v180) -> v177{big 16}
   297|          lea   v181, bss+96e8                        *screen
   298|       memcpy   v181, v177 {size 16}                  screen =
   299|          mov   v182, [bss+a270] :8b                  *window
   300|         call   set_render_target (v182)
   301|         call   init_logger ()
   302|         call   start_initial_workspace_scan ()
   303|          mov   v184, [bss+a270] :8b
   304|         call   platform_get_dpi_scale (v184) -> v183
   305|          mov   [data+11c], v183 :4b                  dpi_scale =
   306|         call   init_fonts_and_dependent_things ()
   307|          mov   v185, [bss+29c] :4b                   line_height
   308|          mov   [bss+298], v185 :4b                   old_line_height = line_height
   309|     constant   v186 = 1                              window_has_focus
   310|     constant   v187 = 0                              window_resized
   311|          lea   v188, stack+5a0                       *shift_key
   312|     constant   v189 = 0xbff0000000000000
   313|          mov   [v188], v189 :8b                      shift_key.last_press
   314|          mov   [v188+8], v189 :8b                    shift_key.last_release
   315|        clear   v188+16 {size 8}                      press_count
   316|         jump   14 if v78 == 0                        if eye_tracking_active (v78 is true, 0 is eye_tracking_active)
   317|         call   eye_tracking_init ()

  -------- Basic Block 14 -------- defines v190-191 --------

             ... dominating: block 13 instruction 316
  1 predecessor: 13
   318|          mov   v190, [bss+2b2] :1b                   should_quit
   319|         jump   77 if v190 != 0                       break while if should_quit
   320|          mov   [data+118], v78 :1b                   redraw_requested = true
   321|          mov   v191, [data+118] :1b
   322|         jump   15 if v191 != 0                       if !redraw_requested
   323|         call   platform_wait_message ()

  -------- Basic Block 15 --------

             ... dominating: block 14 instruction 322
  1 predecessor: 14
   324|         jump   16 if v78 == 0                        if eye_tracking_active (v78 is true, 0 is eye_tracking_active)
   325|         call   eye_tracking_tick ()

  -------- Basic Block 16 -------- defines v192-194 --------

             ... dominating: block 15 instruction 324
  1 predecessor: 15
   326|         call   update_window_events ()
   327|          mov   v192, [bss+2a8] :8b                   frame_time
   328|     constant   v193 = 0x4122750000000000             MAX_TIME_BEFORE_RESETTING
   329|         jump   17 if v192 <= v193                    if frame_time > MAX_TIME_BEFORE_RESETTING
   330|         call   init_time ()
   331|         call   get_time () -> v194
   332|          mov   [bss+2a8], v194 :8b                   frame_time =

  -------- Basic Block 17 -------- defines v195-203 --------

             ... dominating: block 16 instruction 329
  1 predecessor: 16
   333|         call   get_time () -> v196
   334|         copy   v195 = v196                           current_time =
   335|          mov   v199, [bss+2a8] :8b                   frame_time
   336|        binop   v198, v195 - v199                     current_time - frame_time
   337|     constant   v200 = 0x3f91111111111111             MAX_FRAME_DT
   338|         call   min (v198, v200) -> v197
   339|          mov   [data+110], v197 :8b                  frame_dt =
   340|          mov   [bss+2a8], v195 :8b                   frame_time = current_time
   341|          mov   v201, [bss+29c] :4b                   line_height
   342|          mov   [bss+298], v201 :4b                   old_line_height = line_height
   343|         call   get_window_resizes () -> v202{big 16} *[]Window_Resize_Record (window_sizes)
   344|     constant   v203 = 0                              it_index

  -------- Basic Block 18 -------- defines v204-221 --------

             ... dominating: block 17 instruction 344
  1 predecessor: 17
   345|          mov   v204, [v202] :8b                      window_sizes.count
   346|         jump   23 if v203 >= v204                    for loop exit condition
   347|          mov   v206, [v202+8] :8b                    windows_sizes.data
   348|        binop   v207, v203 * 16                       it_index * size
   349|        binop   v205, v206 + v207                     *it
   350|          mov   v208, [v205] :8b                      it
   351|         call   update_window (v208)
   352|          mov   v209, [v205] :8b                      it
   353|          mov   v210, [bss+a270] :8b                  window
   354|         jump   22 if v209 != v210                    if it.window == window
   355|          mov   v212, [bss+239] :1b                   dont_ignore_next_window_resize
   356|      compare   v211 = (v212 != 0)                    should_reinit = || result
   357|         jump   20 if v211 != 0                       short circuit ||
   358|          mov   v213, [v205+8] :4b                    it.width
   359|  cast_number   v214 (s64), v213 (s32)
   360|          mov   v216, [bss+2c0] :8b                   window_width
   361|      compare   v215 = (v214 != v216)                 it.width != window_width
   362|      compare   v217 = (v215 != 0)                    v217 = || result in block 19
   363|         jump   19 if v217 != 0                       short circuit ||
   364|          mov   v218, [v205+c] :4b                    it.height
   365|  cast_number   v219 (s64), v218 (s32)
   366|          mov   v221, [bss+2b8] :8b                   window_height
   367|      compare   v220 = (v219 != v221)
   368|         copy   v217 = v220                           v217 = || result in block 19

  -------- Basic Block 19 --------

             ... dominating: block 18 instruction 363
  1 predecessor: 18
   369|         copy   v211 = v217                           should_reinit = || result

  -------- Basic Block 20 -------- defines v222-230 --------

             ... dominating: block 18 instruction 357
  1 predecessor: 18
   370|          mov   v222, [v205+8] :4b                    it.width
   371|  cast_number   v223 (s64), v222 (s32)
   372|          mov   [bss+2c0], v223 :8b                   window_width = it.width
   373|          mov   v224, [v205+c] :4b                    it.height
   374|  cast_number   v225 (s64), v224 (s32)
   375|          mov   [bss+2b8], v225 :8b                   window_height = it.height
   376|         jump   21 if v211 == 0                       if should_reinit
   377|          mov   v227, [bss+2c0] :8b                   window_width
   378|          mov   v228, [bss+2b8] :8b                   window_height
   379|         call   make_rect (v178, v178, v227, v228) -> v226{big 16}
   380|       memcpy   v181, v226 {size 16}                  screen =
   381|          mov   v230, [bss+a270] :8b                  window
   382|         call   platform_get_dpi_scale (v230) -> v229
   383|          mov   [data+11c], v229 :4b                  dpi_scale =
   384|         call   init_fonts_and_dependent_things ()
   385|          mov   [bss+239], v54 :1b                    dont_ignore_next_window_resize = false

  -------- Basic Block 21 --------

             ... dominating: block 20 instruction 376
  1 predecessor: 20
   386|     constant   v187 = 1                              window_resized = true

  -------- Basic Block 22 --------

             ... dominating: block 18 instruction 350
  3 predecessors: 18, 17, 18
   387|        binop   v203, v203 + 1                        it_index += 1
   388|         jump   18                                    loop for

  -------- Basic Block 23 -------- defines v231-237 --------

             ... dominating: block 17 instruction 344
  1 predecessor: 22
   389|          mov   v231, [bss+2c0] :8b                   window_width
   390|     constant   v233 = 0x64                           MIN_WINDOW_WIDTH, MIN_WINDOW_HEIGHT
   391|      compare   v232 = (v231 < v233)
   392|      compare   v235 = (v232 != 0)                    window_width < MIN_WINDOW_WIDTH
   393|          mov   v236, [bss+2b8] :8b                   window_height
   394|      compare   v237 = (v236 < v233)                  window_height < MIN_WINDOW_HEIGHT
   395|        binop   v234, v235 | v237                     ||
   396|         jump   24 if v234 == 0                       proceed inside loop
   397|         jump   14                                    continue

  -------- Basic Block 24 -------- defines v238-243 --------

             ... dominating: block 23 instruction 396
  1 predecessor: 23
   398|         call   update_mouse_state ()
   399|          lea   v238, stack+5d8                       *screen_with_title_bar
   400|       memcpy   v238, v181 {size 16}                  screen_with_title_bar : Rect = screen
   401|          mov   v239, [v238+c] :4b                    v239 = screen_with_title_bar.h
   402|     constant   v241 = 0x43480000                     200.0
   403|        binop   v240, v239 + v241
   404|          mov   [v238+12], v240 :4b                   screen_with_title_bar.h =
   405|          mov   [data+118], v54 :1b                   redraw_requested = false
   406|     constant   v187 = 0                              window_resized = false
   407|          mov   [bss+278], v54 :1b                    dont_scroll_this_frame = false
   408|          mov   v186, [bss+1f9] :1b                   window_has_focus = Input.input_application_has_focus
   409|         call   maybe_update_workspace_buffers ()
   410|         call   finder_update ()

   411|          lea   v242, bss+8738                        *open_editors
   412|     constant   v243 = 0                              it_index

  -------- Basic Block 25 -------- defines v244-263 --------

             ... dominating: block 24 instruction 412
  1 predecessor: 24
   413|          mov   v244, [v242] :8b                      open_editors.count
   414|         jump   27 if v243 >= v244                    for loop exit condition
   415|          mov   v246, [v242+8] :8b                    open_editors.data
   416|        binop   v247, v243 * 744                      it_index * size
   417|        binop   v245, v246 + v247                     it (this is a for *)
   418|        binop   v248, v245 + 65                       it.cursor_moved
   419|     constant   v249 = 0                              .has_not_moved
   420|          mov   [v248], v249 :1b                      cursor_moved = .has_not_moved;
   421|          mov   v250, [bss+298] :4b                   old_line_height
   422|          mov   v251, [bss+29c] :4b                   line_height
   423|         jump   26 if v250 == v251                    if old_line_height != line_height
   424|        binop   v253, v245 + 560                      *it.viewport
   425|          mov   v254, [v253] :4b
   426|  cast_number   v255 (float), v254 (s32)              it.viewport.top
   427|          mov   v256, [bss+298] :4b                   old_line_height
   428|        binop   v252, v255 / v256                     lines_scrolled :=
   429|        binop   v257, v245 + 560                      *it.viewport
   430|          mov   v259, [bss+29c] :4b                   line_height
   431|        binop   v258, v252 * v259                     lines_scrolled * line_height
   432|  cast_number   v260 (s32), v258 (float)
   433|          mov   [v257+20], v260 :4b                   it.viewport.scroll_y.target =
   434|        binop   v261, v245 + 560                      *it.viewport
   435|        binop   v262, v245 + 560                      *it.viewport
   436|          mov   v263, [v262+14] :4b                   it.viewport.scroll_y.target
   437|          mov   [v261], v263 :4b                      it.viewport.top =

  -------- Basic Block 26 --------

             ... dominating: block 25 instruction 418
  3 predecessors: 25, 24, 25
   438|        binop   v243, v243 + 1                        it_index += 1
   439|         jump   25                                    loop for

  -------- Basic Block 27 -------- defines v264-266 --------

             ... dominating: block 24 instruction 412
  1 predecessor: 26
   440|     constant   v264 = 0                              num_text_input_events_to_ignore := 0
   441|         call   start_key_sequence_handling ()
   442|          lea   v265, bss+85a8                        *Input.events_this_frame
   443|     constant   v266 = 0                              it_index

  -------- Basic Block 28 -------- defines v267-272 --------

             ... dominating: block 27 instruction 443
  1 predecessor: 27
   444|          mov   v267, [v265] :8b                      Input.events_this_frame.count
   445|         jump   72 if v266 >= v267                    for loop exit condition
   446|          mov   v269, [v265+8] :8b                    Input.events_this_frame.data
   447|        binop   v270, v266 * 48                       it_index * size
   448|        binop   v268, v269 + v270                     *event
   449|          mov   v271, [v268] :4b                      event (it)
   450|     constant   v272 = 5                              .QUIT
   451|         jump   30 if v271 != v272                    case .QUIT

  -------- Basic Block 29 --------

             ... dominating: block 28 instruction 451
  1 predecessor: 28
   452|          mov   [bss+2b2], v78 :1b                    should_quit = true
   453|         jump   56

  -------- Basic Block 30 -------- defines v273 --------

             ... dominating: block 28 instruction 451
  1 predecessor: 28
   454|     constant   v273 = 1                              .KEYBOARD
   455|         jump   47 if v271 != v273                    case .KEYBOARD

  -------- Basic Block 31 -------- defines v274-282 --------

             ... dominating: block 30 instruction 455
  1 predecessor: 30
   456|          mov   v274, [data+787] :1b                  config.settings.double_shift_to_search_in_workspace
   457|      compare   v276 = (v274 != 0)
   458|          mov   v277, [v268+8] :4b                    event.key_code
   459|     constant   v279 = 0x8d                           .SHIFT
   460|      compare   v278 = (v277 == v279)
   461|        binop   v275, v276 & v278
   462|         jump   41 if v275 == 0                       if
   463|          mov   v280, [v268+4] :4b                    event.key_pressed
   464|         jump   32 if v280 != 0
   465|          lea   v281, stack+5a0+8                     *last_release
   466|          mov   v282, [bss+2a8] :8b                   frame_time
   467|          mov   [v281], v282 :8b                      last_release = frame_time

  -------- Basic Block 32 -------- defines v283-286 --------

             ... dominating: block 31 instruction 464
  1 predecessor: 31
   468|          mov   v283, [v268+4] :4b                    event.key_pressed
   469|      compare   v284 = (v283 != 0)
   470|         jump   33 if v284 == 0                       short circuit &&
   471|        binop   v286, v268 + 12                       event.modifier_flags
   472|         call   only_shift_pressed (v286) -> v285
   473|         copy   v284 = v285

  -------- Basic Block 33 -------- defines v287-292 --------

             ... dominating: block 32 instruction 470
  1 predecessor: 32
   474|         jump   40 if v284 == 0
   475|          mov   v287, [stack+5a0] :8b                 last_pressed
   476|          mov   v289, [stack+5a8] :8b                 last_release
   477|      compare   v288 = (v287 < v289)
   478|      compare   v290 = (v288 != 0)
   479|         jump   34 if v290 == 0                       short circuit &&
   480|          mov   v291, [stack+5b0] :8b                 press_count
   481|      compare   v292 = (v291 > 0)
   482|         copy   v290 = v292

  -------- Basic Block 34 -------- defines v293-298 --------

             ... dominating: block 33 instruction 479
  1 predecessor: 33
   483|      compare   v293 = (v290 != 0)
   484|         jump   35 if v293 == 0                       short circuit &&
   485|          mov   v294, [bss+2a8] :8b                   frame_time
   486|          mov   v296, [stack+5a0] :8b                 last_press
   487|        binop   v295, v294 - v296                     frame_time - last_press
   488|     constant   v298 = 0x3fc999999999999a             0.2
   489|      compare   v297 = (v295 < v298)
   490|         copy   v293 = v297

  -------- Basic Block 35 -------- defines v299 --------

             ... dominating: block 34 instruction 484
  1 predecessor: 34
   491|         jump   38 if v293 == 0
   492|         call   finder_is_open () -> v299
   493|         jump   36 if v299 == 0                       if finder_is_open()
   494|         call   finder_close ()
   495|         jump   37

  -------- Basic Block 36 --------                           else

             ... dominating: block 35 instruction 493
  1 predecessor: 35
   496|         call   finder_open_from_editor ()

  -------- Basic Block 37 -------- defines v300 --------

             ... dominating: block 35 instruction 493
  1 predecessor: 36
   497|          lea   v300, stack+5a0+10                    *press_count
   498|          mov   [v300], v178 :8b                      press_count = 0
   499|         jump   39

  -------- Basic Block 38 -------- defines v301 --------

             ... dominating: block 35 instruction 491
  1 predecessor: 33
   500|          lea   v301, stack+5a0+10                    *press_count
   501|          mov   [v301], v16 :8b                       press_count = 1

  -------- Basic Block 39 -------- defines v302-303 --------

             ... dominating: block 35 instruction 491
  1 predecessor: 38
   502|          lea   v302, stack+5a0                       *last_press
   503|          mov   v303, [bss+2a8] :8b                   frame_time
   504|          mov   [v302], v303 :8b                      last_press = frame_time

  -------- Basic Block 40 -------- defines v304-306 --------

             ... dominating: block 33 instruction 474
  1 predecessor: 32
   505|          mov   v304, [v268+4] :4b                    event.key_pressed
   506|         jump   41 if v304 == 0
   507|          lea   v305, stack+5a0                       *last_press
   508|          mov   v306, [bss+2a8] :8b                   frame_time
   509|          mov   [v305], v306 :8b                      last_press = frame_time

  -------- Basic Block 41 -------- defines v307-311 --------

             ... dominating: block 31 instruction 462
  2 predecessors: 40, 31
   510|          mov   v307, [v268+8] :4b                    event.key_code
   511|     constant   v308 = 0x8c                           .CTRL
   512|         jump   44 if v307 != v308
   513|          mov   v309, [bss+1a] :1b                    buffer_switcher_hot
   514|      compare   v310 = (v309 != 0)
   515|         jump   42 if v310 == 0                       short circuit &&
   516|          mov   v311, [v268+4] :4b                    event.key_pressed
   517|      compare   v310 = (v311 == 0)

  -------- Basic Block 42 --------

             ... dominating: block 41 instruction 515
  1 predecessor: 41
   518|         jump   43 if v310 == 0
   519|         call   finalize_buffer_switch ()

  -------- Basic Block 43 -------- defines v312-313 --------

             ... dominating: block 42 instruction 518
  1 predecessor: 41
   520|          mov   v312, [v268+4] :4b                    event.key_pressed
   521|      compare   v313 = (v312 != 0)
   522|          mov   [bss+1a], v313 :1b                    buffer_switcher_hot =

  -------- Basic Block 44 -------- defines v314-321 --------

             ... dominating: block 41 instruction 512
  1 predecessor: 41
   523|          mov   v314, [v268+4] :4b                    event.key_pressed
   524|         jump   46 if v314 == 0
   525|          mov   v315, [v268+8] :4b                    event.key_code
   526|     constant   v317 = 0x1b                           .ESCAPE
   527|      compare   v316 = (v315 == v317)
   528|      compare   v319 = (v316 != 0)
   529|          mov   v320, [bss+9278] :4b                  prev_key_pressed
   530|      compare   v321 = (v320 == v317)
   531|        binop   v318, v319 & v321                     &&
   532|         jump   45 if v318 == 0
   533|         call   cleanup_extraneous_windows ()

  -------- Basic Block 45 -------- defines v322 --------

             ... dominating: block 44 instruction 532
  1 predecessor: 44
   534|          mov   v322, [v268+8] :4b                    event.key_code
   535|          mov   [bss+9278], v322 :4b                  prev_key_pressed

  -------- Basic Block 46 --------

             ... dominating: block 44 instruction 524
  1 predecessor: 44
   536|         jump   56

  -------- Basic Block 47 -------- defines v323 --------

             ... dominating: block 30 instruction 455
  1 predecessor: 30
   537|     constant   v323 = 4                              .MOUSE_WHEEL
   538|         jump   51 if v271 != v323                    casse .MOUSE_WHEEL

  -------- Basic Block 48 -------- defines v324-325 --------

             ... dominating: block 47 instruction 538
  1 predecessor: 47
   539|         call   ctrl_or_cmd_pressed () -> v324
   540|         jump   50 if v324 == 0
   541|          mov   v325, [v268+1c] :4b                   event.wheel_delta
   542|         jump   49 if v325 >= 0
   543|         call   decrease_font_size ()
   544|          mov   [bss+278], v78 :1b                    dont_scroll_this_frame = true
   545|         jump   50

  -------- Basic Block 49 -------- defines v326 --------

             ... dominating: block 48 instruction 542
  1 predecessor: 48
   546|          mov   v326, [v268+1c] :4b                   event.wheel_delta
   547|         jump   50 if v326 <= 0
   548|         call   increase_font_size ()
   549|          mov   [bss+278], v78 :1b                    dont_scroll_this_frame = true

  -------- Basic Block 50 --------

             ... dominating: block 48 instruction 540
  3 predecessors: 49, 49, 48
   550|         jump   56

  -------- Basic Block 51 -------- defines v327 --------

             ... dominating: block 47 instruction 538
  1 predecessor: 47
   551|     constant   v327 = 6                              .DRAG_AND_DROP_FILES
   552|         jump   53 if v271 != v327

  -------- Basic Block 52 -------- defines v328 --------

             ... dominating: block 51 instruction 552
  1 predecessor: 51
   553|        binop   v328, v268 + 32                       event.files
   554|         call   editors_handle_file_drop (v328)
   555|         jump   56

  -------- Basic Block 53 -------- defines v329 --------

             ... dominating: block 51 instruction 552
  1 predecessor: 51
   556|     constant   v329 = 2                              .TEXT_INPUT
   557|         jump   56 if v271 != v329                    case .TEXT_INPUT

  -------- Basic Block 54 --------

             ... dominating: block 53 instruction 557
  1 predecessor: 53
   558|         jump   55 if v264 == 0                       num_text_events_to_ignore
   559|        binop   v264, v264 + -1                       num_text_events_to_ignore -= 1
   560|         jump   71                                    continue

  -------- Basic Block 55 --------

             ... dominating: block 54 instruction 558
  1 predecessor: 54
   561|         jump   56

  -------- Basic Block 56 -------- defines v330-337 --------

             ... dominating: block 28 instruction 451
  7 predecessors: 28, 29, 31, 48, 52, 54, 54
   562|     constant   v330 = 0                              handled := false
   563|         call   map_event_to_action (v268) -> v332, v333{big 24}
   564|         copy   v331 = v332                           action :=
   565|     constant   v335 = 0                              .in_place
   566|         call   handle_common_editor_action (v331, v335) -> v334
   567|         copy   v330 = v334                           handled =
   568|         jump   70 if v330 != 0                       if !handled
   569|          mov   v336, [data+258] :8b                  active_global_widget
   570|     constant   v337 = 0                              .editors
   571|         jump   58 if v336 != v337                    case .editors

  -------- Basic Block 57 -------- defines v338 --------

             ... dominating: block 56 instruction 571
  1 predecessor: 56
   572|         call   editors_handle_event (v268) -> v338
   573|         copy   v330 = v338                           handled =
   574|         jump   70

  -------- Basic Block 58 -------- defines v339 --------

             ... dominating: block 56 instruction 571
  1 predecessor: 56
   575|     constant   v339 = 1                              .finder
   576|         jump   60 if v336 != v339                    case .finder

  -------- Basic Block 59 -------- defines v340 --------

             ... dominating: block 58 instruction 576
  1 predecessor: 58
   577|         call   finder_handle_event (v268) -> v340
   578|         copy   v330 = v340                           handled =
   579|         jump   70

  -------- Basic Block 60 -------- defines v341 --------

             ... dominating: block 58 instruction 576
  1 predecessor: 58
   580|     constant   v341 = 2                              .open_file_dialog
   581|         jump   62 if v336 != v341                    case open_file_dialog

  -------- Basic Block 61 -------- defines v342 --------

             ... dominating: block 60 instruction 581
  1 predecessor: 60
   582|         call   open_file_dialog_handle_event (v268) -> v342
   583|         copy   v330 = v342                           handled =
   584|         jump   70

  -------- Basic Block 62 -------- defines v343 --------

             ... dominating: block 60 instruction 581
  1 predecessor: 60
   585|     constant   v343 = 3                              .go_to_line_dialog
   586|         jump   64 if v336 != v343                    case .go_to_line_dialog

  -------- Basic Block 63 -------- defines v344 --------

             ... dominating: block 62 instruction 586
  1 predecessor: 62
   587|         call   go_to_line_dialog_handle_event (v268) -> v344
   588|         copy   v330 = v344                           handled =
   589|         jump   70

  -------- Basic Block 64 -------- defines v345 --------

             ... dominating: block 62 instruction 586
  1 predecessor: 62
   590|     constant   v345 = 5                              .unsaved_buffers_dialog
   591|         jump   66 if v336 != v345                    case .unsaved_buffers_dialog

  -------- Basic Block 65 -------- defines v346 --------

             ... dominating: block 64 instruction 591
  1 predecessor: 64
   592|         call   unsaved_buffers_dialog_handle_event (v268) -> v346
   593|         copy   v330 = v346                           handled =
   594|         jump   70

  -------- Basic Block 66 -------- defines v347 --------

             ... dominating: block 64 instruction 591
  1 predecessor: 64
   595|     constant   v347 = 4                              .commands_dialog
   596|         jump   68 if v336 != v347                    case .commands_dialog

  -------- Basic Block 67 -------- defines v348 --------

             ... dominating: block 66 instruction 596
  1 predecessor: 66
   597|         call   commands_dialog_handle_event (v268) -> v348
   598|         copy   v330 = v348                           handled =
   599|         jump   70

  -------- Basic Block 68 -------- defines v349 --------

             ... dominating: block 66 instruction 596
  1 predecessor: 66
   600|     constant   v349 = 6                              .open_project_dialog
   601|         jump   70 if v336 != v349                    case .open_project_dialog

  -------- Basic Block 69 -------- defines v350 --------

             ... dominating: block 68 instruction 601
  1 predecessor: 68
   602|         call   open_project_dialog_handle_event (v268) -> v350
   603|         copy   v330 = v350                           handled =
   604|         jump   70

  -------- Basic Block 70 -------- defines v351-357 --------

             ... dominating: block 56 instruction 568
  10 predecessors: 56, 57, 59, 61, 63, 65, 67, 69, 69, 56
   605|      compare   v352 = (v330 != 0)                    handled
   606|          mov   v353, [v268] :4b                      event.type
   607|     constant   v355 = 1                              .KEYBOARD
   608|      compare   v354 = (v353 == v355)
   609|        binop   v351, v352 & v354
   610|         jump   71 if v351 == 0
   611|          mov   v356, [v268+16] :2b                   event.text_input_count
   612|  cast_number   v357 (s64), v356 (u16)
   613|         copy   v264 = v357                           num_text_input_events_to_ignore

  -------- Basic Block 71 --------

             ... dominating: block 28 instruction 449
  3 predecessors: 70, 27, 28
   614|        binop   v266, v266 + 1                        it_index += 1
   615|         jump   28                                    loop for

  -------- Basic Block 72 -------- defines v358-360 --------

             ... dominating: block 27 instruction 443
  1 predecessor: 71
   616|         call   end_key_sequence_handling ()
   617|          mov   v358, [bss+2b2] :1b                   should_quit
   618|      compare   v359 = (v358 != 0)
   619|         jump   73 if v359 == 0                       short circuit &&
   620|         call   unsaved_buffers_exist () -> v360
   621|         copy   v359 = v360

  -------- Basic Block 73 -------- defines v361-365 --------

             ... dominating: block 72 instruction 619
  1 predecessor: 72
   622|      compare   v362 = (v359 != 0)
   623|          mov   v363, [bss+2b1] :1b                   force_quit
   624|      compare   v364 = (v363 == 0)
   625|        binop   v361, v362 & v364
   626|         jump   74 if v361 == 0
   627|     constant   v365 = 0                              .exit_program
   628|         call   show_unsaved_buffers_dialog (v365)
   629|          mov   [bss+2b2], v54 :1b                    should_quit = false

  -------- Basic Block 74 -------- defines v366 --------

             ... dominating: block 73 instruction 626
  1 predecessor: 72
   630|         call   refresh_open_buffers ()
   631|         call   draw_frame ()
   632|         call   pointer_end_frame ()
   633|         call   maybe_save_editor_history ()
   634|          mov   v366, [bss+2b0] :1b                   should_reload_workspace
   635|         jump   75 if v366 == 0
   636|         call   hard_reload_workspace ()
   637|          mov   [bss+2b0], v54 :1b                    should_reload_workspace = false
   638|          mov   [data+118], v78 :1b                   redraw_requested = true
   639|         call   platform_apply_config (v168)          *config.platform

  -------- Basic Block 75 -------- defines v367-371 --------

             ... dominating: block 74 instruction 635
  1 predecessor: 74
   640|         call   reset_temporary_storage ()
   641|         call   get_time () -> v367
   642|          mov   v369, [bss+2a8] :8b                   frame_time
   643|        binop   v368, v367 - v369
   644|     constant   v370 = 0x3f6b4e81b4e81b4f             QUICK_FRAME_DT
   645|         jump   76 if v368 > v370
   646|     constant   v371 = 2
   647|         call   sleep_milliseconds (v371)

  -------- Basic Block 76 --------

             ... dominating: block 75 instruction 645
  1 predecessor: 75
   648|         jump   14

  -------- Basic Block 77 --------

             ... dominating: block 14 instruction 319
  1 predecessor: 14
   649|         jump   78 if v78 == 0                        eye_tracking_active (0)
   650|         call   eye_tracking_done ()

  -------- Basic Block 78 --------

             ... dominating: block 77 instruction 649
  1 predecessor: 77
   651|         call   deinit_logger ()                      deferred after [301]
   652|       return





  Disassembly of 'boyer_moore_first_index' in Workspace 3 at C:/Repos/focus/modules/Strings_Shared/boyer_moore.jai:7
  - Stack size 48

  -------- Basic Block 0 -------- defines v7-8 --------

             (no dominating)

     0|   stack_node
     1|          mov   v7, [v2] :8b                          needle.count
     2|         jump   1 if v7 != 0                          if needle.count == 0
     3| return_value   v3 -> 1                               return start_index,
     4|     constant   v8 = 1
     5| return_value   v8 -> 2                               true
     6|       return

  -------- Basic Block 1 -------- defines v9-16 --------

             ... dominating: block 0 instruction 2
  1 predecessor: 0
     7|          mov   v9, [v2] :8b                          needle.count
     8|     constant   v10 = 1
     9|         jump   2 if v9 != v10                        if needle.count == 1
    10|          mov   v13, [v2+8] :8b                       needle.data
    11|          mov   v14, [v13] :1b                        needle.data[0] (u8)
    12|         call   first_index (v1, v14, v3, v4) -> v11, v12
    13|         copy   v15 = v11                             index
    14|         copy   v16 = v12                             found
    15| return_value   v15 -> 1                              return index,
    16| return_value   v16 -> 2                              found
    17|       return

  -------- Basic Block 2 -------- defines v17-21 --------

             ... dominating: block 1 instruction 9
  1 predecessor: 1
    18|          mov   v17, [v1] :8b                         haystack.count
    19|          mov   v19, [v2] :8b                         needle.count
    20|        binop   v18, v17 - v19                        haystack.count - needle.count
    21|         jump   3 if v3 <= v18                        if start_index >
    22|     constant   v20 = 0xffffffffffffffff              -1
    23| return_value   v20 -> 1                              return -1,
    24|     constant   v21 = 0
    25| return_value   v21 -> 2                              false
    26|       return

  -------- Basic Block 3 -------- defines v22-30 --------

             ... dominating: block 2 instruction 21
  1 predecessor: 2
    27|          lea   v23, bss+8760+828                     thread_data.last_used_needle
    28|     string==   v22, v2 == v23
    29|      compare   v25 = (v22 != 0)
    30|          mov   v26, [bss+8f98] :1b                   thread_data.last_search_was_reversed
    31|        binop   v24, v25 | v26
    32|         jump   5 if v24 == 0                         if
    33|     constant   v27 = 0
    34|          mov   [bss+8f98], v27 :1b                   thread_data.last_search_was_reversed = false
    35|          mov   v29, [v23] :8b                        thread_data.last_used_needle.count
    36|      compare   v28 = (v29 != 0)
    37|         jump   4 if v28 == 0                         if thread_data.last_used_needle
    38|          lea   v30, rdata+1468                       empty allocator
    39|         call   free (v23, v30)                       thread_data.last_used_needle

  -------- Basic Block 4 -------- defines v31-34 --------

             ... dominating: block 3 instruction 37
  1 predecessor: 3
    40|          lea   v32, rdata+a8                         __default_allocator
    41|         call   copy_string (v2, v32) -> v31{big 16}
    42|          lea   v33, bss+8760                         *thread_data
    43|        binop   v34, v33 + 2088                       *thread_data.last_used_needle
    44|       memcpy   v34, v31 {size 16}
    45|         call   make_bad_character_delta (v2, v4)
    46|         call   make_good_suffix_delta (v2, v4)

  -------- Basic Block 5 -------- defines v35-50 --------

             ... dominating: block 3 instruction 32
  1 predecessor: 3
    47|          mov   v36, [v1+8] :8b                       haystack.data
    48|          mov   v37, [v2] :8b                         needle.count
    49|        binop   v38, v37 + -1                         - 1
    50|        binop   v39, v38 + v3                         + start index
    51|  cast_number   v40 (u64), v39 (s64)
    52|   cast_check   v39, v40 {fatal=1}
    53|  cast_number   v42 (s64), v40 (u64)
    54|        binop   v41, v36 + v42
    55|         copy   v35 = v41                             haystack_ptr :=
    56|          mov   v44, [v1+8] :8b                       haystack.data
    57|          mov   v45, [v1] :8b                         haystack.count
    58|  cast_number   v46 (u64), v45 (s64)
    59|   cast_check   v45, v46 {fatal=1}
    60|  cast_number   v48 (s64), v46 (u64)
    61|        binop   v47, v44 + v48
    62|         copy   v43 = v47                             haystack_end :=
    63|          mov   v50, [v2] :8b                         needle.count
    64|        binop   v49, v50 + -1                         needle_end :=

  -------- Basic Block 6 -------- defines v51 --------       while haystack_ptr < haystack_end

             ... dominating: block 5 instruction 64
  1 predecessor: 5
    65|         jump   11 if v35 >= v43
    66|         copy   v51 = v49                             needle_index :=

  -------- Basic Block 7 -------- defines v52-59 --------    while needle_index >= 0 && compare.compare(<<cast(*u8)haystack_ptr, needle[needle_index])

             ... dominating: block 6 instruction 66
  1 predecessor: 6
    67|      compare   v52 = (v51 >= 0)                      needle_index >= 0
    68|      compare   v53 = (v52 != 0)
    69|         jump   8 if v53 == 0
    70|          mov   v55, [v4+8] :8b                       compare.compare
    71|          mov   v56, [v35] :1b                        haystack_ptr.* u8
    72|          mov   v57, [v2] :8b                         needle.count
    73|  array_check   v51, v57                              needle_index
    74|          mov   v58, [v2+8] :8b                       needle.data
    75|          mov   v59, [v58+v51*1] :1b                  needle[needle_index]
    76|         call   v55 (v56, v59) -> v54                 compare.compare()
    77|         copy   v53 = v54

  -------- Basic Block 8 -------- defines v60 --------

             ... dominating: block 7 instruction 69
  1 predecessor: 7
    78|         jump   9 if v53 == 0
    79|  cast_number   v60 (s64), v10 (s64)                  v10 is 1
    80|        binop   v35, v35 - v60                        haystack_ptr -= 1
    81|        binop   v51, v51 + -1                         needle_index -= 1
    82|         jump   7

  -------- Basic Block 9 -------- defines v61-65 --------

             ... dominating: block 8 instruction 78
  1 predecessor: 7
    83|         jump   10 if v51 >= 0                        if needle_index < 0
    84|  cast_number   v62 (s64), v10 (s64)
    85|        binop   v61, v35 + v62                        haystack_ptr + 1
    86|          mov   v63, [v1+8] :8b                       haystack.data
    87|        binop   v64, v61 - v63
    88| return_value   v64 -> 1                              return haystack_ptr + 1 - haystack,data,
    89|     constant   v65 = 1
    90| return_value   v65 -> 2                              true
    91|       return

  -------- Basic Block 10 -------- defines v66-76 --------

             ... dominating: block 9 instruction 83
  1 predecessor: 9
    92|          lea   v67, bss+8760                         *thread_data.bad_character_delta
    93|          mov   v68, [v35] :1b                        haystack_ptr.* u8
    94|  cast_number   v69 (s64), v68 (u8)
    95|     constant   v70 = 0x100                           thread_data.bad_character_delta.count
    96|  array_check   v69, v70
    97|          mov   v71, [v67+v69*8] :8b                  thread_data.bad_character_delta[haystack_ptr.*]
    98|          lea   v72, bss+8760+800                     *thread_data.good_suffix_delta
    99|          mov   v73, [v72] :8b                        thread_data.good_suffix_delta.count
   100|  array_check   v51, v73                              needle_index
   101|          mov   v74, [v72+8] :8b                      thread_data.good_suffix_delta.data
   102|          mov   v75, [v74+v51*8] :8b                  thread_data.good_suffix_delta[needle_index]
   103|         call   max (v71, v75) -> v66
   104|  cast_number   v76 (s64), v66 (s64)
   105|        binop   v35, v35 + v76                        haystack_ptr +=
   106|         jump   6

  -------- Basic Block 11 -------- defines v77-78 --------

             ... dominating: block 6 instruction 65
  1 predecessor: 6
   107|     constant   v77 = 0xffffffffffffffff              -1
   108| return_value   v77 -> 1                              return -1,
   109|     constant   v78 = 0
   110| return_value   v78 -> 2                              false
   111|       return

















  Disassembly of 'boyer_moore_sse2_first_index' in Workspace 3 at C:/Repos/focus/modules/Strings_Shared/boyer_moore.jai:158
  - Stack size 140

  -------- Basic Block 0 -------- defines v7-8 --------

             (no dominating)

     0|   stack_node
     1|          mov   v7, [v2] :8b
     2|         jump   1 if v7 != 0
     3| return_value   v3 -> 1
     4|     constant   v8 = 1
     5| return_value   v8 -> 2
     6|       return

  -------- Basic Block 1 -------- defines v9-16 --------

             ... dominating: block 0 instruction 2
  1 predecessor: 0
     7|          mov   v9, [v2] :8b
     8|     constant   v10 = 1
     9|         jump   2 if v9 != v10
    10|          mov   v13, [v2+8] :8b
    11|          mov   v14, [v13] :1b
    12|         call   first_index (v1, v14, v3, v4) -> v11, v12
    13|         copy   v15 = v11
    14|         copy   v16 = v12
    15| return_value   v15 -> 1
    16| return_value   v16 -> 2
    17|       return

  -------- Basic Block 2 -------- defines v17-21 --------

             ... dominating: block 1 instruction 9
  1 predecessor: 1
    18|          mov   v17, [v1] :8b
    19|          mov   v19, [v2] :8b
    20|        binop   v18, v17 - v19
    21|         jump   3 if v3 <= v18
    22|     constant   v20 = 0xffffffffffffffff
    23| return_value   v20 -> 1
    24|     constant   v21 = 0
    25| return_value   v21 -> 2
    26|       return

  -------- Basic Block 3 -------- defines v22-30 --------

             ... dominating: block 2 instruction 21
  1 predecessor: 2
    27|          lea   v23, bss+87c8+828
    28|     string==   v22, v2 == v23
    29|      compare   v25 = (v22 != 0)
    30|          mov   v26, [bss+9000] :1b
    31|        binop   v24, v25 | v26
    32|         jump   5 if v24 == 0
    33|     constant   v27 = 0
    34|          mov   [bss+9000], v27 :1b
    35|          mov   v29, [v23] :8b
    36|      compare   v28 = (v29 != 0)
    37|         jump   4 if v28 == 0
    38|          lea   v30, rdata+1db8
    39|         call   free (v23, v30)

  -------- Basic Block 4 -------- defines v31-34 --------

             ... dominating: block 3 instruction 37
  1 predecessor: 3
    40|          lea   v32, rdata+a8
    41|         call   copy_string (v2, v32) -> v31{big 16}
    42|          lea   v33, bss+87c8
    43|        binop   v34, v33 + 2088
    44|       memcpy   v34, v31 {size 16}
    45|         call   make_bad_character_delta (v2, v4)
    46|         call   make_good_suffix_delta (v2, v4)

  -------- Basic Block 5 -------- defines v35-38 --------

             ... dominating: block 3 instruction 32
  1 predecessor: 3
    47|          mov   v36, [v2] :8b                         needle.coount
    48|        binop   v35, v36 + -1                         needle_end :=
    49|          mov   v37, [v4] :1b                         compare.kind
    50|     constant   v38 = 0                               .CASE_SENSITIVE
    51|         jump   20 if v37 != v38                      case .CASE_SENSITIVE

  -------- Basic Block 6 -------- defines v39-62 --------

             ... dominating: block 5 instruction 51
  1 predecessor: 5
    52|          mov   v40, [v1+8] :8b                       haystack.data
    53|  cast_number   v42 (u64), v40 (*u8)
    54|          mov   v43, [v1] :8b                         haystack.count
    55|  cast_number   v44 (u64), v43 (s64)
    56|   cast_check   v43, v44 {fatal=1}
    57|        binop   v39, v42 + v44                        end :=
    58|          mov   v46, [v1+8] :8b                       haystack.data
    59|  cast_number   v48 (u64), v46 (*u8)
    60|  cast_number   v50 (u64), v3 (int)                   start_index
    61|   cast_check   v3, v50 {fatal=1}
    62|        binop   v49, v48 + v50                        haystack.data + start_index
    63|  cast_number   v51 (u64), v35 (s64)
    64|   cast_check   v35, v51 {fatal=1}
    65|        binop   v45, v49 + v51                        + needle_end
    66|        binop   v52, v39 + -15                        end_simd := end - 15;
    67|         jump   14 if v45 >= v52                      if haystack_ptr < end_simd
    68|          lea   v53, stack+30                         *needle_buffer
    69|        clear   v53+0 {size 16}                       needle_buffer :
    70|         copy   v54 = v53                             needle_ptr := *needle_buffer
    71|          mov   v55, [v2] :8b                         needle.count
    72|  array_check   v35, v55
    73|          mov   v56, [v2+8] :8b                       needle.data
    74|          mov   v57, [v56+v35*1] :1b                  needle[needle_end]
    75|     constant   v58 = 0x10                            16
    76|       memset   v54, v57 {count v58}
    77|          lea   v59, stack+40                         *results
    78|        clear   v59+0 {size 4}                        results :
    79|         copy   v60 = v59                             results_data := *results
    80|      asm_x86   v61 -> vec.0, v54 -> gpr.1            movdqu

  -------- Basic Block 7 -------- defines v63-72 --------

             ... dominating: block 6 instruction 80
  1 predecessor: 6
    81|         jump   14 if v45 >= v52
    82|      asm_x86   v63 -> vec.1, v45 -> gpr.0
    83|      asm_x86   v63 -> vec.1, v61 -> vec.0
    84|      asm_x86   v65 -> gpr.1, v63 -> vec.1
    85|      asm_x86   v67 -> gpr.3, v65 -> gpr.1
    86|      asm_x86   v65 -> gpr.1
    87|      asm_x86   v65 -> gpr.1, v67 -> gpr.3
    88|      asm_x86   v60 -> gpr.2, v65 -> gpr.1
    89|          mov   v69, [stack+42] :2b                   results.found
    90|         jump   12 if v69 == 0
    91|          mov   v70, [stack+40] :2b                   results.index
    92|  cast_number   v71 (u64), v70 (u16)
    93|        binop   v45, v45 + v71                        haystack_ptr += results.index
    94|         copy   v72 = v35                             needle_index := needle_end

  -------- Basic Block 8 -------- defines v73-82 --------

             ... dominating: block 7 instruction 94
  1 predecessor: 7
    95|      compare   v73 = (v72 >= 0)                      while
    96|      compare   v74 = (v73 != 0)
    97|         jump   9 if v74 == 0                         needle_index >= 0
    98|          mov   v76, [v4+8] :8b                       *compare.compare
    99|  cast_number   v78 (*u8), v45 (u64)                  haystack_ptr
   100|          mov   v79, [v78] :1b
   101|          mov   v80, [v2] :8b                         needle.count
   102|  array_check   v72, v80
   103|          mov   v81, [v2+8] :8b                       needle.data
   104|          mov   v82, [v81+v72*1] :1b                  needle[needle_index]
   105|         call   v76 (v79, v82) -> v75                 compare.compare()
   106|         copy   v74 = v75

  -------- Basic Block 9 --------

             ... dominating: block 8 instruction 97
  1 predecessor: 8
   107|         jump   10 if v74 == 0
   108|        binop   v45, v45 + -1                         haystack_ptr -= 1
   109|        binop   v72, v72 + -1                         needle_index -= 1
   110|         jump   8

  -------- Basic Block 10 -------- defines v83-89 --------

             ... dominating: block 9 instruction 107
  1 predecessor: 8
   111|         jump   11 if v72 >= 0                        if needle_index < 0
   112|  cast_number   v83 (int), v45 (u64)
   113|   cast_check   v45, v83 {fatal=1}
   114|        binop   v84, v83 + 1                          haystack_ptr + 1
   115|          mov   v86, [v1+8] :8b                       haystack.data
   116|  cast_number   v88 (int), v86 (*u8)
   117|        binop   v85, v84 - v88                        return haystack_ptr + 1 - haystack.data,
   118| return_value   v85 -> 1
   119|     constant   v89 = 1                               true
   120| return_value   v89 -> 2
   121|       return

  -------- Basic Block 11 -------- defines v90-102 --------

             ... dominating: block 10 instruction 111
  1 predecessor: 10
   122|          lea   v91, bss+87c8                         *thread_data.bad_character_delta
   123|  cast_number   v93 (*u8), v45 (u64)
   124|          mov   v94, [v93] :1b                        haystack_ptr.* u8
   125|  cast_number   v95 (s64), v94 (u8)
   126|     constant   v96 = 0x100                           thread_data.bad_character_delta.count
   127|  array_check   v95, v96
   128|          mov   v97, [v91+v95*8] :8b                  thread_data.bad_character_delta[v95]
   129|          lea   v98, bss+87c8+800                     *thread_data.good_suffix_delta
   130|          mov   v99, [v98] :8b                        thread_data.good_suffix_delta.count
   131|  array_check   v72, v99
   132|          mov   v100, [v98+8] :8b                     thread_data.good_suffix_delta.data
   133|          mov   v101, [v100+v72*8] :8b                thread_data.good_suffix_delta[needle_index]
   134|         call   max (v97, v101) -> v90
   135|  cast_number   v102 (u64), v90 (s64)
   136|   cast_check   v90, v102 {fatal=1}
   137|        binop   v45, v45 + v102                       haystack_ptr +=
   138|         jump   13

  -------- Basic Block 12 --------

             ... dominating: block 7 instruction 90
  1 predecessor: 7
   139|        binop   v45, v45 + 16                         haystack_ptr += 16

  -------- Basic Block 13 --------

             ... dominating: block 7 instruction 90
  1 predecessor: 12
   140|         jump   7

  -------- Basic Block 14 -------- defines v103 --------

             ... dominating: block 6 instruction 67
  2 predecessors: 7, 6
   141|         jump   19 if v45 >= v39
   142|         copy   v103 = v35

  -------- Basic Block 15 -------- defines v104-113 --------

             ... dominating: block 14 instruction 142
  1 predecessor: 14
   143|      compare   v104 = (v103 >= 0)
   144|      compare   v105 = (v104 != 0)
   145|         jump   16 if v105 == 0
   146|          mov   v107, [v4+8] :8b
   147|  cast_number   v109 (*u8), v45 (u64)
   148|          mov   v110, [v109] :1b
   149|          mov   v111, [v2] :8b
   150|  array_check   v103, v111
   151|          mov   v112, [v2+8] :8b
   152|          mov   v113, [v112+v103*1] :1b
   153|         call   v107 (v110, v113) -> v106
   154|         copy   v105 = v106

  -------- Basic Block 16 --------

             ... dominating: block 15 instruction 145
  1 predecessor: 15
   155|         jump   17 if v105 == 0
   156|        binop   v45, v45 + -1
   157|        binop   v103, v103 + -1
   158|         jump   15

  -------- Basic Block 17 -------- defines v114-120 --------

             ... dominating: block 16 instruction 155
  1 predecessor: 15
   159|         jump   18 if v103 >= 0
   160|  cast_number   v114 (int), v45 (u64)
   161|   cast_check   v45, v114 {fatal=1}
   162|        binop   v115, v114 + 1
   163|          mov   v117, [v1+8] :8b
   164|  cast_number   v119 (int), v117 (*u8)
   165|        binop   v116, v115 - v119
   166| return_value   v116 -> 1
   167|     constant   v120 = 1
   168| return_value   v120 -> 2
   169|       return

  -------- Basic Block 18 -------- defines v121-133 --------

             ... dominating: block 17 instruction 159
  1 predecessor: 17
   170|          lea   v122, bss+87c8
   171|  cast_number   v124 (*u8), v45 (u64)
   172|          mov   v125, [v124] :1b
   173|  cast_number   v126 (s64), v125 (u8)
   174|     constant   v127 = 0x100
   175|  array_check   v126, v127
   176|          mov   v128, [v122+v126*8] :8b
   177|          lea   v129, bss+87c8+800
   178|          mov   v130, [v129] :8b
   179|  array_check   v103, v130
   180|          mov   v131, [v129+8] :8b
   181|          mov   v132, [v131+v103*8] :8b
   182|         call   max (v128, v132) -> v121
   183|  cast_number   v133 (u64), v121 (s64)
   184|   cast_check   v121, v133 {fatal=1}
   185|        binop   v45, v45 + v133
   186|         jump   14

  -------- Basic Block 19 -------- defines v134-135 --------

             ... dominating: block 14 instruction 141
  1 predecessor: 14
   187|     constant   v134 = 0xffffffffffffffff
   188| return_value   v134 -> 1
   189|     constant   v135 = 0
   190| return_value   v135 -> 2
   191|       return
   192|         jump   42

  -------- Basic Block 20 -------- defines v136 --------

             ... dominating: block 5 instruction 51
  1 predecessor: 5
   193|     constant   v136 = 1
   194|         jump   35 if v37 != v136                     case .IGNORE_CASE;

  -------- Basic Block 21 -------- defines v137-179 --------

             ... dominating: block 20 instruction 194
  1 predecessor: 20
   195|          mov   v138, [v1+8] :8b                      haystack.data
   196|  cast_number   v140 (u64), v138 (*u8)
   197|          mov   v141, [v1] :8b                        haystack.count
   198|  cast_number   v142 (u64), v141 (s64)
   199|   cast_check   v141, v142 {fatal=1}
   200|        binop   v137, v140 + v142                     end :=
   201|          mov   v144, [v1+8] :8b                      haystack.data
   202|  cast_number   v146 (u64), v144 (*u8)
   203|  cast_number   v148 (u64), v3 (int)                  start_index
   204|   cast_check   v3, v148 {fatal=1}
   205|        binop   v147, v146 + v148                     haystack.data + start_index
   206|  cast_number   v149 (u64), v35 (s64)
   207|   cast_check   v35, v149 {fatal=1}
   208|        binop   v143, v147 + v149                     haystack.data + start_index + needle_end
   209|        binop   v150, v137 + -15                      end_simd := end - 15
   210|         jump   29 if v143 >= v150                    if haystack_ptr < end_simd
   211|          lea   v151, stack+48                        *needle_buffer
   212|        clear   v151+0 {size 16}                      needle_buffer :
   213|         copy   v152 = v151                           needle_ptr := *needle_buffer
   214|          mov   v153, [v2] :8b                        needle.count
   215|  array_check   v35, v153
   216|          mov   v154, [v2+8] :8b                      needle.data
   217|          mov   v155, [v154+v35*1] :1b                needle[nededle_end]
   218|     constant   v156 = 0x10                           16
   219|       memset   v152, v155 {count v156}
   220|          lea   v157, rdata+2cb78
   221|          lea   v158, stack+58
   222|       memcpy   v158, v157 {size 16}                  case_bytes :=
   223|          lea   v159, rdata+2cb88
   224|          lea   v160, stack+68
   225|       memcpy   v160, v159 {size 16}                  a_bytes :=
   226|          lea   v161, rdata+2cb98
   227|          lea   v162, stack+78
   228|       memcpy   v162, v161 {size 16}                  z_bytes :=
   229|         copy   v163 = v158                           case_ptr :=
   230|         copy   v164 = v160                           a_ptr :=
   231|         copy   v165 = v162                           z_ptr :=
   232|          lea   v166, stack+88                        *results
   233|        clear   v166+0 {size 4}                       results :
   234|         copy   v167 = v166                           results_data := *results
   235|      asm_x86   v168 -> vec.0, v163 -> gpr.2
   236|      asm_x86   v170 -> vec.1, v164 -> gpr.3
   237|      asm_x86   v172 -> vec.2, v165 -> gpr.6
   238|      asm_x86   v174 -> vec.3, v152 -> gpr.1
   239|      asm_x86   v176 -> vec.4, v174 -> vec.3
   240|      asm_x86   v176 -> vec.4, v168 -> vec.0
   241|      asm_x86   v178 -> vec.5, v178 -> vec.5

  -------- Basic Block 22 -------- defines v180-197 --------

             ... dominating: block 21 instruction 241
  1 predecessor: 21
   242|         jump   29 if v143 >= v150
   243|      asm_x86   v180 -> vec.6, v143 -> gpr.0
   244|      asm_x86   v182 -> vec.7, v174 -> vec.3
   245|      asm_x86   v182 -> vec.7, v180 -> vec.6
   246|      asm_x86   v180 -> vec.6, v168 -> vec.0
   247|      asm_x86   v184 -> vec.8, v176 -> vec.4
   248|      asm_x86   v184 -> vec.8, v180 -> vec.6
   249|      asm_x86   v186 -> vec.9, v180 -> vec.6
   250|      asm_x86   v186 -> vec.9, v172 -> vec.2
   251|      asm_x86   v188 -> vec.10, v170 -> vec.1
   252|      asm_x86   v188 -> vec.10, v180 -> vec.6
   253|      asm_x86   v186 -> vec.9, v188 -> vec.10
   254|      asm_x86   v182 -> vec.7, v186 -> vec.9
   255|      asm_x86   v186 -> vec.9, v178 -> vec.5
   256|      asm_x86   v184 -> vec.8, v186 -> vec.9
   257|      asm_x86   v182 -> vec.7, v184 -> vec.8
   258|      asm_x86   v190 -> gpr.1, v182 -> vec.7
   259|      asm_x86   v192 -> gpr.2, v190 -> gpr.1
   260|      asm_x86   v190 -> gpr.1
   261|      asm_x86   v190 -> gpr.1, v192 -> gpr.2
   262|      asm_x86   v167 -> gpr.7, v190 -> gpr.1
   263|          mov   v194, [stack+8a] :2b
   264|         jump   27 if v194 == 0
   265|          mov   v195, [stack+88] :2b
   266|  cast_number   v196 (u64), v195 (u16)
   267|        binop   v143, v143 + v196
   268|         copy   v197 = v35

  -------- Basic Block 23 -------- defines v198-207 --------

             ... dominating: block 22 instruction 268
  1 predecessor: 22
   269|      compare   v198 = (v197 >= 0)
   270|      compare   v199 = (v198 != 0)
   271|         jump   24 if v199 == 0
   272|          mov   v201, [v4+8] :8b
   273|  cast_number   v203 (*u8), v143 (u64)
   274|          mov   v204, [v203] :1b
   275|          mov   v205, [v2] :8b
   276|  array_check   v197, v205
   277|          mov   v206, [v2+8] :8b
   278|          mov   v207, [v206+v197*1] :1b
   279|         call   v201 (v204, v207) -> v200
   280|         copy   v199 = v200

  -------- Basic Block 24 --------

             ... dominating: block 23 instruction 271
  1 predecessor: 23
   281|         jump   25 if v199 == 0
   282|        binop   v143, v143 + -1
   283|        binop   v197, v197 + -1
   284|         jump   23

  -------- Basic Block 25 -------- defines v208-214 --------

             ... dominating: block 24 instruction 281
  1 predecessor: 23
   285|         jump   26 if v197 >= 0
   286|  cast_number   v208 (int), v143 (u64)
   287|   cast_check   v143, v208 {fatal=1}
   288|        binop   v209, v208 + 1
   289|          mov   v211, [v1+8] :8b
   290|  cast_number   v213 (int), v211 (*u8)
   291|        binop   v210, v209 - v213
   292| return_value   v210 -> 1
   293|     constant   v214 = 1
   294| return_value   v214 -> 2
   295|       return

  -------- Basic Block 26 -------- defines v215-227 --------

             ... dominating: block 25 instruction 285
  1 predecessor: 25
   296|          lea   v216, bss+87c8
   297|  cast_number   v218 (*u8), v143 (u64)
   298|          mov   v219, [v218] :1b
   299|  cast_number   v220 (s64), v219 (u8)
   300|     constant   v221 = 0x100
   301|  array_check   v220, v221
   302|          mov   v222, [v216+v220*8] :8b
   303|          lea   v223, bss+87c8+800
   304|          mov   v224, [v223] :8b
   305|  array_check   v197, v224
   306|          mov   v225, [v223+8] :8b
   307|          mov   v226, [v225+v197*8] :8b
   308|         call   max (v222, v226) -> v215
   309|  cast_number   v227 (u64), v215 (s64)
   310|   cast_check   v215, v227 {fatal=1}
   311|        binop   v143, v143 + v227
   312|         jump   28

  -------- Basic Block 27 --------

             ... dominating: block 22 instruction 264
  1 predecessor: 22
   313|        binop   v143, v143 + 16

  -------- Basic Block 28 --------

             ... dominating: block 22 instruction 264
  1 predecessor: 27
   314|         jump   22

  -------- Basic Block 29 -------- defines v228 --------

             ... dominating: block 21 instruction 210
  2 predecessors: 22, 21
   315|         jump   34 if v143 >= v137
   316|         copy   v228 = v35

  -------- Basic Block 30 -------- defines v229-238 --------

             ... dominating: block 29 instruction 316
  1 predecessor: 29
   317|      compare   v229 = (v228 >= 0)
   318|      compare   v230 = (v229 != 0)
   319|         jump   31 if v230 == 0
   320|          mov   v232, [v4+8] :8b
   321|  cast_number   v234 (*u8), v143 (u64)
   322|          mov   v235, [v234] :1b
   323|          mov   v236, [v2] :8b
   324|  array_check   v228, v236
   325|          mov   v237, [v2+8] :8b
   326|          mov   v238, [v237+v228*1] :1b
   327|         call   v232 (v235, v238) -> v231
   328|         copy   v230 = v231

  -------- Basic Block 31 --------

             ... dominating: block 30 instruction 319
  1 predecessor: 30
   329|         jump   32 if v230 == 0
   330|        binop   v143, v143 + -1
   331|        binop   v228, v228 + -1
   332|         jump   30

  -------- Basic Block 32 -------- defines v239-245 --------

             ... dominating: block 31 instruction 329
  1 predecessor: 30
   333|         jump   33 if v228 >= 0
   334|  cast_number   v239 (int), v143 (u64)
   335|   cast_check   v143, v239 {fatal=1}
   336|        binop   v240, v239 + 1
   337|          mov   v242, [v1+8] :8b
   338|  cast_number   v244 (int), v242 (*u8)
   339|        binop   v241, v240 - v244
   340| return_value   v241 -> 1
   341|     constant   v245 = 1
   342| return_value   v245 -> 2
   343|       return

  -------- Basic Block 33 -------- defines v246-258 --------

             ... dominating: block 32 instruction 333
  1 predecessor: 32
   344|          lea   v247, bss+87c8
   345|  cast_number   v249 (*u8), v143 (u64)
   346|          mov   v250, [v249] :1b
   347|  cast_number   v251 (s64), v250 (u8)
   348|     constant   v252 = 0x100
   349|  array_check   v251, v252
   350|          mov   v253, [v247+v251*8] :8b
   351|          lea   v254, bss+87c8+800
   352|          mov   v255, [v254] :8b
   353|  array_check   v228, v255
   354|          mov   v256, [v254+8] :8b
   355|          mov   v257, [v256+v228*8] :8b
   356|         call   max (v253, v257) -> v246
   357|  cast_number   v258 (u64), v246 (s64)
   358|   cast_check   v246, v258 {fatal=1}
   359|        binop   v143, v143 + v258
   360|         jump   29

  -------- Basic Block 34 -------- defines v259-260 --------

             ... dominating: block 29 instruction 315
  1 predecessor: 29
   361|     constant   v259 = 0xffffffffffffffff
   362| return_value   v259 -> 1
   363|     constant   v260 = 0
   364| return_value   v260 -> 2
   365|       return
   366|         jump   42

  -------- Basic Block 35 -------- defines v261-274 --------

             ... dominating: block 5 instruction 51
  2 predecessors: 20, 21
   367|          mov   v262, [v1+8] :8b
   368|          mov   v263, [v2] :8b
   369|        binop   v264, v263 + -1
   370|        binop   v265, v264 + v3
   371|  cast_number   v266 (u64), v265 (s64)
   372|   cast_check   v265, v266 {fatal=1}
   373|  cast_number   v268 (s64), v266 (u64)
   374|        binop   v267, v262 + v268
   375|         copy   v261 = v267
   376|          mov   v270, [v1+8] :8b
   377|          mov   v271, [v1] :8b
   378|  cast_number   v272 (u64), v271 (s64)
   379|   cast_check   v271, v272 {fatal=1}
   380|  cast_number   v274 (s64), v272 (u64)
   381|        binop   v273, v270 + v274
   382|         copy   v269 = v273

  -------- Basic Block 36 -------- defines v275-276 --------

             ... dominating: block 35 instruction 382
  1 predecessor: 35
   383|         jump   41 if v261 >= v269
   384|          mov   v276, [v2] :8b
   385|        binop   v275, v276 + -1

  -------- Basic Block 37 -------- defines v277-284 --------

             ... dominating: block 36 instruction 385
  1 predecessor: 36
   386|      compare   v277 = (v275 >= 0)
   387|      compare   v278 = (v277 != 0)
   388|         jump   38 if v278 == 0
   389|          mov   v280, [v4+8] :8b
   390|          mov   v281, [v261] :1b
   391|          mov   v282, [v2] :8b
   392|  array_check   v275, v282
   393|          mov   v283, [v2+8] :8b
   394|          mov   v284, [v283+v275*1] :1b
   395|         call   v280 (v281, v284) -> v279
   396|         copy   v278 = v279

  -------- Basic Block 38 -------- defines v285 --------

             ... dominating: block 37 instruction 388
  1 predecessor: 37
   397|         jump   39 if v278 == 0
   398|  cast_number   v285 (s64), v10 (s64)
   399|        binop   v261, v261 - v285
   400|        binop   v275, v275 + -1
   401|         jump   37

  -------- Basic Block 39 -------- defines v286-290 --------

             ... dominating: block 38 instruction 397
  1 predecessor: 37
   402|         jump   40 if v275 >= 0
   403|  cast_number   v287 (s64), v10 (s64)
   404|        binop   v286, v261 + v287
   405|          mov   v288, [v1+8] :8b
   406|        binop   v289, v286 - v288
   407| return_value   v289 -> 1
   408|     constant   v290 = 1
   409| return_value   v290 -> 2
   410|       return

  -------- Basic Block 40 -------- defines v291-301 --------

             ... dominating: block 39 instruction 402
  1 predecessor: 39
   411|          lea   v292, bss+87c8
   412|          mov   v293, [v261] :1b
   413|  cast_number   v294 (s64), v293 (u8)
   414|     constant   v295 = 0x100
   415|  array_check   v294, v295
   416|          mov   v296, [v292+v294*8] :8b
   417|          lea   v297, bss+87c8+800
   418|          mov   v298, [v297] :8b
   419|  array_check   v275, v298
   420|          mov   v299, [v297+8] :8b
   421|          mov   v300, [v299+v275*8] :8b
   422|         call   max (v296, v300) -> v291
   423|  cast_number   v301 (s64), v291 (s64)
   424|        binop   v261, v261 + v301
   425|         jump   36

  -------- Basic Block 41 -------- defines v302-303 --------

             ... dominating: block 36 instruction 383
  1 predecessor: 36
   426|     constant   v302 = 0xffffffffffffffff
   427| return_value   v302 -> 1
   428|     constant   v303 = 0
   429| return_value   v303 -> 2
   430|       return
   431|         jump   42

  -------- Basic Block 42 --------

             ... dominating: block 5 instruction 51
  3 predecessors: 6, 21, 35
   432|       return


















  Disassembly of 'get_image_bytes_per_texel' in Workspace 3 at C:/Repos/focus/modules/Simp/texture_format.jai:70
  - Stack size 0

  -------- Basic Block 0 -------- defines v3 --------

             (no dominating)

     0|     constant   v3 = 1
     1|         jump   2 if v1 != v3                         case R8

  -------- Basic Block 1 -------- defines v4 --------

             ... dominating: block 0 instruction 1
  1 predecessor: 0
     2|     constant   v4 = 1
     3| return_value   v4 -> 1
     4|       return
     5|         jump   52

  -------- Basic Block 2 -------- defines v5 --------

             ... dominating: block 0 instruction 1
  1 predecessor: 0
     6|     constant   v5 = 2                                case RGB
     7|         jump   4 if v1 != v5

  -------- Basic Block 3 --------

             ... dominating: block 2 instruction 7
  1 predecessor: 2
     8|         jump   5

  -------- Basic Block 4 -------- defines v6 --------

             ... dominating: block 2 instruction 7
  1 predecessor: 2
     9|     constant   v6 = 8
    10|         jump   6 if v1 != v6                         case R16

  -------- Basic Block 5 --------

             ... dominating: block 2 instruction 7
  2 predecessors: 4, 3
    11|         jump   7

  -------- Basic Block 6 -------- defines v7 --------

             ... dominating: block 4 instruction 10
  1 predecessor: 4
    12|     constant   v7 = 6
    13|         jump   8 if v1 != v7                         case B5G6R5

  -------- Basic Block 7 --------

             ... dominating: block 2 instruction 7
  2 predecessors: 6, 5
    14|         jump   9

  -------- Basic Block 8 -------- defines v8 --------

             ... dominating: block 6 instruction 13
  1 predecessor: 6
    15|     constant   v8 = 0x10
    16|         jump   10 if v1 != v8                        case R16F

  -------- Basic Block 9 --------

             ... dominating: block 2 instruction 7
  2 predecessors: 8, 7
    17|         jump   11

  -------- Basic Block 10 -------- defines v9 --------

             ... dominating: block 8 instruction 16
  1 predecessor: 8
    18|     constant   v9 = 0x18
    19|         jump   12 if v1 != v9                        case R16I

  -------- Basic Block 11 --------

             ... dominating: block 2 instruction 7
  2 predecessors: 10, 9
    20|         jump   13

  -------- Basic Block 12 -------- defines v10 --------

             ... dominating: block 10 instruction 19
  1 predecessor: 10
    21|     constant   v10 = 0x10b
    22|         jump   14 if v1 != v10                       case D16

  -------- Basic Block 13 -------- defines v11 --------

             ... dominating: block 2 instruction 7
  2 predecessors: 12, 11
    23|     constant   v11 = 2
    24| return_value   v11 -> 1
    25|       return
    26|         jump   52

  -------- Basic Block 14 -------- defines v12 --------

             ... dominating: block 12 instruction 22
  1 predecessor: 12
    27|     constant   v12 = 3
    28|         jump   16 if v1 != v12

  -------- Basic Block 15 -------- defines v13 --------

             ... dominating: block 14 instruction 28
  1 predecessor: 14
    29|     constant   v13 = 3
    30| return_value   v13 -> 1
    31|       return
    32|         jump   52

  -------- Basic Block 16 -------- defines v14 --------

             ... dominating: block 14 instruction 28
  1 predecessor: 14
    33|     constant   v14 = 0x16
    34|         jump   18 if v1 != v14

  -------- Basic Block 17 --------

             ... dominating: block 16 instruction 34
  1 predecessor: 16
    35|         jump   19

  -------- Basic Block 18 -------- defines v15 --------

             ... dominating: block 16 instruction 34
  1 predecessor: 16
    36|     constant   v15 = 0x17
    37|         jump   20 if v1 != v15

  -------- Basic Block 19 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 18, 17
    38|         jump   21

  -------- Basic Block 20 -------- defines v16 --------

             ... dominating: block 18 instruction 37
  1 predecessor: 18
    39|     constant   v16 = 7
    40|         jump   22 if v1 != v16

  -------- Basic Block 21 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 20, 19
    41|         jump   23

  -------- Basic Block 22 -------- defines v17 --------

             ... dominating: block 20 instruction 40
  1 predecessor: 20
    42|     constant   v17 = 4
    43|         jump   24 if v1 != v17

  -------- Basic Block 23 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 22, 21
    44|         jump   25

  -------- Basic Block 24 -------- defines v18 --------

             ... dominating: block 22 instruction 43
  1 predecessor: 22
    45|     constant   v18 = 5
    46|         jump   26 if v1 != v18

  -------- Basic Block 25 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 24, 23
    47|         jump   27

  -------- Basic Block 26 -------- defines v19 --------

             ... dominating: block 24 instruction 46
  1 predecessor: 24
    48|     constant   v19 = 0x11
    49|         jump   28 if v1 != v19

  -------- Basic Block 27 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 26, 25
    50|         jump   29

  -------- Basic Block 28 -------- defines v20 --------

             ... dominating: block 26 instruction 49
  1 predecessor: 26
    51|     constant   v20 = 0x13
    52|         jump   30 if v1 != v20

  -------- Basic Block 29 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 28, 27
    53|         jump   31

  -------- Basic Block 30 -------- defines v21 --------

             ... dominating: block 28 instruction 52
  1 predecessor: 28
    54|     constant   v21 = 0x19
    55|         jump   32 if v1 != v21

  -------- Basic Block 31 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 30, 29
    56|         jump   33

  -------- Basic Block 32 -------- defines v22 --------

             ... dominating: block 30 instruction 55
  1 predecessor: 30
    57|     constant   v22 = 0x1b
    58|         jump   34 if v1 != v22

  -------- Basic Block 33 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 32, 31
    59|         jump   35

  -------- Basic Block 34 -------- defines v23 --------

             ... dominating: block 32 instruction 58
  1 predecessor: 32
    60|     constant   v23 = 0x10c
    61|         jump   36 if v1 != v23

  -------- Basic Block 35 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 34, 33
    62|         jump   37

  -------- Basic Block 36 -------- defines v24 --------

             ... dominating: block 34 instruction 61
  1 predecessor: 34
    63|     constant   v24 = 0x10d
    64|         jump   38 if v1 != v24

  -------- Basic Block 37 -------- defines v25 --------

             ... dominating: block 16 instruction 34
  2 predecessors: 36, 35
    65|     constant   v25 = 4
    66| return_value   v25 -> 1
    67|       return
    68|         jump   52

  -------- Basic Block 38 -------- defines v26 --------

             ... dominating: block 36 instruction 64
  1 predecessor: 36
    69|     constant   v26 = 0x12
    70|         jump   40 if v1 != v26

  -------- Basic Block 39 --------

             ... dominating: block 38 instruction 70
  1 predecessor: 38
    71|         jump   41

  -------- Basic Block 40 -------- defines v27 --------

             ... dominating: block 38 instruction 70
  1 predecessor: 38
    72|     constant   v27 = 0x14
    73|         jump   42 if v1 != v27

  -------- Basic Block 41 --------

             ... dominating: block 38 instruction 70
  2 predecessors: 40, 39
    74|         jump   43

  -------- Basic Block 42 -------- defines v28 --------

             ... dominating: block 40 instruction 73
  1 predecessor: 40
    75|     constant   v28 = 0x1a
    76|         jump   44 if v1 != v28

  -------- Basic Block 43 --------

             ... dominating: block 38 instruction 70
  2 predecessors: 42, 41
    77|         jump   45

  -------- Basic Block 44 -------- defines v29 --------

             ... dominating: block 42 instruction 76
  1 predecessor: 42
    78|     constant   v29 = 0x1c
    79|         jump   46 if v1 != v29

  -------- Basic Block 45 --------

             ... dominating: block 38 instruction 70
  2 predecessors: 44, 43
    80|         jump   47

  -------- Basic Block 46 -------- defines v30 --------

             ... dominating: block 44 instruction 79
  1 predecessor: 44
    81|     constant   v30 = 0x10e
    82|         jump   48 if v1 != v30

  -------- Basic Block 47 -------- defines v31 --------

             ... dominating: block 38 instruction 70
  2 predecessors: 46, 45
    83|     constant   v31 = 8
    84| return_value   v31 -> 1
    85|       return
    86|         jump   52

  -------- Basic Block 48 -------- defines v32 --------

             ... dominating: block 46 instruction 82
  1 predecessor: 46
    87|     constant   v32 = 0x15
    88|         jump   50 if v1 != v32

  -------- Basic Block 49 --------

             ... dominating: block 48 instruction 88
  1 predecessor: 48
    89|         jump   51

  -------- Basic Block 50 -------- defines v33 --------

             ... dominating: block 48 instruction 88
  1 predecessor: 48
    90|     constant   v33 = 0x1d
    91|         jump   52 if v1 != v33

  -------- Basic Block 51 -------- defines v34 --------

             ... dominating: block 48 instruction 88
  2 predecessors: 50, 49
    92|     constant   v34 = 0x10
    93| return_value   v34 -> 1
    94|       return
    95|         jump   52

  -------- Basic Block 52 -------- defines v35 --------

             ... dominating: block 0 instruction 1
  28 predecessors: 0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 51
    96|     constant   v35 = 0
    97| return_value   v35 -> 1
    98|       return



  -------- Basic Block 0 -------- defines v3 --------

             (no dominating)

     0|     constant   v3 = 1
     1|         jump   2 if v1 != v3                         case R8

  -------- Basic Block 1 -------- defines v4 --------

             ... dominating: block 0 instruction 1
  1 predecessor: 0
     2|     constant   v4 = 1
     3| return_value   v4 -> 1
     4|       return

  -------- Basic Block 2 -------- defines v5 --------

             ... dominating: block 0 instruction 1
  1 predecessor: 0
     6|     constant   v5 = 2                                case RGB
     7|         jump   3 if v1 == 2
     8|     constant   v6 = 8
     9|         jump   3 if v1 == v6                         case R16
    10|     constant   v7 = 6
    11|         jump   3 if v1 == v7                         case B5G6R5
    12|     constant   v8 = 0x10
    13|         jump   3 if v1 == v8                        case R16F
    14|     constant   v9 = 0x18
    15|         jump   3 if v1 == v9                        case R16I
    21|     constant   v10 = 0x10b
    22|         jump   3 if v1 == v10                       case D16
    23|         jump   4

  -------- Basic Block 3 --------

             ... dominating: block 2 instruction 7
  1 predecessor: 2
    24|     constant   v11 = 2
    25| return_value   v11 -> 1
    26|       return


  -------- Basic Block 4 --------





  Disassembly of 'search_and_update_results' in Workspace 3 at C:/Repos/focus/src/editors.jai:859
  - Stack size 2192

  -------- Basic Block 0 -------- defines v4-10 --------

             (no dominating)

     0|   stack_node
     1|        binop   v4, v1 + 144                          *search_bar
     2|         call   reset_search_results (v4)
     3|        binop   v6, v1 + 144
     4|        binop   v7, v6 + 56                           input.text
     5|         call   to_string (v7) -> v5{big 16}
     6|          lea   v8, stack+20                          *needle
     7|       memcpy   v8, v5 {size 16}                      needle :=
     8|          mov   v10, [v8] :8b                         needle.count
     9|      compare   v9 = (v10 != 0)
    10|         jump   1 if v9 != 0                          if !needle return
    11|          nop
    12|       return

  -------- Basic Block 1 -------- defines v11-28 --------

             ... dominating: block 0 instruction 10
  1 predecessor: 0
    13|        binop   v12, v2 + 96                          *buffer.bytes
    14|         call   to_string (v12) -> v11{big 16}
    15|          lea   v13, stack+40                         *buffer_str
    16|       memcpy   v13, v11 {size 16}                    buffer_str :=
    17|          mov   v14, [stack+40] :8b                   buffer_str.count
    18|     constant   v16 = 0x7fffffff                      S32_MAX
    19|      compare   v15 = (v14 < v16)
    20|      compare   v18 = (v15 != 0)
    21|          mov   v19, [stack+20] :8b                   needle.count
    22|      compare   v20 = (v19 < v16)
    23|        binop   v17, v18 & v20
    24|          lea   v21, stack+60                         "" / []Any
    25|        clear   v21+0 {size 16}
    26|          lea   v22, rdata+18a68                      #caller_location
    27|         call   assert (v17, v21, v21, v22)
    28|        binop   v24, v1 + 144                         editor.case_sensitive
    29|          mov   v25, [v24+154] :1b                    case_sensitive
    30|         call   bmh_prepare_skip_table (v8, v25) -> v23{big 1024}
    31|          lea   v26, stack+70                         *skip_table
    32|       memcpy   v26, v23 {size 1024}                  skip_table :=
    33|     constant   v27 = 0                               offset :=
    34|     constant   v28 = 0                               i :=

  -------- Basic Block 2 -------- defines v29-36 --------

             ... dominating: block 1 instruction 34
  1 predecessor: 1
    35|     constant   v29 = 1                               true
    36|         jump   11 if v29 == 0                        while true
    37|        binop   v30, v1 + 144                         *search_bar
    38|          mov   v31, [v30+154] :1b                    case_sensitive
    39|         jump   3 if v31 == 0                         if case_sensitive
    40|     constant   v33 = 0x100
    41|          lea   v34, stack+870                        parameter *skip_table
    42|          mov   [v34], v33 :8b                        parameter skip_table.count = 256
    43|          mov   [v34+8], v26 :8b                      parameter skip_table.data = *skip_table
    44|        binop   v35, v1 + 144
    45|          mov   v36, [v35+155] :1b                    ignore_whitespace
    46|         call   bmh_find_index_from_left (v13, v8, v27, v34, v36) -> v32
    47|         copy   v27 = v32                             offset =
    48|         jump   4

  -------- Basic Block 3 -------- defines v37-41 --------

             ... dominating: block 2 instruction 39
  1 predecessor: 2
    49|     constant   v38 = 0x100
    50|          lea   v39, stack+880
    51|          mov   [v39], v38 :8b
    52|          mov   [v39+8], v26 :8b
    53|        binop   v40, v1 + 144
    54|          mov   v41, [v40+155] :1b
    55|         call   bmh_find_index_from_left (v13, v8, v27, v39, v41) -> v37
    56|         copy   v27 = v37                             offset =

  -------- Basic Block 4 --------

             ... dominating: block 2 instruction 39
  1 predecessor: 3
    57|         jump   5 if v27 >= 0                         if offset < 0
    58|         jump   11                                    break

  -------- Basic Block 5 -------- defines v42-49 --------

             ... dominating: block 4 instruction 57
  1 predecessor: 4
    59|        binop   v42, v1 + 144                         *search_bar
    60|          mov   v43, [v42+156] :1b                    search_bar.whole_word
    61|      compare   v44 = (v43 == 0)
    62|         jump   7 if v44 != 0                         short circuit ||
    63|        binop   v45, v1 + 144                         *search_bar
    64|          mov   v46, [v45+156] :1b                    search_bar.whole_word
    65|      compare   v47 = (v46 != 0)
    66|         jump   6 if v47 == 0                         short circuit &&
    67|          mov   v49, [stack+20] :8b                   needle.count
    68|         call   match_whole_word (v13, v27, v49) -> v48
    69|         copy   v47 = v48

  -------- Basic Block 6 --------

             ... dominating: block 5 instruction 66
  1 predecessor: 5
    70|         copy   v44 = v47

  -------- Basic Block 7 -------- defines v50-63 --------

             ... dominating: block 5 instruction 62
  1 predecessor: 5
    71|         jump   10 if v44 == 0
    72|        binop   v52, v1 + 144                         *search_bar
    73|        binop   v53, v52 + 288                        *search_bar.results
    74|         call   array_add (v53) -> v51
    75|         copy   v50 = v51                             result :=
    76|          mov   [v50], v27 :8b                        result.offset =
    77|         call   offset_to_line (v2, v27) -> v54
    78|          mov   [v50+8], v54 :4b                      result.line =
    79|        binop   v55, v1 + 144                         *search_bar
    80|          mov   v56, [v55+148] :8b                    search_bar.selected_result
    81|      compare   v57 = (v56 < 0)
    82|      compare   v58 = (v57 != 0)
    83|         jump   8 if v58 == 0                         short circuit &&
    84|          mov   v59, [v50] :8b                        result.offset
    85|        binop   v61, v1 + 144                         *search_bar
    86|          mov   v62, [v61+150] :4b                    search_point_offset
    87|  cast_number   v63 (s64), v62 (s32)
    88|      compare   v60 = (v59 >= v63)
    89|         copy   v58 = v60

  -------- Basic Block 8 -------- defines v64-65 --------

             ... dominating: block 7 instruction 83
  1 predecessor: 7
    90|         jump   9 if v58 == 0
    91|        binop   v64, v1 + 144                         *search_bar
    92|        binop   v65, v64 + 328                        *selected_result
    93|          mov   [v65], v28 :8b                        = i

  -------- Basic Block 9 --------

             ... dominating: block 8 instruction 90
  1 predecessor: 7
    94|        binop   v28, v28 + 1                          i += 1

  -------- Basic Block 10 -------- defines v66 --------

             ... dominating: block 7 instruction 71
  1 predecessor: 5
    95|          mov   v66, [stack+20] :8b                   needle.count
    96|        binop   v27, v27 + v66                        offset += needle.count
    97|         jump   2

  -------- Basic Block 11 -------- defines v67-75 --------

             ... dominating: block 2 instruction 36
  1 predecessor: 2
    98|        binop   v67, v1 + 144                         *search_bar
    99|          mov   v68, [v67+148] :8b                    search_bar.selected_result
   100|      compare   v69 = (v68 < 0)
   101|      compare   v71 = (v69 != 0)
   102|      compare   v72 = (v28 > 0)                       i > 0
   103|        binop   v70, v71 & v72
   104|         jump   12 if v70 == 0
   105|        binop   v73, v1 + 144                         *search_bar
   106|        binop   v74, v73 + 328                        *selected_result
   107|        binop   v75, v28 + -1                         i - 1
   108|          mov   [v74], v75 :8b

  -------- Basic Block 12 -------- defines v76-81 --------

             ... dominating: block 11 instruction 104
  1 predecessor: 11
   109|        binop   v76, v1 + 144                         *search_bar
   110|          mov   v77, [v76+148] :8b                    search_bar.selected_result
   111|      compare   v78 = (v77 >= 0)
   112|      compare   v80 = (v78 != 0)
   113|        binop   v79, v80 & v3                         jump
   114|         jump   13 if v79 == 0
   115|     constant   v81 = 0
   116|         call   jump_to_search_result (v1, v2, v81)

  -------- Basic Block 13 --------

             ... dominating: block 12 instruction 114
  1 predecessor: 12
   117|       return
























  Disassembly of 'get_closest_line' in Workspace 3 at C:/Repos/focus/src/editors.jai:904
  - Stack size 32

  -------- Basic Block 0 -------- defines v5-16 --------

             (no dominating)

     0|   stack_node
     1|          mov   v5, [v3] :4b                          cooords.line
     2|         copy   v6 = v5
     3|         call   get_line_info (v1, v2, v6) -> v7, v8, v9
     4|         copy   v10 = v7
     5|         copy   v11 = v8
     6|         copy   v12 = v9
     7|      compare   v14 = (v12 != 0)                      count != 0
     8|          mov   v16, [v3+4] :4b                       coords.col
     9|      compare   v15 = (v12 >= v16)                    count >= coords.col
    10|        binop   v13, v14 & v15                        &&
    11|         jump   1 if v13 == 0
    12| return_value   v6 -> 1
    13|       return

  -------- Basic Block 1 -------- defines v17-29 --------

             ... dominating: block 0 instruction 11
  1 predecessor: 0
    14|          mov   v17, [v3] :4b
    15|        binop   v18, v17 + -1
    16|         copy   v19 = v18
    17|         call   get_line_info (v1, v2, v19) -> v20, v21, v22
    18|         copy   v23 = v20
    19|         copy   v24 = v21
    20|         copy   v25 = v22
    21|      compare   v27 = (v25 != 0)
    22|          mov   v29, [v3+4] :4b
    23|      compare   v28 = (v25 >= v29)
    24|        binop   v26, v27 & v28
    25|         jump   2 if v26 == 0
    26| return_value   v19 -> 1
    27|       return

  -------- Basic Block 2 -------- defines v30-42 --------

             ... dominating: block 1 instruction 25
  1 predecessor: 1
    28|          mov   v30, [v3] :4b
    29|        binop   v31, v30 + 1
    30|         copy   v32 = v31
    31|         call   get_line_info (v1, v2, v32) -> v33, v34, v35
    32|         copy   v36 = v33
    33|         copy   v37 = v34
    34|         copy   v38 = v35
    35|      compare   v40 = (v38 != 0)
    36|          mov   v42, [v3+4] :4b
    37|      compare   v41 = (v38 >= v42)
    38|        binop   v39, v40 & v41
    39|         jump   3 if v39 == 0
    40| return_value   v32 -> 1
    41|       return

  -------- Basic Block 3 -------- defines v43-55 --------

             ... dominating: block 2 instruction 39
  1 predecessor: 2
    42|          mov   v43, [v3] :4b
    43|        binop   v44, v43 + -2
    44|         copy   v45 = v44
    45|         call   get_line_info (v1, v2, v45) -> v46, v47, v48
    46|         copy   v49 = v46
    47|         copy   v50 = v47
    48|         copy   v51 = v48
    49|      compare   v53 = (v51 != 0)
    50|          mov   v55, [v3+4] :4b
    51|      compare   v54 = (v51 >= v55)
    52|        binop   v52, v53 & v54
    53|         jump   4 if v52 == 0
    54| return_value   v45 -> 1
    55|       return

  -------- Basic Block 4 -------- defines v56-68 --------

             ... dominating: block 3 instruction 53
  1 predecessor: 3
    56|          mov   v56, [v3] :4b
    57|        binop   v57, v56 + 2
    58|         copy   v58 = v57
    59|         call   get_line_info (v1, v2, v58) -> v59, v60, v61
    60|         copy   v62 = v59
    61|         copy   v63 = v60
    62|         copy   v64 = v61
    63|      compare   v66 = (v64 != 0)
    64|          mov   v68, [v3+4] :4b
    65|      compare   v67 = (v64 >= v68)
    66|        binop   v65, v66 & v67
    67|         jump   5 if v65 == 0
    68| return_value   v58 -> 1
    69|       return

  -------- Basic Block 5 -------- defines v69 --------

             ... dominating: block 4 instruction 67
  1 predecessor: 4
    70|          mov   v69, [v3] :4b
    71| return_value   v69 -> 1
    72|       return
















Disassembly of 'os_clipboard_get_text' in Workspace 3 at C:/Repos/focus/modules/Clipboard/Clipboard.jai:31
- Stack size 80

-------- Basic Block 0 -------- defines v3-33 --------

           (no dominating)

   0|   stack_node
   1|          lea   v3, stack+20                            *text
   2|        clear   v3+0 {size 16}                          text : string
   3|         call   OpenClipboard (v1) -> v4
   4|         jump   3 if v4 == 0
   5|     constant   v7 = 0xd                                CF_UNICODETEXT
   6|         call   GetClipboardData (v7) -> v6
   7|         copy   v5 = v6                                 hData :=
   8|         call   GlobalLock (v5) -> v9
   9|         copy   v8 = v9                                 buffer :=
  10|     constant   v12 = 0xfde9                            CP
  11|     constant   v13 = 0
  12|     constant   v14 = 0xffffffffffffffff                -1
  13|     constant   v15 = 0
  14|     constant   v16 = 0
  15|     constant   v17 = 0
  16|         call   WideCharToMultiByte (v12, v13, v5, v14, v15, v13, v16, v17) -> v11
  17|         copy   v10 = v11                               length :=
  18|  cast_number   v20 (s64), v10 (s32)
  19|          lea   v21, rdata+1468                         *Allocator.{}
  20|         call   alloc (v20, v21) -> v19
  21|         copy   v18 = v19                               utf8 :=
  22|     constant   v23 = 0
  23|     constant   v24 = 0
  24|         call   WideCharToMultiByte (v12, v13, v5, v14, v18, v10, v23, v24) -> v22
  25|         jump   1 if v10 == 0                           if length
  26|        binop   v25, v10 + -1                           length - 1
  27|  cast_number   v26 (s64), v25 (s32)
  28|          mov   [stack+20], v26 :8b                     text.count =
  29|          mov   [stack+28], v18 :8b                     text.data =
  30|          mov   v27, [stack+28] :8b                     text.data
  31|        binop   v28, v10 + -1                           length - 1
  32|  cast_number   v29 (s64), v28 (s32)
  33|          mov   v30, [v27+v29*1] :1b                    text.data[length-1]
  34|      compare   v31 = (v30 == 0)
  35|          lea   v32, stack+30                           assert *format_string and *args
  36|        clear   v32+0 {size 16}
  37|          lea   v33, rdata+10d68                        #caller_location
  38|         call   assert (v31, v32, v32, v33)
  39|         jump   2

-------- Basic Block 1 -------- defines v34 --------

           ... dominating: block 0 instruction 25
1 predecessor: 0
  40|          lea   v34, stack+40                           *""
  41|        clear   v34+0 {size 16}
  42|       memcpy   v3, v34 {size 16}                       text = ""

-------- Basic Block 2 -------- defines v35-36 --------

           ... dominating: block 0 instruction 25
1 predecessor: 1
  43|         call   GlobalUnlock (v5) -> v35
  44|         call   CloseClipboard () -> v36

-------- Basic Block 3 --------

           ... dominating: block 0 instruction 4
1 predecessor: 0
  45| return_value   v3 -> 1
  46|       return





















  Disassembly of 'dump_buffer_state' in Workspace 3 at C:/Repos/focus/src/session.jai:339
  - Stack size 4504

  -------- Basic Block 0 -------- defines v3-16 --------

             (no dominating)

     0|   stack_node
     1|          lea   v5, data+db8                          *open_buffers
     2|         call   *[] (v5, v1) -> v4
     3|         copy   v3 = v4                               buffer :=
     4|          lea   v6, stack+20                          *state
     5|         call   {anonymous} (v6)                      state : Buffer_State
     6|     constant   v7 = 1                                Buffer_State.CURRENT_VERSION
     7|          mov   [stack+20], v7 :8b                    state.version =
     8|          mov   [stack+28], v1 :8b                    state.buffer_id = buffer_id
     9|        binop   v8, v6 + 16                           *state.file
    10|       memcpy   v8, v3 {size 56}                      state.file = buffer.file
    11|          mov   v9, [v3+d8] :1b                       buffer.has_file
    12|          mov   [stack+68], v9 :1b                    state.has_file =
    13|          mov   v10, [v3+db] :1b                      buffer.modified
    14|          mov   [stack+69], v10 :1b                   state.unsaved =
    15|        binop   v11, v3 + 72                          *buffer.last_modtime
    16|        binop   v12, v6 + 80                          *state.last_modtime
    17|       memcpy   v12, v11 {size 16}                    state.last_modtime = buffer.last_modtime
    18|          mov   v13, [v3+58] :8b                      buffer.last_size
    19|          mov   [stack+80], v13 :8b                   state.last_size =
    20|     constant   v14 = 0                               num_editors :=
    21|          lea   v15, bss+8778                         *open_editors
    22|     constant   v16 = 0                               it_index

  -------- Basic Block 1 -------- defines v17-21 --------

             ... dominating: block 0 instruction 22
  1 predecessor: 0
    23|          mov   v17, [v15] :8b                        open_editors.count
    24|         jump   4 if v16 >= v17                       if it_index >= open_editors.count break
    25|          mov   v19, [v15+8] :8b                      open_editors.data
    26|        binop   v20, v16 * 744                        it_index * size
    27|        binop   v18, v19 + v20                        *it
    28|          mov   v21, [v18] :8b                        it
    29|         jump   2 if v21 == v1                        if it.buffer_id != buffer_id
    30|         jump   3                                        continue

  -------- Basic Block 2 -------- defines v22-34 --------

             ... dominating: block 1 instruction 29
  1 predecessor: 1
    31|          lea   v23, stack+d8                         *editor_state
    32|     constant   v24 = 2                               editor_states.count
    33|  array_check   v14, v24
    34|        binop   v25, v14 * 32                         num_editors * size
    35|        binop   v22, v23 + v25                        editor_state = *editor+states[num_editors]
    36|          mov   [v22], v16 :8b                        editor_state.editor_id = it_index
    37|        binop   v26, v18 + 8                          *it.cursors
    38|          mov   v27, [v18+30] :8b                     it.main_cursor
    39|          mov   v28, [v26] :8b                        it.cursors.count
    40|  array_check   v27, v28
    41|          mov   v29, [v26+8] :8b                      it.cursors.data
    42|        binop   v31, v27 * 12                         it.main_cursor * size
    43|        binop   v30, v29 + v31                        it.cursors[it.main_cursor]
    44|        binop   v32, v22 + 8                          editor_state.main_cursor
    45|       memcpy   v32, v30 {size 12}                    editor_state.main_cursor = it.cursors[it.main_cursor].state
    46|          mov   v33, [v18+230] :4b                    it.viewport.top
    47|          mov   [v22+20], v33 :4b                     editor_state.viewport_top =
    48|          mov   v34, [v18+234] :4b                    it.viewport.left
    49|          mov   [v22+24], v34 :4b                     editor_state.viewport_left =
    50|        binop   v14, v14 + 1                          num_editors += 1
    51|         jump   3 if v14 < v24                        if num_editors >= 2
    52|         jump   4                                         break

  -------- Basic Block 3 --------

             ... dominating: block 1 instruction 28
  3 predecessors: 2, 0, 1
    53|        binop   v16, v16 + 1                          it_index += 1
    54|         jump   1                                     loop for

  -------- Basic Block 4 -------- defines v35-45 --------

             ... dominating: block 0 instruction 22
  1 predecessor: 3
    55|      compare   v35 = (v14 >= v7)                     num_editors >= 1
    56|          lea   v36, stack+118                        assert *format_string
    57|     constant   v37 = 0x3b
    58|          mov   [v36], v37 :8b                        format_string.count
    59|       string   v38, {long string, 59 bytes}
    60|          mov   [v36+8], v38 :8b                      format_string.data
    61|          lea   v39, stack+128                        assert *args
    62|        clear   v39+0 {size 16}                       .[]
    63|          lea   v40, rdata+12160                      #caller_location
    64|         call   assert (v35, v36, v39, v40)
    65|          lea   v41, stack+d8                         *editor_states
    66|        binop   v42, v41 + 0                          *editor_state[0]
    67|        binop   v43, v6 + 104                         *state.editor1
    68|       memcpy   v43, v42 {size 32}                    state.editor1 = editor_states[0]
    69|         jump   5 if v14 <= v7                        if num_editors > 1
    70|        binop   v44, v41 + 32                         *editor_states[1]
    71|        binop   v45, v6 + 136                         *state.editor2
    72|       memcpy   v45, v44 {size 32}                    state.editor2 = editor_states[1]

  -------- Basic Block 5 -------- defines v46-49 --------

             ... dominating: block 4 instruction 69
  1 predecessor: 4
    73|      compare   v46 = (v14 > v7)                      num_editors > 1
    74|          mov   [stack+c8], v46 :1b                   state.editor2_exists =
    75|          mov   v48, [v3+db] :1b                      buffer.modified
    76|         jump   6 if v48 == 0                         ifx buffer.modified
    77|          mov   v49, [v3+60] :8b                      buffer.bytes.count
    78|         copy   v47 = v49                             ifx result
    79|         jump   7

  -------- Basic Block 6 -------- defines v50 --------

             ... dominating: block 5 instruction 76
  1 predecessor: 5
    80|     constant   v50 = 0                               0
    81|         copy   v47 = v50                             ifx result

  -------- Basic Block 7 -------- defines v51-56 --------

             ... dominating: block 5 instruction 76
  1 predecessor: 6
    82|          mov   [stack+d0], v47 :8b                   state.bytes_size =
    83|          lea   v51, stack+138                        *builder
    84|     constant   v52 = 0xffffffffffffffff              -1
    85|          mov   [v51+8], v52 :8b                      builder subsequent_buffer_size
    86|        clear   v51+0 {size 8}                        builder initialized * failed
    87|        clear   v51+16 {size 4088}                    builder allocator + current_buffer + initial_bytes
    88|         call   init_string_builder (v51, v52)
    89|     constant   v53 = 0xb8                            size_of(Buffer_State)
    90|         call   append (v51, v6, v53)                 *builder, *state
    91|          mov   v54, [v3+db] :1b                      buffer.modified
    92|         jump   8 if v54 == 0
    93|          mov   v55, [v3+68] :8b                      buffer.bytes.data
    94|          mov   v56, [v3+60] :8b                      buffer.bytes.count
    95|         call   append (v51, v55, v56)                *builder

  -------- Basic Block 8 -------- defines v57-70 --------

             ... dominating: block 7 instruction 92
  1 predecessor: 7
    96|          lea   v58, rdata+c90                        *temp allocator
    97|     constant   v59 = 0
    98|     constant   v60 = 0
    99|         call   builder_to_string (v51, v58, v59, v60) -> v57{big 16}
   100|          lea   v61, stack+1140                       hashable_str
   101|       memcpy   v61, v57 {size 16}                    hashable_str :=
   102|         call   to_bytes (v61) -> v63{big 16}
   103|         call   calculate_meow_hash (v63) -> v62
   104|          mov   [stack+1160], v62 :8b                 meow_hash :=
   105|          lea   v64, stack+1160
   106|     constant   v65 = 8                               size(meow_hash)
   107|         call   append (v51, v64, v65)                builder, meow_hash
   108|        binop   v67, v0 + 16                          *context.allocator
   109|     constant   v68 = 1
   110|         call   builder_to_string (v51, v67, v59, v68) -> v66{big 16}
   111|          lea   v69, stack+1178                       *str
   112|       memcpy   v69, v66 {size 16}                    str :=
   113| return_value   v69 -> 1
   114|       return






















Disassembly of 'basic_type_stuff' in Workspace 2 at C:/jai/how_to/008_types.jai:46
- Stack size 336

-------- Basic Block 0 -------- defines v1-50 --------

           (no dominating)

   0|   stack_node
   1|     constant   v1 = 0
   2|    emit_type   v1, float64
   3|    emit_type   v2, int
   4|          lea   v4, stack+20                            *format_string
   5|     constant   v5 = 7
   6|          mov   [v4], v5 :8b                            format_string.count = 7
   7|       string   v6, "a is %\n"
   8|          mov   [v4+8], v6 :8b                          format_string.data =
   9|     constant   v7 = 1                                  args.count
  10|          lea   v8, stack+30                            *args
  11|          mov   [v8], v7 :8b                            args.count = 1
  12|          lea   v9, stack+40                            *a
  13|          mov   [stack+40], v1 :8b                      a := float64
  14|          lea   v10, stack+48                           *Any (any)
  15|    emit_type   v11, Type
  16|          mov   [v10], v11 :8b                          any.type
  17|          mov   [v10+8], v9 :8b                         any.value_pointer
  18|          mov   [v8+8], v10 :8b                         args.data
  19|     constant   v12 = 0
  20|         call   print (v4, v8, v12) -> v3               to_standard_error
  21|          lea   v14, stack+58
  22|          mov   [v14], v5 :8b
  23|       string   v15, "b is %\n"
  24|          mov   [v14+8], v15 :8b
  25|          lea   v16, stack+68
  26|          mov   [stack+68], v2 :8b
  27|          lea   v17, stack+70
  28|          mov   [v17], v11 :8b
  29|          mov   [v17+8], v16 :8b
  30|          mov   [v8+8], v17 :8b
  31|         call   print (v14, v8, v12) -> v13
  32|    emit_type   v18, Vector3
  33|         copy   v19 = v18
  34|          lea   v21, stack+80
  35|          mov   [v21], v7 :8b
  36|       string   v22, "\n"
  37|          mov   [v21+8], v22 :8b
  38|          lea   v23, stack+90
  39|        clear   v23+0 {size 16}
  40|         call   print (v21, v23, v12) -> v20
  41|          lea   v25, stack+a0
  42|     constant   v26 = 0x15
  43|          mov   [v25], v26 :8b
  44|       string   v27, "The value of d is: %\n"
  45|          mov   [v25+8], v27 :8b
  46|          lea   v28, stack+b0
  47|          mov   [stack+b0], v19 :8b
  48|          lea   v29, stack+b8
  49|          mov   [v29], v11 :8b
  50|          mov   [v29+8], v28 :8b
  51|          mov   [v8+8], v29 :8b
  52|         call   print (v25, v8, v12) -> v24
  53|          lea   v31, stack+c8
  54|     constant   v32 = 0x37
  55|          mov   [v31], v32 :8b
  56|       string   v33, {long string, 55 bytes}
  57|          mov   [v31+8], v33 :8b
  58|    emit_type   v34, Type
  59|          lea   v35, stack+d8
  60|          mov   [stack+d8], v34 :8b
  61|          lea   v36, stack+e0
  62|          mov   [v36], v11 :8b
  63|          mov   [v36+8], v35 :8b
  64|          mov   [v8+8], v36 :8b
  65|         call   print (v31, v8, v12) -> v30
  66|         call   print (v21, v23, v12) -> v37
  67|    emit_type   v38, Type
  68|          lea   v40, stack+f0
  69|     constant   v41 = 0x18
  70|          mov   [v40], v41 :8b
  71|       string   v42, "e is of type %, value %\n"
  72|          mov   [v40+8], v42 :8b
  73|     constant   v43 = 2
  74|          mov   [v8], v43 :8b
  75|          lea   v44, stack+100
  76|          mov   [v8+8], v44 :8b
  77|    emit_type   v45, Type
  78|          lea   v46, stack+120
  79|          mov   [stack+120], v45 :8b
  80|          lea   v47, stack+128
  81|          mov   [v47], v11 :8b
  82|          mov   [v47+8], v46 :8b
  83|       memcpy   v44, v47 {size 16}
  84|        binop   v44, v44 + 16
  85|          lea   v48, stack+138
  86|          mov   [stack+138], v38 :8b
  87|          lea   v49, stack+140
  88|          mov   [v49], v11 :8b
  89|          mov   [v49+8], v48 :8b
  90|       memcpy   v44, v49 {size 16}
  91|         call   print (v40, v8, v12) -> v39
  92|         call   print (v21, v23, v12) -> v50
  93|       return



















Disassembly of 'named_arguments' in Workspace 2 at C:/jai/how_to/010_calling_procedures.jai:20
- Stack size 128

-------- Basic Block 0 -------- defines v1-26 --------

           (no dominating)

   0|   stack_node
   1|          lea   v1, stack+20
   2|     constant   v2 = 4
   3|          mov   [v1], v2 :8b
   4|       string   v3, "Fred"
   5|          mov   [v1+8], v3 :8b
   6|          lea   v4, stack+30
   7|     constant   v5 = 9
   8|          mov   [v4], v5 :8b
   9|       string   v6, "Hot Damn!"
  10|          mov   [v4+8], v6 :8b
  11|     constant   v7 = 0
  12|     constant   v8 = 4
  13|         call   make_character (v1, v4, v7, v8)
  14|         call   make_character (v1, v4, v7, v8)
  15|         call   make_character (v1, v4, v7, v8)
  16|         call   make_character (v1, v4, v7, v8)
  17|          lea   v9, stack+40
  18|     constant   v10 = 7
  19|          mov   [v9], v10 :8b
  20|       string   v11, "My Call"
  21|          mov   [v9+8], v11 :8b
  22|     constant   v12 = 1
  23|     constant   v13 = 2
  24|     constant   v14 = 3
  25|          lea   v15, stack+50
  26|     constant   v16 = 0x11
  27|          mov   [v15], v16 :8b
  28|       string   v17, "The New Originals"
  29|          mov   [v15+8], v17 :8b
  30|     constant   v18 = 0x40b00000
  31|     constant   v19 = 0x40c00000
  32|     constant   v20 = 0
  33|         call   many_things (v9, v12, v13, v14, v15, v18, v19, v20)
  34|         call   many_things (v9, v12, v13, v14, v15, v18, v19, v20)
  35|          lea   v21, stack+60
  36|     constant   v22 = 6
  37|          mov   [v21], v22 :8b
  38|       string   v23, "Hello,"
  39|          mov   [v21+8], v23 :8b
  40|     constant   v24 = 0
  41|          lea   v25, stack+70
  42|          mov   [v25], v10 :8b
  43|       string   v26, "Sailor!"
  44|          mov   [v25+8], v26 :8b
  45|         call   curious (v21, v24, v25)
  46|       return




























Disassembly of 'varargs_strings' in Workspace 2 at C:/jai/how_to/010_calling_procedures.jai:77
- Stack size 360

-------- Basic Block 0 -------- defines v3-14 --------

           (no dominating)

   0|   stack_node
   1|          lea   v4, stack+20
   2|     constant   v5 = 0x1a
   3|          mov   [v4], v5 :8b                            format_string.count
   4|       string   v6, "The type of 'names' is %.\n"
   5|          mov   [v4+8], v6 :8b                          format_string.data
   6|     constant   v7 = 1
   7|          lea   v8, stack+30
   8|          mov   [v8], v7 :8b
   9|    emit_type   v9, [] string
  10|          lea   v10, stack+40
  11|          mov   [stack+40], v9 :8b
  12|          lea   v11, stack+48
  13|    emit_type   v12, Type
  14|          mov   [v11], v12 :8b
  15|          mov   [v11+8], v10 :8b
  16|          mov   [v8+8], v11 :8b
  17|     constant   v13 = 0
  18|         call   print (v4, v8, v13) -> v3
  19|     constant   v14 = 0                                 it_index

-------- Basic Block 1 -------- defines v15-32 --------

           ... dominating: block 0 instruction 19
1 predecessor: 0
  20|          mov   v15, [v2] :8b                           names.count
  21|         jump   3 if v14 >= v15                         exit for
  22|          mov   v17, [v2+8] :8b                         names.data
  23|        binop   v18, v14 * 16
  24|        binop   v16, v17 + v18
  25|          lea   v20, stack+58
  26|     constant   v21 = 0x1b
  27|          mov   [v20], v21 :8b
  28|       string   v22, "i is %, and names[%] is %.\n"
  29|          mov   [v20+8], v22 :8b
  30|     constant   v23 = 3
  31|          mov   [v8], v23 :8b
  32|          lea   v24, stack+68
  33|          mov   [v8+8], v24 :8b
  34|          lea   v25, stack+98
  35|          mov   [stack+98], v1 :8b
  36|          lea   v26, stack+a0
  37|    emit_type   v27, int
  38|          mov   [v26], v27 :8b
  39|          mov   [v26+8], v25 :8b
  40|       memcpy   v24, v26 {size 16}
  41|        binop   v24, v24 + 16
  42|          lea   v28, stack+b0
  43|          mov   [stack+b0], v14 :8b
  44|          lea   v29, stack+b8
  45|    emit_type   v30, s64
  46|          mov   [v29], v30 :8b
  47|          mov   [v29+8], v28 :8b
  48|       memcpy   v24, v29 {size 16}
  49|        binop   v24, v24 + 16
  50|          lea   v31, stack+c8
  51|    emit_type   v32, string
  52|          mov   [v31], v32 :8b
  53|          mov   [v31+8], v16 :8b
  54|       memcpy   v24, v31 {size 16}
  55|         call   print (v20, v8, v13) -> v19

-------- Basic Block 2 --------

           ... dominating: block 1 instruction 25
2 predecessors: 0, 1
  56|        binop   v14, v14 + 1
  57|         jump   1

-------- Basic Block 3 -------- defines v33-46 --------

           ... dominating: block 0 instruction 19
1 predecessor: 2
  58|         call   print_strings_together (v2)
  59|          lea   v33, rdata+578
  60|     constant   v34 = 6
  61|          lea   v35, stack+d8
  62|          mov   [v35], v34 :8b
  63|          mov   [v35+8], v33 :8b
  64|         call   print_strings_together (v35)
  65|     constant   v36 = 4
  66|          mov   [v8], v36 :8b
  67|          lea   v37, stack+e8
  68|          mov   [v8+8], v37 :8b
  69|          lea   v38, stack+128
  70|          mov   [v38], v36 :8b
  71|       string   v39, "Ohio"
  72|          mov   [v38+8], v39 :8b
  73|       memcpy   v37, v38 {size 16}
  74|        binop   v37, v37 + 16
  75|          lea   v40, stack+138
  76|          mov   [v40], v34 :8b
  77|       string   v41, "Oregon"
  78|          mov   [v40+8], v41 :8b
  79|       memcpy   v37, v40 {size 16}
  80|        binop   v37, v37 + 16
  81|          lea   v42, stack+148
  82|          mov   [v42], v36 :8b
  83|       string   v43, "Oslo"
  84|          mov   [v42+8], v43 :8b
  85|       memcpy   v37, v42 {size 16}
  86|        binop   v37, v37 + 16
  87|          lea   v44, stack+158
  88|     constant   v45 = 7
  89|          mov   [v44], v45 :8b
  90|       string   v46, "Oceania"
  91|          mov   [v44+8], v46 :8b
  92|       memcpy   v37, v44 {size 16}
  93|         call   print_strings_together (v8)
  94|       return






















  Disassembly of 'arguments_with_varargs' in Workspace 2 at C:/jai/how_to/010_calling_procedures.jai:70
  - Stack size 1296

  -------- Basic Block 0 -------- defines v1-111 --------

             (no dominating)

     0|   stack_node
     1|     constant   v1 = 0xb                                i
     2|     constant   v2 = 5
     3|          lea   v3, stack+20                            names : []string
     4|          mov   [v3], v2 :8b                            names.count = 5
     5|          lea   v4, stack+30
     6|          mov   [v3+8], v4 :8b                          names.data
     7|          lea   v5, stack+80                            *Fred
     8|     constant   v6 = 4
     9|          mov   [v5], v6 :8b                            Fred.count
    10|       string   v7, "Fred"
    11|          mov   [v5+8], v7 :8b                          Fred.data
    12|       memcpy   v4, v5 {size 16}                        names[0] = Fred
    13|        binop   v4, v4 + 16
    14|          lea   v8, stack+90                            *Alfred
    15|     constant   v9 = 6
    16|          mov   [v8], v9 :8b                            Alfred.count = 6
    17|       string   v10, "Alfred"
    18|          mov   [v8+8], v10 :8b                         Alfred.data
    19|       memcpy   v4, v8 {size 16}                        names[1] = Alfred
    20|        binop   v4, v4 + 16
    21|          lea   v11, stack+a0                           *Alan
    22|          mov   [v11], v6 :8b                           Alan.count = 4
    23|       string   v12, "Alan"
    24|          mov   [v11+8], v12 :8b                        Alan.data
    25|       memcpy   v4, v11 {size 16}                       names[1] = Alan
    26|        binop   v4, v4 + 16
    27|          lea   v13, stack+b0                           *Frederick
    28|     constant   v14 = 9
    29|          mov   [v13], v14 :8b                          Frederick.count = 9
    30|       string   v15, "Frederick"
    31|          mov   [v13+8], v15 :8b                        Frederick.data
    32|       memcpy   v4, v13 {size 16}                       names[2] = Frederick
    33|        binop   v4, v4 + 16
    34|          lea   v16, stack+c0                           *Joe
    35|     constant   v17 = 3
    36|          mov   [v16], v17 :8b                          Joe.count = 3
    37|       string   v18, "Joe"
    38|          mov   [v16+8], v18 :8b                        Joe.data
    39|       memcpy   v4, v16 {size 16}                       names[3] = Joe
    40|         call   varargs_strings (v1, v3)
    41|          lea   v20, stack+d0
    42|     constant   v21 = 1
    43|          mov   [v20], v21 :8b
    44|       string   v22, "\n"
    45|          mov   [v20+8], v22 :8b
    46|          lea   v23, stack+e0
    47|        clear   v23+0 {size 16}
    48|     constant   v24 = 0
    49|         call   print (v20, v23, v24) -> v19
    50|          lea   v25, stack+f0
    51|          mov   [v25], v2 :8b
    52|       string   v26, "Hello"
    53|          mov   [v25+8], v26 :8b
    54|     constant   v27 = 2
    55|         call   varargs_strings_and_ints (v25, v27, v23)
    56|          lea   v28, stack+100
    57|          mov   [v28], v6 :8b
    58|       string   v29, "What"
    59|          mov   [v28+8], v29 :8b
    60|          mov   [v3], v14 :8b
    61|          lea   v30, stack+110
    62|          mov   [v3+8], v30 :8b
    63|          lea   v31, stack+1a0
    64|          mov   [v31], v27 :8b
    65|       string   v32, "is"
    66|          mov   [v31+8], v32 :8b
    67|          lea   v33, stack+1b0
    68|    emit_type   v34, string
    69|          mov   [v33], v34 :8b
    70|          mov   [v33+8], v31 :8b
    71|       memcpy   v30, v33 {size 16}
    72|        binop   v30, v30 + 16
    73|          lea   v35, stack+1c0
    74|          mov   [v35], v17 :8b
    75|       string   v36, "the"
    76|          mov   [v35+8], v36 :8b
    77|          lea   v37, stack+1d0
    78|          mov   [v37], v34 :8b
    79|          mov   [v37+8], v35 :8b
    80|       memcpy   v30, v37 {size 16}
    81|        binop   v30, v30 + 16
    82|          lea   v38, stack+1e0
    83|          mov   [v38], v9 :8b
    84|       string   v39, "matter"
    85|          mov   [v38+8], v39 :8b
    86|          lea   v40, stack+1f0
    87|          mov   [v40], v34 :8b
    88|          mov   [v40+8], v38 :8b
    89|       memcpy   v30, v40 {size 16}
    90|        binop   v30, v30 + 16
    91|          lea   v41, stack+200
    92|          mov   [stack+200], v14 :8b
    93|          lea   v42, stack+208
    94|    emit_type   v43, s64
    95|          mov   [v42], v43 :8b
    96|          mov   [v42+8], v41 :8b
    97|       memcpy   v30, v42 {size 16}
    98|        binop   v30, v30 + 16
    99|     constant   v44 = 0x64
   100|          lea   v45, stack+218
   101|          mov   [stack+218], v44 :8b
   102|          lea   v46, stack+220
   103|          mov   [v46], v43 :8b
   104|          mov   [v46+8], v45 :8b
   105|       memcpy   v30, v46 {size 16}
   106|        binop   v30, v30 + 16
   107|          lea   v47, stack+230
   108|          mov   [v47], v2 :8b
   109|       string   v48, "dudes"
   110|          mov   [v47+8], v48 :8b
   111|          lea   v49, stack+240
   112|          mov   [v49], v34 :8b
   113|          mov   [v49+8], v47 :8b
   114|       memcpy   v30, v49 {size 16}
   115|        binop   v30, v30 + 16
   116|     constant   v50 = 0x2ee0
   117|          lea   v51, stack+250
   118|          mov   [stack+250], v50 :8b
   119|          lea   v52, stack+258
   120|          mov   [v52], v43 :8b
   121|          mov   [v52+8], v51 :8b
   122|       memcpy   v30, v52 {size 16}
   123|        binop   v30, v30 + 16
   124|          lea   v53, stack+268
   125|     constant   v54 = 0xc
   126|          mov   [v53], v54 :8b
   127|       string   v55, "and dudettes"
   128|          mov   [v53+8], v55 :8b
   129|          lea   v56, stack+278
   130|          mov   [v56], v34 :8b
   131|          mov   [v56+8], v53 :8b
   132|       memcpy   v30, v56 {size 16}
   133|        binop   v30, v30 + 16
   134|    emit_type   v57, float
   135|          lea   v58, stack+288
   136|          mov   [stack+288], v57 :8b
   137|          lea   v59, stack+290
   138|    emit_type   v60, Type
   139|          mov   [v59], v60 :8b
   140|          mov   [v59+8], v58 :8b
   141|       memcpy   v30, v59 {size 16}
   142|         call   varargs_strings_and_ints (v28, v21, v3)
   143|          lea   v61, stack+2a0
   144|          mov   [v61], v17 :8b
   145|       string   v62, "How"
   146|          mov   [v61+8], v62 :8b
   147|          mov   [v3], v17 :8b
   148|          lea   v63, stack+2b0
   149|          mov   [v3+8], v63 :8b
   150|          lea   v64, stack+2e0
   151|          mov   [v64], v17 :8b
   152|       string   v65, "are"
   153|          mov   [v64+8], v65 :8b
   154|          lea   v66, stack+2f0
   155|          mov   [v66], v34 :8b
   156|          mov   [v66+8], v64 :8b
   157|       memcpy   v63, v66 {size 16}
   158|        binop   v63, v63 + 16
   159|          lea   v67, stack+300
   160|          mov   [v67], v17 :8b
   161|       string   v68, "you"
   162|          mov   [v67+8], v68 :8b
   163|          lea   v69, stack+310
   164|          mov   [v69], v34 :8b
   165|          mov   [v69+8], v67 :8b
   166|       memcpy   v63, v69 {size 16}
   167|        binop   v63, v63 + 16
   168|          lea   v70, stack+320
   169|          mov   [v70], v9 :8b
   170|       string   v71, "there?"
   171|          mov   [v70+8], v71 :8b
   172|          lea   v72, stack+330
   173|          mov   [v72], v34 :8b
   174|          mov   [v72+8], v70 :8b
   175|       memcpy   v63, v72 {size 16}
   176|         call   varargs_strings_and_ints (v61, v2, v3)
   177|          lea   v73, stack+340
   178|          mov   [v73], v2 :8b
   179|       string   v74, "Where"
   180|          mov   [v73+8], v74 :8b
   181|          mov   [v3], v2 :8b
   182|          lea   v75, stack+350
   183|          mov   [v3+8], v75 :8b
   184|          lea   v76, stack+3a0
   185|          mov   [stack+3a0], v21 :8b
   186|          lea   v77, stack+3a8
   187|          mov   [v77], v43 :8b
   188|          mov   [v77+8], v76 :8b
   189|       memcpy   v75, v77 {size 16}
   190|        binop   v75, v75 + 16
   191|          lea   v78, stack+3b8
   192|          mov   [v78], v34 :8b
   193|          mov   [v78+8], v64 :8b
   194|       memcpy   v75, v78 {size 16}
   195|        binop   v75, v75 + 16
   196|          lea   v79, stack+3c8
   197|          mov   [v79], v34 :8b
   198|          mov   [v79+8], v67 :8b
   199|       memcpy   v75, v79 {size 16}
   200|        binop   v75, v75 + 16
   201|          lea   v80, stack+3d8
   202|          mov   [v80], v2 :8b
   203|       string   v81, "going"
   204|          mov   [v80+8], v81 :8b
   205|          lea   v82, stack+3e8
   206|          mov   [v82], v34 :8b
   207|          mov   [v82+8], v80 :8b
   208|       memcpy   v75, v82 {size 16}
   209|        binop   v75, v75 + 16
   210|          lea   v83, stack+3f8
   211|          mov   [v83], v27 :8b
   212|       string   v84, "to"
   213|          mov   [v83+8], v84 :8b
   214|          lea   v85, stack+408
   215|          mov   [v85], v34 :8b
   216|          mov   [v85+8], v83 :8b
   217|       memcpy   v75, v85 {size 16}
   218|         call   varargs_strings_and_ints (v73, v17, v3)
   219|          lea   v86, stack+418
   220|        clear   v86+0 {size 96}
   221|          lea   v87, stack+478
   222|          mov   [v87], v17 :8b
   223|       string   v88, "did"
   224|          mov   [v87+8], v88 :8b
   225|          lea   v89, stack+418
   226|          mov   [v89], v34 :8b
   227|          mov   [v89+8], v87 :8b
   228|          lea   v90, stack+488
   229|          mov   [v90], v6 :8b
   230|       string   v91, "that"
   231|          mov   [v90+8], v91 :8b
   232|          lea   v92, stack+418
   233|          mov   [v92+16], v34 :8b
   234|          mov   [v92+24], v90 :8b
   235|          lea   v93, stack+498
   236|          mov   [v93], v2 :8b
   237|       string   v94, "thing"
   238|          mov   [v93+8], v94 :8b
   239|          lea   v95, stack+418
   240|          mov   [v95+32], v34 :8b
   241|          mov   [v95+40], v93 :8b
   242|          lea   v96, stack+418
   243|          mov   [v96+48], v34 :8b
   244|          mov   [v96+56], v67 :8b
   245|     constant   v97 = 0xfedcba9876543210
   246|          lea   v98, stack+4a8
   247|          mov   [stack+4a8], v97 :8b
   248|          lea   v99, stack+418
   249|          mov   [v99+64], v43 :8b
   250|          mov   [v99+72], v98 :8b
   251|          lea   v100, stack+4b0
   252|          mov   [v100], v9 :8b
   253|       string   v101, "showed"
   254|          mov   [v100+8], v101 :8b
   255|          lea   v102, stack+418
   256|          mov   [v102+80], v34 :8b
   257|          mov   [v102+88], v100 :8b
   258|          lea   v103, stack+4c0
   259|          mov   [v103], v17 :8b
   260|       string   v104, "Who"
   261|          mov   [v103+8], v104 :8b
   262|     constant   v105 = 0xfffffffffffffff7
   263|          lea   v106, stack+4d0
   264|          mov   [v106], v9 :8b
   265|          mov   [v106+8], v86 :8b
   266|         call   varargs_strings_and_ints (v103, v105, v106)
   267|          lea   v107, stack+4e0
   268|          mov   [v107], v17 :8b
   269|       string   v108, "Why"
   270|          mov   [v107+8], v108 :8b
   271|          lea   v109, stack+4f0
   272|          mov   [v109], v9 :8b
   273|          mov   [v109+8], v86 :8b
   274|         call   varargs_strings_and_ints (v107, v27, v109)
   275|     constant   v110 = 0xfffffffffffffc19
   276|          lea   v111, stack+500
   277|          mov   [v111], v9 :8b
   278|          mov   [v111+8], v86 :8b
   279|         call   varargs_strings_and_ints (v25, v110, v111)
   280|       return



5
data
4
*Fred
6
*Alfred


     1|     constant   v1 = 0xb                              i
     2|     constant   v2 = 5
     3|          lea   v3, stack+20                          names : []string + [5] string
     4|          mov   [v3], v2 :8b                          names.count = 5
     5|          lea   v4, stack+30
     6|          mov   [v3+8], v4 :8b                        names.data
     7|     constant   v6 = 4
     8|          mov   [v4], v6 :8b                          Fred.count
     9|       string   v7, "Fred"
    10|          mov   [v4+8], v7 :8b                        Fred.data
    11|        binop   v4, v4 + 16
    12|     constant   v9 = 6
    13|          mov   [v4], v9 :8b                          Alfred.count = 6
    14|       string   v10, "Alfred"
    15|          mov   [v4+8], v10 :8b                       Alfred.data
    16|        binop   v4, v4 + 16
    17|          mov   [v4], v6 :8b                          Alan.count = 4
    18|       string   v12, "Alan"
    19|          mov   [v4+8], v12 :8b                       Alan.data
    20|        binop   v4, v4 + 16
    21|     constant   v14 = 9
    22|          mov   [v4], v14 :8b                         Frederick.count = 9
    23|       string   v15, "Frederick"
    24|          mov   [v4+8], v15 :8b                       Frederick.data
    25|        binop   v4, v4 + 16
    26|     constant   v17 = 3
    27|          mov   [v4], v17 :8b                         Joe.count = 3
    28|       string   v18, "Joe"
    29|          mov   [v4+8], v18 :8b                       Joe.data
    30|         call   varargs_strings (v1, v3)


     1|     constant   v1 = 0xb                              i
     2|          lea   v3, stack+20                          names : []string + [5] string
     3|          mov   [v3], 5 :8b                           names.count = 5
     4|          lea   v4, stack+30
     5|          mov   [v3+8], v4 :8b                        names.data
     6|          mov   [v4], 4 :8b                           Fred.count
     7|       string   v7, "Fred"
     8|          mov   [v4+8], v7 :8b                        Fred.data
     9|          mov   [v4+10], 6 :8b                        Alfred.count = 6
    10|       string   v10, "Alfred"
    11|          mov   [v4+18], v10 :8b                      Alfred.data
    12|          mov   [v4+20], 4 :8b                        Alan.count = 4
    13|       string   v12, "Alan"
    14|          mov   [v4+28], v12 :8b                      Alan.data
    15|          mov   [v4+30], 9 :8b                        Frederick.count = 9
    16|       string   v15, "Frederick"
    17|          mov   [v4+38], v15 :8b                      Frederick.data
    18|          mov   [v4+40], 3 :8b                        Joe.count = 3
    19|       string   v18, "Joe"
    20|          mov   [v4+48], v18 :8b                      Joe.data
    21|         call   varargs_strings (v1, v3)























  Disassembly of 'comma_separated_assignments' in Workspace 2 at C:/jai/how_to/010_calling_procedures.jai:227
  - Stack size 112

  -------- Basic Block 0 -------- defines v1-84 --------

             (no dominating)

     0|   stack_node
     1|     constant   v1 = 0
     2|     constant   v2 = 0
     3|         call   foo () -> v3, v4
     4|         copy   v1 = v3
     5|         copy   v2 = v4
     6|         call   foo () -> v5, v6
     7|         copy   v7 = v5
     8|         copy   v8 = v6
     9|     constant   v9 = 1
    10|          lea   v10, stack+20
    11|        clear   v10+0 {size 16}
    12|          lea   v11, rdata+1580
    13|         call   assert (v9, v10, v10, v11)
    14|          lea   v12, rdata+15a0
    15|         call   assert (v9, v10, v10, v12)
    16|     constant   v13 = 0
    17|     constant   v14 = 0
    18|        binop   v15, v1 + 1
    19|         copy   v16 = v15
    20|        binop   v17, v2 + 1
    21|         copy   v18 = v17
    22|         copy   v13 = v16
    23|         copy   v14 = v18
    24|          lea   v19, stack+30                         *v
    25|        clear   v19+0 {size 12}                       v : Vector3
    26|     constant   v20 = 0x3f800000                      1.0
    27|         copy   v21 = v20
    28|     constant   v22 = 0x40800000                      4.0
    29|         copy   v23 = v22
    30|     constant   v24 = 0x41100000                      9.0
    31|         copy   v25 = v24
    32|          mov   [stack+30], v21 :4b                   v.x =
    33|          mov   [stack+34], v23 :4b                   v.y =
    34|          mov   [stack+38], v25 :4b                   v.z =
    35|         call   wacky () -> v26, v27, v28{big 16}, v29
    36|         copy   v30 = v26
    37|         copy   v31 = v27
    38|          lea   v32, stack+50
    39|       memcpy   v32, v28 {size 16}
    40|         copy   v33 = v29
    41|         copy   v34 = v30
    42|         copy   v35 = v31
    43|          lea   v36, stack+60
    44|       memcpy   v36, v32 {size 16}
    45|         copy   v37 = v33
    46|          lea   v38, rdata+15c0
    47|         call   assert (v9, v10, v10, v38)
    48|          lea   v39, rdata+15e0
    49|         call   assert (v9, v10, v10, v39)
    50|          lea   v40, rdata+1600
    51|         call   assert (v9, v10, v10, v40)
    52|          lea   v41, rdata+1620
    53|         call   assert (v9, v10, v10, v41)
    54|     constant   v42 = 0xffffffff
    55|     constant   v43 = 0xffffffff
    56|     constant   v44 = 0xffffffff
    57|     constant   v46 = 0xffffffff
    58|      compare   v45 = (v42 == v46)
    59|      compare   v48 = (v45 != 0)
    60|      compare   v49 = (v43 == v46)
    61|        binop   v47, v48 & v49
    62|      compare   v51 = (v47 != 0)
    63|      compare   v52 = (v44 == v46)
    64|        binop   v50, v51 & v52
    65|          lea   v53, rdata+1640
    66|         call   assert (v50, v10, v10, v53)
    67|     constant   v42 = 0x81818181
    68|     constant   v43 = 0x81818181
    69|     constant   v44 = 0x81818181
    70|     constant   v55 = 0x81818181
    71|      compare   v54 = (v42 == v55)
    72|      compare   v57 = (v54 != 0)
    73|      compare   v58 = (v43 == v55)
    74|        binop   v56, v57 & v58
    75|      compare   v60 = (v56 != 0)
    76|      compare   v61 = (v44 == v55)
    77|        binop   v59, v60 & v61
    78|          lea   v62, rdata+1660
    79|         call   assert (v59, v10, v10, v62)
    80|     constant   v63 = 0x81000000
    81|        binop   v42, v42 - v63
    82|        binop   v43, v43 - v63
    83|     constant   v65 = 0x818181
    84|      compare   v64 = (v42 == v65)
    85|      compare   v67 = (v64 != 0)
    86|      compare   v68 = (v43 == v65)
    87|        binop   v66, v67 & v68
    88|          lea   v69, rdata+1680
    89|         call   assert (v66, v10, v10, v69)
    90|        binop   v44, v44 + 126
    91|        binop   v42, v42 + 126
    92|     constant   v71 = 0x818181ff
    93|      compare   v70 = (v44 == v71)
    94|      compare   v73 = (v70 != 0)
    95|     constant   v75 = 0x8181ff
    96|      compare   v74 = (v42 == v75)
    97|        binop   v72, v73 & v74
    98|          lea   v76, rdata+16a0
    99|         call   assert (v72, v10, v10, v76)
   100|        binop   v30, v30 + 1
   101|        binop   v31, v31 + v20
   102|        binop   v77, v30 * 2
   103|         copy   v30 = v77
   104|     constant   v79 = 0x40000000
   105|        binop   v78, v31 * v79
   106|         copy   v31 = v78
   107|     constant   v81 = 8
   108|      compare   v80 = (v30 == v81)
   109|          lea   v82, rdata+16c0
   110|         call   assert (v80, v10, v10, v82)
   111|      compare   v83 = (v31 == v22)
   112|          lea   v84, rdata+16e0
   113|         call   assert (v83, v10, v10, v84)
   114|       return
















   Disassembly of 'enum_basics' in Workspace 2 at C:/jai/how_to/013_enums.jai:11
- Stack size 392

-------- Basic Block 0 -------- defines v1-13 --------

           (no dominating)

   0|   stack_node
   1|          lea   v2, stack+20
   2|     constant   v3 = 0x21
   3|          mov   [v2], v3 :8b
   4|       string   v4, {long string, 33 bytes}
   5|          mov   [v2+8], v4 :8b
   6|     constant   v5 = 1
   7|          lea   v6, stack+30
   8|          mov   [v6], v5 :8b
   9|    emit_type   v7, Fruits_We_Sell
  10|          lea   v8, stack+40
  11|          mov   [stack+40], v7 :8b
  12|          lea   v9, stack+48
  13|    emit_type   v10, Type
  14|          mov   [v9], v10 :8b
  15|          mov   [v9+8], v8 :8b
  16|          mov   [v6+8], v9 :8b
  17|     constant   v11 = 0
  18|         call   print (v2, v6, v11) -> v1
  19|         call   enum_values_as_s64 () -> v12{big 16}
  20|     constant   v13 = 0                                 it_index

-------- Basic Block 1 -------- defines v14-29 --------

           ... dominating: block 0 instruction 20
1 predecessor: 0
  21|          mov   v14, [v12] :8b                          enum_values_as_s64.count
  22|         jump   3 if v13 >= v14
  23|          mov   v16, [v12+8] :8b                        enum_values_as_s64.data
  24|          mov   v15, [v16+v13*8] :8b                    it
  25|          lea   v18, stack+68
  26|     constant   v19 = 6
  27|          mov   [v18], v19 :8b
  28|       string   v20, "     %: %\n"
  29|          mov   [v18+8], v20 :8b
  30|     constant   v21 = 2
  31|          mov   [v6], v21 :8b
  32|          lea   v22, stack+78
  33|          mov   [v6+8], v22 :8b
  34|          lea   v23, stack+98
  35|          mov   [stack+98], v15 :8b
  36|          lea   v24, stack+a0
  37|    emit_type   v25, s64
  38|          mov   [v24], v25 :8b
  39|          mov   [v24+8], v23 :8b
  40|       memcpy   v22, v24 {size 16}
  41|        binop   v22, v22 + 16
  42|  cast_number   v26 (Fruits_We_Sell), v15 (s64)
  43|   cast_check   v15, v26 {fatal=1}
  44|          lea   v27, stack+b0
  45|          mov   [stack+b0], v26 :4b
  46|          lea   v28, stack+b8
  47|    emit_type   v29, Fruits_We_Sell
  48|          mov   [v28], v29 :8b
  49|          mov   [v28+8], v27 :8b
  50|       memcpy   v22, v28 {size 16}
  51|         call   print (v18, v6, v11) -> v17

-------- Basic Block 2 --------

           ... dominating: block 1 instruction 25
2 predecessors: 0, 1
  52|        binop   v13, v13 + 1
  53|         jump   1

-------- Basic Block 3 -------- defines v30-55 --------

           ... dominating: block 0 instruction 20
1 predecessor: 2
  54|         call   enum_range () -> v30, v31
  55|         copy   v32 = v30
  56|         copy   v33 = v31
  57|          lea   v35, stack+c8
  58|     constant   v36 = 0x1e
  59|          mov   [v35], v36 :8b
  60|       string   v37, "\nIts values range from % to %\n"
  61|          mov   [v35+8], v37 :8b
  62|     constant   v38 = 2
  63|          mov   [v6], v38 :8b
  64|          lea   v39, stack+d8
  65|          mov   [v6+8], v39 :8b
  66|          lea   v40, stack+f8
  67|          mov   [stack+f8], v32 :8b
  68|          lea   v41, stack+100
  69|    emit_type   v42, s64
  70|          mov   [v41], v42 :8b
  71|          mov   [v41+8], v40 :8b
  72|       memcpy   v39, v41 {size 16}
  73|        binop   v39, v39 + 16
  74|          lea   v43, stack+110
  75|          mov   [stack+110], v33 :8b
  76|          lea   v44, stack+118
  77|          mov   [v44], v42 :8b
  78|          mov   [v44+8], v43 :8b
  79|       memcpy   v39, v44 {size 16}
  80|         call   print (v35, v6, v11) -> v34
  81|         call   enum_names () -> v45{big 16}
  82|          lea   v46, stack+128
  83|       memcpy   v46, v45 {size 16}
  84|          lea   v48, stack+148
  85|          mov   [v48], v36 :8b
  86|       string   v49, "\nIts values as strings are: %\n"
  87|          mov   [v48+8], v49 :8b
  88|          mov   [v6], v5 :8b
  89|          lea   v50, stack+158
  90|    emit_type   v51, [] string
  91|          mov   [v50], v51 :8b
  92|          mov   [v50+8], v46 :8b
  93|          mov   [v6+8], v50 :8b
  94|         call   print (v48, v6, v11) -> v47
  95|          lea   v53, stack+168
  96|          mov   [v53], v38 :8b
  97|       string   v54, "\n\n"
  98|          mov   [v53+8], v54 :8b
  99|          lea   v55, stack+178
 100|        clear   v55+0 {size 16}
 101|         call   print (v53, v55, v11) -> v52
 102|       return





























  Disassembly of 'main' in Workspace 2 at C:/jai/how_to/015_array_literals.jai:25
  - Stack size 1736

  -------- Basic Block 0 -------- defines v1-3 --------

             (no dominating)

     0|   stack_node
     1|          lea   v1, rdata+12b0                        .[1, 3, 5, 7, 9]
     2|          lea   v2, stack+20                          numbers :=
     3|       memcpy   v2, v1 {size 40}
     4|     constant   v3 = 0                                it_index

  -------- Basic Block 1 -------- defines v4-19 --------

             ... dominating: block 0 instruction 4
  1 predecessor: 0
     5|     constant   v4 = 5                                numbers.count
     6|         jump   3 if v3 >= v4                         exit for
     7|          mov   v5, [v2+v3*8] :8b                     it
     8|          lea   v7, stack+48
     9|     constant   v8 = 0xf
    10|          mov   [v7], v8 :8b
    11|       string   v9, "numbers[%] = %\n"
    12|          mov   [v7+8], v9 :8b
    13|     constant   v10 = 2
    14|          lea   v11, stack+58
    15|          mov   [v11], v10 :8b
    16|          lea   v12, stack+68
    17|          mov   [v11+8], v12 :8b
    18|          lea   v13, stack+88
    19|          mov   [stack+88], v3 :8b
    20|          lea   v14, stack+90
    21|    emit_type   v15, s64
    22|          mov   [v14], v15 :8b
    23|          mov   [v14+8], v13 :8b
    24|       memcpy   v12, v14 {size 16}
    25|        binop   v12, v12 + 16
    26|          lea   v16, stack+a0
    27|          mov   [stack+a0], v5 :8b
    28|          lea   v17, stack+a8
    29|    emit_type   v18, int
    30|          mov   [v17], v18 :8b
    31|          mov   [v17+8], v16 :8b
    32|       memcpy   v12, v17 {size 16}
    33|     constant   v19 = 0
    34|         call   print (v7, v11, v19) -> v6

  -------- Basic Block 2 --------

             ... dominating: block 1 instruction 8
  2 predecessors: 0, 1
    35|        binop   v3, v3 + 1                            it_index += 1
    36|         jump   1                                     loop for

  -------- Basic Block 3 -------- defines v20-55 --------

             ... dominating: block 0 instruction 4
  1 predecessor: 2
    37|     constant   v22 = 5
    38|          lea   v23, stack+b8                         add_numbers numbers
    39|          mov   [v23], v22 :8b                        add_numbers numbers.count
    40|          mov   [v23+8], v2 :8b                       add_numbers numbers.data
    41|         call   add_numbers (v23) -> v21
    42|         copy   v20 = v21
    43|          lea   v26, rdata+12d8                       .[1, 2, 3, 4, 5]
    44|          lea   v27, stack+c8                         add_numbers numbers
    45|          mov   [v27], v22 :8b                        add_numbers numbers.count
    46|          mov   [v27+8], v26 :8b                      add_numbers numbers.data
    47|         call   add_numbers (v27) -> v25
    48|         copy   v24 = v25
    49|          lea   v29, stack+d8
    50|     constant   v30 = 0x15
    51|          mov   [v29], v30 :8b
    52|       string   v31, "sum1 is %, sum2 is %\n"
    53|          mov   [v29+8], v31 :8b
    54|     constant   v32 = 2
    55|          lea   v33, stack+e8
    56|          mov   [v33], v32 :8b
    57|          lea   v34, stack+f8
    58|          mov   [v33+8], v34 :8b
    59|          lea   v35, stack+118
    60|          mov   [stack+118], v20 :8b
    61|          lea   v36, stack+120
    62|    emit_type   v37, int
    63|          mov   [v36], v37 :8b
    64|          mov   [v36+8], v35 :8b
    65|       memcpy   v34, v36 {size 16}
    66|        binop   v34, v34 + 16
    67|          lea   v38, stack+130
    68|          mov   [stack+130], v24 :8b
    69|          lea   v39, stack+138
    70|          mov   [v39], v37 :8b
    71|          mov   [v39+8], v38 :8b
    72|       memcpy   v34, v39 {size 16}
    73|     constant   v40 = 0
    74|         call   print (v29, v33, v40) -> v28
    75|          lea   v42, stack+148
    76|     constant   v43 = 1
    77|          mov   [v42], v43 :8b
    78|       string   v44, "\n"
    79|          mov   [v42+8], v44 :8b
    80|          lea   v45, stack+158
    81|        clear   v45+0 {size 16}
    82|         call   print (v42, v45, v40) -> v41
    83|         call   get_strings (v22) -> v46, v47{big 16}
    84|         copy   v48 = v46
    85|          lea   v49, stack+178
    86|       memcpy   v49, v47 {size 16}
    87|     constant   v52 = 6
    88|         call   get_strings (v52) -> v50, v51{big 16}
    89|         copy   v53 = v50
    90|          lea   v54, stack+198
    91|       memcpy   v54, v51 {size 16}
    92|     constant   v55 = 0

  -------- Basic Block 4 -------- defines v56-69 --------

             ... dominating: block 3 instruction 92
  1 predecessor: 3
    93|          mov   v56, [v49] :8b
    94|         jump   6 if v55 >= v56
    95|          mov   v58, [v49+8] :8b
    96|        binop   v59, v55 * 16
    97|        binop   v57, v58 + v59
    98|          lea   v61, stack+1a8
    99|     constant   v62 = 0x12
   100|          mov   [v61], v62 :8b
   101|       string   v63, "strings1[%] = '%'\n"
   102|          mov   [v61+8], v63 :8b
   103|          mov   [v33], v32 :8b
   104|          lea   v64, stack+1b8
   105|          mov   [v33+8], v64 :8b
   106|          lea   v65, stack+1d8
   107|          mov   [stack+1d8], v55 :8b
   108|          lea   v66, stack+1e0
   109|    emit_type   v67, s64
   110|          mov   [v66], v67 :8b
   111|          mov   [v66+8], v65 :8b
   112|       memcpy   v64, v66 {size 16}
   113|        binop   v64, v64 + 16
   114|          lea   v68, stack+1f0
   115|    emit_type   v69, string
   116|          mov   [v68], v69 :8b
   117|          mov   [v68+8], v57 :8b
   118|       memcpy   v64, v68 {size 16}
   119|         call   print (v61, v33, v40) -> v60

  -------- Basic Block 5 --------

             ... dominating: block 4 instruction 98
  2 predecessors: 3, 4
   120|        binop   v55, v55 + 1
   121|         jump   4

  -------- Basic Block 6 -------- defines v70 --------

             ... dominating: block 3 instruction 92
  1 predecessor: 5
   122|     constant   v70 = 0

  -------- Basic Block 7 -------- defines v71-84 --------

             ... dominating: block 6 instruction 122
  1 predecessor: 6
   123|          mov   v71, [v54] :8b
   124|         jump   9 if v70 >= v71
   125|          mov   v73, [v54+8] :8b
   126|        binop   v74, v70 * 16
   127|        binop   v72, v73 + v74
   128|          lea   v76, stack+200
   129|     constant   v77 = 0x12
   130|          mov   [v76], v77 :8b
   131|       string   v78, "strings2[%] = '%'\n"
   132|          mov   [v76+8], v78 :8b
   133|          mov   [v33], v32 :8b
   134|          lea   v79, stack+210
   135|          mov   [v33+8], v79 :8b
   136|          lea   v80, stack+230
   137|          mov   [stack+230], v70 :8b
   138|          lea   v81, stack+238
   139|    emit_type   v82, s64
   140|          mov   [v81], v82 :8b
   141|          mov   [v81+8], v80 :8b
   142|       memcpy   v79, v81 {size 16}
   143|        binop   v79, v79 + 16
   144|          lea   v83, stack+248
   145|    emit_type   v84, string
   146|          mov   [v83], v84 :8b
   147|          mov   [v83+8], v72 :8b
   148|       memcpy   v79, v83 {size 16}
   149|         call   print (v76, v33, v40) -> v75

  -------- Basic Block 8 --------

             ... dominating: block 7 instruction 128
  2 predecessors: 6, 7
   150|        binop   v70, v70 + 1
   151|         jump   7

  -------- Basic Block 9 -------- defines v85-175 --------

             ... dominating: block 6 instruction 122
  1 predecessor: 8
   152|          lea   v86, stack+258
   153|          mov   [v86], v43 :8b
   154|       string   v87, "\n"
   155|          mov   [v86+8], v87 :8b
   156|         call   print (v86, v45, v40) -> v85
   157|     constant   v88 = 0
   158|          lea   v90, stack+268
   159|     constant   v91 = 0x19
   160|          mov   [v90], v91 :8b
   161|       string   v92, "a.count is %, data is %.\n"
   162|          mov   [v90+8], v92 :8b
   163|          mov   [v33], v32 :8b
   164|          lea   v93, stack+278
   165|          mov   [v33+8], v93 :8b
   166|     constant   v94 = 0
   167|          lea   v95, stack+298
   168|          mov   [stack+298], v94 :8b
   169|          lea   v96, stack+2a0
   170|    emit_type   v97, s64
   171|          mov   [v96], v97 :8b
   172|          mov   [v96+8], v95 :8b
   173|       memcpy   v93, v96 {size 16}
   174|        binop   v93, v93 + 16
   175|          lea   v98, stack+2b0
   176|          mov   [stack+2b0], v88 :8b
   177|          lea   v99, stack+2b8
   178|    emit_type   v100, *string
   179|          mov   [v99], v100 :8b
   180|          mov   [v99+8], v98 :8b
   181|       memcpy   v93, v99 {size 16}
   182|         call   print (v90, v33, v40) -> v89
   183|          lea   v102, stack+2c8
   184|     constant   v103 = 0xc
   185|          mov   [v102], v103 :8b
   186|       string   v104, "a.data is %\n"
   187|          mov   [v102+8], v104 :8b
   188|          mov   [v33], v43 :8b
   189|          lea   v105, stack+2d8
   190|          mov   [stack+2d8], v88 :8b
   191|          lea   v106, stack+2e0
   192|    emit_type   v107, *string
   193|          mov   [v106], v107 :8b
   194|          mov   [v106+8], v105 :8b
   195|          mov   [v33+8], v106 :8b
   196|         call   print (v102, v33, v40) -> v101
   197|          lea   v108, stack+300
   198|          mov   [v108], v94 :8b
   199|          mov   [v108+8], v94 :8b
   200|          lea   v109, stack+2f0
   201|       memcpy   v109, v108 {size 16}
   202|          lea   v111, stack+310
   203|     constant   v112 = 0x1a
   204|          mov   [v111], v112 :8b
   205|       string   v113, "b.count is %; b.data is %\n"
   206|          mov   [v111+8], v113 :8b
   207|          mov   [v33], v32 :8b
   208|          lea   v114, stack+320
   209|          mov   [v33+8], v114 :8b
   210|          lea   v115, stack+2f0
   211|          lea   v116, stack+340
   212|          mov   [v116], v97 :8b
   213|          mov   [v116+8], v115 :8b
   214|       memcpy   v114, v116 {size 16}
   215|        binop   v114, v114 + 16
   216|          lea   v117, stack+2f0+8
   217|          lea   v118, stack+350
   218|    emit_type   v119, *string
   219|          mov   [v118], v119 :8b
   220|          mov   [v118+8], v117 :8b
   221|       memcpy   v114, v118 {size 16}
   222|         call   print (v111, v33, v40) -> v110
   223|          lea   v121, stack+360
   224|     constant   v122 = 0x10
   225|          mov   [v121], v122 :8b
   226|       string   v123, "type_of(b) is %\n"
   227|          mov   [v121+8], v123 :8b
   228|          mov   [v33], v43 :8b
   229|    emit_type   v124, [] string
   230|          lea   v125, stack+370
   231|          mov   [stack+370], v124 :8b
   232|          lea   v126, stack+378
   233|    emit_type   v127, Type
   234|          mov   [v126], v127 :8b
   235|          mov   [v126+8], v125 :8b
   236|          mov   [v33+8], v126 :8b
   237|         call   print (v121, v33, v40) -> v120
   238|          lea   v128, stack+398
   239|          mov   [v128], v94 :8b
   240|          mov   [v128+8], v94 :8b
   241|          lea   v129, stack+388
   242|       memcpy   v129, v128 {size 16}
   243|          lea   v131, stack+3a8
   244|          mov   [v131], v112 :8b
   245|       string   v132, "c.count is %; c.data is %\n"
   246|          mov   [v131+8], v132 :8b
   247|          mov   [v33], v32 :8b
   248|          lea   v133, stack+3b8
   249|          mov   [v33+8], v133 :8b
   250|          lea   v134, stack+388
   251|          lea   v135, stack+3d8
   252|          mov   [v135], v97 :8b
   253|          mov   [v135+8], v134 :8b
   254|       memcpy   v133, v135 {size 16}
   255|        binop   v133, v133 + 16
   256|          lea   v136, stack+388+8
   257|          lea   v137, stack+3e8
   258|    emit_type   v138, *string
   259|          mov   [v137], v138 :8b
   260|          mov   [v137+8], v136 :8b
   261|       memcpy   v133, v137 {size 16}
   262|         call   print (v131, v33, v40) -> v130
   263|          lea   v140, stack+3f8
   264|     constant   v141 = 0x3c
   265|          mov   [v140], v141 :8b
   266|       string   v142, {long string, 60 bytes}
   267|          mov   [v140+8], v142 :8b
   268|          mov   [v33], v32 :8b
   269|          lea   v143, stack+408
   270|          mov   [v33+8], v143 :8b
   271|          lea   v144, stack+428
   272|          mov   [stack+428], v94 :8b
   273|          lea   v145, stack+430
   274|          mov   [v145], v97 :8b
   275|          mov   [v145+8], v144 :8b
   276|       memcpy   v143, v145 {size 16}
   277|        binop   v143, v143 + 16
   278|          lea   v146, stack+440
   279|          mov   [stack+440], v88 :8b
   280|          lea   v147, stack+448
   281|    emit_type   v148, *string
   282|          mov   [v147], v148 :8b
   283|          mov   [v147+8], v146 :8b
   284|       memcpy   v143, v147 {size 16}
   285|         call   print (v140, v33, v40) -> v139
   286|          mov   v149, [stack+390] :8b
   287|      compare   v150 = (v149 == 0)
   288|          lea   v151, rdata+1300
   289|         call   assert (v150, v45, v45, v151)
   290|      compare   v152 = (v88 == 0)
   291|          lea   v153, rdata+1320
   292|         call   assert (v152, v45, v45, v153)
   293|          lea   v155, stack+458
   294|     constant   v156 = 0x1c
   295|          mov   [v155], v156 :8b
   296|       string   v157, "test_global_array.data is %\n"
   297|          mov   [v155+8], v157 :8b
   298|          mov   [v33], v43 :8b
   299|          lea   v158, bss+18
   300|          lea   v159, stack+468
   301|    emit_type   v160, [0] string
   302|          mov   [v159], v160 :8b
   303|          mov   [v159+8], v158 :8b
   304|          mov   [v33+8], v159 :8b
   305|         call   print (v155, v33, v40) -> v154
   306|     constant   v161 = 1
   307|          lea   v162, rdata+1340
   308|         call   assert (v161, v45, v45, v162)
   309|          lea   v164, stack+478
   310|     constant   v165 = 0x28
   311|          mov   [v164], v165 :8b
   312|       string   v166, {long string, 40 bytes}
   313|          mov   [v164+8], v166 :8b
   314|          mov   [v33], v32 :8b
   315|          lea   v167, stack+488
   316|          mov   [v33+8], v167 :8b
   317|          lea   v168, stack+198
   318|          lea   v169, stack+4a8
   319|          mov   [v169], v97 :8b
   320|          mov   [v169+8], v168 :8b
   321|       memcpy   v167, v169 {size 16}
   322|        binop   v167, v167 + 16
   323|          lea   v170, stack+198+8
   324|          lea   v171, stack+4b8
   325|    emit_type   v172, *string
   326|          mov   [v171], v172 :8b
   327|          mov   [v171+8], v170 :8b
   328|       memcpy   v167, v171 {size 16}
   329|         call   print (v164, v33, v40) -> v163
   330|         call   print (v86, v45, v40) -> v173
   331|          lea   v174, rdata+1360
   332|     constant   v175 = 0

  -------- Basic Block 10 -------- defines v176-187 --------

             ... dominating: block 9 instruction 332
  1 predecessor: 9
   333|     constant   v176 = 5
   334|         jump   12 if v175 >= v176
   335|          mov   v177, [v174+v175*8] :8b
   336|          lea   v179, stack+4c8
   337|          mov   [v179], v52 :8b
   338|       string   v180, "[%] %\n"
   339|          mov   [v179+8], v180 :8b
   340|          mov   [v33], v32 :8b
   341|          lea   v181, stack+4d8
   342|          mov   [v33+8], v181 :8b
   343|          lea   v182, stack+4f8
   344|          mov   [stack+4f8], v175 :8b
   345|          lea   v183, stack+500
   346|    emit_type   v184, s64
   347|          mov   [v183], v184 :8b
   348|          mov   [v183+8], v182 :8b
   349|       memcpy   v181, v183 {size 16}
   350|        binop   v181, v181 + 16
   351|          lea   v185, stack+510
   352|          mov   [stack+510], v177 :8b
   353|          lea   v186, stack+518
   354|    emit_type   v187, Fruit_That_Is_Good
   355|          mov   [v186], v187 :8b
   356|          mov   [v186+8], v185 :8b
   357|       memcpy   v181, v186 {size 16}
   358|         call   print (v179, v33, v40) -> v178

  -------- Basic Block 11 --------

             ... dominating: block 10 instruction 336
  2 predecessors: 9, 10
   359|        binop   v175, v175 + 1
   360|         jump   10

  -------- Basic Block 12 -------- defines v188-208 --------

             ... dominating: block 9 instruction 332
  1 predecessor: 11
   361|          lea   v188, rdata+1388
   362|          lea   v189, stack+528
   363|          mov   [v189], v22 :8b
   364|          mov   [v189+8], v188 :8b
   365|         call   f (v189)
   366|         call   g () -> v190{big 16}
   367|          lea   v191, stack+538
   368|       memcpy   v191, v190 {size 16}
   369|          lea   v193, stack+558
   370|     constant   v194 = 0xd
   371|          mov   [v193], v194 :8b
   372|       string   v195, "r.count is %\n"
   373|          mov   [v193+8], v195 :8b
   374|          mov   [v33], v43 :8b
   375|          lea   v196, stack+538
   376|          lea   v197, stack+568
   377|    emit_type   v198, s64
   378|          mov   [v197], v198 :8b
   379|          mov   [v197+8], v196 :8b
   380|          mov   [v33+8], v197 :8b
   381|         call   print (v193, v33, v40) -> v192
   382|          lea   v200, stack+578
   383|     constant   v201 = 0xe
   384|          mov   [v200], v201 :8b
   385|       string   v202, "g().data is %\n"
   386|          mov   [v200+8], v202 :8b
   387|          mov   [v33], v43 :8b
   388|          lea   v203, stack+538+8
   389|          lea   v204, stack+588
   390|    emit_type   v205, *string
   391|          mov   [v204], v205 :8b
   392|          mov   [v204+8], v203 :8b
   393|          mov   [v33+8], v204 :8b
   394|         call   print (v200, v33, v40) -> v199
   395|          lea   v206, rdata+1390
   396|          lea   v207, stack+598
   397|       memcpy   v207, v206 {size 96}
   398|     constant   v208 = 0

  -------- Basic Block 13 -------- defines v209-223 --------

             ... dominating: block 12 instruction 398
  1 predecessor: 12
   399|     constant   v209 = 8
   400|         jump   15 if v208 >= v209
   401|        binop   v211, v208 * 12
   402|        binop   v210, v207 + v211
   403|          lea   v213, stack+5f8
   404|          mov   [v213], v52 :8b
   405|       string   v214, "% % %\n"
   406|          mov   [v213+8], v214 :8b
   407|     constant   v215 = 3
   408|          mov   [v33], v215 :8b
   409|          lea   v216, stack+608
   410|          mov   [v33+8], v216 :8b
   411|        binop   v217, v210 + 0
   412|          lea   v218, stack+638
   413|    emit_type   v219, float
   414|          mov   [v218], v219 :8b
   415|          mov   [v218+8], v217 :8b
   416|       memcpy   v216, v218 {size 16}
   417|        binop   v216, v216 + 16
   418|        binop   v220, v210 + 4
   419|          lea   v221, stack+648
   420|          mov   [v221], v219 :8b
   421|          mov   [v221+8], v220 :8b
   422|       memcpy   v216, v221 {size 16}
   423|        binop   v216, v216 + 16
   424|        binop   v222, v210 + 8
   425|          lea   v223, stack+658
   426|          mov   [v223], v219 :8b
   427|          mov   [v223+8], v222 :8b
   428|       memcpy   v216, v223 {size 16}
   429|         call   print (v213, v33, v40) -> v212

  -------- Basic Block 14 --------

             ... dominating: block 13 instruction 403
  2 predecessors: 12, 13
   430|        binop   v208, v208 + 1
   431|         jump   13

  -------- Basic Block 15 -------- defines v224-237 --------

             ... dominating: block 12 instruction 398
  1 predecessor: 14
   432|          lea   v225, rdata+13f0
   433|     constant   v226 = 3
   434|          lea   v227, stack+678
   435|          mov   [v227], v226 :8b
   436|          mov   [v227+8], v225 :8b
   437|          lea   v228, stack+688
   438|          mov   [v228], v32 :8b
   439|       string   v229, ", "
   440|          mov   [v228+8], v229 :8b
   441|          lea   v230, rdata+1420
   442|         call   join (v227, v228, v40, v40, v230) -> v224{big 16}
   443|          lea   v231, stack+668
   444|       memcpy   v231, v224 {size 16}
   445|          lea   v233, stack+6a8
   446|     constant   v234 = 7
   447|          mov   [v233], v234 :8b
   448|       string   v235, "s is %\n"
   449|          mov   [v233+8], v235 :8b
   450|          mov   [v33], v43 :8b
   451|          lea   v236, stack+6b8
   452|    emit_type   v237, string
   453|          mov   [v236], v237 :8b
   454|          mov   [v236+8], v231 :8b
   455|          mov   [v33+8], v236 :8b
   456|         call   print (v233, v33, v40) -> v232
   457|       return























  Disassembly of 'nested_while_loops' in Workspace 2 at C:/jai/how_to/019_looping.jai:129
  - Stack size 448

  -------- Basic Block 0 -------- defines v1-10 --------

             (no dominating)

     0|   stack_node
     1|          lea   v2, stack+20                          print stuff
     2|     constant   v3 = 5
     3|          mov   [v2], v3 :8b
     4|       string   v4, "i, j\n"
     5|          mov   [v2+8], v4 :8b
     6|          lea   v5, stack+30
     7|        clear   v5+0 {size 16}
     8|     constant   v6 = 0
     9|         call   print (v2, v5, v6) -> v1
    10|          lea   v8, stack+40
    11|          mov   [v8], v3 :8b
    12|       string   v9, "----\n"
    13|          mov   [v8+8], v9 :8b
    14|         call   print (v8, v5, v6) -> v7
    15|     constant   v10 = 0                               j : int

  -------- Basic Block 1 -------- defines v11-12 --------

             ... dominating: block 0 instruction 15
  1 predecessor: 0
    16|     constant   v11 = 4
    17|         jump   5 if v10 >= v11                       while j < 4
    18|     constant   v12 = 0                               i : int

  -------- Basic Block 2 -------- defines v13 --------

             ... dominating: block 1 instruction 18
  1 predecessor: 1
    19|         jump   4 if v12 >= v11                       while i < 4
    20|     constant   v13 = 2
    21|         jump   3 if v12 != v13                       if i == 2
    22|          nop
    23|        binop   v12, v12 + 1                          i += 1 (deferred)
    24|         jump   2                                     loop i (continue)

  -------- Basic Block 3 -------- defines v14-23 --------

             ... dominating: block 2 instruction 21
  1 predecessor: 2
    25|          lea   v15, stack+50                         print stuff
    26|          mov   [v15], v3 :8b
    27|       string   v16, "%, %\n"
    28|          mov   [v15+8], v16 :8b
    29|          lea   v17, stack+60
    30|          mov   [v17], v13 :8b
    31|          lea   v18, stack+70
    32|          mov   [v17+8], v18 :8b
    33|          lea   v19, stack+90
    34|          mov   [stack+90], v12 :8b
    35|          lea   v20, stack+98
    36|    emit_type   v21, int
    37|          mov   [v20], v21 :8b
    38|          mov   [v20+8], v19 :8b
    39|       memcpy   v18, v20 {size 16}
    40|        binop   v18, v18 + 16
    41|          lea   v22, stack+a8
    42|          mov   [stack+a8], v10 :8b
    43|          lea   v23, stack+b0
    44|          mov   [v23], v21 :8b
    45|          mov   [v23+8], v22 :8b
    46|       memcpy   v18, v23 {size 16}
    47|         call   print (v15, v17, v6) -> v14
    48|        binop   v12, v12 + 1                          i += 1 (deferred)
    49|         jump   2                                     loop i

  -------- Basic Block 4 --------

             ... dominating: block 2 instruction 19
  1 predecessor: 2
    50|        binop   v10, v10 + 1                          j += 1 (deferred)
    51|         jump   1                                     loop j

  -------- Basic Block 5 -------- defines v24-27 --------

             ... dominating: block 1 instruction 17
  1 predecessor: 1
    52|          lea   v25, stack+c0                         print("\n")
    53|     constant   v26 = 1
    54|          mov   [v25], v26 :8b
    55|       string   v27, "\n"
    56|          mov   [v25+8], v27 :8b
    57|         call   print (v25, v5, v6) -> v24
    58|     constant   v10 = 0                               j = 0

  -------- Basic Block 6 -------- defines v28-29 --------

             ... dominating: block 5 instruction 58
  1 predecessor: 5
    59|      compare   v28 = (v10 < v11)                     j_loop :=
    60|         jump   10 if v28 == 0                        while j_loop
    61|     constant   v29 = 0

  -------- Basic Block 7 -------- defines v30-45 --------

             ... dominating: block 6 instruction 61
  1 predecessor: 6
    62|      compare   v30 = (v29 < v11)
    63|         jump   9 if v30 == 0
    64|          lea   v32, stack+d0
    65|          mov   [v32], v3 :8b
    66|       string   v33, "%, %\n"
    67|          mov   [v32+8], v33 :8b
    68|     constant   v34 = 2
    69|          lea   v35, stack+e0
    70|          mov   [v35], v34 :8b
    71|          lea   v36, stack+f0
    72|          mov   [v35+8], v36 :8b
    73|          lea   v37, stack+110
    74|          mov   [stack+110], v29 :8b
    75|          lea   v38, stack+118
    76|    emit_type   v39, int
    77|          mov   [v38], v39 :8b
    78|          mov   [v38+8], v37 :8b
    79|       memcpy   v36, v38 {size 16}
    80|        binop   v36, v36 + 16
    81|          lea   v40, stack+128
    82|          mov   [stack+128], v10 :8b
    83|          lea   v41, stack+130
    84|          mov   [v41], v39 :8b
    85|          mov   [v41+8], v40 :8b
    86|       memcpy   v36, v41 {size 16}
    87|         call   print (v32, v35, v6) -> v31
    88|      compare   v42 = (v29 == v34)
    89|      compare   v44 = (v42 != 0)
    90|      compare   v45 = (v10 == v34)
    91|        binop   v43, v44 & v45
    92|         jump   8 if v43 == 0
    93|          nop
    94|        binop   v29, v29 + 1
    95|        binop   v10, v10 + 1
    96|         jump   10

  -------- Basic Block 8 --------

             ... dominating: block 7 instruction 92
  1 predecessor: 7
    97|        binop   v29, v29 + 1
    98|         jump   7

  -------- Basic Block 9 --------

             ... dominating: block 7 instruction 63
  1 predecessor: 7
    99|        binop   v10, v10 + 1
   100|         jump   6

  -------- Basic Block 10 -------- defines v46-52 --------

             ... dominating: block 6 instruction 60
  1 predecessor: 6
   101|          lea   v47, stack+140
   102|          mov   [v47], v26 :8b
   103|       string   v48, "\n"
   104|          mov   [v47+8], v48 :8b
   105|         call   print (v47, v5, v6) -> v46
   106|          lea   v49, stack+150
   107|     constant   v50 = 0xe
   108|          mov   [v49], v50 :8b
   109|       string   v51, "Hello, Sailor!"
   110|          mov   [v49+8], v51 :8b
   111|          lea   v52, bss+18
   112|       memcpy   v52, v49 {size 16}

  -------- Basic Block 11 -------- defines v53-61 --------

             ... dominating: block 10 instruction 112
  1 predecessor: 10
   113|         call   shorten_the_global_string () -> v53{big 16}
   114|          lea   v54, stack+160
   115|       memcpy   v54, v53 {size 16}
   116|          mov   v56, [v54] :8b
   117|      compare   v55 = (v56 != 0)
   118|         jump   13 if v55 == 0
   119|          mov   v57, [stack+160] :8b
   120|         jump   12 if v57 != v11
   121|          lea   v59, stack+180
   122|     constant   v60 = 0x15
   123|          mov   [v59], v60 :8b
   124|       string   v61, "~~~ (skipped!!!) ~~~\n"
   125|          mov   [v59+8], v61 :8b
   126|         call   print (v59, v5, v6) -> v58
   127|         jump   11

  -------- Basic Block 12 -------- defines v62-68 --------

             ... dominating: block 11 instruction 120
  1 predecessor: 11
   128|          lea   v63, stack+190
   129|     constant   v64 = 6
   130|          mov   [v63], v64 :8b
   131|       string   v65, "::: %\n"
   132|          mov   [v63+8], v65 :8b
   133|          lea   v66, stack+1a0
   134|          mov   [v66], v26 :8b
   135|          lea   v67, stack+1b0
   136|    emit_type   v68, string
   137|          mov   [v67], v68 :8b
   138|          mov   [v67+8], v54 :8b
   139|          mov   [v66+8], v67 :8b
   140|         call   print (v63, v66, v6) -> v62
   141|         jump   11

  -------- Basic Block 13 --------

             ... dominating: block 11 instruction 118
  1 predecessor: 11
   142|       return





















  -------- Basic Block 0 -------- defines v1 --------

             (no dominating)

     0|   stack_node
     1|     constant   v1 = 0                                i := 0

  -------- Basic Block 1 -------- defines v2-13 --------

             ... dominating: block 0 instruction 1
  1 predecessor: 0
     2|     constant   v2 = 0xa
     3|         jump   4 if v1 >= v2                         while i < 10
     4|     constant   v4 = 2
     5|        binop   v3, v1 % v4
     6|         jump   2 if v3 == 0                          if i % 2 continue
     7|          nop
     8|        binop   v1, v1 + 1                            start of deferred statements
     9|          lea   v6, stack+20
    10|          mov   [v6], v4 :8b
    11|       string   v7, "%\n"
    12|          mov   [v6+8], v7 :8b
    13|     constant   v8 = 1
    14|          lea   v9, stack+30
    15|          mov   [v9], v8 :8b
    16|          lea   v10, stack+40
    17|          mov   [stack+40], v1 :8b
    18|          lea   v11, stack+48
    19|    emit_type   v12, s64
    20|          mov   [v11], v12 :8b
    21|          mov   [v11+8], v10 :8b
    22|          mov   [v9+8], v11 :8b
    23|     constant   v13 = 0
    24|         call   print (v6, v9, v13) -> v5
    25|         jump   1

  -------- Basic Block 2 -------- defines v14-24 --------

             ... dominating: block 1 instruction 6
  1 predecessor: 1
    26|     constant   v15 = 3
    27|        binop   v14, v1 % v15
    28|         jump   3 if v14 == 0
    29|          nop
    30|        binop   v1, v1 + 1
    31|          lea   v17, stack+58
    32|          mov   [v17], v4 :8b
    33|       string   v18, "%\n"
    34|          mov   [v17+8], v18 :8b
    35|     constant   v19 = 1
    36|          lea   v20, stack+68
    37|          mov   [v20], v19 :8b
    38|          lea   v21, stack+78
    39|          mov   [stack+78], v1 :8b
    40|          lea   v22, stack+80
    41|    emit_type   v23, s64
    42|          mov   [v22], v23 :8b
    43|          mov   [v22+8], v21 :8b
    44|          mov   [v20+8], v22 :8b
    45|     constant   v24 = 0
    46|         call   print (v17, v20, v24) -> v16
    47|         jump   4

  -------- Basic Block 3 -------- defines v25-34 --------

             ... dominating: block 2 instruction 28
  1 predecessor: 2
    48|         copy   v25 = v1
    49|        binop   v1, v1 + 1
    50|          lea   v27, stack+90
    51|          mov   [v27], v4 :8b
    52|       string   v28, "%\n"
    53|          mov   [v27+8], v28 :8b
    54|     constant   v29 = 1
    55|          lea   v30, stack+a0
    56|          mov   [v30], v29 :8b
    57|          lea   v31, stack+b0
    58|          mov   [stack+b0], v1 :8b
    59|          lea   v32, stack+b8
    60|    emit_type   v33, s64
    61|          mov   [v32], v33 :8b
    62|          mov   [v32+8], v31 :8b
    63|          mov   [v30+8], v32 :8b
    64|     constant   v34 = 0
    65|         call   print (v27, v30, v34) -> v26
    66|         jump   1

  -------- Basic Block 4 --------

             ... dominating: block 1 instruction 3
  1 predecessor: 1
    67|       return





  -------- Basic Block 0 -------- defines v1 --------

             (no dominating)

     0|   stack_node
     1|     constant   v1 = 0                                i := 0

  -------- Basic Block 1 -------- defines v2-13 --------

             ... dominating: block 0 instruction 1
  1 predecessor: 0
     2|     constant   v2 = 0xa
     3|         jump   3 if v1 >= v2                         while i < 10
     4|     constant   v4 = 2
     5|        binop   v3, v1 % v4                           i % 2
     6|         jump   2 if v3 != 0                          if i % 2 == 0  continue
     7|     constant   v5 = 3
     8|        binop   v6, v1 % v5                           i % 3
     9|         jump   3 if v6 != 0                          if i % 3 == 0  break
    10|         copy   v7 = v1                               j := i

  -------- Basic Block 2 -------- defines v8 --------

             ... dominating: block 1 instruction 6
  1 predecessor: 1
    11|        block   v8 = 1                                defer jump target
    12|         jump   4

  -------- Basic Block 3 -------- defines v8 --------

             ... dominating: block 1 instruction 9
  1 predecessor: 1
    13|        block   v8 = 5                                defer jump target

  -------- Basic Block 4 -------- defines v9-17 --------

             ... dominating: block 2 instruction 12
  2 predecessors: 2, 3


    14|        binop   v1, v1 + 1                            i += 1
    15|          lea   v10, stack+20                         format_string
    16|          mov   [v10], v5 :8b                         format_string.count = 3
    17|       string   v11, "%\n"
    18|          mov   [v10+8], v11 :8b                      format_string.data
    19|     constant   v12 = 1
    20|          lea   v13, stack+30                         args
    21|          mov   [v13], v12 :8b                        args.count = 1
    22|          lea   v14, stack+40                         *copy_of_it
    23|          mov   [stack+40], v1 :8b                    copy_of_it.* = it
    24|          lea   v15, stack+48                         *Any (any)
    25|    emit_type   v16, s64
    26|          mov   [v15], v16 :8b                        any.type = s64
    27|          mov   [v15+8], v14 :8b                      any.value_pointer = *copy_of_it
    28|          mov   [v13+8], v15 :8b                      args.data
    29|     constant   v17 = 0                               stderr = false
    30|         call   print (v10, v13, v17) -> v9           format_string, args, stderr
    31|         jump   v8                                    end defer


  -------- Basic Block 5 --------

             ... dominating: block 4 instruction 31
  1 predecessor: 4
    32|       return






























Disassembly of 'array_target_for_loops' in Workspace 2 at C:/jai/how_to/019_looping.jai:465
- Stack size 1216

-------- Basic Block 0 -------- defines v1-3 --------

           (no dominating)

   0|   stack_node
   1|          lea   v1, rdata+fd8
   2|          lea   v2, stack+20                            array :
   3|       memcpy   v2, v1 {size 64}
   4|     constant   v3 = 0                                  it_index

-------- Basic Block 1 -------- defines v4-15 --------

           ... dominating: block 0 instruction 4
1 predecessor: 0
   5|     constant   v4 = 4                                  array.count
   6|         jump   3 if v3 >= v4                           
   7|        binop   v6, v3 * 16
   8|        binop   v5, v2 + v6
   9|          lea   v8, stack+60
  10|     constant   v9 = 2
  11|          mov   [v8], v9 :8b
  12|       string   v10, "%\n"
  13|          mov   [v8+8], v10 :8b
  14|     constant   v11 = 1
  15|          lea   v12, stack+70
  16|          mov   [v12], v11 :8b
  17|          lea   v13, stack+80
  18|    emit_type   v14, string
  19|          mov   [v13], v14 :8b
  20|          mov   [v13+8], v5 :8b
  21|          mov   [v12+8], v13 :8b
  22|     constant   v15 = 0
  23|         call   print (v8, v12, v15) -> v7

-------- Basic Block 2 --------

           ... dominating: block 1 instruction 9
2 predecessors: 0, 1
  24|        binop   v3, v3 + 1
  25|         jump   1

-------- Basic Block 3 -------- defines v16-25 --------

           ... dominating: block 0 instruction 4
1 predecessor: 2
  26|          lea   v17, stack+90
  27|     constant   v18 = 1
  28|          mov   [v17], v18 :8b
  29|       string   v19, "\n"
  30|          mov   [v17+8], v19 :8b
  31|          lea   v20, stack+a0
  32|        clear   v20+0 {size 16}
  33|     constant   v21 = 0
  34|         call   print (v17, v20, v21) -> v16
  35|         call   print (v17, v20, v21) -> v22
  36|          lea   v23, stack+b0
  37|        clear   v23+0 {size 40}
  38|         copy   v24 = v18
  39|     constant   v25 = 5
  40|         jump   6 if v24 > v25

-------- Basic Block 4 -------- defines v26 --------

           ... dominating: block 3 instruction 40
1 predecessor: 3
  41|        binop   v26, v24 * v24
  42|         call   array_add (v23, v26)

-------- Basic Block 5 --------

           ... dominating: block 4 instruction 41
2 predecessors: 3, 4
  43|        binop   v24, v24 + 1
  44|         jump   4 if v24 <= v25

-------- Basic Block 6 -------- defines v27 --------

           ... dominating: block 3 instruction 40
1 predecessor: 5
  45|     constant   v27 = 0

-------- Basic Block 7 -------- defines v28-43 --------

           ... dominating: block 6 instruction 45
1 predecessor: 6
  46|          mov   v28, [v23] :8b
  47|         jump   9 if v27 >= v28
  48|          mov   v30, [v23+8] :8b
  49|          mov   v29, [v30+v27*8] :8b
  50|          lea   v32, stack+d8
  51|     constant   v33 = 0xf
  52|          mov   [v32], v33 :8b
  53|       string   v34, "numbers[%] = %\n"
  54|          mov   [v32+8], v34 :8b
  55|     constant   v35 = 2
  56|          lea   v36, stack+e8
  57|          mov   [v36], v35 :8b
  58|          lea   v37, stack+f8
  59|          mov   [v36+8], v37 :8b
  60|          lea   v38, stack+118
  61|          mov   [stack+118], v27 :8b
  62|          lea   v39, stack+120
  63|    emit_type   v40, s64
  64|          mov   [v39], v40 :8b
  65|          mov   [v39+8], v38 :8b
  66|       memcpy   v37, v39 {size 16}
  67|        binop   v37, v37 + 16
  68|          lea   v41, stack+130
  69|          mov   [stack+130], v29 :8b
  70|          lea   v42, stack+138
  71|    emit_type   v43, int
  72|          mov   [v42], v43 :8b
  73|          mov   [v42+8], v41 :8b
  74|       memcpy   v37, v42 {size 16}
  75|         call   print (v32, v36, v21) -> v31

-------- Basic Block 8 --------

           ... dominating: block 7 instruction 50
2 predecessors: 6, 7
  76|        binop   v27, v27 + 1
  77|         jump   7

-------- Basic Block 9 -------- defines v44-54 --------

           ... dominating: block 6 instruction 45
1 predecessor: 8
  78|          lea   v45, stack+148
  79|     constant   v46 = 0xc
  80|          mov   [v45], v46 :8b
  81|       string   v47, "numbers = %\n"
  82|          mov   [v45+8], v47 :8b
  83|          lea   v48, stack+158
  84|          mov   [v48], v18 :8b
  85|          lea   v49, stack+168
  86|    emit_type   v50, [..] int
  87|          mov   [v49], v50 :8b
  88|          mov   [v49+8], v23 :8b
  89|          mov   [v48+8], v49 :8b
  90|         call   print (v45, v48, v21) -> v44
  91|          lea   v52, stack+178
  92|          mov   [v52], v18 :8b
  93|       string   v53, "\n"
  94|          mov   [v52+8], v53 :8b
  95|         call   print (v52, v20, v21) -> v51
  96|          mov   v54, [v23] :8b
  97|        binop   v54, v54 + -1

-------- Basic Block 10 -------- defines v55-63 --------

           ... dominating: block 9 instruction 97
1 predecessor: 9
  98|         jump   12 if v54 < 0
  99|          mov   v56, [v23+8] :8b
 100|          mov   v55, [v56+v54*8] :8b
 101|          lea   v58, stack+188
 102|     constant   v59 = 0x17
 103|          mov   [v58], v59 :8b
 104|       string   v60, "anonymous backwards: %\n"
 105|          mov   [v58+8], v60 :8b
 106|          mov   [v48], v18 :8b
 107|          lea   v61, stack+198
 108|          mov   [stack+198], v55 :8b
 109|          lea   v62, stack+1a0
 110|    emit_type   v63, int
 111|          mov   [v62], v63 :8b
 112|          mov   [v62+8], v61 :8b
 113|          mov   [v48+8], v62 :8b
 114|         call   print (v58, v48, v21) -> v57

-------- Basic Block 11 --------

           ... dominating: block 10 instruction 101
2 predecessors: 9, 10
 115|        binop   v54, v54 + -1
 116|         jump   10

-------- Basic Block 12 -------- defines v64 --------

           ... dominating: block 9 instruction 97
1 predecessor: 11
 117|          mov   v64, [v23] :8b
 118|        binop   v64, v64 + -1

-------- Basic Block 13 -------- defines v65-73 --------

           ... dominating: block 12 instruction 118
1 predecessor: 12
 119|         jump   15 if v64 < 0
 120|          mov   v66, [v23+8] :8b
 121|          mov   v65, [v66+v64*8] :8b
 122|          lea   v68, stack+1b0
 123|     constant   v69 = 0x17
 124|          mov   [v68], v69 :8b
 125|       string   v70, "'number'  backwards: %\n"
 126|          mov   [v68+8], v70 :8b
 127|          mov   [v48], v18 :8b
 128|          lea   v71, stack+1c0
 129|          mov   [stack+1c0], v65 :8b
 130|          lea   v72, stack+1c8
 131|    emit_type   v73, int
 132|          mov   [v72], v73 :8b
 133|          mov   [v72+8], v71 :8b
 134|          mov   [v48+8], v72 :8b
 135|         call   print (v68, v48, v21) -> v67

-------- Basic Block 14 --------

           ... dominating: block 13 instruction 122
2 predecessors: 12, 13
 136|        binop   v64, v64 + -1
 137|         jump   13

-------- Basic Block 15 -------- defines v74-77 --------

           ... dominating: block 12 instruction 118
1 predecessor: 14
 138|          lea   v75, stack+1d8
 139|          mov   [v75], v18 :8b
 140|       string   v76, "\n"
 141|          mov   [v75+8], v76 :8b
 142|         call   print (v75, v20, v21) -> v74
 143|     constant   v77 = 0

-------- Basic Block 16 -------- defines v78-92 --------

           ... dominating: block 15 instruction 143
1 predecessor: 15
 144|          mov   v78, [v23] :8b
 145|         jump   18 if v77 >= v78
 146|          mov   v80, [v23+8] :8b
 147|          mov   v79, [v80+v77*8] :8b
 148|          lea   v82, stack+1e8
 149|     constant   v83 = 0x25
 150|          mov   [v82], v83 :8b
 151|       string   v84, {long string, 37 bytes}
 152|          mov   [v82+8], v84 :8b
 153|     constant   v85 = 2
 154|          mov   [v48], v85 :8b
 155|          lea   v86, stack+1f8
 156|          mov   [v48+8], v86 :8b
 157|          lea   v87, stack+218
 158|          mov   [stack+218], v79 :8b
 159|          lea   v88, stack+220
 160|    emit_type   v89, int
 161|          mov   [v88], v89 :8b
 162|          mov   [v88+8], v87 :8b
 163|       memcpy   v86, v88 {size 16}
 164|        binop   v86, v86 + 16
 165|          lea   v90, stack+230
 166|          mov   [stack+230], v77 :8b
 167|          lea   v91, stack+238
 168|    emit_type   v92, s64
 169|          mov   [v91], v92 :8b
 170|          mov   [v91+8], v90 :8b
 171|       memcpy   v86, v91 {size 16}
 172|         call   print (v82, v48, v21) -> v81

-------- Basic Block 17 --------

           ... dominating: block 16 instruction 148
2 predecessors: 15, 16
 173|        binop   v77, v77 + 1
 174|         jump   16

-------- Basic Block 18 -------- defines v93-96 --------

           ... dominating: block 15 instruction 143
1 predecessor: 17
 175|          lea   v94, stack+248
 176|          mov   [v94], v18 :8b
 177|       string   v95, "\n"
 178|          mov   [v94+8], v95 :8b
 179|         call   print (v94, v20, v21) -> v93
 180|     constant   v96 = 0

-------- Basic Block 19 -------- defines v97-100 --------

           ... dominating: block 18 instruction 180
1 predecessor: 18
 181|          mov   v97, [v23] :8b
 182|         jump   24 if v96 >= v97
 183|          mov   v99, [v23+8] :8b
 184|          mov   v98, [v99+v96*8] :8b
 185|     constant   v100 = 0

-------- Basic Block 20 -------- defines v101-104 --------

           ... dominating: block 19 instruction 185
1 predecessor: 19
 186|          mov   v101, [v23] :8b
 187|         jump   23 if v100 >= v101
 188|          mov   v103, [v23+8] :8b
 189|          mov   v102, [v103+v100*8] :8b
 190|     constant   v104 = 0x10
 191|         jump   21 if v102 != v104
 192|         jump   22

-------- Basic Block 21 -------- defines v105-123 --------

           ... dominating: block 20 instruction 191
1 predecessor: 20
 193|          lea   v106, stack+258
 194|     constant   v107 = 0xa
 195|          mov   [v106], v107 :8b
 196|       string   v108, "% + % = %\n"
 197|          mov   [v106+8], v108 :8b
 198|     constant   v109 = 3
 199|          mov   [v48], v109 :8b
 200|          lea   v110, stack+268
 201|          mov   [v48+8], v110 :8b
 202|          lea   v111, stack+298
 203|          mov   [stack+298], v98 :8b
 204|          lea   v112, stack+2a0
 205|    emit_type   v113, int
 206|          mov   [v112], v113 :8b
 207|          mov   [v112+8], v111 :8b
 208|       memcpy   v110, v112 {size 16}
 209|        binop   v110, v110 + 16
 210|          lea   v114, stack+2b0
 211|          mov   [stack+2b0], v102 :8b
 212|          lea   v115, stack+2b8
 213|          mov   [v115], v113 :8b
 214|          mov   [v115+8], v114 :8b
 215|       memcpy   v110, v115 {size 16}
 216|        binop   v110, v110 + 16
 217|        binop   v116, v98 + v102
 218|          lea   v117, stack+2c8
 219|          mov   [stack+2c8], v116 :8b
 220|          lea   v118, stack+2d0
 221|          mov   [v118], v113 :8b
 222|          mov   [v118+8], v117 :8b
 223|       memcpy   v110, v118 {size 16}
 224|         call   print (v106, v48, v21) -> v105
 225|     constant   v120 = 9
 226|      compare   v119 = (v102 >= v120)
 227|      compare   v122 = (v119 != 0)
 228|      compare   v123 = (v98 >= v120)
 229|        binop   v121, v122 & v123
 230|         jump   22 if v121 == 0
 231|         jump   24

-------- Basic Block 22 --------

           ... dominating: block 20 instruction 190
3 predecessors: 21, 19, 20
 232|        binop   v100, v100 + 1
 233|         jump   20

-------- Basic Block 23 --------

           ... dominating: block 19 instruction 185
3 predecessors: 22, 18, 19
 234|        binop   v96, v96 + 1
 235|         jump   19

-------- Basic Block 24 -------- defines v124-133 --------

           ... dominating: block 18 instruction 180
1 predecessor: 23
 236|          lea   v125, stack+2e0
 237|          mov   [v125], v18 :8b
 238|       string   v126, "\n"
 239|          mov   [v125+8], v126 :8b
 240|         call   print (v125, v20, v21) -> v124
 241|          lea   v128, stack+2f0
 242|     constant   v129 = 0x22
 243|          mov   [v128], v129 :8b
 244|       string   v130, {long string, 34 bytes}
 245|          mov   [v128+8], v130 :8b
 246|          mov   [v48], v18 :8b
 247|          lea   v131, stack+300
 248|    emit_type   v132, [..] int
 249|          mov   [v131], v132 :8b
 250|          mov   [v131+8], v23 :8b
 251|          mov   [v48+8], v131 :8b
 252|         call   print (v128, v48, v21) -> v127
 253|     constant   v133 = 0

-------- Basic Block 25 -------- defines v134-145 --------

           ... dominating: block 24 instruction 253
1 predecessor: 24
 254|          mov   v134, [v23] :8b
 255|         jump   27 if v133 >= v134
 256|          mov   v136, [v23+8] :8b
 257|          mov   v135, [v136+v133*8] :8b
 258|        binop   v137, v135 & v18
 259|         jump   26 if v137 != 0
 260|          mov   v138, [v23+8] :8b
 261|          mov   v139, [v23] :8b
 262|        binop   v140, v139 + -1
 263|        binop   v142, v140 * 8
 264|        binop   v141, v138 + v142
 265|        binop   v144, v133 * 8
 266|        binop   v143, v138 + v144
 267|       memcpy   v143, v141 {size 8}
 268|        binop   v133, v133 + -1
 269|          mov   v145, [v23] :8b
 270|        binop   v145, v145 + -1
 271|          mov   [v23], v145 :8b

-------- Basic Block 26 --------

           ... dominating: block 25 instruction 258
3 predecessors: 25, 24, 25
 272|        binop   v133, v133 + 1
 273|         jump   25

-------- Basic Block 27 -------- defines v146-158 --------

           ... dominating: block 24 instruction 253
1 predecessor: 26
 274|          lea   v147, stack+310
 275|          mov   [v147], v129 :8b
 276|       string   v148, {long string, 34 bytes}
 277|          mov   [v147+8], v148 :8b
 278|          mov   [v48], v18 :8b
 279|          lea   v149, stack+320
 280|    emit_type   v150, [..] int
 281|          mov   [v149], v150 :8b
 282|          mov   [v149+8], v23 :8b
 283|          mov   [v48+8], v149 :8b
 284|         call   print (v147, v48, v21) -> v146
 285|          lea   v152, stack+330
 286|          mov   [v152], v18 :8b
 287|       string   v153, "\n"
 288|          mov   [v152+8], v153 :8b
 289|         call   print (v152, v20, v21) -> v151
 290|          lea   v155, stack+340
 291|     constant   v156 = 6
 292|          mov   [v155], v156 :8b
 293|       string   v157, "Site 1"
 294|          mov   [v155+8], v157 :8b
 295|         call   get_some_teas (v155) -> v154{big 16}
 296|     constant   v158 = 0

-------- Basic Block 28 -------- defines v159-168 --------

           ... dominating: block 27 instruction 296
1 predecessor: 27
 297|          mov   v159, [v154] :8b
 298|         jump   30 if v158 >= v159
 299|          mov   v161, [v154+8] :8b
 300|        binop   v162, v158 * 16
 301|        binop   v160, v161 + v162
 302|          lea   v164, stack+360
 303|     constant   v165 = 0x11
 304|          mov   [v164], v165 :8b
 305|       string   v166, "This is a tea: %\n"
 306|          mov   [v164+8], v166 :8b
 307|          mov   [v48], v18 :8b
 308|          lea   v167, stack+370
 309|    emit_type   v168, string
 310|          mov   [v167], v168 :8b
 311|          mov   [v167+8], v160 :8b
 312|          mov   [v48+8], v167 :8b
 313|         call   print (v164, v48, v21) -> v163

-------- Basic Block 29 --------

           ... dominating: block 28 instruction 302
2 predecessors: 27, 28
 314|        binop   v158, v158 + 1
 315|         jump   28

-------- Basic Block 30 -------- defines v169-176 --------

           ... dominating: block 27 instruction 296
1 predecessor: 29
 316|          lea   v170, stack+380
 317|          mov   [v170], v18 :8b
 318|       string   v171, "\n"
 319|          mov   [v170+8], v171 :8b
 320|         call   print (v170, v20, v21) -> v169
 321|          lea   v173, stack+3a0
 322|          mov   [v173], v156 :8b
 323|       string   v174, "Site 2"
 324|          mov   [v173+8], v174 :8b
 325|         call   get_some_teas (v173) -> v172{big 16}
 326|          lea   v175, stack+390
 327|       memcpy   v175, v172 {size 16}
 328|     constant   v176 = 0

-------- Basic Block 31 -------- defines v177-180 --------

           ... dominating: block 30 instruction 328
1 predecessor: 30
 329|          mov   v177, [v175] :8b
 330|         jump   33 if v176 >= v177
 331|          mov   v179, [v175+8] :8b
 332|        binop   v180, v176 * 16
 333|        binop   v178, v179 + v180

-------- Basic Block 32 --------

           ... dominating: block 31 instruction 333
2 predecessors: 30, 31
 334|        binop   v176, v176 + 1
 335|         jump   31

-------- Basic Block 33 -------- defines v181 --------

           ... dominating: block 30 instruction 328
1 predecessor: 32
 336|     constant   v181 = 0

-------- Basic Block 34 -------- defines v182-208 --------

           ... dominating: block 33 instruction 336
1 predecessor: 33
 337|          mov   v182, [v175] :8b
 338|         jump   36 if v181 >= v182
 339|          mov   v184, [v175+8] :8b
 340|        binop   v185, v181 * 16
 341|        binop   v183, v184 + v185
 342|          lea   v187, stack+3c0
 343|     constant   v188 = 0x1a
 344|          mov   [v187], v188 :8b
 345|       string   v189, "it is %; type_of(it) is %\n"
 346|          mov   [v187+8], v189 :8b
 347|     constant   v190 = 2
 348|          mov   [v48], v190 :8b
 349|          lea   v191, stack+3d0
 350|          mov   [v48+8], v191 :8b
 351|          lea   v192, stack+3f0
 352|          mov   [stack+3f0], v183 :8b
 353|          lea   v193, stack+3f8
 354|    emit_type   v194, *string
 355|          mov   [v193], v194 :8b
 356|          mov   [v193+8], v192 :8b
 357|       memcpy   v191, v193 {size 16}
 358|        binop   v191, v191 + 16
 359|    emit_type   v195, *string
 360|          lea   v196, stack+408
 361|          mov   [stack+408], v195 :8b
 362|          lea   v197, stack+410
 363|    emit_type   v198, Type
 364|          mov   [v197], v198 :8b
 365|          mov   [v197+8], v196 :8b
 366|       memcpy   v191, v197 {size 16}
 367|         call   print (v187, v48, v21) -> v186
 368|          lea   v200, stack+430
 369|          mov   [v200], v18 :8b
 370|       string   v201, " "
 371|          mov   [v200+8], v201 :8b
 372|          lea   v202, rdata+300
 373|         call   split (v183, v200, v202) -> v199{big 16}
 374|          lea   v203, stack+420
 375|       memcpy   v203, v199 {size 16}
 376|     constant   v204 = 0
 377|          mov   v205, [v203] :8b
 378|  array_check   v204, v205
 379|          mov   v206, [v203+8] :8b
 380|        binop   v208, v204 * 16
 381|        binop   v207, v206 + v208
 382|       memcpy   v183, v207 {size 16}

-------- Basic Block 35 --------

           ... dominating: block 34 instruction 342
2 predecessors: 33, 34
 383|        binop   v181, v181 + 1
 384|         jump   34

-------- Basic Block 36 -------- defines v209-218 --------

           ... dominating: block 33 instruction 336
1 predecessor: 35
 385|          lea   v210, stack+450
 386|     constant   v211 = 0x2e
 387|          mov   [v210], v211 :8b
 388|       string   v212, {long string, 46 bytes}
 389|          mov   [v210+8], v212 :8b
 390|          mov   [v48], v18 :8b
 391|          lea   v213, stack+460
 392|    emit_type   v214, [] string
 393|          mov   [v213], v214 :8b
 394|          mov   [v213+8], v175 :8b
 395|          mov   [v48+8], v213 :8b
 396|         call   print (v210, v48, v21) -> v209
 397|          lea   v215, rdata+1018
 398|          lea   v216, stack+480
 399|          mov   [v216], v25 :8b
 400|          mov   [v216+8], v215 :8b
 401|          lea   v217, stack+470
 402|       memcpy   v217, v216 {size 16}
 403|     constant   v218 = 0

-------- Basic Block 37 -------- defines v219-222 --------

           ... dominating: block 36 instruction 403
1 predecessor: 36
 404|          mov   v219, [v217] :8b
 405|         jump   39 if v218 >= v219
 406|          mov   v221, [v217+8] :8b
 407|        binop   v222, v218 * 16
 408|        binop   v220, v221 + v222

-------- Basic Block 38 --------

           ... dominating: block 37 instruction 408
2 predecessors: 36, 37
 409|        binop   v218, v218 + 1
 410|         jump   37

-------- Basic Block 39 -------- defines v223-238 --------

           ... dominating: block 36 instruction 403
1 predecessor: 38
 411|          lea   v223, stack+490
 412|     constant   v224 = 0x11
 413|          mov   [v223], v224 :8b
 414|       string   v225, "We didn't crash!\n"
 415|          mov   [v223+8], v225 :8b
 416|         call   write_string (v223, v21)
 417|     constant   v226 = 0
 418|          mov   v227, [v175] :8b
 419|  array_check   v226, v227
 420|          mov   v228, [v175+8] :8b
 421|        binop   v230, v226 * 16
 422|        binop   v229, v228 + v230
 423|     constant   v231 = 8
 424|          mov   [v229], v231 :8b
 425|       string   v232, "Mister T"
 426|          mov   [v229+8], v232 :8b
 427|          lea   v234, stack+4a0
 428|     constant   v235 = 0xf
 429|          mov   [v234], v235 :8b
 430|       string   v236, "Teas is now: %\n"
 431|          mov   [v234+8], v236 :8b
 432|          mov   [v48], v18 :8b
 433|          lea   v237, stack+4b0
 434|    emit_type   v238, [] string
 435|          mov   [v237], v238 :8b
 436|          mov   [v237+8], v175 :8b
 437|          mov   [v48+8], v237 :8b
 438|         call   print (v234, v48, v21) -> v233
 439|       return
