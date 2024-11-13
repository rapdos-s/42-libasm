;         size_t    ft_read(int fd, void *buf, size_t count);
;         rax       ft_read(rdi, rsi, rdx);
          global    ft_read

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
READ_CALL EQU       0                             ; number to syscall read (READ_SYSCALL_TYPE)
NULL_CHAR EQU       0                             ; Character '\0' (null character)

          section   .text
ft_read:
          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL
          mov       rax, rdi                      ; rax = rdi
          xor       rax, rax                      ; rax = 0
          mov       rax, READ_CALL                ; rax = READ_SYSCALL_TYPE
          syscall                                 ; read on fd rdi and write im buffer rsi rdx characters
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
