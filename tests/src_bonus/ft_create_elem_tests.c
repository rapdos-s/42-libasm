/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_create_elem_tests.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:17 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 23:44:47 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(char *elems[], size_t elems_size);
static void	print(t_list *cur, t_list *beg, char *elems[], size_t elems_size);
static int	check(t_list *begin_list, char *elems[], size_t elems_size);

void	ft_create_elem_tests(void)
{
	putheader(__FILE__, BONUS_COLOR, BONUS_SYMBOL);
	g_ctrl.test = "ft_create_elem";
	test((char *[]){"Hi, 42!"}, 1);
	test((char *[]){NULL}, 1);
	test((char *[]){"1", NULL, "2"}, 3);
}

static void	test(char *elems[], size_t elems_size)
{
	size_t	i;
	t_list	*current_elem;
	t_list	*begin_list;

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
	if (check(begin_list, elems, elems_size) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	print(begin_list, begin_list, elems, elems_size);
	free_list(begin_list);
}

static void	print(t_list *cur, t_list *beg, char *elems[], size_t elems_size)
{
	size_t	i;

	i = 0;
	putf("errno = %i | [", errno);
	while (i < elems_size)
	{
		putstrquotes((char *)cur -> data);
		cur = cur -> next;
		i++;
		if (i < elems_size)
			putf(", ");
	}
	if (i < elems_size)
		putstrquotes(NULL);
	putf("] = ft_create_elem({");
	cur = beg;
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

static int	check(t_list *begin_list, char *elems[], size_t elems_size)
{
	size_t	i;

	i = 0;
	while (i < elems_size && begin_list != NULL)
	{
		if (elems[i] == NULL && begin_list -> data != NULL)
			return (FAIL);
		if (elems[i] != NULL && begin_list -> data == NULL)
			return (FAIL);
		if ((elems[i] != NULL && begin_list -> data != NULL) && \
			strcmp(elems[i], begin_list -> data) != 0)
			return (FAIL);
		begin_list = begin_list -> next;
		i++;
	}
	if (begin_list != NULL)
		return (FAIL);
	return (SUCCESS);
}
