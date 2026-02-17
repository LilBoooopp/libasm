global ft_list_remove_if
extern free

	; void ft_list_remove_if(t_list **begin_list, void *data_ref, int(*cmp)(), void (*free_fct)(void *))
	; rdi = **begin_list
	; rsi = *data_ref
	; rdx = (*cmp)()
	; rcx = (*free_fct)(void *)

ft_list_remove_if:
	push rbp
	push rbx
	push r12
	push r13
	push r14

	mov rbx, rdi; rbx = **begin_list
	mov r12, rsi; r12 = *data_ref
	mov r13, rdx; r13 = int (*cmp)()
	mov r14, rcx; r14 = (*free_fct)(void *)

	; while (*begin_list)

.loop:
	mov  rbp, [rbx]; cur = *begin_list
	test rbp, rbp
	jz   .done

	;    rax = cmp(cur->data, data_ref)
	mov  rdi, [rbp]
	mov  rsi, r12
	call r13

	;    if (rax == 0)
	test eax, eax
	jnz  .else

	mov rcx, [rbp + 8]; cur->next
	mov [rbx], rcx; *begin_list = cur->next

	;    free_fct(cur->data)
	mov  rdi, [rbp]
	call r14

	;    free(cur)
	mov  rdi, rbp
	call free wrt ..plt
	jmp  .loop

.else:
	lea rbx, [rbp + 8]; &cur->next
	jmp .loop

.done:
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	ret
