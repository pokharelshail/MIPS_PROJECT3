.data
	input: .space 1000
	error_message: .asciiz "Nan"
.text
	main:
	#take User Input
		li $v0, 8 
		la $a0, input
		li $a1, 1001
		syscall
        la $s0, input   #load input to register
        li $s1, 0    #The pointer where it begins
        li $s2, 0  #Pointer where it ends
