	global  ft_atoi_base
	section .text
	;       void ft_putnbr_base(int nbr, char *base)
	;       rdi = nbr
	;       rsi = *base

	; 1) validate the base - return 0 if base is empty, only 1 character, has duplicates, or '+'/'-' is present
	; 2) base - skip whitespace ASCII 9-13, 32
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

	; j = 0
	; while ((base[j] >= 9 && base[j] <= 13) || base[j] == 32)
	; j++
	; }

ft_atoi_base:
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
	xor   ecx, ecx

	; while (base[i] != '\0')

.validate:
	movzx r8d, byte [rsi + rcx]
	test  r8b, r8b
	jz    .valid

	;   base[i] == '-'
	cmp r8b, '-'
	je  .zero
	;   base[i] == '+'
	cmp r8b, '+'
	je  .zero

	lea rdx, [rcx + 1]; j = i + 1

.duplicate_check:
	;base[j] != '\0'
	movzx    r9d, byte [rsi + rdx]
	test     r9b, r9b
	jz       .outerloop

	;   base[i] == base[j]
	cmp r8b, r9b
	je  .zero
	inc rdx
	jmp .duplicate_check

.outerloop:
	inc rcx
	jmp .validate

.valid:
	;   ecx = base_len, rsi = base, rdi = str
	mov r8d, ecx; r8d base_len

.skip_ws:
	movzx eax, byte [rdi]
	cmp   al, ' '
	je    .ws
	cmp   al, 9
	jb    .ws_done
	cmp   al, 13
	ja    .ws_done

.ws:
	inc rdi
	jmp .skip_ws

.ws_done:
	;   handle signs
	xor ecx, ecx; ecx = negative flag (0 = positive)

.signs:
	movzx eax, byte [rdi]
	cmp   al, '-'
	je    .neg_sign
	cmp   al, '+'
	je    .pos_sign
	jmp   .signs_done

.neg_sign:
	xor ecx, 1; toggle negative flag
	inc rdi
	jmp .signs

.pos_sign:
	inc rdi
	jmp .signs

.signs_done:
	push rcx; save negative flag

	;   convert: result = result * base_len + index
	xor eax, eax; eax = result = 0

.convert:
	movzx r9d, byte [rdi]; r9b = current char in str
	test  r9b, r9b
	jz    .done

	;   find r9b in base string
	xor ecx, ecx; ecx = index into base

.find:
	movzx r10d, byte [rsi + rcx]
	test  r10b, r10b
	jz    .done; char not in base, stop converting
	cmp   r9b, r10b
	je    .found
	inc   ecx
	jmp   .find

.found:
	;    result = result * base_len + index
	imul eax, r8d; result *= base_len
	add  eax, ecx; result += index
	inc  rdi; next char in str
	jmp  .convert

.done:
	pop  rcx; restore negative
	test ecx, ecx
	jz   .ret
	neg  eax

.ret:
	ret

.zero:
	xor eax, eax
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
