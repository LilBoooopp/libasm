global  ft_write
section .text
extern  __errno_location

	;ssize_t write(int fd, const void buf[.count], size_t count)
	; rdi = fd
	; rsi = *buf
	; rsx = count

ft_write:
	mov rax, 1
	syscall

	cmp rax, 0
	jge .ok

	push rbx
	mov  rbx, rax
	call __errno_location wrt ..plt
	neg  rbx
	mov  dword [rax], ebx
	pop  rbx

	mov rax, -1
	ret

.ok:
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
