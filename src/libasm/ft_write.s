;         ssize_t   ft_write(int fd, const void *buf, size_t count);
;         rax       ft_write(rdi, rsi, rdx);
          global    ft_write

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
NULL_CHAR EQU       0                             ; Character '\0' (null character)
WRI_CALL  EQU       1                             ; number to syscall write (WRITE_SYSCALL_TYPE)

          section   .text
ft_write:

          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL

          mov       rax, rdi                      ; rax = rdi
          xor       rax, rax                      ; rax = 0
          mov       rax, WRI_CALL                 ; rax = WRITE_SYSCALL_TYPE
          syscall                                 ; write on fd rdi the buffer rsi's rdx characters
          cmp       rax, 0                        ; compare rax to 0
          jl        _exit_on_error                ; jump to _exit_on_error if rax < 0
          ret                                     ; return rax

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = 0
          mov       rax, -1                       ; rax = -1
          ret                                     ; return rax

_exit_on_error:
          xor       r12, r12                      ; r12 = 0
          sub       r12, rax                      ; r12 = -rax
          call      __errno_location              ; rax = &errno
          mov       [rax], r12                    ; *rax = r12
          xor       rax, rax                      ; rax = 0
          mov       rax, -1                       ; rax = -1
          ret                                     ; return rax
