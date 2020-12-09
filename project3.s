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

    new_line:
    	li $v0, 10
    	syscall
    
    SubprogramA:
      la $s7, ($ra) #load  value from $ra to register $s7
      la $t9, ($a0) #loading  value from $a0 to register $t9

      addi $t8, $a1, 0  #store the end address
      la $t7, input
    space_check:
    	beq $t9, $t8, end_deletion  #This will check for the empty substrings or exit the loop after spotting one.
        add $t6, $t7, $t9
        lb $t5, ($t6)       
    	beq $t5, 32, go_for_loop  #load the first word from the substring
        beq $t5, 9, go_for_loop
        j rewind
    go_for_loop:
    	addi $t9, $t9, 1
    	j space_check
    rewind:
    	beq $t9, $t8, end_deletion



