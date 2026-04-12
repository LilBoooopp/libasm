global ft_list_push_front
extern malloc

	; void ft_list_push_front(t_list **begin_list, void *data)
	; rdi = *begin_list
	; rsi = *data

ft_list_push_front:
	; save registers and push rdx for stack alignment
	push rdi
	push rsi
	push rdx

	; malloc 16 bytes for a t_list node
	mov  rdi, 16
	call malloc wrt ..plt

	; check null
	test rax, rax
	pop  rdx
	pop  rsi
	pop  rdi
	; if malloc failed then return
	jz   .ret

	mov  [rax], rsi
	mov  rsi, [rdi]
	mov  [rax+8], rsi
	mov  [rdi], rax

.ret:

	ret
