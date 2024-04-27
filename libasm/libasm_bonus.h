/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm_bonus.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/17 07:38:57 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/27 02:33:20 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_BONUS_H
# define LIBASM_BONUS_H

// System libraries ////////////////////////////////////////////////////////////

// variables: errno
# include <errno.h>

// functions: free(), malloc()
# include <stdlib.h>

// Structs /////////////////////////////////////////////////////////////////////

// data: The data contained in the node.
// next: The address of the next node, or NULL if the node is the last one.
typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

// Libasm Bonus Functions //////////////////////////////////////////////////////

// Necessary for the function ft_list_push_front()
extern t_list	*ft_create_elem(void *data);

extern int		ft_atoi_base(const char *ptr, const char *base);
extern void		ft_list_push_front(t_list **begin_list, void *data);
extern int		ft_list_size(t_list *begin_list);
extern void		ft_list_sort(t_list **begin_list, int (*cmp)());
extern void		ft_list_remove_if(
					t_list **begin_list,
					void *data_ref,
					int (*cmp)(),
					void (*free_fct)(void *)
					);

#endif // LIBASM_BONUS_H
