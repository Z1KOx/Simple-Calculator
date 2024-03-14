INCLUDE Irvine32.inc

.data
num1 DWORD ?
num2 DWORD ?
op BYTE ?

prompt1  BYTE  "Enter first number: ", 0
prompt2  BYTE  "Enter second number: ", 0
prompt3  BYTE  "Enter operator: ", 0
result   DWORD ?

invalid_operator_msg BYTE "Invalid operator!", 0
newline db 10, 13, 0
space BYTE ' ', 0 
equals BYTE '=', 0

.code
main PROC
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
    mov eax, num1
    add eax, num2
    mov result, eax
    
    jmp display_result

subtraction:
    mov eax, num1
    sub eax, num2
    mov result, eax

    jmp display_result

multiplication:
    mov eax, num1
    imul eax, num2
    mov result, eax
    
    jmp display_result

division:
    mov eax, num1
    cdq                       ; Clear EDX to prepare for division
    idiv num2                 ; Divide EAX by num2, result in EAX, remainder in EDX
    mov result, eax
    
    jmp display_result

invalid_operator:
    mov edx, OFFSET newline
    call WriteString
    
    mov edx, OFFSET invalid_operator_msg
    call WriteString
    
    mov edx, OFFSET newline
    call WriteString

    jmp operator_input

display_result:
    mov edx, OFFSET newline  ; Print newline
    call WriteString

    mov eax, num1            ; Print num1
    call WriteInt

    mov edx, OFFSET space    ; Print space
    call WriteString

    mov al, op               ; Print '+'
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

    jmp exit_program

exit_program:
    ret
main ENDP

END main