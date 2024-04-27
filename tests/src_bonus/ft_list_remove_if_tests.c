/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_remove_if_tests.c                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:21 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/27 03:48:49 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(char *elems[], char *data_ref, char *results[], size_t size[]);
static int	check(t_list *begin_list, char *results[], size_t size[]);
static void	print(t_list *cur, char *e[], char *data_ref, size_t size[]);

void	ft_list_remove_if_tests(void)
{
	putheader(__FILE__, BONUS_COLOR, BONUS_SYMBOL);
	g_ctrl.test = "ft_list_remove_if";
	test((char *[]){"ABC", "123", "ABCDEF"}, \
		"ABC", (char *[]){"123", "ABCDEF"}, (size_t []){3, 2});
	test((char *[]){"ABC", "123", "ABCDEF"}, \
		"ABCDEF", (char *[]){"ABC", "123"}, (size_t []){3, 2});
	test((char *[]){"ABC", "ABC", "123"}, \
		"ABC", (char *[]){"123"}, (size_t []){3, 1});
	test((char *[]){"ABC", "ABC", "ABC"}, \
		"ABC", NULL, (size_t []){3, 0});
	test((char *[]){NULL}, \
		NULL, NULL, (size_t []){1, 1});
}

static void	test(char *elems[], char *data_ref, char *results[], size_t size[])
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
	while (i < size[0])
	{
		current_elem -> next = ft_create_elem(safe_strdup(elems[i]));
		current_elem = current_elem -> next;
		i++;
	}
	ft_list_remove_if(&begin_list, (void *)data_ref, strcmp, free_fct);
	if (check(begin_list, results, size) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	print(begin_list, elems, data_ref, size);
	free_list(begin_list);
	(void) results;
}

static int	check(t_list *begin_list, char *results[], size_t size[])
{
	size_t	i;

	i = 0;
	while (i < size[0] && begin_list != NULL)
	{
		if ((begin_list -> data != NULL && results[i] != NULL) && \
			strcmp(begin_list -> data, results[i]) != 0)
			return (FAIL);
		begin_list = begin_list -> next;
		i++;
	}
	return (SUCCESS);
}

static void	print(t_list *cur, char *e[], char *data_ref, size_t size[])
{
	size_t	i;

	putf("ft_list_remove_if({");
	i = 0;
	while (i < size[0])
	{
		putstrquotes(e[i]);
		i++;
		if (i < size[0])
			putf(", ");
	}
	putf("}, ");
	putstrquotes(data_ref);
	putf(", strcmp, free_elem);\n");
	i = 0;
	putf("       errno = %i | [", errno);
	while (i < size[1])
	{
		putstrquotes((char *)cur -> data);
		cur = cur -> next;
		i++;
		if (i < size[1])
			putf(", ");
	}
	putf("]\n\n");
}
