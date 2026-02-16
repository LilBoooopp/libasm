global  ft_strcmp
section .text

	; int strcmp(const char *s1, const char *s2)
	; rdi = *s1
	; rsi = *s2

ft_strcmp:
.loop:
	movzx eax, byte [rdi]
	movzx ecx, byte [rsi]
	cmp   eax, ecx
	jne   .diff
	test  eax, eax
	je    .done
	inc   rdi
	inc   rsi
	jmp   .loop

.diff:
	sub eax, ecx
	ret

.done:
	ret
