INCLUDE Irvine32.inc

.data
operand1 DWORD ?
operand2 DWORD ?
op BYTE ?

prompt1  BYTE  "Enter first number: ", 0
prompt2  BYTE  "Enter second number: ", 0
prompt3  BYTE  "Enter operator (+, -, *, /): ", 0
result   DWORD ?

invalid_input_msg BYTE "Invalid input!", 0
invalid_operator_msg BYTE "Invalid operator!", 0
result_msg BYTE "Result: ", 0

.code
main PROC
    mov edx, OFFSET prompt1  ; Prompt user for the first number
    call WriteString
    call ReadInt              ; Read integer from user input
    mov operand1, eax        ; Store the first number

    mov edx, OFFSET prompt2  ; Prompt user for the second number
    call WriteString
    call ReadInt              ; Read integer from user input
    mov operand2, eax        ; Store the second number

    mov edx, OFFSET prompt3  ; Prompt user for the operator
    call WriteString
    invoke ReadChar           ; Read a single character from user input
    mov op, al                ; Store the character as the operator

wait_for_enter:
    invoke ReadChar           ; Wait for the user to press Enter
    cmp al, 13               ; Check if the input character is Enter
    jne wait_for_enter        ; If not Enter, wait for Enter

    ; Perform operation based on the operator
    cmp op, '+'         ; Check if operator is addition
    je addition

    cmp op, '-'         ; Check if operator is subtraction
    je subtraction

    cmp op, '*'         ; Check if operator is multiplication
    je multiplication

    cmp op, '/'         ; Check if operator is division
    je division

    jmp invalid_operator      ; Jump to invalid_operator if operator is invalid

addition:
    mov eax, operand1
    add eax, operand2
    mov result, eax
    jmp display_result

subtraction:
    mov eax, operand1
    sub eax, operand2
    mov result, eax
    jmp display_result

multiplication:
    mov eax, operand1
    imul eax, operand2
    mov result, eax
    jmp display_result

division:
    mov eax, operand1
    cdq                       ; Clear EDX to prepare for division
    idiv operand2             ; Divide EAX by operand2, result in EAX, remainder in EDX
    mov result, eax
    jmp display_result

invalid_operator:
    mov edx, OFFSET invalid_operator_msg
    call WriteString
    jmp exit_program

display_result:
    mov edx, OFFSET result_msg
    call WriteString
    mov eax, result
    call WriteInt

    call DumpRegs             ; Display the register values

exit_program:
    exit
main ENDP

END main
