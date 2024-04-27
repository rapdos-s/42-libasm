/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   puterror.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:22:40 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/24 02:22:06 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

void	puterror(void)
{
	putf("[ %sER%s ] ", RED, RESET_COLOR);
	putf("%s: %s\n", g_ctrl.test, g_ctrl.error_str);
}
