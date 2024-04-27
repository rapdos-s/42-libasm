/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   free_list.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/25 22:35:13 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:57:48 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

void	free_list(t_list *begin)
{
	t_list	*next_elem;

	if (begin == NULL)
		return ;
	while (begin != NULL)
	{
		next_elem = begin -> next;
		free (begin -> data);
		free (begin);
		begin = next_elem;
	}
}
