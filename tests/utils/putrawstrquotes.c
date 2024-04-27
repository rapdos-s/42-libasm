/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   putrawstrquotes.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 19:26:29 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/24 02:42:54 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

void	putrawstrquotes(const char *str, size_t size)
{
	if (str != NULL)
	{
		putf("\"");
		putrawstr(str, size);
		putf("\"");
	}
	else
		putf("NULL");
}
