.intel_syntax noprefix
.arch generic64

.section .text
  .global dothestuff
  .global dothestuff2

dothestuff:
	# left in rdi
	# right in rsi
	# count in rdx
	# result in rax

	xor rax, rax

.loop:
	# decrement 'A' from rdi
	sub BYTE PTR [rdi], 0x41
	# decrement 'X' from rsi
	sub BYTE PTR [rsi], 0x58

	# rdi has opponent
	# rsi has player

	# mov rsi into a temp register
	xor r8, r8
	movb r8b, BYTE PTR [rsi]

	# add rsi to rax
	add rax, r8
	inc rax

	# if rsi == rdi add three, go next
	xor r8, r8
	mov r8b, BYTE PTR [rdi]
	cmp r8b, BYTE PTR [rsi]
	jnz .testwin
	addq rax, 3
	jmp .next

.testwin:
	# add 1 to rdi. if it's equal to rdi add six.
	add BYTE PTR [rdi], 1
	# convert 3 to 0
	cmp BYTE PTR [rdi], 3
	jnz .testwin2
	mov BYTE PTR [rdi], 0

.testwin2:
	xor r8, r8
	mov r8b, BYTE PTR [rdi]
	cmp r8b, BYTE PTR [rsi]
	jnz .next
	addq rax, 6

.next:
	inc rdi
	inc rsi
	dec rdx
	jnz .loop
	
	ret

dothestuff2:
	# left in rdi
	# right in rsi
	# count in rdx
	# result in rax

	xor rax, rax

.loop2:
	# decrement 'A' from rdi
	sub BYTE PTR [rdi], 0x41
	# decrement 'X' from rsi
	sub BYTE PTR [rsi], 0x58

	# rdi has opponent
	# rsi has result

	# move rsi into a temp register
	xor r8, r8
	movb r8b, BYTE PTR [rsi]
	# multiply r8 by 3
	imul r8, 3
	# add r8 to rax
	add rax, r8

	# if rsi == 0 then we lose, so go to the next
	cmp BYTE PTR [rsi], 0
	jz .reslose

	# if rsi == 1 then we draw
	cmp BYTE PTR [rsi], 1
	jz .resdraw

	# if rsi == 2 then we win
	cmp BYTE PTR [rsi], 2
	jz .reswin

.reslose:
	# we play rdi - 1 (or 2 if rdi == 0)
	xor r8, r8
	mov r8b, BYTE PTR [rdi]

	# if rdi == 0, then add 3 to rax
	cmp r8b, 0
	jz .reslose2
	# add r8 to rax
	add rax, r8
	jmp .next2

.reslose2:
	addq rax, 3
	jmp .next2

.resdraw:
	# add rdi + 1 to rax
	xor r8, r8
	mov r8b, BYTE PTR [rdi]
	add rax, r8
	inc rax
	jmp .next2

.reswin:
	xor r8, r8
	mov r8b, BYTE PTR [rdi]

	# if rdi == 2, then add 1 to rax
	cmp r8b, 2
	jz .reswin2

	# add r8 + 2 to rax
	add rax, r8
	addq rax, 2
	jmp .next2

.reswin2:
	addq rax, 1
	jmp .next2

.next2:
	inc rdi
	inc rsi
	dec rdx
	jnz .loop2
	
	ret
