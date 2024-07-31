
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
  nop  #fill the branch jump delay slot ? optional
  beq $0, $0, tv2
  nop #fill the branch jump delay slot ? optional

tv1:
  ori   $s0, $0 , 0x0123  # MME_B = 0x00000123
  sll   $s0, $s0, 16      # MME_B = 0x01230000
  ori   $s0, $s0, 0x4567  # MME_B = 0x01234567; base
  ori   $s1, $0 , 0x89ab  # MME_E = 0x000089ab
  sll   $s1, $s1, 16      # MME_E = 0x89ab0000
  ori   $s1, $s1, 0xcdef  # MME_E = 0x89abcdef; exponent
  ori   $s2, $0 , 0x9384  # MME_N = 0x00009384
  sll   $s2, $s2, 16      # MME_N = 0x93840000
  ori   $s2, $s2, 0x9ca7  # MME_N = 0x93849ca7; modulus
  ori   $s3, $0,  0x8c8d  # MME_K = 0x00008c8d
  sll   $s3, $s3, 16      # MME_K = 0x8c8d0000
  ori   $s3, $s3, 0x9129  # MME_K = 0x8c8d9129; K const
  beq   $0,  $0,  mme_begin   # Jump to begin
  nop

tv2:
  ori   $s0, $0 , 0x0011  # MME_B = 0x00000011
  sll   $s0, $s0, 16      # MME_B = 0x00110000
  ori   $s0, $s0, 0x2233  # MME_B = 0x00112233; base
  ori   $s1, $0 , 0x4455  # MME_E = 0x00004455
  sll   $s1, $s1, 16      # MME_E = 0x44550000
  ori   $s1, $s1, 0x6677  # MME_E = 0x44556677; exponent
  ori   $s2, $0 , 0x9384  # MME_N = 0x00009384
  sll   $s2, $s2, 16      # MME_N = 0x93840000
  ori   $s2, $s2, 0x9ca7  # MME_N = 0x93849ca7; modulus
  ori   $s3, $0,  0x8c8d  # MME_K = 0x00008c8d
  sll   $s3, $s3, 16      # MME_K = 0x8c8d0000
  ori   $s3, $s3, 0x9129  # MME_K = 0x8c8d9129; K const
  beq   $0,  $0,  mme_begin   # Jump to begin
  nop

mme_begin:
  ori   $t0, $s0, 0x0     # t0 = m
  ori   $t1, $s3, 0x0     # t1 = k
  ori   $t2, $s2, 0x0     # t2 = n
  beq   $0, $0, mmm_begin
  nop

mmm_done_1:
  ori   $s5, $t3, 0x0     
  ori   $t0, $0, 1        
  ori   $t1, $s3, 0x0     
  ori   $t2, $s2, 0x0     
  beq   $0, $0, mmm_begin
  nop
  
mmm_done_2:
  ori   $s6, $t3, 0x0     
  ori   $t8, $0, 32       

mme_loop: #mme loop task 2
  beq   $t8, $0, mme_end_loop  
  nop
  srl   $t9, $s1, 31      
  ori   $t8, $0, 1        
  and   $t9, $t9, $t8     
  beq   $t9, $0, skip_mmm_r
  nop
  ori   $t0, $s6, 0x0     
  ori   $t1, $s5, 0x0     
  ori   $t2, $s2, 0x0     
  beq   $0, $0, mmm_begin
  nop

mmm_done_3:
  ori   $s6, $t3, 0x0     

skip_mmm_r:
  ori   $t0, $s5, 0x0     
  ori   $t1, $s5, 0x0     
  ori   $t2, $s2, 0x0     
  beq   $0, $0, mmm_begin
  nop

mmm_done_4:
  ori   $s5, $t3, 0x0    
  subu  $t8, $t8, $t8    #Correction here, changing from immediate to register subtraction, (resolved error)
  sll   $s1, $s1, 1       
  beq   $0, $0, mme_loop
  nop

mme_end_loop:
  ori   $t0, $s6, 0x0     
  ori   $t1, $0, 1        
  ori   $t2, $s2, 0x0     
  beq   $0, $0, mmm_begin
  nop

mmm_done_5:
  ori   $s4, $t3, 0x0    #copy the value of t3 into final result register $s4
  beq   $0, $0, done
  nop

done: 
  beq   $0, $0, done
  nop

mmm_begin:
  ori   $t3, $0, 0       
  ori   $t4, $0, 32      

mmm_loop:
  ori   $t6, $0, 1        
  and   $t5, $t0, $t6    
  and   $t6, $t3, $t6     
  addu  $t7, $t5, $t6    
  ori   $t8, $0, 1       
  and   $t7, $t7, $t8    
  beq   $t7, $0, mmm_skip_add
  nop
  addu  $t3, $t3, $t1    

mmm_skip_add:
  srl   $t3, $t3, 1      
  sltu  $t5, $t2, $t3    
  beq   $t5, $0, mmm_skip_sub
  nop
  subu  $t3, $t3, $t2    

mmm_skip_sub:
  #subu $t4, $t4, 1  
  subu  $t4, $t4, $t4    #Correction here x2, changing from immediate to register subtraction subu(args1,args2,args3)
  beq   $t4, $0, mmm_done
  nop
  sll   $t0, $t0, 1       
  beq   $s4, $s4, mmm_loop
  nop

mmm_done:
  beq   $s4, $s4, mmm_done  #Store the result in $s4
  # beq $0, $0, mmm_done
  nop
