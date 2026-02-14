; ft_strcmp.s
global ft_strcmp
section .text

ft_strcmp:
.loop:
	movzx	edx, byte [rdi]	; edx = (unsigned char)*s1
	movzx	ecx, byte [rsi]	; ecx = (unsigned char)*s2
	cmp		edx, ecx
	jne		.diff			; if bytes differ, compute result
	test	edx, edx
	je		.equal			; both zero => strings equal
	inc		rdi
	inc		rsi
	jmp		.loop

.diff:
	sub		edx, ecx		; edx = edx - ecx (range -255..255)
	mov		eax, edx		; return as int in eax
	ret

.equal:
	xor		eax, eax		; return 0
	ret