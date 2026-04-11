global sub

section .data
section .text

sub:
	mov eax, [esp+4]
	sub eax,  [esp+8]
	ret
