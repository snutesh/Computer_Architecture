@ 			QuickSort Algorithm
@--------------------------------------------------------------------------------------
@ quicksort (array[], start, end)
@ {
@	if(end > start)
@	{
@		p = partition(array[], start, high)
@		quicksort(array[], start, p-1)
@		quicksort(array[], p+1, end)
@	}
@ }
@--------------------------------------------------------------------------------------
@		Begining of QuickSort Algorithm
@--------------------------------------------------------------------------------------
.quicksort:
	@ ADD YOUR CODE HERE
	cmp r4, r2 		@ Compare starting index and ending index
	bgt .CONTINUE	@ if ending index is greater than starting index
	b .RET			
.CONTINUE:			
	sub sp, sp, 12	@ Create Activation Block for Partition function
	st r2, [sp]		@ store the start
	st r4, 4[sp]	@ store the end
	st ra, 8[sp]	@ store the return address
	call .partition	@ Call partition function to divide the array
	ld r2, [sp]
	ld r4, 4[sp]
	ld ra, 8[sp]
	add sp, sp, 12	@ Delete Activation Block of partition function
	sub sp, sp, 16	@ Create activation block for quicksort function
	st r2, [sp]		@ store the value of first element of partition
	st r4, 4[sp]	@ store the value of last element of partition
	st r5, 8[sp]	@ store the value of p (value of i returned by partition)
	st ra, 12[sp]	@ store the value of return address
	sub r5, r5, 4	@ decrement p, (this store the value of p which is used in quicksort
	mov r4, r5		@ function )
	call .quicksort	@ call quicksort
	ld r2, [sp]		
	ld r4, 4[sp]	
	ld r5, 8[sp]	
	ld ra, 12[sp]	
	add sp, sp, 16	@ Delete activation block of QuickSort Function
	sub sp, sp, 16	@ Create activation block of second QuickSort Function
	st r2, [sp]		@ store the value of first element of partition
	st r4, 4[sp]	@ store the value of last element of partition
	st r5, 8[sp]	@ store the value of p (value of i returned by partition)
	st ra, 12[sp]	@ store the value of return address
	add r5, r5, 4	@ increment p, (this store the value of p which is used in quicksort
	mov r2, r5		@function )
	call .quicksort	
	ld r2, [sp]	
	ld r4, 4[sp]	
	ld r5, 8[sp]	
	ld ra, 12[sp]	
	add sp, sp, 16	
	b .RET		
@----------------------------------------------------------------------------------------
@			Partition Algorithm
@----------------------------------------------------------------------------------------
@ partition(array[], start, end)
@ {
@	pivot = array[end]
@	i = start-1
@	j = start
@	while(j < end)
@	{
@		if(pivot > array[j])
@		{
@			i++
@			swap array[i] and array[j]
@		}
@	}
@	i++
@	swap array[i] and array[end]
@	i++
@	return
@ }
@----------------------------------------------------------------------------------------
@		Begining of Partition Algorithm 
@----------------------------------------------------------------------------------------
.partition:		
	ld r6, [r4]   	@ Select last element as pivot element
	sub r5, r2, 4	@ initialise i with start-1
	mov r7, r2		@ initialise j with first element address
.LOOP:			
	ld r8, [r7]	 
	cmp r6, r8		@ Compare pivot > array[j]
	bgt .SWAP		@ if true increment i and swap element
	b .CHECK		
.SWAP:			
	ld r10, [r7]
	add r5, r5, 4	@ increment i i.e. i++
	ld r11, [r5]	@------------------------
	st r11, [r7]	@	Swap
	st r10, [r5]	@------------------------
	b .CHECK
.CHECK:			
	add r7, r7, 4		@ increment j i.e. j++
	cmp r4, r7			@ compare j < end
	bgt .LOOP			
	b .END			
.END:			
	ld r9, [r4]	@ 
	add r10, r5, 4	@ increment i
	ld r11, [r10]	@-----------------------
	st r11, [r4]	@	Final Swap
	st r9, [r10]	@-----------------------
	add r5, r5, 4	@ again increment i to return
	b .RET			@ return 
.RET:
	ret
@---------------------------------------------------------------------------------------
@			Main Function
@---------------------------------------------------------------------------------------
.main:

	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12		@ replace 12 with the number to be sorted
	st r1, 0[r0]
	mov r1, 7		@ replace 7 with the number to be sorted
	st r1, 4[r0]
	mov r1, 11  	@ replace 11 with the number to be sorted
	st r1, 8[r0]
	mov r1, 9   	@ replace 9 with the number to be sorted
	st r1, 12[r0]
	mov r1, 3   	@ replace 3 with the number to be sorted
	st r1, 16[r0]
	mov r1, 15  	@ replace 15 with the number to be sorted
	st r1, 20[r0]
	mov r1, 17  	@ replace 15 with the number to be sorted
	st r1, 24[r0]
	mov r1, 21  	@ replace 15 with the number to be sorted
	st r1, 28[r0]
	mov r1, 25  	@ replace 15 with the number to be sorted
	st r1, 32[r0]
	mov r1, 14  	@ replace 15 with the number to be sorted
	st r1, 36[r0]
	mov r1, 19  	@ replace 15 with the number to be sorted
	st r1, 40[r0]
	@ EXTEND ON SIMILAR LINES FOR MORE NUMBERS

	mov r2, 0		@ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 10		@ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted
	mul r3, r3, 4		
	add r4, r2, r3
	
	@ ADD YOUR CODE HERE 

	call .quicksort

 	@ ADD YOUR CODE HERE

	@ Print statements for the result
	mov r3, 10      @ REPLACE 5 WITH N-1, where, N is the number of numbers being sorted 
	mov r2, 0      @ Starting address of the array
.printLoop:
	ld r1, 0[r2]
	.print r1
	add r2,r2,4  @ Incrementing address value
	cmp r3, 0@ r3 contains number of elements in array
	
	
	
	sub r3,r3,1
	bgt .printLoop
