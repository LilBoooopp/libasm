global  ft_read
section .text
extern  __errno_location

	;ssize_t read(int fd, void buf[.count], size_t count)
	; rdi = fd
	; rsi = *buf
	; rsx = count

ft_read:
	mov rax, 0
	syscall

	test rax, rax
	jns  .done

	neg  eax
	push rax
	call __errno_location wrt ..plt
	pop  rdx
	mov  dword [rax], edx
	mov  rax, -1

.done:
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
