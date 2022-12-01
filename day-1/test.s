.intel_syntax noprefix
.arch generic64

.section .text
  .global dothestuff

dothestuff:
	# first arg is in rdi, contains pointer to the first number
	# second value is in rsi, contains the number of numbers

	# we want to have two accumulators
	# one for the global max rax
	# one for the current total rcx

	# zero out the accumulators
	xor rax, rax
	xor rcx, rcx

	# while rsi > 0
	#   add rdi to rcx
	#   if rcx - rax > 0 
	#     rax = rcx
	#   if rdi == 0
	#     rcx = 0
	#   rsi--
	mov r10, rsi
	mov r11, rdi

.logic1:  # r10 is loop index
	add rcx, [r11]
	# increment rdi
	add r11, 8

	cmp rcx, [rdx]
	jle .notgreater1
	mov [rdx], rcx
.notgreater1:
	cmpq [r11], 0
	jnz .nonzero1
	mov rcx, 0
.nonzero1:
	dec r10
	jnz .logic1

	# reset rsi
	mov r10, rsi
	mov r11, rdi

	# while rsi > 0
	#   add rdi to rcx
	#   if rcx - rbx > 0 and rcx < rax
	#     rbx = rcx
	#   if rdi == 0
	#     rcx = 0
	#   rsi--

.logic2:  # r10 is loop index
	add rcx, [r11]
	# increment rdi
	add r11, 8

	cmp rcx, [rdx + 8]
	jle .notgreater2
	cmp rcx, [rdx]
	jge .notgreater2
	mov [rdx + 8], rcx
.notgreater2:
	cmpq [r11], 0
	jnz .nonzero2
	mov rcx, 0
.nonzero2:
	dec r10
	jnz .logic2

; 	# reset rsi
	mov r10, rsi
	mov r11, rdi

.logic3:  # r10 is loop index
	add rcx, [r11]
	# increment rdi
	add r11, 8

	cmp rcx, [rdx + 16]
	jle .notgreater3
	cmp rcx, [rdx + 8]
	jge .notgreater3
	mov [rdx + 16], rcx
.notgreater3:
	cmpq [r11], 0
	jnz .nonzero3
	mov rcx, 0
.nonzero3:
	dec r10
	jnz .logic3
	
	ret
