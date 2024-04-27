/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_read_tests.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/18 22:26:42 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:42:59 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(char *buf, ssize_t count, int check_fd, int check_null);
static int	init_values(int buffer_fd[2], char *buffer, int *fd, int check_fd);
static int	check(const char *buffer, int fd, ssize_t ret, ssize_t count);
static int	check_buffer(const char *buf, const char *buffer, ssize_t count);

void	ft_read_tests(void)
{
	putheader(__FILE__, MANDATORY_COLOR, MANDATORY_SYMBOL);
	g_ctrl.test = "ft_read";
	test("Hello, 42!", 10, FALSE, FALSE);
	test("Hello, 42!", 11, FALSE, FALSE);
	test("Hello\0, 42!", 12, FALSE, FALSE);
	test("Hello, 42!", 11, TRUE, FALSE);
	test("Hello, 42!", 10, FALSE, TRUE);
	test("", 1, FALSE, FALSE);
}

static void	test(char *buf, ssize_t count, int check_fd, int check_null)
{
	char	stack_buffer[16];
	char	*buffer;
	int		buffer_fd[2];
	int		fd;
	ssize_t	ret;

	fd = 0;
	if (init_values(buffer_fd, stack_buffer, &fd, check_fd) == FAIL)
		return ;
	buffer = stack_buffer;
	if (check_null == TRUE)
		buffer = NULL;
	if (check_fd == FALSE)
		write(buffer_fd[1], buf, count);
	ret = ft_read(fd, buffer, count);
	close(buffer_fd[1]);
	close(buffer_fd[0]);
	if (check(buffer, fd, ret, count) == FAIL || \
		check_buffer(buf, buffer, count) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	putf("errno = %i | %i = ft_read(%i, ", errno, (int) ret, fd);
	putrawstrquotes(buffer, count);
	putf(", %i);\n", (int) count);
}

static int	init_values(int buffer_fd[2], char *buffer, int *fd, int check_fd)
{
	ssize_t	i;
	int		ret;

	errno = 0;
	buffer_fd[0] = 0;
	buffer_fd[1] = 0;
	i = 0;
	while (i < 16)
	{
		buffer[i] = '\0';
		i++;
	}
	ret = pipe(buffer_fd);
	if (ret == FAIL)
	{
		g_ctrl.error_str = "pipe failed";
		puterror();
	}
	*fd = buffer_fd[0];
	if (check_fd == TRUE)
		*fd = 4242;
	return (ret);
}

static int	check(const char *buffer, int fd, ssize_t ret, ssize_t count)
{
	if (errno == 0 && ret != count)
		return (FAIL);
	if (buffer == NULL && (errno != EINVAL || ret != FAIL))
		return (FAIL);
	if (fd >= 1024 && (errno != EBADF || ret != FAIL))
		return (FAIL);
	if (errno != 0 && ret != FAIL)
		return (FAIL);
	return (SUCCESS);
}

static int	check_buffer(const char *buf, const char *buffer, ssize_t count)
{
	ssize_t	i;

	if (buf != NULL && buffer != NULL)
	{
		i = 0;
		while ((i < count) && (buffer[i] == buf[i]))
			i++;
		i--;
		if (buffer[i] != buf[i])
			return (FAIL);
	}
	return (SUCCESS);
}
