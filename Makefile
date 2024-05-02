# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/17 06:59:39 by rapdos-s          #+#    #+#              #
#    Updated: 2024/04/30 14:54:05 by rapdos-s         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Files ########################################################################

NAME       = libasm.a

HDR        = libasm.h
HDR_B      = libasm_bonus.h

SRC        = ft_strlen.s
SRC       += ft_strcpy.s
SRC       += ft_strcmp.s
SRC       += ft_write.s
SRC       += ft_read.s
SRC       += ft_strdup.s

SRC_B      = ft_create_elem_bonus.s
SRC_B     += ft_atoi_base_bonus.s
SRC_B     += ft_list_push_front_bonus.s
SRC_B     += ft_list_size_bonus.s
SRC_B     += ft_list_sort_bonus.s
SRC_B     += ft_list_remove_if_bonus.s

OBJ        = $(SRC:%.s=%.o)
OBJ_B      = $(SRC_B:%.s=%.o)

# Commands #####################################################################

ASMC       = nasm -f elf64
AR         = ar crs
DEL        = rm -f

# Special Targets ##############################################################

.DEFAULT_GOAL = all
.PHONY: all mandatory bonus clean fclean re

# Basic Rules ##################################################################

all: $(NAME)

$(NAME): mandatory bonus

mandatory: $(OBJ)

bonus: $(OBJ_B)

clean:
	$(DEL) $(OBJ) $(OBJ_B)

fclean: clean
	$(DEL) $(NAME)

re: fclean all

# Pattern Rules ################################################################

%.o: %.s $(HDR)
	$(ASMC) -o $(@) $(<)
	$(AR) $(NAME) $(@)

%_bonus.o: %_bonus.s $(HDR_B)
	$(ASMC) -o $(@) $(<)
	$(AR) $(NAME) $(@)
