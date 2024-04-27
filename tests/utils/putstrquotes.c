/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   putstrquotes.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 19:26:29 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 02:41:55 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

void	putstrquotes(const char *str)
{
	if (str != NULL)
	{
		putf("\"");
		putf(str);
		putf("\"");
	}
	else
		putf("NULL");
}
