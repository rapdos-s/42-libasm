/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_push_front_tests.c                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:20 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 23:51:08 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(char *elems[], size_t elems_size);
static int	check(t_list *begin_list, char *elems[], size_t elems_size);
static void	print(t_list *curr, t_list *beg, char *elems[], size_t elems_size);

void	ft_list_push_front_tests(void)
{
	putheader(__FILE__, BONUS_COLOR, BONUS_SYMBOL);
	g_ctrl.test = "ft_list_push_front";
	test((char *[]){"Hi, 42!"}, 1);
	test((char *[]){NULL}, 1);
	test((char *[]){"1", NULL, "2"}, 3);
}

static void	test(char *elems[], size_t elems_size)
{
	size_t	i;
	t_list	*begin_list;

	errno = 0;
	begin_list = NULL;
	i = 0;
	while (i < elems_size)
	{
		ft_list_push_front(&begin_list, safe_strdup(elems[i]));
		i++;
	}
	if (check(begin_list, elems, elems_size) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	print(begin_list, begin_list, elems, elems_size);
	free_list(begin_list);
}

static int	check(t_list *begin_list, char *elems[], size_t elems_size)
{
	size_t	i;

	i = 0;
	while (i < elems_size && begin_list != NULL)
	{
		i++;
		if (elems[elems_size - i] == NULL && begin_list -> data != NULL)
			return (FAIL);
		if (elems[elems_size - i] != NULL && begin_list -> data == NULL)
			return (FAIL);
		if ((elems[elems_size - i] != NULL && begin_list -> data != NULL) && \
			strcmp(elems[elems_size - i], begin_list -> data) != 0)
			return (FAIL);
		begin_list = begin_list -> next;
	}
	if (errno == EINVAL && begin_list != NULL)
		return (FAIL);
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
