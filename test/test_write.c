#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

ssize_t ft_write(int fd, const void *buf, size_t count);

int main(void){
    ssize_t n1 = ft_write(1, "hi\n", 3);
    printf("n1=%zd errno=%d\n", n1, errno);

    ssize_t n2 = ft_write(-1, "x", 1);
    printf("n2=%zd errno=%d (%s)\n", n2, errno, strerror(errno));
}
