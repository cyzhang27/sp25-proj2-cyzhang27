.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    blez a1, error_exit    # If a1 <= 0, jump to error_exit

    li t0, 0               # Index counter (i = 0)
    lw t1, 0(a0)           # Load first element as max value
    li t2, 0               # Set max index to 0
    li t3, 4               # Each integer is 4 bytes

loop_start:
    addi t0, t0, 1         # i = i + 1
    beq t0, a1, loop_end   # If i == length, exit loop
    
    mul t4, t0, t3         # Compute offset: i * 4
    add t5, a0, t4         # Compute address of A[i]
    lw t6, 0(t5)           # Load A[i] into t6
    
    ble t6, t1, loop_continue # If A[i] <= max, continue
    mv t1, t6              # Update max value
    mv t2, t0              # Update max index

loop_continue:
    j loop_start           # Repeat loop

loop_end:
    mv a0, t2              # Store max index in a0
    jr ra                  # Return

error_exit:
    li a0, 36              # Load return code 36 into a0
    j exit                 # quit the program