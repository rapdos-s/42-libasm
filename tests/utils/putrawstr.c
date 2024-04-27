/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   putrawstr.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:23:53 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/24 08:29:32 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

void	putrawstr(const char *s, size_t size)
{
	size_t	i;

	i = 0;
	while (size--)
	{
		if (s[i] == '\t')
			putf("\\t");
		else if (s[i] == '\n')
			putf("\\n");
		else if (s[i] == '\\')
			putf("\\\\");
		else if (s[i] == '\'')
			putf("\\\'");
		else if (s[i] == '\"')
			putf("\\\"");
		else if (s[i] == '\0')
			putf("\\0");
		else
			putf("%c", s[i]);
		i++;
	}
}
