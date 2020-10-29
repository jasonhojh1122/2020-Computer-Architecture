.globl __start

.rodata
  msg: .string "Hello, CA2020"

.text

__start:
  li t0, 0
  li t1, 1
  # prints msg
  li a0, 4
  la a1, msg
  ecall
  li a0, 10
  ecall
