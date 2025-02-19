.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

    # Prologue
    # Prologue: Check for malformed input
    blez a2, error_exit_36   # If a2 <= 0, exit with code 36
    blez a3, error_exit_37   # If a3 <= 0, exit with code 37
    blez a4, error_exit_37   # If a4 <= 0, exit with code 37

    li t0, 0                 # t0 will store the dot product result
    li t1, 4                 # Each integer is 4 bytes

loop_start:
    beqz a2, loop_end        # If a2 (counter) reaches 0, exit loop

    lw t2, 0(a0)             # Load element from array 0
    lw t3, 0(a1)             # Load element from array 1

    mul t4, t2, t3           # Multiply the two elements
    add t0, t0, t4           # Add the product to the sum

    mul t5, a3, t1           # Compute byte stride for array 0
    mul t6, a4, t1           # Compute byte stride for array 1
    add a0, a0, t5           # Move pointer for array 0
    add a1, a1, t6           # Move pointer for array 1

    addi a2, a2, -1          # Decrement count
    j loop_start             # Repeat loop

loop_end:
    mv a0, t0                # Move result into return register
    jr ra                    # Return

error_exit_36:
    li a0, 36                # Load return code 36
    j exit                   # Jump to exit

error_exit_37:
    li a0, 37                # Load return code 37
    j exit                   # Jump to exit
