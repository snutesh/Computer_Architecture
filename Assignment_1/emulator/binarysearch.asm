.binarysearch:
		@ ADD YOUR CODE HERE
		
.main:

	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12	@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7	@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11      @ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9   	@ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3   	@ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  	@ replace 15 with the number to be sorted
	st r1, 20[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS
	
	@ Store the Element to be searched in r0
	mov r0,16
	
	@Flag for storing the boolean result
	mov r1, 0
	
	mov r2, 0       @ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 6	@ REPLACE 6 WITH N, where, N is the number of numbers being sorted
	
	@ ADD YOUR CODE HERE
	


	call .binarysearch
	
	@ ADD YOUR CODE HERE

	@ Print statement for the result 
	@ Boolean result is stored in r1
	.print r1
    
