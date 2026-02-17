#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct s_list {
  void *data;
  struct s_list *next;
} t_list;

int ft_atoi_base(const char *str, const char *base);
void ft_list_push_front(t_list **begin_list, void *data);
int ft_list_size(t_list *begin_list);
void ft_list_sort(t_list **begin_list, int (*cmp)());
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(),
                       void (*free_fct)(void *));

static int g_tests = 0;
static int g_pass = 0;

static void check(const char *label, int condition) {
  g_tests++;
  if (condition) {
    g_pass++;
    printf(" PASSED %s\n", label);
  } else
    printf(" FAILED %s\n", label);
}

static t_list *build_list(char **strs, int count) {
  t_list *head;
  t_list *node;
  int i;

  head = NULL;
  i = count - 1;
  while (i >= 0) {
    node = malloc(sizeof(t_list));
    if (!node)
      return (NULL);
    node->data = strs[i];
    node->next = head;
    head = node;
    i--;
  }
  return (head);
}

static void free_list(t_list *head) {
  t_list *tmp;

  while (head) {
    tmp = head->next;
    free(head);
    head = tmp;
  }
}

static void free_list_full(t_list *head) {
  t_list *tmp;

  while (head) {
    tmp = head->next;
    free(head->data);
    free(head);
    head = tmp;
  }
}

static void list_to_str(t_list *head, char *buf, size_t bufsize) {
  size_t pos;

  pos = 0;
  buf[0] = '\0';
  while (head && pos < bufsize - 1) {
    if (pos > 0 && pos < bufsize - 1)
      buf[pos++] = ',';
    const char *s = (const char *)head->data;
    while (*s && pos < bufsize - 1)
      buf[pos++] = *s++;
    head = head->next;
  }
  buf[pos] = '\0';
}

// static void test_atoi_base(void) {
//   printf("\n ft_atoi_base \n");
//
//   check("42 in decimal", ft_atoi_base("42", "0123456789") == 42);
//   check("0 in decimal", ft_atoi_base("0", "0123456789") == 0);
//   check("-42 in decimal", ft_atoi_base("0", "0123456789") == -42);
//
//   check("101 in binary = 5", ft_atoi_base("101", "01") == 5);
//   check("-101 in binary = -5", ft_atoi_base("-101", "01") == -5);
//   check("1111 in binary = 15", ft_atoi_base("1111", "01") == 15);
//
//   check("1A in hex = 26", ft_atoi_base("1A", "0123456789ABCDEF") == 26);
//   check("FF in hex = 255", ft_atoi_base("FF", "0123456789ABCDEF") == 255);
//   check("-FF in hex = -255", ft_atoi_base("-FF", "0123456789ABCDEF") ==
//   -255);
//
//   check("po in poneyvif = 1", ft_atoi_base("po", "poneyvif") == 1);
//
//   check("leading spaces", ft_atoi_base("   42", "0123456789") == 42);
//   check("leading tabs and spaces",
//         ft_atoi_base(" \t\n 42", "0123456789") == 42);
//
//   check("--42 = 42 (double neg)", ft_atoi_base("--42", "0123456789") == 42);
//   check("-+42 = -42", ft_atoi_base("-+42", "0123456789") == -42);
//
//   check("empty base returns 0", ft_atoi_base("42", "") == 0);
//   check("single char base returns 0", ft_atoi_base("42", "0") == 0);
//   check("duplicate in base returns 0", ft_atoi_base("42", "0123456788") ==
//   0); check("+ in base returns 0", ft_atoi_base("42", "01+23") == 0);
//   check("- in base returns 0", ft_atoi_base("42", "01-23") == 0);
//
//   check("stops at non-base char", ft_atoi_base("42xyz", "0123456789") == 42);
// }

static void test_list_push_front(void) {
  t_list *head;

  printf("\n ft_list_push_front \n");

  head = NULL;
  ft_list_push_front(&head, "first");
  check("push to empty: not NULL", head != NULL);
  check("push to empty: data correct",
        head && strcmp(head->data, "first") == 0);
  check("push to empty: next to NULL", head && head->next == NULL);

  ft_list_push_front(&head, "second");
  check("push second: head data", head && strcmp(head->data, "second") == 0);
  check("push second: next data",
        head && head->next && strcmp(head->next->data, "first") == 0);

  ft_list_push_front(&head, "third");
  check("push third: head data", head && strcmp(head->data, "third") == 0);
  check("push third: list size 3", head && head->next && head->next->next &&
                                       head->next->next->next == NULL);

  free_list(head);
}

