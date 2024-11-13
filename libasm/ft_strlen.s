;         size_t    ft_strlen(const char *s);
;         rax       ft_strlen(rdi);
          global    ft_strlen

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
NULL_CHAR EQU       0                             ; Character '\0' (null character)

          section   .text
ft_strlen:
          xor       rax, rax                      ; rax = 0
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdi == NULL

_while:
          cmp       byte [rdi + rax], NULL_CHAR   ; compare (1 byte) rdi[rax] to '\0'
          je        _exit                         ; jump to _exit if rdi[rax] == '\0'
          inc       rax                           ; rax++
          jmp       _while                        ; jump to _while

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = 0
          ret                                     ; return rax

_exit:
          ret                                     ; return rax
