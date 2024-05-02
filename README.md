# 42-libasm
Minha versão da reimplementação de funções básicas da linguagem C em Assembly.

O que precisa?
nasm
cc
make
ar
rm

Como usar:

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