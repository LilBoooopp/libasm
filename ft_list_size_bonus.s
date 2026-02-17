global  ft_list_size
section .text

	; int ft_list_size(t_list *begin_list)
	; rdi = begin_list

ft_list_size:
	xor rax, rax

.loop:
	test rdi, rdi
	jz   .done
	inc  rax
	mov  rdi, [rdi + 8]
	jmp  .loop

.done:
	ret
