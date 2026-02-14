#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *ft_strdup(const char *s);

int main(void){
    const char *s = "hello";     // avoid comparing directly to a literal
    char *a = ft_strdup(s);

    printf("[%s]\n", a);                          // [hello]
    printf("same content? %d\n", strcmp(a, s)==0);       // 1
    printf("different storage? %d\n", (void*)a != (const void*)s); // 1

    free(a);
    return 0;
}
