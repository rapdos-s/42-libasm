/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_write_tests.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/18 12:54:02 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/26 17:43:25 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	test(const char *buf, ssize_t count, int check_fd);
static int	init_values(int buffer_fd[2], char *buffer);
static int	check(const char *buf, int fd, ssize_t ret, ssize_t count);
static int	check_buffer(const char *buf, const char *buffer, ssize_t count);

void	ft_write_tests(void)
{
	putheader(__FILE__, MANDATORY_COLOR, MANDATORY_SYMBOL);
	g_ctrl.test = "ft_write";
	test("Hello, 42!", 10, FALSE);
	test("Hello, 42!", 11, FALSE);
	test("Hello\0, 42!", 12, FALSE);
	test("Hello, 42!", 11, TRUE);
	test("", 1, FALSE);
	test(NULL, 1, FALSE);
}

static void	test(const char *buf, ssize_t count, int check_fd)
{
	char	buffer[16];
	int		buffer_fd[2];
	int		fd;
	ssize_t	ret;

	if (init_values(buffer_fd, buffer) == FAIL)
		return ;
	fd = buffer_fd[1];
	if (check_fd == TRUE)
		fd = 4242;
	ret = ft_write(fd, buf, count);
	if (check_fd == FALSE)
		read(buffer_fd[0], buffer, sizeof(buffer));
	close(buffer_fd[1]);
	close(buffer_fd[0]);
	if (check(buf, fd, ret, count) == FAIL || \
		check_buffer(buf, buffer, count) == FAIL)
		putf("[ %sKO%s ] ", YELLOW, RESET_COLOR);
	else
		putf("[ %sOK%s ] ", GREEN, RESET_COLOR);
	putf("errno = %i | %i = ft_write(%i, ", errno, (int) ret, fd);
	putrawstrquotes(buf, count);
	putf(", %i);\n", (int) count);
}

static int	init_values(int buffer_fd[2], char *buffer)
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
	return (ret);
}

static int	check(const char *buf, int fd, ssize_t ret, ssize_t count)
{
	if (errno == 0 && ret != count)
		return (FAIL);
	if (buf == NULL && (errno != EINVAL || ret != FAIL))
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
