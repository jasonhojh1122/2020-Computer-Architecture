.globl __start

.rodata
    op_not_supported_msg: .string "op not supported"
    zero_div_msg: .string "divided by zero"
.text

__start:
    # read A from stdin and store A to s0
    li a0, 5
    ecall
    mv s0, a0
    
    # read op from stdin and store op to s1
    li a0, 5
    ecall
    mv s1, a0
    
    # read B from stdin and store B to s2
    li a0, 5
    ecall
    mv s2, a0

################################################################################ 
# TODO block: Add your code here
# A in s0
# op in s1
# B in s2
# result in s3
# tmp in s4

slt s4, s1, zero
bne s4, zero, op_not_supported
addi s4, zero, 4
bge s1, s4, op_not_supported
add s4, zero, zero
beq s1, s4, op_add
addi s4, s4, 1
beq s1, s4, op_minus
addi s4, s4, 1
beq s1, s4, op_mul
j op_div

op_add:
    add s3, s0, s2
    
    j result

op_minus:
    sub s3, s0, s2
    
    j result

op_mul:
    mul s3, s0, s2

    j result

op_div:
    beq s2, zero, zero_div
    div s3, s0, s2

    j result
#
################################################################################ 

zero_div:
    li a0, 4
    la a1, zero_div_msg
    ecall
    
    j return


# print the result in s3
result:
    li a0, 1
    mv a1, s3
    ecall
    
    j return


op_not_supported:
    li a0, 4
    la a1, op_not_supported_msg
    ecall
    
    j return
    
    
return:
    li a0, 10
    ecall

