/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcpy_tests.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/17 15:54:53 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:43:13 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(char *dst, const char *src, size_t size);
static int	check(char *dst, const char *src);

void	ft_strcpy_tests(void)
{
	char	dst[9];

	putheader(__FILE__, MANDATORY_COLOR, MANDATORY_SYMBOL);
	g_ctrl.test = "ft_strcpy";
	test(dst, "Hello 42!", 9);
	test(NULL, "Hello 42!", 9);
	test(dst, NULL, 0);
	test(NULL, NULL, 0);
	test(dst, "01234", 5);
	test(dst, "\t\n\0\n", 4);
}

static void	test(char *dst, const char *src, size_t size)
{
	char	dst_cpy[9];
	char	*ret;
	size_t	i;

	errno = 0;
	i = 9;
	if (dst != NULL)
		while (i--)
			dst[i] = '\0';
	i = 9;
	while (i--)
		dst_cpy[i] = '\0';
	ret = ft_strcpy(dst, src);
	if (check(dst, src) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	putf("errno = %i | ", errno);
	putrawstrquotes(ret, size);
	putf(" = ft_strcpy(");
	putrawstrquotes(dst_cpy, 9);
	putf(", ");
	putrawstrquotes(src, size);
	putf(");\n");
}

static int	check(char *dst, const char *src)
{
	size_t	i;

	i = 0;
	if (dst != NULL && src != NULL && errno == 0)
	{
		while (dst[i] != '\0' && src[i] != '\0' && dst[i] != src[i])
			i++;
	}
	if (((dst == NULL || src == NULL) && errno != EINVAL))
		return (FAIL);
	if ((dst != NULL && src != NULL) && src[i] != '\0' && dst[i] != src[i])
		return (FAIL);
	return (SUCCESS);
}
