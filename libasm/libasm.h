/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/17 07:38:57 by rapdos-s          #+#    #+#             */
/*   Updated: 2024/04/30 00:51:34 by rapdos-s         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

// System libraries ////////////////////////////////////////////////////////////

// variables: errno
# include <errno.h>

// functions: malloc()
# include <stdlib.h>

// types: size_t
# include <unistd.h>

// libasm Functions ////////////////////////////////////////////////////////////

extern size_t	ft_strlen(const char *s);
extern char		*ft_strcpy(char *dst, const char *src);
extern int		ft_strcmp(const char *s1, const char *s2);
extern size_t	ft_write(int fd, const void *buf, size_t count);
extern size_t	ft_read(int fd, void *buf, size_t count);
extern char		*ft_strdup(const char *s);

#endif // LIBASM_H
