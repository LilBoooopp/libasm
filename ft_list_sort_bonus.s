global  ft_list_sort
section .text

	; void ft_list_sort(t_list **begin_list, int (*cmp)())
	; rdi = **begin_list
	; rsi = (*cmp)()

ft_list_sort:
	push rbp
	push rbx
	push r12
	push r13
	push r14

	mov ebx, 1; swapped = 1
	mov r12, rdi; begin_list
	mov r13, rsi; (*cmp)

	; while (swapped)

.loop:
	test ebx, ebx
	jz   .done
	mov  ebx, 0; swapped = 0
	mov  r14, [r12]; r14 = t_list *cur
	;    while (cur && cur->next)

.loop2:
	test r14, r14
	jz   .loop; cur
	mov  rdi, [r14]; cur->data
	mov  rsi, [r14 + 8]; cur->next
	test rsi, rsi; cur->next != NULL
	jz   .loop
	mov  rsi, [rsi]; cur->next->data
	;    if ((*cmp)(cur->data, cur->next->data) > 0)
	call r13
	test eax, eax
	jle  .loop2outer

	;   swap(cur->data, cur->next->data)
	mov rdi, [r14]; rdi = cur->data
	mov rsi, [r14 + 8]; rsi = cur->next
	mov rdx, [rsi]; rdx = cur->next->data
	mov [r14], rdx; cur->data = cur->next->data
	mov [rsi], rdi; cur->next->data = cur->data
	mov ebx, 1; swapped = 1

.loop2outer:
	mov r14, [r14 + 8]
	jmp .loop2

.done:
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
