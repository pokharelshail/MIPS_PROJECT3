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
    
    dataset: 
    	la $s1, ($s2) #make data itteratable by string

    substring:
    	add $t1, $s0, $s2           #iterator taking the pointers sum
        lb $t2, 0($t1)    #loading the current character
      	beq $t2, 0, end_of_substring #a few criteron to exit the loop while iterating through the substrings
        beq $t2, 10, end_of_substring
