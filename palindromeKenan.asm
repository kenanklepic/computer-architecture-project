## strlen.asm
##
## Count the characters in a string
##
## Registers:
##  $8 -- count
##  $9 -- pointer to the char
## $10 -- the char (in low order byte)

         .text
         .globl  main
		 
# Initialize
main:

# ori      $2,$2,0 
 ori      $8,$0,0        #  count = 0
         lui      $9,0x1000     #  point at first char. Change to Ox1000 in spim
         lui      $11, 0x1000   # keep track of first char address. pointer to the first char
# while not ch==null do
loop:    lbu      $10,0($9)      # get the char
         sll      $0,$0,0        # branch delay
           
         beq      $10,$0,done    # exit loop if char == null
         sll      $0,$0,0        # branch delay

         addiu    $8,$8,1        # count++
         addiu    $9,$9,1        # point at the next char

         j        loop
         sll      $0,$0,0        # branch delay slot

# finish
done:    sll      $0,$0,0        # target for branch

palindrome:

	sltiu $13, $8, 2   #check if string is length smaller than 2, if it is put 1 in $13, else put 0 in $13
	bne $13,$0,finishTrue  #jump to finishTrue if $13 has value 1, that is not equal to 0
	sll $0, $0, 0		#branch delay slot
	addiu $9, $9, -1       #decrement pointer to last char because the last char is /0
	srl $8, $8, 1          #devide string with 2, find middle point

palLoop:
	
	lbu $10, 0($9)  #load value from last char address pointer into $10
        sll $0, $0, 0   #branch delay slot
        sll $0, $0, 0   #branch delay slot
	lbu $12, 0($11) #load value from first char address pointer into $12
        sll $0, $0, 0   #branch delay slot
        sll $0, $0, 0   #branch delay slot
	bne $10, $12, finishFalse #if first and last char are not equal then jum to finishFalse
	sll $0, $0, 0   #branch delay slot
	addiu $11, $11, 1 #increment first char address pointer
	addiu $9, $9, -1  #decrement last char address pointer
	addiu $8, $8, -1    #decrement middle point, lenght check
	beq $8, $0, finishTrue #if middle point is then jump to finshTrue
	sll $0, $0, 0   #branch delay slot
	j palLoop       #jump to begging of the loop so that the char values can be checked for equality
	sll $0, $0, 0   #branch delay slot
	
	
finishTrue:

addiu $4,$4,1   #add 1 to the output register $4



finishFalse:

addiu $4,$4,0  #add 0 to the output register $4

         .data
string:  .asciiz  "String Input"





