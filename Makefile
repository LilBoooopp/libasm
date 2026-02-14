NAME	:= libasm.a
AS		:= nasm
ASFLAGS	:= -f elf64
AR		:= ar
ARFLAGS	:= rcs
RM		:= rm -f
CC		:= cc
CFLAGS	:= -Wall -Werror -Wextra

SRC := ft_strlen.s 
#ft_strcmp.s ft_strcpy.s ft_write.s ft_read.s ft_strdup.s
OBJ := $(SRC:.s=.o)

all: $(NAME)

$(NAME): $(OBJ)
	$(AR) $(ARFLAGS) $@ $^

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(NAME) test

re: fclean all

test: $(NAME) main.c
	$(CC) $(CFLAGS) main.c -L. -lasm -o $@

.PHONY: all clean fclean re test
