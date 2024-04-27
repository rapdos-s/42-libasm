/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   putheader.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:54 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 15:37:37 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

void	putheader(const char *s, const char *color, char c)
{
	size_t	length;
	size_t	line_length;

	length = 0;
	line_length = LINE_MAX_SIZE;
	if (s != NULL)
	{
		while (s[length] != '\0')
			length++;
		putf("%s%c %s ", color, c, s);
		line_length = line_length - length - 3;
	}
	while (line_length--)
		putf("%c", c);
	putf("%s\n", RESET_COLOR);
}
