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

