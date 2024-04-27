# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rapdos-s <rapdos-s@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/17 07:56:12 by rapdos-s          #+#    #+#              #
#    Updated: 2024/04/26 23:45:17 by rapdos-s         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libasm_tester.out

TESTS_DIR			 = tests
MANDATORY_SRC_DIR	 = $(TESTS_DIR)/src_mandatory
BONUS_SRC_DIR		 = $(TESTS_DIR)/src_bonus
UTILS_DIR			 = $(TESTS_DIR)/utils
LIBASM_DIR			 = libasm
BUILD_DIR			 = build
INCLUDES_DIR		 = $(TESTS_DIR) $(LIBASM_DIR)

LIBASM	 = $(LIBASM_DIR)/libasm.a

MAIN_SRC = main.c

MANDATORY_SRC	 = $(MANDATORY_SRC_DIR)/ft_strlen_tests.c
MANDATORY_SRC	+= $(MANDATORY_SRC_DIR)/ft_strcpy_tests.c
MANDATORY_SRC	+= $(MANDATORY_SRC_DIR)/ft_strcmp_tests.c
MANDATORY_SRC	+= $(MANDATORY_SRC_DIR)/ft_write_tests.c
MANDATORY_SRC	+= $(MANDATORY_SRC_DIR)/ft_read_tests.c
MANDATORY_SRC	+= $(MANDATORY_SRC_DIR)/ft_strdup_tests.c

BONUS_SRC	 = $(BONUS_SRC_DIR)/ft_atoi_base_tests.c
BONUS_SRC	+= $(BONUS_SRC_DIR)/ft_list_push_front_tests.c
BONUS_SRC	+= $(BONUS_SRC_DIR)/ft_list_size_tests.c
BONUS_SRC	+= $(BONUS_SRC_DIR)/ft_list_sort_tests.c
BONUS_SRC	+= $(BONUS_SRC_DIR)/ft_create_elem_tests.c
BONUS_SRC	+= $(BONUS_SRC_DIR)/ft_list_remove_if_tests.c

UTILS_SRC	 = $(UTILS_DIR)/free_fct.c
UTILS_SRC	+= $(UTILS_DIR)/free_list.c
UTILS_SRC	+= $(UTILS_DIR)/puterror.c
UTILS_SRC	+= $(UTILS_DIR)/putf.c
UTILS_SRC	+= $(UTILS_DIR)/putheader.c
UTILS_SRC	+= $(UTILS_DIR)/putrawstr.c
UTILS_SRC	+= $(UTILS_DIR)/putrawstrquotes.c
UTILS_SRC	+= $(UTILS_DIR)/putstrquotes.c
UTILS_SRC	+= $(UTILS_DIR)/safe_strdup.c
UTILS_SRC	+= $(UTILS_DIR)/sigsegv_handler.c

