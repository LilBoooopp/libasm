; ft_strlen.s

global ft_strlen	; export symbol so the linker can find it
section .text		; code lives in the .text (executable) section

ft_strlen:
	xor	rax, rax	; rax = 0 (return value register on a x86-64 SysV)
.loop:
	cmp		byte [rdi], 0	; is *s == 0 ?
	je		.done			; if yes jump to return
	inc		rdi				; s++
	inc		rax				; n++
	jmp		.loop			;repeat
.done:
	ret						; return n in rax