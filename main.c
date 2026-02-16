#include <errno.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
size_t ft_strlen(const char *s);
int ft_strcmp(const char *, const char *);
char *ft_strcpy(char *dst, const char *src);
ssize_t ft_write(int fd, const void *buf, size_t count);
char *ft_strdup(const char *s);
int main(void) {
  printf("%zu\n", ft_strlen("abc"));   // expect 3
  printf("%zu\n", ft_strlen(""));      // expect 0
  printf("%zu\n", ft_strlen("hello")); // expect 5

  printf("%d\n", ft_strcmp("abc", "abc")); // 0
  printf("%d\n", ft_strcmp("abc", "abd")); // negative
  printf("%d\n", ft_strcmp("abd", "abc")); // positive
  printf("%d\n", ft_strcmp("", ""));       // 0
  printf("%d\n", ft_strcmp("", "A"));      // negative

  char b[32];
  printf("%s\n", ft_strcpy(b, "hi")); // hi
  printf("%s\n", b);                  // hi
  printf("%s\n", ft_strcpy(b, ""));   // (prints empty line)
  puts(b);                            // (empty line)
  printf("%p == %p\n", (void *)b, (void *)ft_strcpy(b, "abc")); // same ptr

  ssize_t n1 = ft_write(1, "hi\n", 3);
  printf("n1=%zd errno=%d\n", n1, errno);

  ssize_t n2 = ft_write(-1, "x", 1);
  printf("n2=%zd errno=%d (%s)\n", n2, errno, strerror(errno));

  // const char *s = "hello"; // avoid comparing directly to a literal
  // char *a = ft_strdup(s);
  //
  // printf("[%s]\n", a);                                             // [hello]
  // printf("same content? %d\n", ft_strcmp(a, s) == 0);              // 1
  // printf("different storage? %d\n", (void *)a != (const void *)s); // 1

  // free(a);
}
