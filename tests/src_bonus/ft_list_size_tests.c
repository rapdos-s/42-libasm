/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_size_tests.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:23 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 23:48:27 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(char *elems[], int elems_size);
static int	check(int ret, int elems_size);
static void	print(int ret, char *elems[], int elems_size);

void	ft_list_size_tests(void)
{
	putheader(__FILE__, BONUS_COLOR, BONUS_SYMBOL);
	g_ctrl.test = "ft_list_size";
	test((char *[]){"Hi, 42!"}, 1);
	test((char *[]){NULL}, 1);
	test((char *[]){"1", NULL, "2"}, 3);
}

static void	test(char *elems[], int elems_size)
{
	int		i;
	int		ret;
	t_list	*begin_list;
	t_list	*current_elem;

	errno = 0;
	i = 0;
	begin_list = NULL;
	begin_list = ft_create_elem(safe_strdup(elems[0]));
	current_elem = begin_list;
	i++;
	while (i < elems_size)
	{
		current_elem -> next = ft_create_elem(safe_strdup(elems[i]));
		current_elem = current_elem -> next;
		i++;
	}
	ret = ft_list_size(begin_list);
	if (check(ret, elems_size) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	print(ret, elems, elems_size);
	free_list(begin_list);
}

static int	check(int ret, int elems_size)
{
	if (ret != elems_size)
		return (FAIL);
	return (SUCCESS);
}

static void	print(int ret, char *elems[], int elems_size)
{
	int	i;

	i = 0;
	putf("errno = %i | %i = ft_list_size({", errno, ret);
	i = 0;
	while (i < elems_size)
	{
		putstrquotes(elems[i]);
		i++;
		if (i < elems_size)
			putf(", ");
	}
	putf("});\n");
}
