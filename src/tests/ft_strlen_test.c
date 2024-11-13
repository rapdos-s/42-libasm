/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlen_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/07 18:01:44 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/11/07 18:45:49 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../libasm/libasm.h"
#include "tests.h"

static void	test(const char *s);

void	ft_strlen_test(void)
{
	printf("# ft_strlen tests ######################");
	printf("########################################\n\n");

	test("Hello World!");
	test("ABC");
	test("");
	test(NULL);

	printf("\n########################################");
	printf("########################################\n");
}

static void	test(const char *s)
{
	size_t	ft_len;
	size_t	len;

	printf("string: %s\n", s);
	if (s == NULL)
	{
		printf("strlen    | return: [N/A] | errno: [N/A]\n");
		errno = 0;
		ft_len = ft_strlen(s);
		printf("ft_strlen | return: %zu | errno: %i\n", ft_len, errno);
	}
	else
	{
		errno = 0;
		len = strlen(s);
		printf("strlen    | return: %zu | errno: %i\n", len, errno);
		errno = 0;
		ft_len = ft_strlen(s);
		printf("ft_strlen | return: %zu | errno: %i\n", ft_len, errno);
	}
	printf("\n");
}
