/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strcpy_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/07 18:01:44 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/11/07 20:21:00 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../libasm/libasm.h"
#include "tests.h"

static void	test(char *dst, const char *src);

void	ft_strcpy_test(void)
{
	printf("# ft_strcpy tests ######################");
	printf("########################################\n\n");

	// test("12345", "ABCDE");
	// test("12345", "ABC");
	// test("", "");
	// test(NULL, "ABCDE");
	test("12345", NULL);

	printf("\n########################################");
	printf("########################################\n");
}

static void	test(char *dst, const char *src)
{
	char	*heap_dst;
	char	*return_ptr;

	heap_dst = NULL;
	heap_dst = (char *)malloc(ft_strlen(dst) + 1);

	ft_write(1, "dst before : ", 13);
	ft_write(1, dst, ft_strlen(dst));
	ft_write(1, "\n", 1);

	ft_write(1, "src        : ", 13);
	ft_write(1, src, ft_strlen(src));
	ft_write(1, "\n", 1);

	errno = 0;
	return_ptr = ft_strcpy(heap_dst, src);

	ft_write(1, "dst after  : ", 13);
	ft_write(1, heap_dst, ft_strlen(heap_dst));
	ft_write(1, "\n", 1);

	ft_write(1, "return_ptr : ", 13);
	ft_write(1, return_ptr, ft_strlen(return_ptr));
	ft_write(1, "\n", 1);

	printf("errno      : %i\n", errno);
	free(heap_dst);
	printf("\n");
}
