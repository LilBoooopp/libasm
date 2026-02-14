; ft_strcmp.s
global ft_strcpy
section .text

ft_strcpy:
	mov		rax, rdi				; To preserve the dest in rax
.loop:
	mov		dl, [rsi]
	mov		byte [rdi], dl
	test	dl, dl
	je		.done
	inc		rdi
	inc		rsi
	jmp		.loop

.done:
	ret