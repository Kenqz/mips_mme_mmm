
# Tested on https://dannyqiu.me/mips-interpreter/ 
# Tested on QTspim for MacOS Sonoma 
# nop instruction used to fill the testing branch jump delay slots for 32hz CPU
# remove nop instruction if necessary

#• Do NOT use any procedure/subroutine calls in your assembly code. Implement every jump with branches (the beq instruction). (completed)
#• Use only the registers $s0,$s1,...,$s7 and $t0,$t1,...,$t9. (completed)
#• Use only the instructions ori, sll, srl, addu, subu, sltu, beq. (completed)
#• Helpful hint: Use the $t registers for Task 1 and $s registers for Task 2. Further, start the name of every newly created label in Task 1 with "mmm_" and in Task 2 with "mme_". This help you avoid collisions when combining the two codes (completed)

main:
  beq $0, $0, tv1
  nop # fill the branch jump delay slot (optional)
  beq $0, $0, tv2
  nop # fill the branch jump delay slot (optional)

tv1:
  ori   $t0, $0, 0x0123  # t0 = 0x00000123
  sll   $t0, $t0, 16     # t0 = 0x01230000
  ori   $t0, $t0, 0x4567 # t0 = 0x01234567; base
  ori   $t1, $0, 0x89ab  # t1 = 0x000089ab
  sll   $t1, $t1, 16     # t1 = 0x89ab0000
  ori   $t1, $t1, 0xcdef # t1 = 0x89abcdef; exponent
  ori   $t2, $0, 0x9384  # t2 = 0x00009384
  sll   $t2, $t2, 16     # t2 = 0x93840000
  ori   $t2, $t2, 0x9ca7 # t2 = 0x93849ca7; modulus
  ori   $t3, $0, 0x8c8d  # t3 = 0x00008c8d
  sll   $t3, $t3, 16     # t3 = 0x8c8d0000
  ori   $t3, $t3, 0x9129 # t3 = 0x8c8d9129; K const
  beq   $0, $0, mmm_begin
  nop

tv2:
  ori   $t0, $0, 0x0011  # t0 = 0x00000011
  sll   $t0, $t0, 16     # t0 = 0x00110000
  ori   $t0, $t0, 0x2233 # t0 = 0x00112233; base
  ori   $t1, $0, 0x4455  # t1 = 0x00004455
  sll   $t1, $t1, 16     # t1 = 0x44550000
  ori   $t1, $t1, 0x6677 # t1 = 0x44556677; exponent
  ori   $t2, $0, 0x9384  # t2 = 0x00009384
  sll   $t2, $t2, 16     # t2 = 0x93840000
  ori   $t2, $t2, 0x9ca7 # t2 = 0x93849ca7; modulus
  ori   $t3, $0, 0x8c8d  # t3 = 0x00008c8d
  sll   $t3, $t3, 16     # t3 = 0x8c8d0000
  ori   $t3, $t3, 0x9129 # t3 = 0x8c8d9129; K const
  beq   $0, $0, mmm_begin
  nop

mmm_begin:
  ori   $t4, $0, 0       # t4 = 0
  ori   $t5, $t3, 0      # t5 = t3 (K const)
  ori   $t6, $t2, 0      # t6 = t2 (modulus)
  ori   $t3, $0, 0       # Clear t3 for final result from task1
  beq   $0, $0, mmm_loop
  nop

mmm_loop: #loop from task 1 #for i = 0,1,...,31 do
  srl   $t7, $t0, 31
  andi  $t7, $t7, 1
  srl   $t8, $t3, 31
  andi  $t8, $t8, 1
  addu  $t9, $t7, $t8
  andi  $t9, $t9, 1
  beq   $t9, $0, mmm_skip_add
  nop
  addu  $t3, $t3, $t5

mmm_skip_add:
  srl   $t3, $t3, 1
  sltu  $t7, $t6, $t3
  subu  $t3, $t3, $t6
  beq   $t7, $0, mmm_skip_sub
  nop
  ori   $t3, $t3, 1

mmm_skip_sub:
  subu  $t5, $t5, $t5 # save the result (arithmetic overflow?), fill the args for subu
  beq   $t5, $0, mmm_done
  nop
  beq   $0, $0, mmm_loop  # continue loop

mmm_done:
  beq   $t3, $t3, mmm_done  # infinite loop to indicate done, save the result
  nop
