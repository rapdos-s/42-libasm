# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/13 02:41:09 by rapdos-s          #+#    #+#              #
#    Updated: 2024/11/13 04:17:45 by rapdos-s         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Files ########################################################################

libasm_dir           = libasm
tests_dir            = tests

NAME                 = $(libasm_dir)/libasm.a
tests_name           = tests.out
tests_bonus_name     = tests_bonus.out

libasm_header        = $(libasm_dir)/libasm.h
libasm_header_bonus  = $(libasm_dir)/libasm_bonus.h
libasm_tests_header  = $(tests_dir)/tests.h
libasm_tests_header_bonus = $(tests_dir)/tests_bonus.h

compilled_headers    = $(libasm_header:%.h=%.h.gch)
compilled_headers   += $(libasm_header_bonus:%.h=%.h.gch)
compilled_headers   += $(libasm_tests_header:%.h=%.h.gch)
compilled_headers   += $(libasm_tests_header_bonus:%.h=%.h.gch)

sources              = $(libasm_dir)/ft_strlen.s
# sources             += $(libasm_dir)/ft_strcpy.s
# sources             += $(libasm_dir)/ft_strcmp.s
# sources             += $(libasm_dir)/ft_write.s
# sources             += $(libasm_dir)/ft_read.s
# sources             += $(libasm_dir)/ft_strdup.s

sources_bonus        = $(libasm_dir)/ft_create_elem_bonus.s
sources_bonus       += $(libasm_dir)/ft_atoi_base_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_push_front_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_size_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_sort_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_remove_if_bonus.s

sources_tests        = main.c
sources_tests       += $(tests_dir)/ft_strcpy_test.c

sources_tests_bonus  = main_bonus.c

objects              = $(source:%.s=%.o)
objects_bonus        = $(source_bonus:%.s=%.o)
objects_tests        = $(sources_tests:%.s=%.o)
objects_tests_bonus  = $(sources_tests_bonus:%.s=%.o)

dependencies         = $(sources:%.c=%.d)
dependencies        += $(sources_bonus:%.c=%.d)
dependencies        += $(sources_tests:%.c=%.d)
dependencies        += $(sources_tests_bonus:%.c=%.d)

# Colors #######################################################################

gray                 = \033[0;30m
red                  = \033[0;31m
green                = \033[0;32m
yellow               = \033[1;33m
blue                 = \033[0;34m
magenta              = \033[0;35m
cyan                 = \033[0;36m
reset                = \033[0m
main_color           = $(cyan)
tag                  = "[ $(main_color)$(NAME)$(reset) ]"

# Commands #####################################################################

CC                   = $$(which clang)
CFLAGS               = -Wall -Wextra -Werror -Wpedantic

ar                   = $$(which ar) crs
asmc                 = $$(which nasm) -f elf64
echo                 = $$(which echo) -e $(tag)
make                 = $$(which make) --quiet
remove               = $$(which rm) -f
valgrind             = $$(which valgrind)
depflags             = -MMD -MF $(@:%.o=%.d)

# Special Targets ##############################################################

-include $(dependencies)
.DEFAULT_GOAL = all
.PHONY: all clean fclean re
.PHONY: mandatory bonus tests tests_bonus duck

# Basic Rules ##################################################################

all:
	@$(echo) "make all"
	@$(make) mandatory
	@$(make) bonus
	@$(make) test
	@$(make) tests_bonus
	@$(echo) "make all done."

clean:
	@$(echo) "make clean"
	@$(echo) "removing object files..."
	$(remove) $(objects)
	@$(echo) "removing bonus object files..."
	$(remove) $(objects_bonus)
	@$(echo) "removing tests object files..."
	$(remove) $(objects_tests)
	@$(echo) "removing tests bonus object files..."
	$(remove) $(objects_tests_bonus)
	@$(echo) "removing dependency files..."
	@$(remove) $(dependencies)
	@$(echo) "removing compilled headers files..."
	$(remove) $(compilled_headers)
	@$(echo) "make clean done."

fclean:
	@$(echo) "make fclean"
	@$(make) clean
	@$(echo) "removing $(NAME) file..."
	@$(remove) $(NAME)
	@$(echo) "removing $(tests_name) file..."
	@$(remove) $(tests_name)
	@$(echo) "removing $(tests_bonus_name) file..."
	@$(remove) $(tests_bonus_name)
	@$(echo) "make fclean done."

re:
	@$(echo) "make re"
	@$(make) fclean
	@$(make) all
	@$(echo) "make re done."

# Compilation Rules ############################################################

$(NAME):
	@$(echo) "make $(NAME)"
	@$(make) mandatory
	@$(make) bonus
	@$(make) test
	@$(make) tests_bonus
	@$(echo) "make all done."

mandatory: $(objects)

bonus: $(objects_bonus)

test: mandatory $(objects_tests)
	@$(echo) "Compiling $(NAME)..."
	@$(CC) $(objects_tests) $(NAME)
	@$(echo) "$(NAME) compiled."

tests_bonus: bonus $(objects_tests_bonus)
	@$(echo) "Compiling $(NAME)..."
	@$(CC) $(objects_tests_bonus) $(NAME)
	@$(echo) "$(NAME) compiled."

%.o: %.s $(libasm_header)
	@$(echo) "Assembling $(<)..."
	@$(asmc) -o $(@) $(<)
	@$(echo) "Including $(<) in $(NAME)"
	@$(ar) $(NAME) $(@)
	@$(echo) "$(<) assembled."

%_bonus.o: %_bonus.s $(libasm_header_bonus)
	@$(echo) "Assembling $(<)..."
	@$(asmc) -o $(@) $(<)
	@$(echo) "Including $(<) in $(NAME)"
	@$(ar) $(NAME) $(@)
	@$(echo) "$(<) assembled."

%.o: %.c $(libasm_tests_header)
	@$(echo) "Compiling $(<)..."
	@$(CC) -c $(CFLAGS) $(depflags) $(<) -o $(@)
	@$(echo) "$(<) compiled."

%_bonus.o: %_bonus.c $(libasm_tests_header_bonus)
	@$(echo) "Compiling $(<)..."
	@$(CC) -c $(CFLAGS) $(depflags) $(<) -o $(@)
	@$(echo) "$(<) compiled."

# Other Rules ##################################################################

duck:
	@$(echo) "Furious Quacking Sound Effect"

################################################################################
