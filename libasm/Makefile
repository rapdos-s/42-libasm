# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/17 06:59:39 by rapdos-s          #+#    #+#              #
#    Updated: 2024/04/27 02:25:53 by rapdos-s         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm.a

SOURCES_DIR			 = src_mandatory
BONUS_SOURCES_DIR	 = src_bonus

SOURCES	 = $(SOURCES_DIR)/ft_strlen.s
SOURCES	+= $(SOURCES_DIR)/ft_strcpy.s
SOURCES	+= $(SOURCES_DIR)/ft_strcmp.s
SOURCES	+= $(SOURCES_DIR)/ft_write.s
SOURCES	+= $(SOURCES_DIR)/ft_read.s
SOURCES	+= $(SOURCES_DIR)/ft_strdup.s

BONUS_SOURCES	 = $(BONUS_SOURCES_DIR)/ft_create_elem.s
BONUS_SOURCES	+= $(BONUS_SOURCES_DIR)/ft_atoi_base.s
BONUS_SOURCES	+= $(BONUS_SOURCES_DIR)/ft_list_push_front.s
BONUS_SOURCES	+= $(BONUS_SOURCES_DIR)/ft_list_size.s
BONUS_SOURCES	+= $(BONUS_SOURCES_DIR)/ft_list_sort.s
BONUS_SOURCES	+= $(BONUS_SOURCES_DIR)/ft_list_remove_if.s

OBJECTS			 =	$(SOURCES:%.s=%.o)
BONUS_OBJECTS	 =	$(BONUS_SOURCES:%.s=%.o)

DEPENDENCIES		 = $(OBJECTS:.o=.d)
DEPENDENCIES_BONUS	 = $(BONUS_OBJECTS:.o=.d)

AR		 = ar
ARFLAGS	 = crs

NASM			 = nasm
BINARY_FORMAT	 = elf64
DEPFLAGS		 = -M -MP -MF
NASMFLAGS		 = -f $(BINARY_FORMAT) -w+error

DEL = rm -fr
MKD = mkdir -p

.DEFAULT_GOAL = $(NAME)

.PHONY: all mandatory bonus clean fclean re duck

# includes #####################################################################

-include $(DEPENDENCIES)

-include $(DEPENDENCIES_BONUS)

# Basic Rules ##################################################################

$(NAME): all

all: mandatory bonus

mandatory: $(OBJECTS)

bonus: $(BONUS_OBJECTS)

clean:
	$(DEL) $(OBJECTS) $(BONUS_OBJECTS) $(DEPENDENCIES) $(DEPENDENCIES_BONUS)

fclean: clean
	$(DEL) $(NAME)

re: fclean all

# Pattern Rules ################################################################

%.o: %.s
	$(NASM) $(NASMFLAGS) $(<) $(DEPFLAGS) $(@:.o=.d)
	$(NASM) $(NASMFLAGS) $(<) -o $(@)
	$(AR) $(ARFLAGS) $(NAME) $(@)

# Duck Rules ###################################################################

duck:
	@echo "Furious quacking noises!"
