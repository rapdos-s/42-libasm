;         int       ft_list_size(t_list *begin_list);
;         rax       ft_list_size(rdi);
          global    ft_list_size

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
NEXT_POS  EQU       8                             ; t_list.next

          section   .text
ft_list_size:
          xor       rax, rax                      ; rax = 0
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdi == NULL
_while:
          inc       rax                           ; rax++
          mov       rdi, [rdi + NEXT_POS]         ; rdi = rdi.next
          test      rdi, rdi                      ; test rdi == NULL
          jnz       _while                        ; jump to _while if rdi != NULL
          jmp       _exit                         ; jump to _exit

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = 0
          ret                                     ; return rax

_exit:
          ret                                     ; return rax
