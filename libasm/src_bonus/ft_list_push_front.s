;         void      ft_list_push_front(t_list **begin_list, void *data);
;         void      ft_list_push_front(rdi, rsi);
          global    ft_list_push_front

          extern    __errno_location              ; declare &errno
          extern    ft_create_elem                ; declare ft_create_elem()

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
NEXT_POS  EQU       8                             ; t_list.next

          section   .text
ft_list_push_front:
          test      [rdi], rdi                    ; test *rsi == NULL
          jz        _create_new_list              ; jump to _create_new_list if *rsi == NULL
          jmp       _add_to_current_list          ; jump to _add_to_current_list
_create_new_list:
          xor       r12, r12                      ; r12 = 0
          mov       r12, rdi                      ; r12 = rdi
          mov       rdi, rsi                      ; rdi = rsi
          call      ft_create_elem                ; rax = ft_create_elem(rdi)
          mov       [r12], rax                    ; *r12 = rax
          jmp       _exit                         ; jump to _exit
_add_to_current_list:
          xor       r11, r11                      ; r11 = 0
          xor       r12, r12                      ; r12 = 0
          mov       r12, rdi                      ; r12 = rdi
          mov       rdi, rsi                      ; rdi = rsi
          call      ft_create_elem                ; rax = ft_create_elem(rdi)
          mov       r11, rax                      ; r11 = rax
          mov       rax, [r12]                    ; rax = *r12
          mov       [r11 + NEXT_POS], rax         ; rax.next = rax
          mov       [r12], r11                    ; *r12 = r11
          jmp       _exit                         ; jump to _exit

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          ret                                     ; return

_exit:
          ret                                     ; return
