; ft_read.s

global ft_read
extern __errno_location

section .text
ft_read:
	; args: rdi=fd, rsi=buff, rdx=count
	mov		rax, 0			; SYS_read
	syscall					; rax = bytes or -errno

	test	rax, rax
	jge		.ok

	neg		eax							; eax = errno (positive)
	push	rax							; save errno + align stack for call
	call	__errno_location wrt ..plt
	pop		rdx							; rdx = saved errno
	mov		dword [rax], edx			; *errno = saved errno
	mov		eax, -1						; return -1
	ret

.ok:
	ret

section .note.GNU-stack noalloc noexec nowrite