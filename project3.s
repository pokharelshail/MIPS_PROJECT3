.data
	input: .space 1000
	error_message: .asciiz "Nan"
.text
	main:
		li $v0, 8 #Taking User input
		la $a0, input
		li $a1, 1001
		syscall
