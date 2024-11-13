# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/13 02:41:09 by rapdos-s          #+#    #+#              #
#    Updated: 2024/11/13 05:05:02 by rapdos-s         ###   ########.fr        #
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
sources             += $(libasm_dir)/ft_strcpy.s
sources             += $(libasm_dir)/ft_strcmp.s
sources             += $(libasm_dir)/ft_write.s
sources             += $(libasm_dir)/ft_read.s
sources             += $(libasm_dir)/ft_strdup.s

sources_bonus        = $(libasm_dir)/ft_create_elem_bonus.s
sources_bonus       += $(libasm_dir)/ft_atoi_base_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_push_front_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_size_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_sort_bonus.s
sources_bonus       += $(libasm_dir)/ft_list_remove_if_bonus.s

sources_tests        = $(tests_dir)/main.c
sources_tests       += $(tests_dir)/ft_strcpy_test.c
sources_tests       += $(tests_dir)/ft_strlen_test.c

sources_tests_bonus  = $(tests_dir)/main_bonus.c

objects              = $(sources:%.s=%.o)
objects_bonus        = $(sources_bonus:%.s=%.o)
objects_tests        = $(sources_tests:%.c=%.o)
objects_tests_bonus  = $(sources_tests_bonus:%.c=%.o)

dependencies         = $(sources:%.s=%.d)
dependencies        += $(sources_bonus:%.s=%.d)
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
tag_name             = Libasm
tag                  = "[ $(main_color)$(tag_name)$(reset) ]"

# Commands #####################################################################

CC                   = $$(which clang)
CFLAGS               = -Wall -Wextra -Werror -Wpedantic

ar                   = $$(which ar) -crs
asmc                 = $$(which nasm) -f elf64
echo                 = $$(which echo) -e $(tag)
make                 = $$(which make) --no-print-directory
remove               = $$(which rm) -f
valgrind             = $$(which valgrind)
depflags             = -MMD -MF $(@:%.o=%.d)

# Special Targets ##############################################################

-include $(dependencies)
.DEFAULT_GOAL = all
.PHONY: all clean fclean re
.PHONY: mandatory bonus duck

# Basic Rules ##################################################################

all:
	@$(echo) "make all"
	@$(make) mandatory
	@$(make) bonus
	@$(make) $(tests_name)
	@$(make) $(tests_bonus_name)
	@$(echo) "make all done."

clean:
	@$(echo) "make clean"
	@$(echo) "removing object files..."
	@$(remove) $(objects)
	@$(echo) "removing bonus object files..."
	@$(remove) $(objects_bonus)
	@$(echo) "removing tests object files..."
	@$(remove) $(objects_tests)
	@$(echo) "removing tests bonus object files..."
	@$(remove) $(objects_tests_bonus)
	@$(echo) "removing dependencies files..."
	@$(remove) $(dependencies)
	@$(echo) "removing compilled headers files..."
	@$(remove) $(compilled_headers)
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

mandatory: $(objects)

bonus: $(objects_bonus)

$(NAME):
	@$(echo) "make $(NAME)"
	@$(make) mandatory
	@$(make) bonus
	@$(make) $(tests_name)
	@$(make) $(tests_bonus_name)
	@$(echo) "make all done."

$(tests_name): mandatory $(objects_tests)
	@$(echo) "Compiling $(tests_name)..."
	@$(CC) -o $(tests_name) $(objects_tests) $(NAME)
	@$(echo) "$(tests_name) compiled."

$(tests_bonus_name): bonus $(objects_tests_bonus)
	@$(echo) "Compiling $(tests_bonus_name)..."
	@$(CC) -o $(tests_bonus_name) $(objects_tests_bonus) $(NAME)
	@$(echo) "$(tests_bonus_name) compiled."

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