MAIN_OBJ		 = $(MAIN_SRC:%.c=$(BUILD_DIR)/%.o)
MANDATORY_OBJ	 = \
	$(patsubst $(MANDATORY_SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(MANDATORY_SRC))
BONUS_OBJ		 = \
	$(patsubst $(BONUS_SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(BONUS_SRC))
UTILS_OBJ		 = $(patsubst $(UTILS_DIR)/%.c,$(BUILD_DIR)/%.o,$(UTILS_SRC))
OBJECTS			 = $(MAIN_OBJ) $(MANDATORY_OBJ) $(BONUS_OBJ) $(UTILS_OBJ)

MAIN_DEP		 = $(MAIN_OBJ:.o=.d)
MANDATORY_DEP	 = $(MANDATORY_OBJ:.o=.d)
BONUS_DEP		 = $(BONUS_OBJ:.o=.d)
UTILS_DEP		 = $(UTILS_OBJ:.o=.d)
DEPENDENCIES	 = $(MAIN_DEP) $(MANDATORY_DEP) $(BONUS_DEP) $(UTILS_DEP)

MAKE		 = make
MAKE_FLAGS	 = --no-print-directory -C

CC		 = cc
CFLAGS	 = -Wall -Wextra -Werror -Wpedantic -g3
DEPFLAGS = -MMD -MF
INCLUDES = $(addprefix -I./, $(INCLUDES_DIR))

VALGRIND		 = valgrind
VALGRIND_FLAGS	 = --leak-check=full
VALGRIND_FLAGS	+= --show-leak-kinds=all
VALGRIND_FLAGS	+= --track-origins=yes
VALGRIND_FLAGS	+= --track-fds=yes
VALGRIND_FLAGS	+= --undef-value-errors=yes
VALGRIND_FLAGS	+= --error-exitcode=42

MKDIR		 = mkdir -p
RM			 = rm -fr
ECHO		 = /usr/bin/echo -e
NORMINETTE	 = norminette

RED			 = "\033[0;31m"
GREEN		 = "\033[0;32m"
YELLOW		 = "\033[0;33m"
BLUE		 = "\033[0;34m"
PURPLE		 = "\033[0;35m"
CYAN		 = "\033[0;36m"
RESET_COLOR	 = "\033[0m"

LIBASM_TAG	 = "[ "$(CYAN)" LIBASM "$(RESET_COLOR)" ]"
COMPILER_TAG = "[ "$(BLUE)"COMPILER"$(RESET_COLOR)" ]"
CLEAR_TAG	 = "[ "$(YELLOW)" CLEAR  "$(RESET_COLOR)" ]"
TESTER_TAG	 = "[ "$(PURPLE)" TESTER "$(RESET_COLOR)" ]"
OTHER_TAG	 = "[ "$(GREEN)"  MAKE  "$(RESET_COLOR)" ]"

REMOVE_OUTPUT = > /dev/null

.DEFAULT_GOAL = all

.PHONY: all clean fclean re \
		test norminette valgrind t n v \
		force duck

# includes #####################################################################

-include $(DEPENDENCIES)

# Basic Rules ##################################################################

all: $(NAME)

$(NAME): $(LIBASM) $(MAIN_OBJ) $(MANDATORY_OBJ) $(BONUS_OBJ) $(UTILS_OBJ)
	@$(ECHO) $(COMPILER_TAG) "Compiling $(NAME)"
	@$(CC) $(CFLAGS) $(INCLUDES) $(LIBASM) $(OBJECTS) $(<) -o $(@)

clean:
	@$(ECHO) $(CLEAR_TAG) "Cleaning libasm intermediate files"
	@$(MAKE) $(MAKE_FLAGS) $(LIBASM_DIR) clean $(REMOVE_OUTPUT)
	@$(ECHO) $(CLEAR_TAG) "Cleaning tests intermediate files"
	@$(RM) $(BUILD_DIR)

fclean:
	@$(ECHO) $(CLEAR_TAG) "Cleaning libasm intermediate and output files"
	@$(MAKE) $(MAKE_FLAGS) $(LIBASM_DIR) fclean $(REMOVE_OUTPUT)
	@$(ECHO) $(CLEAR_TAG) "Cleaning tests intermediate and output files"
	@$(RM) $(BUILD_DIR) $(NAME)

re: fclean all

# Libasm Rules #################################################################

$(LIBASM): force
	@$(ECHO) $(LIBASM_TAG) "Calling Libasm Makefile"
	@$(MAKE) $(MAKE_FLAGS) $(LIBASM_DIR) all | \
		grep -q "Nothing to be done for" && \
		$(ECHO) $(LIBASM_TAG) "$(LIBASM) already up to date" || \
		$(ECHO) $(LIBASM_TAG) "Building $(LIBASM)"

# Pattern Rules ################################################################

$(MAIN_OBJ): $(MAIN_SRC) $(LIBASM) | $(BUILD_DIR)
	@$(ECHO) $(COMPILER_TAG) "Compilling $(@)"
	@$(CC) $(CFLAGS) -c $(INCLUDES) $(<) $(DEPFLAGS) $(@:.o=.d) -o $(@)

$(BUILD_DIR)/%.o: $(MANDATORY_SRC_DIR)/%.c $(LIBASM) | $(BUILD_DIR)
	@$(ECHO) $(COMPILER_TAG) "Compilling $(@)"
	@$(CC) $(CFLAGS) -c $(INCLUDES) $(<) $(DEPFLAGS) $(@:.o=.d) -o $(@)

$(BUILD_DIR)/%.o: $(BONUS_SRC_DIR)/%.c $(LIBASM) | $(BUILD_DIR)
	@$(ECHO) $(COMPILER_TAG) "Compilling $(@)"
	@$(CC) $(CFLAGS) -c $(INCLUDES) $(<) $(DEPFLAGS) $(@:.o=.d) -o $(@)

$(BUILD_DIR)/%.o: $(UTILS_DIR)/%.c $(LIBASM) | $(BUILD_DIR)
	@$(ECHO) $(COMPILER_TAG) "Compilling $(@)"
	@$(CC) $(CFLAGS) -c $(INCLUDES) $(<) $(DEPFLAGS) $(@:.o=.d) -o $(@)

# Test Rules ###################################################################

test: all
	@$(ECHO) $(TESTER_TAG) "Running $(NAME)"
	@./$(NAME)

norminette:
	@$(ECHO) $(TESTER_TAG) "Running norminette"
	@$(NORMINETTE) $(REMOVE_OUTPUT) && \
		$(ECHO) $(TESTER_TAG) "norminette: OK!" || \
		$(NORMINETTE) | grep -v "OK!"

valgrind: all
	@$(ECHO) $(TESTER_TAG) "Running $(NAME) with valgrind"
	@$(VALGRIND) $(VALGRIND_FLAGS) ./$(NAME)

t: test
n: norminette
v: valgrind

# Utils Rules ##################################################################

$(BUILD_DIR):
	@$(ECHO) $(OTHER_TAG) "Creating $(@) dir"
	@$(MKDIR) $(BUILD_DIR)

force:

# Duck Rules ###################################################################

duck:
	@$(ECHO) $(OTHER_TAG) "Furious quacking noises!"
