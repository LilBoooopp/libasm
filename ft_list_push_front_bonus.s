global ft_list_push_front
extern malloc

	; void ft_list_push_front(t_list **begin_list, void *data)
	; rdi = *begin_list
	; rsi = *data

ft_list_push_front:
	push rdi
	push rsi
	push rdx
	mov  rdi, 16
	call malloc wrt ..plt
	test rax, rax
	pop  rdx
	pop  rsi
	pop  rdi
	jz   .ret
	mov  [rax], rsi
	mov  rsi, [rdi]
	mov  [rax+8], rsi
	mov  [rdi], rax

.ret:

	ret
