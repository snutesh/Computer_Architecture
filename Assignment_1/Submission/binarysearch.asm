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
	mov r2, r5		@ function )
	call .quicksort	
	ld r2, [sp]	
	ld r4, 4[sp]	
	ld r5, 8[sp]	
	ld ra, 12[sp]	
	add sp, sp, 16	
	b .RET	
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
	ld r9, [r4]	 
	add r10, r5, 4	@ increment i
	ld r11, [r10]	@-----------------------
	st r11, [r4]	@	Final Swap
	st r9, [r10]	@-----------------------
	add r5, r5, 4	@ again increment i to return
	b .RET			@ return 
.RET:
	ret
@-------------------------------------------------------------------------------
@				Binary Search Algortihm
@-------------------------------------------------------------------------------
@
@ binarySearch(array[], first, last, search_element)
@ {
@    if (last >= first) {
@        mid = first + (last - l) / 2;
@
@        if (array[mid] == search_element)
@            return mid;
@
@        if (array[mid] > search_element)
@            return binarySearch(array, first, mid - 1, search_element);
@
@        return binarySearch(array, mid + 1, last, search_element);
@    }
@    return -1;
@ }
@-------------------------------------------------------------------------------

.binarysearch:
	@ ADD YOUR CODE HERE
	cmp r2, r4		@ compare first and last index
	bgt .RET		@ if (first > last) implies element not found
	add r5, r2, r4	@ add first and last index
	div r5, r5, 8	@ divide the result by 2 to get mid element
	mul r5, r5, 4	
	ld r6, [r5]
	cmp r0, r6		@ compare the mid element with search element
	beq .FOUND		@ if equal jump to FOUND
	bgt .GTBS		@ if greater than mid element jump to GTBS(greater than binary search )
	sub r4, r5, 4	@ otherwise less than condition is followed
	sub sp, sp,4	@ in case of less than, left partition of mid element is considered
	st ra, [sp]		@ so last = mid - 1
	call .binarysearch	
	ld ra, [sp]
	add sp, sp, 4
	b .RET
.FOUND:
	mov r1, 1		@ if search is complete the flag is set to 1
	b .RET
.GTBS:
	add r2, r5, 4	@ in case of greater than, right partition of mid element is considered
	sub sp, sp,4	@ so first = mid + 1
	st ra, [sp]
	call .binarysearch
	ld ra, [sp]
	add sp, sp, 4
	b .RET	

.main:

	@ Loading the values as an array into the registers
	mov r0, 0    
	mov r1, 12		@ replace 12 with the number to be sorted
	st r1, 0[r0]	
	mov r1, 7		@ replace 7 with the number to be sorted
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
	mov r0, 3
	
	@Flag for storing the boolean result
	mov r1, 0
	
	mov r2, 0   	@ Starting address of the array
	
	@ Retreive the end address of the array
	mov r3, 6		@ REPLACE 6 WITH N, where, N is the number of numbers being sorted
	sub r3, r3, 1
	mul r3, r3, 4		
	add r4, r2, r3
	
	@ ADD YOUR CODE HERE
	sub sp, sp, 16
	st r0, [sp]
	st r1, 4[sp]
	st r4, 8[sp]
	st ra, 12[sp]
	call .quicksort
	ld r0, [sp]
	ld r1, 4[sp]
	ld r4, 8[sp]
	ld ra, 12[sp]
	add sp, sp, 16
	sub sp, sp, 4
	st ra, [sp]	
	call .binarysearch
	ld ra, [sp]
	add sp, sp, 4
	
	@ ADD YOUR CODE HERE

	@ Print statement for the result 
	@ Boolean result is stored in r1
	.print r1
    
