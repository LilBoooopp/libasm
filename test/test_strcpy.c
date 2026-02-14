#include <stdio.h>
char *ft_strcpy(char *dst, const char *src);

int main(void){
    char b[32];
    printf("%s\n", ft_strcpy(b, "hi"));    // hi
    printf("%s\n", b);                      // hi
    printf("%s\n", ft_strcpy(b, ""));       // (prints empty line)
    puts(b);                                // (empty line)
    printf("%p == %p\n", (void*)b, (void*)ft_strcpy(b, "abc")); // same ptr
    return 0;
}