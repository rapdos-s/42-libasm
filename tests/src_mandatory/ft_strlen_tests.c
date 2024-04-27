/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen_tests.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/17 08:25:29 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:43:22 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(const char *s, size_t size, size_t expec_ret);
static int	check(const char *s, size_t ret, size_t expec_ret);

void	ft_strlen_tests(void)
{
	putheader(__FILE__, MANDATORY_COLOR, MANDATORY_SYMBOL);
	g_ctrl.test = "ft_strlen";
	test(NULL, 0, 0);
	test("", 0, 0);
	test("Hello, 42!", 10, 10);
	test("Hello, World!", 13, 13);
	test("\t \n \\ \' \" \0\0\0\t \n \\ \' \" ", 23, 10);
}

static void	test(const char *s, size_t size, size_t expec_ret)
{
	size_t	ret;

	errno = 0;
	ret = ft_strlen(s);
	if (check(s, ret, expec_ret) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	putf("errno = %i | %i = ft_strlen(", errno, (int) ret);
	putrawstrquotes(s, size);
	putf(");\n");
}

static int	check(const char *s, size_t ret, size_t expec_ret)
{
	if (s == NULL && errno != EINVAL)
		return (FAIL);
	if (s != NULL && errno != SUCCESS)
		return (FAIL);
	if (ret != expec_ret)
		return (FAIL);
	return (SUCCESS);
}
