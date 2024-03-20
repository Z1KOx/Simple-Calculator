INCLUDE Irvine32.inc ; Include the Irvine32 library for input/output functions

.data
num1 DWORD ?
num2 DWORD ?
op BYTE ?
selection DWORD ?
result DWORD ? ; Variable to store the result of the operation

prompt1  BYTE  "Enter first number: ", 0
prompt2  BYTE  "Enter second number: ", 0
prompt3  BYTE  "Enter operator (+, -, *, /): ", 0
prompt4  BYTE  "(1) to continue using this calculator (2) exit calculator: ", 0 ; End print
goodbye_msg BYTE "Goodbye...", 0

invalid_operator_msg BYTE "Invalid operator! Please enter +, -, *, or /.", 0
newline db 10, 13, 0 ; Newline character sequence
space BYTE ' ', 0
equals BYTE '=', 0

.code
main PROC
program_start:
    mov edx, OFFSET prompt1   ; Prompt user for the first number
    call WriteString
    
    call ReadInt              ; Read integer from user input
    mov num1, eax             ; Store the first number

    mov edx, OFFSET prompt2   ; Prompt user for the second number
    call WriteString
   
    call ReadInt              ; Read integer from user input
    mov num2, eax             ; Store the second number

operator_input:
    mov edx, OFFSET prompt3   ; Prompt user for the operator
    call WriteString
 
    call ReadChar             ; Read a single character from user input
    mov op, al                ; Store the character as the operator
    
    call WriteChar            ; Print operator input
    call ReadChar             ; Wait for the user to press Enter
    
    jmp compare_operators
    
compare_operators:
    cmp op, '+'               ; Check if operator is addition
    je addition

    cmp op, '-'               ; Check if operator is subtraction
    je subtraction

    cmp op, '*'               ; Check if operator is multiplication
    je multiplication

    cmp op, '/'               ; Check if operator is division
    je division

    jmp invalid_operator      ; Jump to invalid_operator if operator is invalid

addition:
    mov eax, num1             ; Move num1 into eax register
    add eax, num2             ; Add num1 (in eax) with num2 and load result into eax register
    mov result, eax           ; Move result (in eax) into global variable result
    
    jmp display_result

subtraction:
    mov eax, num1             ; Move num1 into eax register
    sub eax, num2             ; Subtract num2 from num1 (in eax) and load result into eax register
    mov result, eax           ; Move result (in eax) into global variable result

    jmp display_result

multiplication:
    mov eax, num1             ; Move num1 into eax register
    imul eax, num2            ; Multiply num1 (in eax) with num2 and load result into eax register
    mov result, eax           ; Move result (in eax) into global variable result
    
    jmp display_result

division:
    mov eax, num1             ; Move num1 into eax register
    cdq                       ; Clear edx to prepare for division
    idiv num2                 ; Divide eax by num2, result in eax, remainder in edx
    mov result, eax           ; Move result (in eax) into global variable result
    
    jmp display_result

invalid_operator:
    mov edx, OFFSET newline                  ; Print newline
    call WriteString
    
    mov edx, OFFSET invalid_operator_msg     ; Print invalid operator message
    call WriteString
    
    mov edx, OFFSET newline                  ; Print newline
    call WriteString

    jmp operator_input                       ; Go back to operator_input

display_result:
    mov edx, OFFSET newline  ; Print newline
    call WriteString

    mov eax, num1            ; Print num1
    call WriteInt

    mov edx, OFFSET space    ; Print space
    call WriteString

    mov al, op               ; Print operator
    call WriteChar

    mov edx, OFFSET space    ; Print space
    call WriteString

    mov eax, num2            ; Print num2
    call WriteInt

    mov edx, OFFSET space    ; Print space
    call WriteString

    mov edx, OFFSET equals   ; Print '='
    call WriteString

    mov edx, OFFSET space    ; Print space
    call WriteString

    mov eax, result          ; Print result
    call WriteInt

    mov edx, OFFSET newline  ; Print newline
    call WriteString

calculate_again:
    mov edx, OFFSET prompt4  ; Prompt user exit or continue
    call WriteString

    mov eax, selection       ; Load selection into eax register
    call ReadInt

    mov edx, OFFSET newline  ; Print newline
    call WriteString
    mov edx, OFFSET newline  ; Print newline
    call WriteString

    call clrscr 

    cmp eax, 1               ; Compare eax(selection) register with 1
    je program_start

    cmp eax, 2               ; Compare eax(selection) register with 2
    je exit_program

    jmp calculate_again

exit_program:
    mov edx, OFFSET goodbye_msg  ; Print goodbye message
    call WriteString

    ret
main ENDP

END main