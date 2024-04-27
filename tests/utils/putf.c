/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   putf.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/24 00:41:34 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/24 02:06:13 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <tests.h>

static void	call_specifier(const char *s, va_list args);
static void	putf_txt(const char *s);
static void	putf_nbr(long n, char specifier, unsigned long base);

void	putf(const char *s, ...)
{
	size_t	i;
	va_list	args;

	if (s == NULL)
		return ;
	va_start(args, s);
	i = 0;
	while (s[i] != '\0')
	{
		if (s[i] != '%')
			write(STDOUT_FILENO, s + i, 1);
		else
		{
			i++;
			call_specifier(s + i, args);
		}
		i++;
	}
}

static void	call_specifier(const char *s, va_list args)
{
	char	c;
	size_t	i;

	i = 0;
	if (s[i] == 'c')
	{
		c = va_arg(args, int);
		write(STDOUT_FILENO, &c, 1);
	}
	else if (s[i] == 's')
		putf_txt(va_arg(args, char *));
	else if (s[i] == 'p')
		putf_nbr((long) va_arg(args, unsigned long), s[i], 16);
	else if (s[i] == 'd' || s[i] == 'i')
		putf_nbr((long) va_arg(args, int), s[i], 10);
	else if (s[i] == 'u')
		putf_nbr((long) va_arg(args, unsigned int), s[i], 10);
	else if (s[i] == 'x' || s[i] == 'X')
		putf_nbr((long) va_arg(args, unsigned int), s[i], 16);
	else
		write(STDOUT_FILENO, s + i, 1);
}

static void	putf_txt(const char *s)
{
	int	str_len;

	if (s == NULL)
		write(STDOUT_FILENO, "(null)", 6);
	else
	{
		str_len = 0;
		while (s[str_len])
			str_len++;
		write(STDOUT_FILENO, s, str_len);
	}
}

static void	putf_nbr(long n, char specifier, unsigned long base)
{
	unsigned long	u_n;
	char			digit;

	if ((n < 0) && (specifier == 'd' || specifier == 'i'))
		write(STDOUT_FILENO, "-", 1);
	if (specifier == 'p')
	{
		if (n == 0)
		{
			write(STDOUT_FILENO, "(nil)", 5);
			return ;
		}
		u_n = (unsigned long) n;
		putf_txt("0x");
		specifier = 'x';
	}
	else
		u_n = n * (-(n < 0) + (n > 0));
	if (u_n >= base)
		putf_nbr(u_n / base, specifier, base);
	if (u_n % base >= 10)
		digit = u_n % base - 10 + 'a' - (32 * (specifier == 'X'));
	else
		digit = u_n % base + '0';
	write(STDOUT_FILENO, &digit, 1);
}
