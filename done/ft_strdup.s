; ft_strdup.s

global ft_strdup
extern ft_strlen, ft_strcpy, malloc

section .text
ft_strdup:
	; Save s and align stack for calls:
	push	rdi

	; n = ft_strlen(s)
	mov		rdi, [rsp]		; rdi = s
	call	ft_strlen		;	rax = n

	; rdi = n + 1, call malloc
	lea		rdi, [rax+1]		; rdi = n + 1
	call	malloc wrt ..plt	; rax = p or 0
	test	rax, rax
	je		.null

	; ft_strcpy(p, s) -> returns p in rax
	mov		rdi, rax		; dest = p
	mov		rsi, [rsp]		;src = s
	call	ft_strcpy

.null:
	add		rsp, 8
	ret

section .note.GNU-stack noalloc noexec nowrite

