;         ssize_t   ft_write(int fd, const void *buf, size_t count);
;         rax       ft_write(rdi, rsi, rdx);
          global    ft_write

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
EBADF     EQU       9                             ; Error value: Bad file descriptor
NULL_CHAR EQU       0                             ; Character '\0' (null character)
EMPTY_STR db        '', 0                         ; Empty string in case of error

          section   .text
ft_write:
          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL
          mov       rax, rdi                      ; rax = rdi
          cmp       rax, 1024                     ; compare rax to 1024
          jge       _exit_on_EBADF                ; jump to _exit_on_EBADF if rdi >= 1024
          xor       rax, rax                      ; rax = 0
          mov       rax, 1                        ; rax = WRITE_SYSCALL_TYPE
          syscall                                 ; write on fd rdi the buffer rsi's rdx characters
          test      rax, rax                      ; test rax for errors
          js        _exit_on_error                ; jump to _exit_on_error if error on rax
          jmp       _exit                         ; jump to _exit

_exit_on_EBADF:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EBADF            ; (4 bytes) *rax = EBADF (Bad file descriptor)
          xor       rax, rax                      ; rax = 0
          mov       rax, -1                       ; rax = -1
          ret                                     ; return rax

_exit_on_EINVAL:
          mov       rsi, EMPTY_STR                ; Load the empty string to write
          mov       rdx, 1                        ; Set rdx length to 1
          mov       rax, 1                        ; rax = WRITE_SYSCALL_TYPE
          syscall                                 ; write on fd rdi the buffer rsi's rdx characters
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = 0
          mov       rax, -1                       ; rax = -1
          ret                                     ; return rax

_exit_on_error:
          mov       ebx, eax                      ; ebx = eax (x32 rax)
          neg       ebx                           ; ebx = -1 * ebx
          call      __errno_location              ; rax = &errno
          mov       dword [eax], ebx              ; (4 bytes) &errno = ebx
          xor       rax, rax                      ; rax = 0
          mov       rax, -1                       ; rax = -1
          ret                                     ; return rax

_exit:
          mov       rax, rdx                      ; rax = rdx
          ret                                     ; return rax
