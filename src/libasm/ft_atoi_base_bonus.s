;         int       ft_atoi_base(const char *ptr, const char *base);
;         rax       ft_atoi_base(rdi, rsi, rdx);
          global    ft_atoi_base

          extern    __errno_location              ; declare &errno

          section   .data
EINVAL    EQU       22                            ; Error value: Invalid Argument
NULL_CHAR EQU       0                             ; Character '\0' (null character)
HORIZ_TAB EQU       9                             ; Character '\t' (horizontal tab)
NEW_LINE  EQU       10                            ; Character '\n' (newline)
VERT_TAB  EQU       11                            ; Character '\v' (vertical tab)
FORM_FEED EQU       12                            ; Character '\f' (form-feed)
CARR_RET  EQU       13                            ; Character '\r' (carriage return)
SPACE     EQU       32                            ; Character ' ' (Space)
PLUS      EQU       43                            ; Character '+' (Plus Signal)
MINUS     EQU       45                            ; Character '-' (Minus Signal)
ZERO      EQU       48                            ; Character '0' (Numeral Zero)

          section   .text
ft_atoi_base:
          xor       rax, rax                      ; rax = 0
          xor       rbx, rbx                      ; rbx = 0
          xor       rcx, rcx                      ; rcx = 0
          xor       rdx, rdx                      ; rdx = 0
_check_rdi:
          test      rdi, rdi                      ; test rdi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rdi == NULL
_check_rsi:
          test      rsi, rsi                      ; test rsi == NULL
          jz        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi == NULL
_check_size_on_rsi:
          cmp       byte [rsi], NULL_CHAR         ; compare (1 byte) rsi[0] to '\0'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[0] == '\0'
          cmp       byte [rsi + 1], NULL_CHAR     ; compare (1 byte) rsi[1] to '\0'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[1] == '\0'
_check_duplicates_on_rsi:
          xor       rax, rax                      ; rax = 0
          xor       rbx, rbx                      ; rbx = 0
          xor       r8b, r8b                      ; r8b = 0
_bigger_loop_check_dups:
          cmp       byte [rsi + rax], NULL_CHAR   ; compare (1 byte) rsi[rax] to '\0'
          je        _end_bigger_loop_check_dups   ; jump to _end_bigger_loop_check_dups if rsi[rax] == '\0'
          mov       r8b, [rsi + rax]              ; r8b = rsi[rax]
          mov       rbx, rax                      ; rbx = rax
          inc       rbx                           ; rbx++
_smaller_loop_check_dups:
          cmp       byte [rsi + rbx], NULL_CHAR   ; compare (1 byte) rsi[rbx] to '\0'
          je        _end_smaller_loop_check_dups  ; jump to _end_smaller_loop_check_dups if rsi[rbx] == '\0'
          cmp       r8b, [rsi + rbx]              ; compare r8b to rsi[rbx]
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if r8b == rsi[rbx]
          inc       rbx                           ; rbx++
          jmp       _smaller_loop_check_dups      ; jump to _smaller_loop_check_dups
_end_smaller_loop_check_dups:
          inc       rax                           ; rax++
          jmp       _bigger_loop_check_dups       ; jump to _bigger_loop_check_dups
_end_bigger_loop_check_dups:
          xor       rax, rax                      ; rax = 0
          xor       rbx, rbx                      ; rbx = 0
_check_invalid_chars_on_rsi:
          xor       rax, rax                      ; rax = 0
_loop_check_invalid_chars:
          cmp       byte [rsi + rax], NULL_CHAR   ; compare (1 byte) rsi[rax] to '\0'
          je        _end_loop_check_invalid_chars ; jump to _end_loop_check_invalid_chars if rsi[rax] == '\0'
          cmp       byte [rsi + rax], HORIZ_TAB   ; compare (1 byte) rsi[rax] to '\t'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == '\t'
          cmp       byte [rsi + rax], NEW_LINE    ; compare (1 byte) rsi[rax] to 'NEW_LINE'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == '\n'
          cmp       byte [rsi + rax], VERT_TAB    ; compare (1 byte) rsi[rax] to 'VERT_TAB'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == '\v'
          cmp       byte [rsi + rax], FORM_FEED   ; compare (1 byte) rsi[rax] to 'FORM_FEED'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == '\f'
          cmp       byte [rsi + rax], CARR_RET    ; compare (1 byte) rsi[rax] to 'CARR_RET'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == '\r'
          cmp       byte [rsi + rax], SPACE       ; compare (1 byte) rsi[rax] to 'SPACE'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == ' '
          cmp       byte [rsi + rax], PLUS        ; compare (1 byte) rsi[rax] to 'PLUS'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == '+'
          cmp       byte [rsi + rax], MINUS       ; compare (1 byte) rsi[rax] to 'MINUS'
          je        _exit_on_EINVAL               ; jump to _exit_on_EINVAL if rsi[rax] == '-'
          inc       rax                           ; rax++
          jmp       _loop_check_invalid_chars     ; jump to _loop_check_invalid_chars
_end_loop_check_invalid_chars:
          xor       rax, rax                      ; rax = 0
_jump_whitespaces:
          xor       rbx, rbx                      ; rbx = 0
