/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base_tests.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:15 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:42:09 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(const char *ptr, const char *base, int expec_ret);
static int	check(const char *ptr, const char *base, int expec_ret, int ret);

void	ft_atoi_base_tests(void)
{
	putheader(__FILE__, BONUS_COLOR, BONUS_SYMBOL);
	g_ctrl.test = "ft_atoi_base";
	test(" ---+--+1234ab567", "0123456789", -1234);
	test(NULL, "42", 0);
	test("42", NULL, 0);
	test("42", "", 0);
	test("42", "0", 0);
	test("42", "01234567890ABC", 0);
	test("42", "0123456789\tABC", 0);
	test("42", "0123456789 ABC", 0);
	test("42", "0123456789+ABC", 0);
	test("42", "0123456789-ABC", 0);
	test("42", "1", 0);
	test("10.101010101010", "0123456789", 10);
	test("", "0123456789", 0);
	test("101010", "01", 42);
	test("42ABC", "0123456789ABCDEF", 273084);
	test("42abc", "0123456789abcdef", 273084);
	test("42", "0123456789", 42);
	test("-42", "0123456789", -42);
	test("-2147483648", "0123456789", -2147483648);
	test("2147483647", "0123456789", 2147483647);
	test("00000000000010", "0123456789", 10);
}

static void	test(const char *ptr, const char *base, int expec_ret)
{
	int	ret;

	errno = 0;
	ret = ft_atoi_base(ptr, base);
	if (check(ptr, base, expec_ret, ret) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	putf("errno = %i | %i = ft_atoi_base(", errno, ret);
	putstrquotes(ptr);
	putf(", ");
	putstrquotes(base);
	putf(");\n", errno, ret, ptr, base);
}

static int	check(const char *ptr, const char *base, int expec_ret, int ret)
{
	if (errno == 0 && ret != expec_ret)
		return (FAIL);
	if ((ptr == NULL || base == NULL) && errno != EINVAL)
		return (FAIL);
	if ((ptr == NULL || base == NULL) && ret != 0)
		return (FAIL);
	return (SUCCESS);
}
