/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   safe_strdup.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/26 23:44:22 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 23:44:39 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

char	*safe_strdup(const char *elem)
{
	char	*str;

	str = NULL;
	if (elem != NULL)
		str = strdup(elem);
	return (str);
}