_loop_jump_whitespaces:
          cmp       byte [rdi + rbx], NULL_CHAR   ; compare (1 byte) rdi[rbx] to '\0'
          je        _end_jump_whitespaces         ; jump to _end_jump_whitespaces if rdi[rbx] == '\0'
          cmp       byte [rdi + rbx], HORIZ_TAB   ; compare (1 byte) rdi[rbx] to '\t'
          je        _inc_jump_whitespaces         ; jump to _inc_jump_whitespaces if rdi[rbx] == '\t'
          cmp       byte [rdi + rbx], NEW_LINE    ; compare (1 byte) rdi[rbx] to 'NEW_LINE'
          je        _inc_jump_whitespaces         ; jump to _inc_jump_whitespaces if rdi[rbx] == '\n'
          cmp       byte [rdi + rbx], VERT_TAB    ; compare (1 byte) rdi[rbx] to 'VERT_TAB'
          je        _inc_jump_whitespaces         ; jump to _inc_jump_whitespaces if rdi[rbx] == '\v'
          cmp       byte [rdi + rbx], FORM_FEED   ; compare (1 byte) rdi[rbx] to 'FORM_FEED'
          je        _inc_jump_whitespaces         ; jump to _inc_jump_whitespaces if rdi[rbx] == '\f'
          cmp       byte [rdi + rbx], CARR_RET    ; compare (1 byte) rdi[rbx] to 'CARR_RET'
          je        _inc_jump_whitespaces         ; jump to _inc_jump_whitespaces if rdi[rbx] == '\r'
          cmp       byte [rdi + rbx], SPACE       ; compare (1 byte) rdi[rbx] to 'SPACE'
          je        _inc_jump_whitespaces         ; jump to _inc_jump_whitespaces if rdi[rbx] == ' '
          jmp       _end_jump_whitespaces         ; jump to _end_jump_whitespaces
_inc_jump_whitespaces:
          inc       rbx                           ; rbx++
          jmp       _loop_jump_whitespaces        ; jump to _loop_jump_whitespaces
_end_jump_whitespaces:
_calculate_signal:
          xor       rcx, rcx                      ; rcx = 0
          inc       rcx                           ; rcx++
_loop_calculate_signal:
          cmp       byte [rdi + rbx], NULL_CHAR   ; compare (1 byte) rdi[rbx] to '\0'
          je        _end_loop_calculate_signal    ; jump to _end_loop_calculate_signal if rdi[rbx] == '\0'
          cmp       byte [rdi + rbx], PLUS        ; compare (1 byte) rdi[rbx] to '+'
          je        _inc_loop_calculate_signal    ; jump to _inc_loop_calculate_signal if rdi[rbx] == '+'
          cmp       byte [rdi + rbx], MINUS       ; compare (1 byte) rdi[rbx] to '-'
          jne       _end_loop_calculate_signal    ; jump to _end_loop_calculate_signal if rdi[rbx] != '-'
_invert_signal:
          neg       rcx                           ; rcx *= -1
_inc_loop_calculate_signal:
          inc       rbx                           ; rbx++
          jmp       _loop_calculate_signal        ; jump to _loop_calculate_signal
_end_loop_calculate_signal:
_calculate_base:
          xor       rdx, rdx                      ; rdx = 0
_loop_calculate_base:
          cmp       byte [rsi + rdx], NULL_CHAR   ; compare (1 byte) rsi[0] to '\0'
          je        _end_loop_calculate_base      ; jump to _end_loop_calculate_base if rsi[rdx] == '\0'
          inc       rdx                           ; rdx++
          jmp       _loop_calculate_base          ; jump to _end_loop_calculate_base
_end_loop_calculate_base:
_calculate_value:
          xor       rax, rax                      ; rax = 0
_bigger_loop_calc_value:
          cmp       byte [rdi + rbx], NULL_CHAR   ; compare (1 byte) rdi[rbx] to '\0'
          je        _end_bigger_loop_calc_value   ; jump to _end_bigger_loop_calc_value if rdi[rbx] == '\0'
          xor       r8b, r8b                      ; r8b = 0
          mov       r8b, [rdi + rbx]              ; r8b = rdi[rbx]
          xor       r9, r9                        ; r9 = 0
_smaller_loop_calc_value:
          cmp       byte [rsi + r9], NULL_CHAR    ; compare (1 byte) rsi[r9] to '\0'
          je        _end_bigger_loop_calc_value   ; jump to _end_bigger_loop_calc_value if rsi[r9] == '\0'
          cmp       r8b, [rsi + r9]               ; compare r8b to rsi[r9]
          je        _end_smaller_loop_calc_value  ; jump to _end_smaller_loop_calc_value if r8b == rsi[r9]
          inc       r9                            ; r9++
          jmp       _smaller_loop_calc_value      ; jump to _smaller_loop_calc_value
_end_smaller_loop_calc_value:
          imul      rax, rdx                      ; rax *= rdx
          add       rax, r9                       ; rax += r9
          inc       rbx                           ; rbx++
          jmp       _bigger_loop_calc_value       ; jump to _bigger_loop_calc_value
_end_bigger_loop_calc_value:
_set_signal:
          imul      rax, rcx                      ; rax *= rcx
          jmp       _exit                         ; jump to _exit

_exit_on_EINVAL:
          call      __errno_location              ; rax = &errno
          mov       dword [rax], EINVAL           ; (4 bytes) *rax = EINVAL (Invalid Argument)
          xor       rax, rax                      ; rax = 0
          ret                                     ; return rax

_exit:
          ret                                     ; return rax
