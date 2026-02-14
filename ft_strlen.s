.intel_syntax noprefix
.global ft_strlen

	; count the amount of characters in a str

ft_strlen:
	xor rax, rax

.loop:
	cmp, byte [rdi], 0
	je   .done
	inc  rdi
	inc  rax
	jmp  loop

.done:
	ret
