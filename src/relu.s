.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    blez a1, error_exit    # If a1 <= 0, jump to error_exit


loop_start:
    li t0, 0                # Load zero into t0 (for comparison)
    li t1, 4                # Each integer is 4 bytes

loop_continue:
    beq a1, x0, loop_end    # If a1 (counter) reaches 0, exit loop
    lw t2, 0(a0)            # Load word from address in a0 into t2
    bge t2, t0, skip        # If t2 >= 0, skip setting it to zero
    sw t0, 0(a0)            # Store 0 at the address in a0

skip:
    add a0, a0, t1          # Move pointer to the next element (a0 += 4)
    addi a1, a1, -1         # Decrement the count (a1 -= 1)
    j loop_continue         # Repeat loop

loop_end:
    # Epilogue
    jr ra

error_exit:
    li a0, 36               # Load return code 36 into a0
    j exit            # quit the program