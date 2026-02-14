; ft_write.s

global ft_write
extern __errno_location

section .text
ft_write:
	; args: rdi=fd, rsi=buff, rdx=count
	mov		rax, 1	; syscall number for write
	syscall			; uses rdi=fd, rsi=buf, rdx=cout

	cmp		rax, 0
	jge		.ok

	; error: rax = -errno
	neg		eax					; eax = errno (positive)
	push	rax					; save errno across the call
	call	__errno_location wrt ..plt	; -> rax = &errno (int*)
	pop		rdx					; rdx = errno
	mov		dword [rax], edx	; *errno = saved errno
	mov		eax, -1				; function returns -1
	ret

.ok:
	ret

; optional silence "executable stack" warning
section .nont.GNU-stack noalloc noexec nowrite