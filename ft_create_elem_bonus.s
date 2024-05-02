;         t_list    *ft_create_elem(void *data);
;         rax       ft_create_elem(rdi);
          global    ft_create_elem

          extern    __errno_location              ; declare &errno
          extern    malloc                        ; declare malloc()

          section   .data
NULL      EQU       0                             ; NULL
ENOMEM    EQU       12                            ; Error value: Cannot allocate memory
LIST_SIZE EQU       16                            ; t_list size
DATA_POS  EQU       0                             ; t_list.data
NEXT_POS  EQU       8                             ; t_list.next

          section   .text
ft_create_elem:
          mov       rbx, rdi                      ; rbx = rdi (data)
          mov       rdi, LIST_SIZE                ; rdi = sizeof(t_list)
          call      malloc                        ; rax = malloc(rdi)
          test      rax, rax                      ; test rax == NULL
          jz        _exit_on_ENOMEM               ; jump to _exit_on_ENOMEM if rax == NULL
          mov       [rax + DATA_POS], rbx         ; rax.data = rbx (data)
          mov       qword [rax + NEXT_POS], NULL  ; (8 bytes) rax.next = NULL
          jmp       _exit                         ; jump to _exit

_exit_on_ENOMEM:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], ENOMEM           ; (4 bytes) *rax = ENOMEM (Cannot allocate memory)
          xor       rax, rax                      ; rax = NULL
          ret                                     ; return rax

_exit:
          ret                                     ; return rax
