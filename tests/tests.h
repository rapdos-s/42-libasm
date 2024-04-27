/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   tests.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/17 08:41:23 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/27 13:50:43 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef TESTS_H
# define TESTS_H

// System libraries ////////////////////////////////////////////////////////////

// functions: isalpha()
# include <ctype.h>

// variables: errno
# include <errno.h>

// functions: setjmp() longjmp()
// types: jmp_buf
# include <setjmp.h>

// functions: signal()
// macros: SIGINT SIGSEGV
# include <signal.h>

// functions: va_arg() va_start()
// types: va_list
# include <stdarg.h>

// functions: free()
# include <stdlib.h>

// functions: strcmp() strcmp() strlen()
# include <string.h>

// functions: close() pipe() read() write()
// types: size_t ssize_t
# include <unistd.h>

// Project libraries ///////////////////////////////////////////////////////////

// functions: ft_read() ft_strcmp() ft_strdup() ft_strcpy() ft_strlen()
//            ft_write()
# include <libasm.h>

// functions: ft_atoi_base() ft_create_elem() ft_list_push_front()
//            ft_list_remove_if() ft_list_size() ft_list_sort()
# include <libasm_bonus.h>

// Common Macros ///////////////////////////////////////////////////////////////

# ifndef FALSE
#  define FALSE 0
# endif // FALSE

# ifndef TRUE
#  define TRUE 1
# endif // TRUE

# ifndef FAIL
#  define FAIL -1
# endif // FAIL

# ifndef SUCCESS
#  define SUCCESS 0
# endif // SUCCESS

// File Descriptor Macros //////////////////////////////////////////////////////

# ifndef STDIN_FILENO
#  define STDIN_FILENO 0
# endif // STDIN_FILENO

# ifndef STDOUT_FILENO
#  define STDOUT_FILENO 1
# endif // STDOUT_FILENO

# ifndef STDERR_FILENO
#  define STDERR_FILENO 2
# endif // STDERR_FILENO

// Color Macros ////////////////////////////////////////////////////////////////

# ifndef RED
#  define RED "\033[0;31m"
# endif // RED

# ifndef GREEN
#  define GREEN "\033[0;32m"
# endif // GREEN

# ifndef YELLOW
#  define YELLOW "\033[0;33m"
# endif // YELLOW

# ifndef BLUE
#  define BLUE "\033[0;34m"
# endif // BLUE

# ifndef PURPLE
#  define PURPLE "\033[0;35m"
# endif // PURPLE

# ifndef CYAN
#  define CYAN "\033[0;36m"
# endif // CYAN

# ifndef RESET_COLOR
#  define RESET_COLOR "\033[0m"
# endif // RESET_COLOR

# ifndef MANDATORY_COLOR
#  define MANDATORY_COLOR BLUE
# endif // MANDATORY_COLOR

# ifndef BONUS_COLOR
#  define BONUS_COLOR PURPLE
# endif // BONUS_COLOR

// Error Values Macros /////////////////////////////////////////////////////////

// Error value: Bad file descriptor
# ifndef EBADF
#  define EBADF 9
# endif // EBADF

// Error value: Cannot allocate memory
# ifndef ENOMEM
#  define ENOMEM 12
# endif // ENOMEM

// Error value: Invalid Argument
# ifndef EINVAL
#  define EINVAL 22
# endif // EINVAL

// Select Tests Macros /////////////////////////////////////////////////////////

# ifndef TEST_MANDATORY
#  define TEST_MANDATORY TRUE
# endif // TEST_MANDATORY

# ifndef TEST_BONUS
#  define TEST_BONUS TRUE
# endif // TEST_BONUS


// Other Macros ////////////////////////////////////////////////////////////////

// Limit the header and footer line size
# ifndef LINE_MAX_SIZE
#  define LINE_MAX_SIZE 80
# endif // LINE_MAX_SIZE

# ifndef MANDATORY_SYMBOL
#  define MANDATORY_SYMBOL '#'
# endif // MANDATORY_SYMBOL

# ifndef BONUS_SYMBOL
#  define BONUS_SYMBOL '+'
# endif // BONUS_SYMBOL

// Structs and global variables ////////////////////////////////////////////////

typedef struct s_ctrl
{
	char	*test;
	char	*error_str;
	jmp_buf	jmp_buffer;
}	t_ctrl;

extern t_ctrl	g_ctrl;

// Mandatory Test Functions ////////////////////////////////////////////////////

void	ft_strlen_tests(void);
void	ft_strcpy_tests(void);
void	ft_strcmp_tests(void);
void	ft_write_tests(void);
void	ft_read_tests(void);
void	ft_strdup_tests(void);

// Bonus Test Functions ////////////////////////////////////////////////////////

void	ft_atoi_base_tests(void);
void	ft_list_push_front_tests(void);
void	ft_list_size_tests(void);
void	ft_list_sort_tests(void);
void	ft_list_remove_if_tests(void);
void	ft_create_elem_tests(void);

// Util Functions //////////////////////////////////////////////////////////////

void	free_fct(void *data);
void	free_list(t_list *begin);
void	puterror(void);
void	putf(const char *s, ...);
void	putheader(const char *s, const char *color, char c);
void	putrawstr(const char *s, size_t size);
void	putrawstrquotes(const char *s, size_t size);
void	putstrquotes(const char *str);
char	*safe_strdup(const char *elem);
void	sigsegv_handler(int signum);

#endif // TESTS_H
