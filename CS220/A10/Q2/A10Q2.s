        .data
v1:		.space 60
m1:   	.asciiz "Give an integer as size of array of floats (n):\n"
m2:		.asciiz "Give n floating point numbers each on separate line:\n"
m3: 	.asciiz "Result:\n"

        .text
        .globl main
main:   li $v0, 4
        la $a0, m1
        syscall					# print m1

		li $v0, 5
		syscall
		move $t0, $v0			# take input 'n' in $t0

		li $v0, 4
        la $a0, m2
        syscall					# print m2

		li.s $f1, -1.0			# initialise const float f1 = -1.0
		li.s $f2, 1.0			# initialise float f = 1.0 (calculates (-1)^i)
		li.s $f3, 0.0			# initialise float sum(f3) = 0.0

for1:	beq $t0, $0, exit1		# loop till n==0

		li $v0, 6
		syscall					# takes input float number in $f0
		
		mul.s $f0, $f0, $f2		# f0 = ((-1)^i)*f0
		add.s $f3, $f3, $f0		# f3 += f0

		mul.s $f2, $f2, $f1		# f1 *= -1.0
		addi $t0, $t0, -1		# n--

		j for1
								# exit for loop
exit1:	li $v0, 4
        la $a0, m3
        syscall					# print m3

		li $v0, 2
		mov.s $f12, $f3
		syscall					# print sum

		jr $ra					# exit main