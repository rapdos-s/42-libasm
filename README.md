# 42-libasm
Minha versão da reimplementação de algumas funções básicas da linguagem C em Assembly.

### Como está o andamento desse repositório?

**Mandatório**

- [ ] ft_strlen
- [ ] ft_strcpy
- [ ] ft_strcmp
- [ ] ft_write
- [ ] ft_read
- [ ] ft_strdup

**Bônus**

- [ ] ft_atoi_base
- [ ] ft_list_push_front
- [ ] ft_list_size
- [ ] ft_list_sort
- [ ] ft_list_remove_if

**Outros Pontos**

- [x] ~~Makefile~~

### O que precisa?

- ar
- clang
- echo
- make
- nasm
- rm
- valgrind

### Como usar:

Escreva um teste, exemplo:

`main.c`
```c
#include "libasm.h"

int main(void)
{
    ft_write(1, "Hello, World!\n", 14);
    return (0);
}
```

para compilar a biblioteca, utilize

```sh
make
```

Para compilar a main.c com a biblioteca

```sh
cc main.c -L. -lasm
```

Para executar
```sh
./a.out
```

A saída esperada é essa
```sh
Hello, World!
```