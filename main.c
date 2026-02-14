#include <stdio.h>
#include <stddef.h>
size_t ft_strlen(const char *s);
int main(void){
    printf("%zu\n", ft_strlen("abc"));   // expect 3
    printf("%zu\n", ft_strlen(""));      // expect 0
    printf("%zu\n", ft_strlen("hello")); // expect 5
}
