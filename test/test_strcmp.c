#include <stdio.h>
int ft_strcmp(const char*, const char*);
int main(void){
    printf("%d\n", ft_strcmp("abc","abc"));   // 0
    printf("%d\n", ft_strcmp("abc","abd"));   // negative
    printf("%d\n", ft_strcmp("abd","abc"));   // positive
    printf("%d\n", ft_strcmp("",""));         // 0
    printf("%d\n", ft_strcmp("","A"));        // negative
}
