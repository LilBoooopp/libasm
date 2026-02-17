NAME	:= libasm.a
AS		:= nasm
ASFLAGS	:= -f elf64
AR		:= ar
ARFLAGS	:= rcs
RM		:= rm -f
CC		:= cc
# CFLAGS	:= -Wall -Werror -Wextra

SRC := ft_strlen.s ft_strcmp.s ft_strcpy.s ft_write.s ft_read.s ft_strdup.s
OBJ := $(SRC:.s=.o)

SRC_BONUS := ft_list_size_bonus.s ft_list_push_front_bonus.s ft_list_sort_bonus.s ft_list_remove_if_bonus.s
OBJ_BONUS := $(SRC_BONUS:.s=.o)

all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(ARFLAGS) $@ $^

bonus: $(OBJ) $(OBJ_BONUS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJ) $(OBJ_BONUS)

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	$(RM) $(OBJ) $(OBJ_BONUS)

fclean: clean
	$(RM) $(NAME) test test_bonus

re: fclean all

test: $(NAME) main.c
	$(CC) $(CFLAGS) main.c -L. -lasm -o $@
	./$@

test_bonus: bonus main_bonus.c
	$(CC) $(CFLAGS) main_bonus.c -L. -lasm -o $@
	./$@

.PHONY: all clean fclean re test bonus test_bonus
