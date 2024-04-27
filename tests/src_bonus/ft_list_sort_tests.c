/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_sort_tests.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:25 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/27 04:05:06 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(char *elems[], char *sorted_elems[], size_t elems_size);
static int	check(t_list *begin_list, char *sorted_elems[], size_t elems_size);
static void	print(t_list *cur, t_list *beg, char *elems[], size_t elems_size);

void	ft_list_sort_tests(void)
{
	putheader(__FILE__, BONUS_COLOR, BONUS_SYMBOL);
	g_ctrl.test = "ft_list_sort";
	test((char *[]){NULL}, (char *[]){NULL}, 1);
	test((char *[]){"A", "B", "C"}, (char *[]){"A", "B", "C"}, 3);
	test((char *[]){"42", "84", "21"}, (char *[]){"21", "42", "84"}, 3);
	test((char *[]){"foo", "bar", "baz"}, (char *[]){"bar", "baz", "foo"}, 3);
}

static void	test(char *elems[], char *sorted_elems[], size_t elems_size)
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
	ft_list_sort(&begin_list, strcmp);
	if (check(begin_list, sorted_elems, elems_size) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	print(begin_list, begin_list, elems, elems_size);
	free_list(begin_list);
}

static int	check(t_list *begin_list, char *sorted_elems[], size_t elems_size)
{
	size_t	i;

	i = 0;
	while (i < elems_size && begin_list != NULL)
	{
		if ((begin_list -> data != NULL && sorted_elems[i] != NULL) && \
			strcmp(begin_list -> data, sorted_elems[i]) != 0)
			return (FAIL);
		begin_list = begin_list -> next;
		i++;
	}
	return (SUCCESS);
}

static void	print(t_list *cur, t_list *beg, char *elems[], size_t elems_size)
{
	size_t	i;

	putf("errno = %i | [", errno);
	i = 0;
	while (i < elems_size && cur != NULL)
	{
		putstrquotes((char *)cur -> data);
		cur = cur -> next;
		i++;
		if (i < elems_size)
			putf(", ");
	}
	if (i < elems_size)
		putstrquotes(NULL);
	putf("] | ft_list_push_front({");
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
