	global  ft_putnbr_base
	section .text
	;       void ft_putnbr_base(int nbr, char *base)
	;       rdi = nbr
	;       rsi = *base

	; 1) validate the base - return 0 if base is empty, only 1 character, has duplicates, or '+'/'-' is present
	; 2) skip whitespace ASCII 9-13, 32
	; 3) handle nbr sign - count + and -, if - is odd make negative
	; 4) for each character in str, find index, if found: result = result * base_len + index, if not: stop

	; void   ft_putnbr_base(int nbr, char *base)
	; {
	; if     (!base || !base[0] || !base[1])
	; return (0)
	; int    i = 0
	; while  (base[i] != '\0')
	; {
	; if     (base[i] == '+' || base[i] == '-')
	; return (0)
	; int    j = i + 1
	; while  (base[j] != '\0' && base[i] != base[j])
	; {
	; j++
	; }
	; i++
	; }

	; j     = 0
	; while ((base[j] >= 9 && base[j] <= 13) || base[j] == 32)
	; j++
	; }

ft_putnbr_base:
	;     check NULL
	test  rsi, rsi
	jz    .zero
	movzx eax, byte [rsi]
	test  al, al
	jz    .zero

	;     check for more than 1 character
	movzx eax, byte [rsi + 1]
	test  al, al
	jz    .zero

	mov rax, 0; i = 0
	;   while (base[i] != '\0')

.loop:
	movzx r8d, byte [rsi + rax]
	test  r8b, r8b
	jz    .endloop

	;   base[i] == '-'
	cmp r8b, '-'
	je  .zero
	;   base[i] == '+'
	cmp r8b, '+'
	je  .zero

	lea rcx, [rax + 1]; j = i + 1

.loop2:
	;base[j] != '\0'
	movzx    r9d, byte [rsi + rcx]
	test     r9b, r9b
	jz       .outerloop

	;   base[i] == base[j]
	cmp r8b, r9b
	je  .zero
	inc rcx
	jmp .loop2

.outerloop:
	inc rax
	jmp .loop

.zero:
	mov eax, 0
	ret

.endloop:
	push rbx
	push r12
	mov  r12d, eax; save base length
	mov  rbx, rsi; save base pointer
	cmp  edi, 0
	jns  .pos

	;    write '-'
	push '-'
	mov  rdi, 1
	mov  rsi, rsp
	mov  rdx, 1
	mov  rax, 1
	syscall
	pop  rax

	neg edi

.pos:
	call print_nbr
	pop  r12
	pop  rbx
	ret

	; print_nbr(int nbr, char *base, int base_len)

print_nbr:
	cmp  edi, r12d
	jb   .print_digit
	push rdi; save remainder for after recursion
	xor  edx, edx
	mov  eax, edi
	div  r12d; eax = quotient, edx = remainder
	mov  edi, eax; recurse with quotient
	call print_nbr
	pop  rdi; restore remainder

.print_digit:
	;     if we skipped the recursion, compute remainder now
	;     if we came from recursion, rdx already has it
	xor   edx, edx
	mov   eax, edi
	div   r12d; edx = edi % base_len
	movzx eax, byte [rbx + rdx]; base[remainder]

	;    write(1, num, 1)
	push rax
	mov  rdi, 1
	mov  rsi, rsp
	mov  rdx, 1
	mov  rax, 1
	syscall

	pop rax
	ret