static void test_list_size(void) {
  t_list *head;
  char *strs3[] = {"a", "b", "c"};
  char *strs1[] = {"only"};

  printf("\n ft_list_size \n");

  check("empty list = 0", ft_list_size(NULL) == 0);

  head = build_list(strs1, 1);
  check("one element = 1", ft_list_size(head) == 1);
  free_list(head);

  head = build_list(strs3, 3);
  check("three elements = 3", ft_list_size(head) == 3);
  free_list(head);
}

static void test_list_sort(void) {
  t_list *head;
  char buf[256];

  printf("\n ft_list_sort \n");

  char *strs[] = {"delta", "alpha", "echo", "bravo", "charlie"};
  head = build_list(strs, 5);
  ft_list_sort(&head, &strcmp);
  list_to_str(head, buf, sizeof(buf));
  check("5 strings sorted", strcmp(buf, "alpha,bravo,charlie,delta,echo") == 0);
  free_list(head);

  char *sorted[] = {"a", "b", "c"};
  head = build_list(sorted, 3);
  ft_list_sort(&head, &strcmp);
  list_to_str(head, buf, sizeof(buf));
  check("already sorted", strcmp(buf, "a,b,c") == 0);
  free_list(head);

  char *rev[] = {"c", "b", "a"};
  head = build_list(rev, 3);
  ft_list_sort(&head, &strcmp);
  list_to_str(head, buf, sizeof(buf));
  check("reverse sorted", strcmp(buf, "a,b,c") == 0);
  free_list(head);

  char *single[] = {"alone"};
  head = build_list(single, 1);
  ft_list_sort(&head, &strcmp);
  list_to_str(head, buf, sizeof(buf));
  check("single element", strcmp(buf, "alone") == 0);
  free_list(head);

  head = NULL;
  ft_list_sort(&head, &strcmp);
  check("empty list", head == NULL);

  char *dups[] = {"bb", "aa", "bb", "aa", "cc"};
  head = build_list(dups, 5);
  ft_list_sort(&head, &strcmp);
  list_to_str(head, buf, sizeof(buf));
  check("with duplicates", strcmp(buf, "aa,aa,bb,bb,cc") == 0);
  free_list(head);
}

static void test_list_remove_if(void) {
  t_list *head;
  char buf[256];

  printf("\n ft_list_remove_if \n");

  head = NULL;
  ft_list_push_front(&head, strdup("cherry"));
  ft_list_push_front(&head, strdup("banana"));
  ft_list_push_front(&head, strdup("apple"));
  ft_list_push_front(&head, strdup("banana"));
  ft_list_push_front(&head, strdup("date"));

  ft_list_remove_if(&head, "banana", &strcmp, &free);
  list_to_str(head, buf, sizeof(buf));
  check("remove banana", strcmp(buf, "date,apple,cherry") == 0);
  free_list_full(head);

  head = NULL;
  ft_list_push_front(&head, strdup("b"));
  ft_list_push_front(&head, strdup("a"));
  ft_list_push_front(&head, strdup("a"));
  ft_list_remove_if(&head, "a", &strcmp, &free);
  list_to_str(head, buf, sizeof(buf));
  check("remove from head", strcmp(buf, "b") == 0);
  free_list_full(head);

  head = NULL;
  ft_list_push_front(&head, strdup("only"));
  ft_list_remove_if(&head, "only", &strcmp, &free);
  check("remove only element", head == NULL);

  head = NULL;
  ft_list_remove_if(&head, "x", &strcmp, &free);
  check("empty list no crash", head == NULL);

  head = NULL;
  ft_list_push_front(&head, strdup("a"));
  ft_list_push_front(&head, strdup("b"));
  ft_list_remove_if(&head, "z", &strcmp, &free);
  list_to_str(head, buf, sizeof(buf));
  check("remove nonexistent", strcmp(buf, "b,a") == 0);
  free_list_full(head);

  head = NULL;
  ft_list_push_front(&head, strdup("x"));
  ft_list_push_front(&head, strdup("x"));
  ft_list_push_front(&head, strdup("x"));
  ft_list_remove_if(&head, "x", &strcmp, &free);
  check("remove all elements", head == NULL);
}

int main(void) {
  printf("═══════════════════════════════\n");
  printf("     libasm bonus test suite   \n");
  printf("═══════════════════════════════\n");

  // test_atoi_base();
  test_list_push_front();
  test_list_size();
  test_list_sort();
  test_list_remove_if();

  printf("\n═══════════════════════════════\n");
  printf("  Results: %d / %d passed\n", g_pass, g_tests);
  printf("═══════════════════════════════\n\n");
  return (g_pass != g_tests);
}
