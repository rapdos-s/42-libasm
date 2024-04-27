;         size_t    ft_read(int fd, void *buf, size_t count);
;         rax       ft_read(rdi, rsi, rdx);
          global    ft_read

          extern    __errno_location              ; declare &errno

          section   .data
EBADF     EQU       9                             ; Error value: Bad file descriptor
EINVAL    EQU       22                            ; Error value: Invalid Argument
MAX_FD    EQU       1024                          ; Character '\0' (null character)
NULL_CHAR EQU       0                             ; Character '\0' (null character)

          section   .text
ft_read:
          xor       rax, rax                      ; rax = 0
          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL
          mov       rax, rdi                      ; rax = rdi
          cmp       rax, MAX_FD                   ; compare rax to MAX_FD
          jge       _exit_on_EBADF                ; jump to _exit_on_EBADF if rdi >= MAX_FD
          xor       rax, rax                      ; rax = READ_SYSCALL_TYPE
          syscall                                 ; read on fd rdi and write im buffer rsi rdx characters
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
          xor       rax, rax                      ; rax = 0
          mov       rax, rdx                      ; rax = rdx
          ret                                     ; return rax
