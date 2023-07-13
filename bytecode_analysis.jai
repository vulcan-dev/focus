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
   346|         jump   23 if v203 >= v204                    if it_index >= window_sizes.count break
   347|          mov   v206, [v202+8] :8b                    windows_sizes.data
   348|        binop   v207, v203 * 16                       it_index * size
   349|        binop   v205, v206 + v207                     *it
   350|          mov   v208, [v205] :8b                      it
   351|         call   update_window (v208)
   352|          mov   v209, [v205] :8b                      it
   353|          mov   v210, [bss+a270] :8b                  window
   354|         jump   22 if v209 != v210                    if it.window == window
   355|          mov   v212, [bss+239] :1b                   dont_ignore_next_window_resize
   356|      compare   v211 = (v212 != 0)
   357|         jump   20 if v211 != 0
   358|          mov   v213, [v205+8] :4b
   359|  cast_number   v214 (s64), v213 (s32)
   360|          mov   v216, [bss+2c0] :8b
   361|      compare   v215 = (v214 != v216)
   362|      compare   v217 = (v215 != 0)
   363|         jump   19 if v217 != 0
   364|          mov   v218, [v205+c] :4b
   365|  cast_number   v219 (s64), v218 (s32)
   366|          mov   v221, [bss+2b8] :8b
   367|      compare   v220 = (v219 != v221)
   368|         copy   v217 = v220

  -------- Basic Block 19 --------

             ... dominating: block 18 instruction 363
  1 predecessor: 18
   369|         copy   v211 = v217

  -------- Basic Block 20 -------- defines v222-230 --------

             ... dominating: block 18 instruction 357
  1 predecessor: 18
   370|          mov   v222, [v205+8] :4b
   371|  cast_number   v223 (s64), v222 (s32)
   372|          mov   [bss+2c0], v223 :8b
   373|          mov   v224, [v205+c] :4b
   374|  cast_number   v225 (s64), v224 (s32)
   375|          mov   [bss+2b8], v225 :8b
   376|         jump   21 if v211 == 0
   377|          mov   v227, [bss+2c0] :8b
   378|          mov   v228, [bss+2b8] :8b
   379|         call   make_rect (v178, v178, v227, v228) -> v226{big 16}
   380|       memcpy   v181, v226 {size 16}
   381|          mov   v230, [bss+a270] :8b
   382|         call   platform_get_dpi_scale (v230) -> v229
   383|          mov   [data+11c], v229 :4b
   384|         call   init_fonts_and_dependent_things ()
   385|          mov   [bss+239], v54 :1b

  -------- Basic Block 21 --------

             ... dominating: block 20 instruction 376
  1 predecessor: 20
   386|     constant   v187 = 1

  -------- Basic Block 22 --------

             ... dominating: block 18 instruction 350
  3 predecessors: 18, 17, 18
   387|        binop   v203, v203 + 1                        it_index += 1
   388|         jump   18

  -------- Basic Block 23 -------- defines v231-237 --------

             ... dominating: block 17 instruction 344
  1 predecessor: 22
   389|          mov   v231, [bss+2c0] :8b
   390|     constant   v233 = 0x64
   391|      compare   v232 = (v231 < v233)
   392|      compare   v235 = (v232 != 0)
   393|          mov   v236, [bss+2b8] :8b
   394|      compare   v237 = (v236 < v233)
   395|        binop   v234, v235 | v237
   396|         jump   24 if v234 == 0
   397|         jump   14

  -------- Basic Block 24 -------- defines v238-243 --------

             ... dominating: block 23 instruction 396
  1 predecessor: 23
   398|         call   update_mouse_state ()
   399|          lea   v238, stack+5d8
   400|       memcpy   v238, v181 {size 16}
   401|          mov   v239, [v238+c] :4b
   402|     constant   v241 = 0x43480000
   403|        binop   v240, v239 + v241
   404|          mov   [v238+12], v240 :4b
   405|          mov   [data+118], v54 :1b
   406|     constant   v187 = 0
   407|          mov   [bss+278], v54 :1b
   408|          mov   v186, [bss+1f9] :1b
   409|         call   maybe_update_workspace_buffers ()
   410|         call   finder_update ()
   411|          lea   v242, bss+8738
   412|     constant   v243 = 0

  -------- Basic Block 25 -------- defines v244-263 --------

             ... dominating: block 24 instruction 412
  1 predecessor: 24
   413|          mov   v244, [v242] :8b
   414|         jump   27 if v243 >= v244
   415|          mov   v246, [v242+8] :8b
   416|        binop   v247, v243 * 744
   417|        binop   v245, v246 + v247
   418|        binop   v248, v245 + 65
   419|     constant   v249 = 0
   420|          mov   [v248], v249 :1b
   421|          mov   v250, [bss+298] :4b
   422|          mov   v251, [bss+29c] :4b
   423|         jump   26 if v250 == v251
   424|        binop   v253, v245 + 560
   425|          mov   v254, [v253] :4b
   426|  cast_number   v255 (float), v254 (s32)
   427|          mov   v256, [bss+298] :4b
   428|        binop   v252, v255 / v256
   429|        binop   v257, v245 + 560
   430|          mov   v259, [bss+29c] :4b
   431|        binop   v258, v252 * v259
   432|  cast_number   v260 (s32), v258 (float)
   433|          mov   [v257+20], v260 :4b
   434|        binop   v261, v245 + 560
   435|        binop   v262, v245 + 560
   436|          mov   v263, [v262+14] :4b
   437|          mov   [v261], v263 :4b

  -------- Basic Block 26 --------

             ... dominating: block 25 instruction 418
  3 predecessors: 25, 24, 25
   438|        binop   v243, v243 + 1
   439|         jump   25

  -------- Basic Block 27 -------- defines v264-266 --------

             ... dominating: block 24 instruction 412
  1 predecessor: 26
   440|     constant   v264 = 0
   441|         call   start_key_sequence_handling ()
   442|          lea   v265, bss+85a8
   443|     constant   v266 = 0

  -------- Basic Block 28 -------- defines v267-272 --------

             ... dominating: block 27 instruction 443
  1 predecessor: 27
   444|          mov   v267, [v265] :8b
   445|         jump   72 if v266 >= v267
   446|          mov   v269, [v265+8] :8b
   447|        binop   v270, v266 * 48
   448|        binop   v268, v269 + v270
   449|          mov   v271, [v268] :4b
   450|     constant   v272 = 5
   451|         jump   30 if v271 != v272

  -------- Basic Block 29 --------

             ... dominating: block 28 instruction 451
  1 predecessor: 28
   452|          mov   [bss+2b2], v78 :1b
   453|         jump   56

  -------- Basic Block 30 -------- defines v273 --------

             ... dominating: block 28 instruction 451
  1 predecessor: 28
   454|     constant   v273 = 1
   455|         jump   47 if v271 != v273

  -------- Basic Block 31 -------- defines v274-282 --------

             ... dominating: block 30 instruction 455
  1 predecessor: 30
   456|          mov   v274, [data+787] :1b
   457|      compare   v276 = (v274 != 0)
   458|          mov   v277, [v268+8] :4b
   459|     constant   v279 = 0x8d
   460|      compare   v278 = (v277 == v279)
   461|        binop   v275, v276 & v278
   462|         jump   41 if v275 == 0
   463|          mov   v280, [v268+4] :4b
   464|         jump   32 if v280 != 0
   465|          lea   v281, stack+5a0+8
   466|          mov   v282, [bss+2a8] :8b
   467|          mov   [v281], v282 :8b

  -------- Basic Block 32 -------- defines v283-286 --------

             ... dominating: block 31 instruction 464
  1 predecessor: 31
   468|          mov   v283, [v268+4] :4b
   469|      compare   v284 = (v283 != 0)
   470|         jump   33 if v284 == 0
   471|        binop   v286, v268 + 12
   472|         call   only_shift_pressed (v286) -> v285
   473|         copy   v284 = v285

  -------- Basic Block 33 -------- defines v287-292 --------

             ... dominating: block 32 instruction 470
  1 predecessor: 32
   474|         jump   40 if v284 == 0
   475|          mov   v287, [stack+5a0] :8b
   476|          mov   v289, [stack+5a8] :8b
   477|      compare   v288 = (v287 < v289)
   478|      compare   v290 = (v288 != 0)
   479|         jump   34 if v290 == 0
   480|          mov   v291, [stack+5b0] :8b
   481|      compare   v292 = (v291 > 0)
   482|         copy   v290 = v292

  -------- Basic Block 34 -------- defines v293-298 --------

             ... dominating: block 33 instruction 479
  1 predecessor: 33
   483|      compare   v293 = (v290 != 0)
   484|         jump   35 if v293 == 0
   485|          mov   v294, [bss+2a8] :8b
   486|          mov   v296, [stack+5a0] :8b
   487|        binop   v295, v294 - v296
   488|     constant   v298 = 0x3fc999999999999a
   489|      compare   v297 = (v295 < v298)
   490|         copy   v293 = v297

  -------- Basic Block 35 -------- defines v299 --------

             ... dominating: block 34 instruction 484
  1 predecessor: 34
   491|         jump   38 if v293 == 0
   492|         call   finder_is_open () -> v299
   493|         jump   36 if v299 == 0
   494|         call   finder_close ()
   495|         jump   37

  -------- Basic Block 36 --------

             ... dominating: block 35 instruction 493
  1 predecessor: 35
   496|         call   finder_open_from_editor ()

  -------- Basic Block 37 -------- defines v300 --------

             ... dominating: block 35 instruction 493
  1 predecessor: 36
   497|          lea   v300, stack+5a0+10
   498|          mov   [v300], v178 :8b
   499|         jump   39

  -------- Basic Block 38 -------- defines v301 --------

             ... dominating: block 35 instruction 491
  1 predecessor: 33
   500|          lea   v301, stack+5a0+10
   501|          mov   [v301], v16 :8b

  -------- Basic Block 39 -------- defines v302-303 --------

             ... dominating: block 35 instruction 491
  1 predecessor: 38
   502|          lea   v302, stack+5a0
   503|          mov   v303, [bss+2a8] :8b
   504|          mov   [v302], v303 :8b

  -------- Basic Block 40 -------- defines v304-306 --------

             ... dominating: block 33 instruction 474
  1 predecessor: 32
   505|          mov   v304, [v268+4] :4b
   506|         jump   41 if v304 == 0
   507|          lea   v305, stack+5a0
   508|          mov   v306, [bss+2a8] :8b
   509|          mov   [v305], v306 :8b

  -------- Basic Block 41 -------- defines v307-311 --------

             ... dominating: block 31 instruction 462
  2 predecessors: 40, 31
   510|          mov   v307, [v268+8] :4b
   511|     constant   v308 = 0x8c
   512|         jump   44 if v307 != v308
   513|          mov   v309, [bss+1a] :1b
   514|      compare   v310 = (v309 != 0)
   515|         jump   42 if v310 == 0
   516|          mov   v311, [v268+4] :4b
   517|      compare   v310 = (v311 == 0)

  -------- Basic Block 42 --------

             ... dominating: block 41 instruction 515
  1 predecessor: 41
   518|         jump   43 if v310 == 0
   519|         call   finalize_buffer_switch ()

  -------- Basic Block 43 -------- defines v312-313 --------

             ... dominating: block 42 instruction 518
  1 predecessor: 41
   520|          mov   v312, [v268+4] :4b
   521|      compare   v313 = (v312 != 0)
   522|          mov   [bss+1a], v313 :1b

  -------- Basic Block 44 -------- defines v314-321 --------

             ... dominating: block 41 instruction 512
  1 predecessor: 41
   523|          mov   v314, [v268+4] :4b
   524|         jump   46 if v314 == 0
   525|          mov   v315, [v268+8] :4b
   526|     constant   v317 = 0x1b
   527|      compare   v316 = (v315 == v317)
   528|      compare   v319 = (v316 != 0)
   529|          mov   v320, [bss+9278] :4b
   530|      compare   v321 = (v320 == v317)
   531|        binop   v318, v319 & v321
   532|         jump   45 if v318 == 0
   533|         call   cleanup_extraneous_windows ()

  -------- Basic Block 45 -------- defines v322 --------

             ... dominating: block 44 instruction 532
  1 predecessor: 44
   534|          mov   v322, [v268+8] :4b
   535|          mov   [bss+9278], v322 :4b

  -------- Basic Block 46 --------

             ... dominating: block 44 instruction 524
  1 predecessor: 44
   536|         jump   56

  -------- Basic Block 47 -------- defines v323 --------

             ... dominating: block 30 instruction 455
  1 predecessor: 30
   537|     constant   v323 = 4
   538|         jump   51 if v271 != v323

  -------- Basic Block 48 -------- defines v324-325 --------

             ... dominating: block 47 instruction 538
  1 predecessor: 47
   539|         call   ctrl_or_cmd_pressed () -> v324
   540|         jump   50 if v324 == 0
   541|          mov   v325, [v268+1c] :4b
   542|         jump   49 if v325 >= 0
   543|         call   decrease_font_size ()
   544|          mov   [bss+278], v78 :1b
   545|         jump   50

  -------- Basic Block 49 -------- defines v326 --------

             ... dominating: block 48 instruction 542
  1 predecessor: 48
   546|          mov   v326, [v268+1c] :4b
   547|         jump   50 if v326 <= 0
   548|         call   increase_font_size ()
   549|          mov   [bss+278], v78 :1b

  -------- Basic Block 50 --------

             ... dominating: block 48 instruction 540
  3 predecessors: 49, 49, 48
   550|         jump   56

  -------- Basic Block 51 -------- defines v327 --------

             ... dominating: block 47 instruction 538
  1 predecessor: 47
   551|     constant   v327 = 6
   552|         jump   53 if v271 != v327

  -------- Basic Block 52 -------- defines v328 --------

             ... dominating: block 51 instruction 552
  1 predecessor: 51
   553|        binop   v328, v268 + 32
   554|         call   editors_handle_file_drop (v328)
   555|         jump   56

  -------- Basic Block 53 -------- defines v329 --------

             ... dominating: block 51 instruction 552
  1 predecessor: 51
   556|     constant   v329 = 2
   557|         jump   56 if v271 != v329

  -------- Basic Block 54 --------

             ... dominating: block 53 instruction 557
  1 predecessor: 53
   558|         jump   55 if v264 == 0
   559|        binop   v264, v264 + -1
   560|         jump   71

  -------- Basic Block 55 --------

             ... dominating: block 54 instruction 558
  1 predecessor: 54
   561|         jump   56

  -------- Basic Block 56 -------- defines v330-337 --------

             ... dominating: block 28 instruction 451
  7 predecessors: 28, 29, 31, 48, 52, 54, 54
   562|     constant   v330 = 0
   563|         call   map_event_to_action (v268) -> v332, v333{big 24}
   564|         copy   v331 = v332
   565|     constant   v335 = 0
   566|         call   handle_common_editor_action (v331, v335) -> v334
   567|         copy   v330 = v334
   568|         jump   70 if v330 != 0
   569|          mov   v336, [data+258] :8b
   570|     constant   v337 = 0
   571|         jump   58 if v336 != v337

  -------- Basic Block 57 -------- defines v338 --------

             ... dominating: block 56 instruction 571
  1 predecessor: 56
   572|         call   editors_handle_event (v268) -> v338
   573|         copy   v330 = v338
   574|         jump   70

  -------- Basic Block 58 -------- defines v339 --------

             ... dominating: block 56 instruction 571
  1 predecessor: 56
   575|     constant   v339 = 1
   576|         jump   60 if v336 != v339

  -------- Basic Block 59 -------- defines v340 --------

             ... dominating: block 58 instruction 576
  1 predecessor: 58
   577|         call   finder_handle_event (v268) -> v340
   578|         copy   v330 = v340
   579|         jump   70

  -------- Basic Block 60 -------- defines v341 --------

             ... dominating: block 58 instruction 576
  1 predecessor: 58
   580|     constant   v341 = 2
   581|         jump   62 if v336 != v341

  -------- Basic Block 61 -------- defines v342 --------

             ... dominating: block 60 instruction 581
  1 predecessor: 60
   582|         call   open_file_dialog_handle_event (v268) -> v342
   583|         copy   v330 = v342
   584|         jump   70

  -------- Basic Block 62 -------- defines v343 --------

             ... dominating: block 60 instruction 581
  1 predecessor: 60
   585|     constant   v343 = 3
   586|         jump   64 if v336 != v343

  -------- Basic Block 63 -------- defines v344 --------

             ... dominating: block 62 instruction 586
  1 predecessor: 62
   587|         call   go_to_line_dialog_handle_event (v268) -> v344
   588|         copy   v330 = v344
   589|         jump   70

  -------- Basic Block 64 -------- defines v345 --------

             ... dominating: block 62 instruction 586
  1 predecessor: 62
   590|     constant   v345 = 5
   591|         jump   66 if v336 != v345

  -------- Basic Block 65 -------- defines v346 --------

             ... dominating: block 64 instruction 591
  1 predecessor: 64
   592|         call   unsaved_buffers_dialog_handle_event (v268) -> v346
   593|         copy   v330 = v346
   594|         jump   70

  -------- Basic Block 66 -------- defines v347 --------

             ... dominating: block 64 instruction 591
  1 predecessor: 64
   595|     constant   v347 = 4
   596|         jump   68 if v336 != v347

  -------- Basic Block 67 -------- defines v348 --------

             ... dominating: block 66 instruction 596
  1 predecessor: 66
   597|         call   commands_dialog_handle_event (v268) -> v348
   598|         copy   v330 = v348
   599|         jump   70

  -------- Basic Block 68 -------- defines v349 --------

             ... dominating: block 66 instruction 596
  1 predecessor: 66
   600|     constant   v349 = 6
   601|         jump   70 if v336 != v349

  -------- Basic Block 69 -------- defines v350 --------

             ... dominating: block 68 instruction 601
  1 predecessor: 68
   602|         call   open_project_dialog_handle_event (v268) -> v350
   603|         copy   v330 = v350
   604|         jump   70

  -------- Basic Block 70 -------- defines v351-357 --------

             ... dominating: block 56 instruction 568
  10 predecessors: 56, 57, 59, 61, 63, 65, 67, 69, 69, 56
   605|      compare   v352 = (v330 != 0)
   606|          mov   v353, [v268] :4b
   607|     constant   v355 = 1
   608|      compare   v354 = (v353 == v355)
   609|        binop   v351, v352 & v354
   610|         jump   71 if v351 == 0
   611|          mov   v356, [v268+16] :2b
   612|  cast_number   v357 (s64), v356 (u16)
   613|         copy   v264 = v357

  -------- Basic Block 71 --------

             ... dominating: block 28 instruction 449
  3 predecessors: 70, 27, 28
   614|        binop   v266, v266 + 1
   615|         jump   28

  -------- Basic Block 72 -------- defines v358-360 --------

             ... dominating: block 27 instruction 443
  1 predecessor: 71
   616|         call   end_key_sequence_handling ()
   617|          mov   v358, [bss+2b2] :1b
   618|      compare   v359 = (v358 != 0)
   619|         jump   73 if v359 == 0
   620|         call   unsaved_buffers_exist () -> v360
   621|         copy   v359 = v360

  -------- Basic Block 73 -------- defines v361-365 --------

             ... dominating: block 72 instruction 619
  1 predecessor: 72
   622|      compare   v362 = (v359 != 0)
   623|          mov   v363, [bss+2b1] :1b
   624|      compare   v364 = (v363 == 0)
   625|        binop   v361, v362 & v364
   626|         jump   74 if v361 == 0
   627|     constant   v365 = 0
   628|         call   show_unsaved_buffers_dialog (v365)
   629|          mov   [bss+2b2], v54 :1b

  -------- Basic Block 74 -------- defines v366 --------

             ... dominating: block 73 instruction 626
  1 predecessor: 72
   630|         call   refresh_open_buffers ()
   631|         call   draw_frame ()
   632|         call   pointer_end_frame ()
   633|         call   maybe_save_editor_history ()
   634|          mov   v366, [bss+2b0] :1b
   635|         jump   75 if v366 == 0
   636|         call   hard_reload_workspace ()
   637|          mov   [bss+2b0], v54 :1b
   638|          mov   [data+118], v78 :1b
   639|         call   platform_apply_config (v168)

  -------- Basic Block 75 -------- defines v367-371 --------

             ... dominating: block 74 instruction 635
  1 predecessor: 74
   640|         call   reset_temporary_storage ()
   641|         call   get_time () -> v367
   642|          mov   v369, [bss+2a8] :8b
   643|        binop   v368, v367 - v369
   644|     constant   v370 = 0x3f6b4e81b4e81b4f
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
   649|         jump   78 if v78 == 0
   650|         call   eye_tracking_done ()

  -------- Basic Block 78 --------

             ... dominating: block 77 instruction 649
  1 predecessor: 77
   651|         call   deinit_logger ()                      deferred after [301]
   652|       return
