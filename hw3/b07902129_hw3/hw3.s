.globl __start

.text

__start:
    # read from standard input
    addi a0, zero, 5
    ecall

################################################################################
# write your recursive code here, n is stored in a0
# please store the answer to s0 and jump to "result"

# current n: a0
# return value: a1
# current sum: s1

addi s1, x0, 0 # initailize s1 to zero
addi a1, x0, 0 # initailize a1 to zero

jal x1, func
addi s0, a1, 0 # store result to s0
jal x0, result

func:
    addi t1, x0, 2
    blt a0, t1, Less # if a0 < t1 then target
    
    addi sp, sp, -12 # move sp
    addi s1, x0, 0 # init s1 to 0
    sw s1, 8(sp)
    sw a0, 4(sp)
    sw x1, 0(sp)
    
    div a0, a0, t1 # n = n / 2
    jal x1, func
    lw s1, 8(sp) # load s1
    add s1, s1, a1 # add return result to s1
    sw s1, 8(sp) # store s1 to stack

    addi t1, x0, 4
    lw a0, 4(sp)
    div a0, a0, t1 # n = n / 2
    jal x1, func

    lw x1, 0(sp) 
    lw a0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12

    add s1, s1, a1 # add return result to s1
    add s1, s1, a0 # add n to s1
    add a1, x0, s1 # put s1 to a1 
    jalr x0, 0(x1)
    
Less:
    addi a1, x0, 1 # return 1
    jalr x0, 0(x1)


################################################################################

result:
    # prints the result in s0
    addi a0, zero, 1
    addi a1, s0, 0
    ecall
    
    # ends the program with status code 0
    addi a0, zero, 10
    ecall

