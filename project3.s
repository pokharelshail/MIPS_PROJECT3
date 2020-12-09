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
    	add $t1, $s0, $s2           
        lb $t2, 0($t1)    #current letter
      	beq $t2, 0, end_of_substring 
        beq $t2, 10, end_of_substring
        beq $t2, 44, end_of_substring
        add $s2, $s2, 1    #i++
        j substring
    end_of_substring:
    	la $a0, ($s1)  #load arguments
        la $a1, ($s2)
        
        #jal SubprogramA
        #jal SubprogramB
        beq $t2, 0, new_line
        beq $t2, 10, new_line

        addi $s2, $s2, 1#itterate
        li $v0, 11 #format values returned from a subprogram
        li $a0, 44
        syscall
        j dataset



