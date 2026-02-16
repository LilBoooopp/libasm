global  ft_strcpy
section .text

	; ft_strcpy(char *dst, const char *src)
	; rdi = dst
	; rsi = src

ft_strcpy:
	xor rax, rdi

.loop:
	mov dl, byte [rsi]
	mov byte [rdi], dl

	cmp dl, 0
	je  .done

	inc rdi
	inc rsi
	jmp .loop

.done:
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
