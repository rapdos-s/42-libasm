;         void      ft_list_sort(t_list **begin_list, int (*cmp)());
;         void      ft_list_sort(rdi, rsi);
          global    ft_list_sort

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
DATA_POS  EQU       0                             ; t_list.data
NEXT_POS  EQU       8                             ; t_list.next

          section   .text
ft_list_sort:
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit if rdi == NULL
          xor       r13, r13                      ; r13 = 0
          mov       r13, rsi                      ; r13 = rsi
          xor       rbx, rbx                      ; rbx = 0
          mov       rbx, [rdi]                    ; rbx = *rdi
_loop_outer:
          test      rbx, rbx                      ; test rbx == NULL
          jz        _end_loop_outer               ; jump to _end_loop_outer if rbx == NULL
          xor       r12, r12                      ; r12 = 0
          mov       r12, [rbx + NEXT_POS]         ; r12 = rbx.next
_loop_inner:
          test      r12, r12                      ; r12 = 0
          jz        _end_loop_inner               ; jump to _end_loop_inner if r12 == NULL
          xor       rdi, rdi                      ; rdi = 0
          mov       rdi, [rbx + DATA_POS]         ; rdi = rbx.data
          xor       rsi, rsi                      ; rsi = 0
          mov       rsi, [r12 + DATA_POS]         ; rsi = r12.data
          test      rdi, rdi                      ; test rdi == NULL
          jz        _end_loop_inner               ; jump to _end_loop_inner if rdi == NULL
          test      rsi, rsi                      ; test rsi == NULL
          jz        _end_loop_inner               ; jump to _end_loop_inner if rsi == NULL
          test      r13, r13                      ; test r13 == NULL
          jz        _end_loop_inner               ; jump to _end_loop_inner if r13 == NULL
          call      r13                           ; eax = cmp(rdi, rsi)
          cmp       eax, 0                        ; compare eax to 0
          jle       _skip                         ; jump to to _skip if eax <= 0
          xor       r14, r14                      ; r14 = 0
          mov       r14, [rbx + DATA_POS]         ; r14 = rbx.data
          mov       rax, [r12 + DATA_POS]         ; rax = r12.data
          mov       [rbx + DATA_POS], rax         ; rbx.data = rax
          mov       [r12 + DATA_POS], r14         ; r12.data = r14
_skip:
          mov       r12, [r12 + NEXT_POS]         ; r12 = r12.next
          jmp       _loop_inner                   ; jump to _loop_inner
_end_loop_inner:
          mov       rbx, [rbx + NEXT_POS]         ; rbx = rbx.next
          jmp       _loop_outer                   ; jump to _loop_outer
_end_loop_outer:
          jmp       _exit                         ; jump to _exit

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          ret                                     ; return

_exit:
          ret                                     ; return
