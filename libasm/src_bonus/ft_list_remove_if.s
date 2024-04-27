;         void      ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *) );
;         void      ft_list_remove_if(rdi, rsi, rdx, rcx);
          global    ft_list_remove_if

          extern    __errno_location              ; declare &errno
          extern    free                          ; declare free()

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
DATA_POS  EQU       0                             ; t_list.data
NEXT_POS  EQU       8                             ; t_list.next

          section   .text
ft_list_remove_if:
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdi == NULL
          test      [rdi], rdi                    ; test *rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if *rdi == NULL
          xor       r9, r9                        ; r9 = NULL
          mov       r9, rdi                       ; r9 = rdi
          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL
          xor       r12, r12                      ; r12 = NULL
          mov       r12, rsi                      ; r12 = rsi
          test      rdx, rdx                      ; test rdx == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdx == NULL
          xor       r11, r11                      ; r11 = NULL
          mov       r11, rdx                      ; r11 = rdx
          test      rcx, rcx                      ; test rcx == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rcx == NULL
          xor       r10, r10                      ; r10 = NULL
          mov       r10, rcx                      ; r10 = rcx
          xor       r14, r14                      ; r14 = NULL
          mov       r14, [rdi]                    ; r14 = *rdi
          xor       r15, r15                      ; r15 = NULL
_loop:
          test      r14, r14                      ; test r14 == NULL
          jz        _end_loop                     ; jump to _end_loop if r14 == NULL
          xor       r13, r13                      ; r13 = NULL
          mov       r13, [r14 + NEXT_POS]         ; r13 = r14.next
          xor       r8, r8                        ; r8 = NULL
          mov       r8, [r14]                     ; r8 = *r14
          xor       rdi, rdi                      ; rdi = NULL
          mov       rdi, [r14 + DATA_POS]         ; rdi = r14.data
          xor       rsi, rsi                      ; rsi = NULL
          mov       rsi, r12                      ; rsi = r12
          call      r11                           ; eax = cmp(rdi, rsi)
          cmp       eax, 0                        ; compare eax to 0
          jz        _outer_else                   ; jump to _outer_else
_outer_if:
          xor       r15, r15                      ; r15 = NULL
          mov       r15, r14                      ; r15 = r14
          jmp       _end_outer_if                 ; jump to _end_outer_if
_outer_else:
          xor       rdi, rdi                      ; rdi = NULL
          mov       rdi, [r14 + DATA_POS]         ; redi = r14.data
          call      r10                           ; free_fct(rdi)
          test      r15, r15                      ; test r15 == NULL
          jz        _inner_else                   ; jump to _inner_else if r15 == NULL
_inner_if:
          xor       rax, rax                      ; rax = NULL
          mov       rax, [r14 + NEXT_POS]         ; rax = r14.next
          mov       qword [r15 + NEXT_POS], rax   ; (8 bytes) r15.next = rax
          jmp       _end_inner_if                 ; jump to _end_inner_if
_inner_else:
          xor       rax, rax                      ; rax = NULL
          mov       rax, [r14 + NEXT_POS]         ; rax = r14.next
          mov       qword [r9], rax               ; (8 bytes) r9 = rax
_end_inner_if:
          xor       rdi, rdi                      ; rdi = NULL
          mov       rdi, r14                      ; rdi = r14
          call      free                          ; free(rdi)
_end_outer_if:
          mov       r14, r13                      ; r14 = r13
          jmp       _loop                         ; jump to _loop
_end_loop:
          jmp       _exit                         ; jump to _exit

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          ret                                     ; return

_exit:
          ret                                     ; return
