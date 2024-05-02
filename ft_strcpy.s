;         char      *ft_strcpy(char *dst, const char *src);
;         rax       ft_strcpy(rdi, rsi);
          global    ft_strcpy

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
NULL_CHAR EQU       0                             ; Character '\0' (null character)

          section   .text
ft_strcpy:
          xor       rcx, rcx                      ; rcx = 0
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdi == NULL
          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL
          mov       byte [rdi], NULL_CHAR         ; (1 byte) rdi[0] = '\0'
_while:
          mov       dl, byte [rsi + rcx]          ; dl = (1 byte) rsi[rcx]
          mov       byte [rdi + rcx], dl          ; (1 byte) rdi[rcx] = dl
          inc       rcx                           ; rcx++;
          cmp       byte [rsi + rcx], NULL_CHAR   ; compare (1 byte) rsi[rcx] to '\0'
          jne       _while                        ; jump to _while if rsi[rcx] == '\0'
          mov       byte [rdi + rcx], NULL_CHAR   ; (1 byte) rdi[rcx] = dl
          mov       rax, rdi                      ; rax = rdi
          ret                                     ; return rax
          jmp       _exit                         ; jump to _exit

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], 22               ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = NULL
          ret                                     ; return rax

_exit:
          ret                                     ; return rax
