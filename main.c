/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/20 06:20:27 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/27 13:49:47 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	setup_environment(void);
static void	close_fds(void);

int	main(void)
{
	setup_environment();
	if (setjmp(g_ctrl.jmp_buffer) == 0)
	{
		if (TEST_MANDATORY)
		{
			ft_strlen_tests();
			ft_strcpy_tests();
			ft_strcmp_tests();
			ft_write_tests();
			ft_read_tests();
			ft_strdup_tests();
		}
		if (TEST_BONUS)
		{
			ft_atoi_base_tests();
			ft_create_elem_tests();
			ft_list_push_front_tests();
			ft_list_size_tests();
			ft_list_sort_tests();
			ft_list_remove_if_tests();
		}
	}
	close_fds();
	return (0);
}

static void	setup_environment(void)
{
	g_ctrl.test = NULL;
	g_ctrl.error_str = NULL;
	signal(SIGINT, sigsegv_handler);
	signal(SIGSEGV, sigsegv_handler);
}

static void	close_fds(void)
{
	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);
}
