/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcmp_tests.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/17 20:03:55 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:43:09 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(const char *s1, const char *s2, size_t size, int expec_ret);
static int	check(const char *s1, const char *s2, int ret, int expec_ret);

void	ft_strcmp_tests(void)
{
	putheader(__FILE__, MANDATORY_COLOR, MANDATORY_SYMBOL);
	g_ctrl.test = "ft_strcmp";
	test("ABC", "ABC", 3, 0);
	test("ABC\0\0", "ABCDE", 5, -68);
	test("ABCDE", "ABC\0\0", 5, 68);
	test("A", "Z", 1, -25);
	test("\0\0\0", "ABC", 3, -65);
	test("ABC", "\0\0\0", 3, 65);
	test("", "", 0, 0);
	test(NULL, "ABC", 3, 0);
	test("ABC", NULL, 3, 0);
	test(NULL, NULL, 0, 0);
	test("\t\n\0\n\n", "\t\n\0\t\t", 5, 0);
}

static void	test(const char *s1, const char *s2, size_t size, int expec_ret)
{
	int	ret;

	errno = 0;
	ret = ft_strcmp(s1, s2);
	if (check(s1, s2, ret, expec_ret) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	putf("errno = %i | %i = ft_strcmp(", errno, ret);
	putrawstrquotes(s1, size);
	putf(", ");
	putrawstrquotes(s2, size);
	putf(");\n");
}

static int	check(const char *s1, const char *s2, int ret, int expec_ret)
{
	if (((s1 == NULL || s2 == NULL) && errno != EINVAL))
		return (FAIL);
	if (ret != expec_ret)
		return (FAIL);
	return (SUCCESS);
}
