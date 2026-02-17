#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

size_t ft_strlen(const char *s);
int ft_strcmp(const char *, const char *);
char *ft_strcpy(char *dst, const char *src);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, const void *buf, size_t count);
char *ft_strdup(const char *s);

static int g_tests = 0;
static int g_pass = 0;

static void check(const char *label, int condition) {
  g_tests++;
  if (condition) {
    g_pass++;
    printf(" PASSED: %s\n", label);
  } else {
    printf(" FAILED: %s\n", label);
  }
}

static void test_strlen(void) {
  printf("\n ft_strlen \n");
  check("empty string", ft_strlen("") == strlen(""));
  check("hello", ft_strlen("hello") == strlen("hello"));
  check("single char", ft_strlen("x") == strlen("x"));
  check("long string", ft_strlen("the quick brown fox jumps") ==
                           strlen("the quick brown fox jumps"));
  check("string with spaces", ft_strlen(" a b ") == strlen(" a b "));
}

static void test_strcpy(void) {
  char buf1[64];
  char buf2[64];
  char *ret;

  printf("\n ft_strcpy \n");

  ret = ft_strcpy(buf1, "hello");
  strcpy(buf2, "hello");
  check("hello (content)", strcmp(buf1, buf2) == 0);
  check("hello (return ptr)", ret == buf1);

  ft_strcpy(buf1, "");
  check("empty string", strcmp(buf1, "") == 0);

  ft_strcpy(buf1, "a");
  check("single char", strcmp(buf1, "a") == 0);

  ft_strcpy(buf1, "longer test string here");
  check("longer string", strcmp(buf1, "longer test string here") == 0);
}

static void test_strcmp(void) {
  printf("\n ft_strcmp \n");
  check("equal strings", ft_strcmp("abc", "abc") == 0);
  check("empty vs empty", ft_strcmp("", "") == 0);
  check("a < b", ft_strcmp("a", "b") < 0);
  check("b > a", ft_strcmp("b", "a") > 0);
  check("short < long", ft_strcmp("abc", "abcd") < 0);
  check("long > short", ft_strcmp("abcd", "abc") > 0);
  check("case sensitive", ft_strcmp("A", "a") != 0);

  int ft = ft_strcmp("hello", "world");
  int lib = strcmp("hello", "world");
  check("sign matches strcmp", (ft < 0) == (lib < 0));

  check("unsigned compare", ft_strcmp("\xff", "\x01") > 0);
}

static void test_write(void) {
  ssize_t ret;

  printf("\n ft_write \n");
  printf(" expect 'hi': ");
  fflush(stdout);
  ret = ft_write(1, "h1", 2);
  printf("\n");
  check("write 2 bytes returns 2", ret == 2);

  ret = ft_write(1, "x", 0);
  check("write 0 bytes returns 0", ret == 0);

  errno = 0;
  ret = ft_write(-1, "x", 1);
  check("bad fd returns -1", ret == -1);
  check("bad fd sets errno EBADF", errno == EBADF);
}

static void test_read(void) {
  int pipefd[2];
  char buf[64];
  ssize_t ret;

  printf("\n ft_read \n");

  if (pipe(pipefd) == -1) {
    printf("  pipe() failed, skipping ft_read tests\n");
    return;
  }

  write(pipefd[1], "hello", 5);
  memset(buf, 0, sizeof(buf));
  ret = ft_read(pipefd[0], buf, 5);
  check("read 5 bytes returns 5", ret == 5);
  check("read correct content", memcmp(buf, "hello", 5) == 0);

  ret = ft_read(pipefd[0], buf, 0);
  check("read 0 bytes returns 0", ret == 0);

  close(pipefd[0]);
  close(pipefd[1]);

  errno = 0;
  ret = ft_read(-1, buf, 1);
  check("bad fd returns -1", ret == -1);
  check("bad fd sets errno EBADF", errno == EBADF);
}

static void test_strdup(void) {
  char *dup;

  printf("\n ft_strdup \n");

  const char *src = "hello";
  dup = ft_strdup(src);
  check("hello (content)", dup && strcmp(dup, src) == 0);
  check("hello (new ptr)", dup && dup != src);
  free(dup);

  dup = ft_strdup("a longer test string for strdup");
  check("longer string",
        dup && strcmp(dup, "a longer test string for strdup") == 0);
  free(dup);
}

int main(void) {
  printf("═══════════════════════════════\n");
  printf("       libasm test suite       \n");
  printf("═══════════════════════════════\n");

  test_strlen();
  test_strcpy();
  test_strcmp();
  test_write();
  test_read();
  test_strdup();

  printf("\n═══════════════════════════════\n");
  printf("  Results: %d / %d passed\n", g_pass, g_tests);
  printf("═══════════════════════════════\n\n");
  return (g_pass != g_tests);
}
