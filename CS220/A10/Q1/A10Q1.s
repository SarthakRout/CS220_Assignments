		.data
ar:		.space 48
ret: 	.space 24
m1:		.asciiz "Enter n (the size of the array)\n"
m2:		.asciiz	"Give n integers each on separate line in sorted order:\n"
m3:		.asciiz "Enter k (the number that you want to search)\n"
m4:		.asciiz "Found element at index "
m5: 	.asciiz "\n"
m6: 	.asciiz "Element was not found\n"

		.text
		.globl main
main:	li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m1     			# Argument: string m1
        syscall         		# Print the string to input n

        addiu $s7, $ra, 0		# Saving $ra  

        li $v0, 5 				# Syscall 5 (read int) 
        syscall					# Read input n

        addiu $s0, $v0, 0 		# Copy integer n to $s0

        addiu $a1, $s0, 0 		# Argument: n

        li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m2     			# Argument: string m2
        syscall         		# Print the string to take integers

        addiu $t3, $0, 0		# Counter for number of integers
        la $t0, ar				# Load address of array
        addiu $a0, $t0, 0 		# Argument: address of array
       	jal gint				# read array of integers

       	li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m3     			# Argument: string m3
        syscall         		# Print the string to input k

       	li $v0, 5 				# Syscall 5 (read int) 
        syscall					# Read input k

        addiu $s6, $v0, 0 		# Copy integer k to $s6        

        addiu $t0, $0, 0
        addiu $t1, $0, 0
        addiu $t2, $s0, -1        

        move $a0, $t0			# First argument: function counter
        move $a1, $t1 			# Second argument: l
        move $a2, $t2			# Third argument: h

        jal search				# Initiate search

        move $s6, $v0
        beq $v0, -1, nf			# Branch if not found
		## Match found ar[mid] == k
		li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m4    			# Argument: string m4
        syscall         		# Print the string m4

        addiu $a0, $s6, 0		# Printing (l+h)/2
        li $v0, 1       		# Syscall 1 (print_int)
        syscall         		# Print integer mid

        li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m5     			# Argument: string m5
        syscall         		# Print the string m5
		## Print element found at index $t4
		j em

nf:		li $v0, 4       		# Syscall 4 (print_str)
        la $a0, m6   			# Argument: string m6
        syscall         		# Print the string "Not found"

em:     addiu $ra, $s7, 0		# Restoring $ra
        jr $ra     				# End main call

gint: 	bne $t3, $a1, readi 	# Check termination of for loop
		jr $ra 
readi:	li $v0, 5				# Read an int
		syscall 
		sw $v0, 0($a0)			# Store it in the array
		addiu $a0, $a0, 4		# Increment the pointer in the array
		addiu $t3, $t3, 1		# Increment the counter
		j gint					# Jump back to start of loop gint

search: la $t3, ret 			# Load address of ret
		sll $t0, $a0, 2
		addu $t3, $t3, $t0			
		sw $ra, 0($t3) 			# Storing the function return address on stack
 
		ble $a1, $a2, cont
		## No match found
		addiu $v0, $0, -1		 
		
        jr $ra

cont:	addu $t4, $a1, $a2		# l + h
		sra $t4, $t4, 1			# divide by 2

		sll $t5, $t4 , 2 		# 4 * (l+h) / 2	
		la $t6, ar 				# Load address of ar	
		addu $t5, $t6, $t5		# Address of mid element
		lw $t7, 0($t5)			# Mid element

		bne $t7, $s6, neq		# Branch if not equal

		## Match found ar[mid] == k
		addiu $v0, $t4, 0		# Return the index found
		j end

neq:	blt $t7, $s6, lt		# Branch if less than
		
		## Greater than case ar[mid] > k

		addiu $a2, $t7, -1		# h = mid - 1
		addiu $a0, $a0, 1		# Increment function counter

		jal search

		addiu $a0, $a0, -1 		# Depth reduced (not required though)

		j end

lt:		## Less than case ar[mid] < k

		addiu $a1, $t7, 1		# l = mid +  1
		addiu $a0, $a0, 1		# Increment function counter

		jal search

		addiu $a0, $a0, -1 		# Depth reduced (not required though) 

end:	la $t3, ret 			# Load address of ret
		sll $t0, $a0, 2			
		addu $t3, $t3, $t0			
		lw $ra, 0($t3)			# Restoring $ra

		jr $ra