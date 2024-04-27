/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sigsegv_handler.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:23:45 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:52:16 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

t_ctrl	g_ctrl;

void	sigsegv_handler(int signum)
{
	g_ctrl.error_str = "Unknown signal error";
	if (signum == SIGSEGV)
		g_ctrl.error_str = "Segmentation fault detected";
	if (signum == SIGINT)
		g_ctrl.error_str = "Signal Interrupt detected";
	puterror();
	longjmp(g_ctrl.jmp_buffer, 1);
}
