/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup_tests.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/18 23:43:45 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:43:19 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(const char *str, size_t size);
static int	check(const char *str, char *ret);

void	ft_strdup_tests(void)
{
	putheader(__FILE__, MANDATORY_COLOR, MANDATORY_SYMBOL);
	g_ctrl.test = "ft_strdup";
	test(NULL, 0);
	test("Hello, 42!", 11);
	test("Hello,\0 42!", 12);
	test("", 1);
}

static void	test(const char *str, size_t size)
{
	char	*ret;

	errno = 0;
	ret = ft_strdup(str);
	if (check(str, ret) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	if (ret == NULL)
		putf("errno = %i | %s = ft_strdup(", errno, "NULL");
	else
		putf("errno = %i | \"%s\" = ft_strdup(", errno, ret);
	putrawstrquotes(str, size);
	putf(");\n");
	free(ret);
}

static int	check(const char *str, char *ret)
{
	size_t	ret_len;

	if (str != NULL && ret == NULL && errno != ENOMEM)
		return (FAIL);
	if (str == NULL && errno != EINVAL)
		return (FAIL);
	if (str != NULL && errno != SUCCESS)
		return (FAIL);
	ret_len = 0;
	if (ret != NULL)
		ret_len = strlen(ret);
	if (strncmp(str, ret, ret_len) != SUCCESS)
		return (FAIL);
	return (SUCCESS);
}
