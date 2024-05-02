;         int       ft_strcmp(const char *s1, const char *s2);
;         rax       ft_strcmp(rdi, rsi);
          global    ft_strcmp

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
NULL_CHAR EQU       0                             ; Character '\0' (null character)

          section   .text
ft_strcmp:
          xor       rax, rax                      ; rax = 0
          xor       rcx, rcx                      ; rcx = 0
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdi == NULL
          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL
_while:
          mov       dl, byte [rsi + rcx]          ; dl = (1 byte) rsi[rcx]
          cmp       byte [rdi + rcx], byte dl     ; compare (1 byte) rdi[rcx] to (1 byte) dl
          ja        _exit                         ; jump to _exit if rdi[rcx] above dl
          jb        _exit                         ; jump to _exit if rdi[rcx] below dl
          cmp       byte [rdi + rcx], 0           ; compare (1 byte) rdi[rcx] to '\0'
          je        _exit                         ; jump to _exit if rdi[rcx] == '\0'
          inc       rcx                           ; rcx++;
          jmp       _while                        ; jump to _while

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], 22               ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = 0
          ret                                     ; return rax

_exit:
          movzx     rax, byte [rdi + rcx]         ; rax = (1 byte) rdi[rcx]
          movzx     rcx, dl                       ; rcx = dl
          sub       rax, rcx                      ; rax = rax - rcx
          ret                                     ; return rax
