global ft_strdup

text .section

	; char *strdup(const char *s)
	; rdi = *s

ft_strdup:
	push rbx
	mov  rbx, rdi
	call ft_strlen

	lea  rdi, [rax + 1]
	call malloc
	test rax, rax
	jz   .null

	mov  rdi, rax
	mov  rsi, rbx
	call ft_strcpy

.null:
	pop rbx
	ret
