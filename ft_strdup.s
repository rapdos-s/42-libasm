;         char      *ft_strdup(const char *s);
;         rax       ft_strdup(rdi);
          global    ft_strdup
          extern    __errno_location              ; declare &errno

          extern    malloc                        ; declare malloc()

          section   .data
ENOMEM    EQU       12                            ; Error value: Cannot allocate memory
EINVAL    EQU       22                            ; Error value: Invalid Argument
NULL_CHAR EQU       0                             ; Character '\0' (null character)

          section   .text
ft_strdup:
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdi == NULL
          push      rdi                           ; push rdi value to stack
          xor       rcx, rcx                      ; rcx = 0
_calculate_length:
          cmp       byte [rdi + rcx], NULL_CHAR   ; compare (1 byte) rdi[rcx] to '\0'
          je        _allocate_memory              ; jump to _allocate_memory if rdi[rcx] == '\0'
          inc       rcx                           ; rcx++
          jmp       _calculate_length             ; jump to _calculate_length
_allocate_memory:
          inc       rcx                           ; rcx++
          mov       rdi, rcx                      ; rdi = rcx
          call      malloc                        ; rax = malloc(rdi)
          test      rax, rax                      ; test rax
          jz        _exit_on_ENOMEM               ; jump to _exit_on_ENOMEM if error on memory allocation
          mov       rdi, rax                      ; rdi = rax
          pop       rdi                           ; pop stack value to rdi
          xor       rcx, rcx                      ; rcx = 0
_while:
          cmp       byte [rdi + rcx], NULL_CHAR   ; compare (1 byte) rdi[rcx] to '\0'
          je        _exit                         ; jump to _exit if rdi[rcx] == '\0'
          mov       dl, byte [rdi + rcx]          ; dl = (1 byte) rdi[rcx]
          mov       byte [rax + rcx], dl          ; (1 byte) rax[rcx] = dl
          inc       rcx                           ; rcx++
          jmp       _while                        ; jump to _while

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = 0
          ret                                     ; return rax

_exit_on_ENOMEM:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], ENOMEM           ; (4 bytes) *rax = ENOMEM (Cannot allocate memory)
          xor       rax, rax                      ; rax = 0
          ret                                     ; return rax
_exit:
          mov       byte [rax + rcx], NULL_CHAR   ; (1 byte) rax[rcx] = '\0'
          ret                                     ; return rax
