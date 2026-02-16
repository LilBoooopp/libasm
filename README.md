# Libasm

> The aim of thie project is to become familiar with assembly language.

## Project Overview
This project requires writing a small library of standard functions in 64-bit assembly language. It serves as an introduction to calling conventions, stack management, and system calls.

### Core Rules
 * **Compiler:** All assembly code must be compiled with 'nasm'.
 * **Syntax:** You must use Intel syntax; AT&T syntax is not allowed. 
 * **Files:** You must write '.s' files. Inline assembly is strictly forbidden.
 * **Stability:** Functions must not quit unexpectedly (e.g., segmentation faults, bus errors, double frees) unless there is undefined behavio.

 ---

## Mandatory Part
The following functions must be rewritten in assembly:

 * `ft_strlen` (man 3 strlen)
 * `ft_strcpy` (man 3 strcpy)
 * `ft_strcmp` (man 3 strcmp)
 * `ft_write` (man 2 write)
 * `ft_read` (man 2 read)
 * `ft_strdup` (man 3 strdup) - *Note: You are allowed to call `malloc` for this function.*

### Syscalls & Error Handling
 * You must check for errors during system calls (like read and write) and handle them properly.
 * When a syscall fails, your code must set the `errno` variable correctly.
 * To achieve this, you are permitted to call the external functions `___error` or `__errno_location`.

---

## Bonus Part

The bonus section introduces linked list manipulation and base conversions.

The linked list functions rely on the following structure:
```c
typedef struct s_list
{
  void *data;
  struct s_list *next;
} t_list;
```

## Bonus Functions
 * `ft_atoi_base`: Convrts a string representing a number in a specific base system to an integer.
 * `ft_list_push_front`: Adds a new `t_list` element to the beginning of the list.
 * `ft_list_size`: Returns the total number of elements currently in the list.
 * `ft_list_sort`: Sorts the list's elements in ascending order using a provided comparison function.
 * `ft_list_remove_if`: Removes elements from the list if their data matches a reference piece of data, evaluated via a comparison function.

---

# Compilation

 * `Makefile` must contain at least the following rules: `$(NAME)`, `all`, `clean`, `fclean`, and `re`.
 * `Makefile` must recompile or relink only the necessary files.

