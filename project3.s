#SHREESHAIL POKHAREL @02931612
#BASE 28 CONVERSIONS 
.data
	input: .space 1000
	error_message: .asciiz "NaN"
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
        
        jal SubprogramA
        jal SubprogramB
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
    	add $t6, $t7, $t8
        addi $t6, $t6, -1
        lb $t5, ($t6)
        beq $t5, 32, down #move down the dataset and moving through each word until 4*8 characters are processed
        beq $t5, 9, down
        j end_deletion
    down:
    	addi $t8, $t8, -1
        j rewind
    end_deletion:
    	beq $t9, $t8, not_a_number #if string is empty  then print NaN
        li $t4, 0
        li $s6, 0   #len
    baseconvert:
    	beq $t9, $t8, end_baseconvert 
    	add $t6, $t7, $t9
        lb $t5, ($t6)
        la $a0, ($t5)
        #check if the number is valid in our base system and then baseconverts using subprogram
        jal SubprogramC  
        bne $v0, 0, continue
        j not_a_number
    continue:
    	mul $t4, $t4, 28  #Multiplying by 28 because of  base 28
        sub $t6, $t5, $v1
        add $t4, $t4, $t6
        addi $s6, $s6, 1
        addi $t9, $t9, 1
        j baseconvert
    end_baseconvert:
    	bgt $s6, 4, number_excess #if length of a valid string is greater than 4, then it's TOO large to deal with
        li $v0, 1
         j end_string
    number_excess:
         #check if input > 4 chars
    	li $v0, 0
        la $t4, error_message
        j end_string
    not_a_number:
        li $v0, 0
        la $t4, error_message
    end_string:
    	#load the stack with return values
        addi $sp, $sp, -4
        sw $t4, ($sp)
        addi $sp, $sp, -4
        sw $v0, ($sp)
        la $ra, ($s7)
        jr $ra
    SubprogramC:
    	blt $a0, 48, invalid  #invaild if ascii value is less than 48, ascii value of 0 is 48
        addi $v1, $0, 48  #storing the ascii value to $v1
        blt $a0, 58, valid  #Value 0-9 is valid
        blt $a0, 65, invalid #invalid if the character is less than "A" in the ascii table
        addi $v1, $0, 55
        ble $a0, 82, valid 
        blt $a0, 97, invalid
        addi $v1, $0, 87    #R
        ble $a0, 114, valid  #r
        bgt $a0, 114, invalid 
    valid:
    	li $v0, 1  #loading the number for valid and invalid
        jr $ra
    invalid:
        li $v0, 0
        jr $ra

    SubprogramB: #check overflow
    	lw $t8, ($sp)  #load the arguments from the stack
        addi $sp, $sp, 4
        lw $t7, ($sp)
        beq $t8, 0, must_change #if $t8 equals 0, the string is not valid
        li $t6, 10  #
        divu $t7, $t6
        li $v0, 1
        mflo $a0
        beq $a0, 0, v_flag # if overflow
        syscall
    v_flag:
    	mfhi $a0
        syscall
        j exit
    must_change:#code for invalid characters
    	li $v0, 4
    	la $a0, ($t7)
        syscall
    exit:
    	jr $ra






