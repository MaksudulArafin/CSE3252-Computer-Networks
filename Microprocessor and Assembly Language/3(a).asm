;Write an assembly language program to implement a counting program that will read a string (a 
;line of characters of letters, digits, punctuation symbols, and others) as input and then count the 
;number of Vowels, Consonants, Digits, and Spaces in the string as output. 



                           
                           
                           
.model small
.stack 100h
.data
    ; --- Constant strings for prompts and labels ---
    prompt_msg      db 'Enter a line of text: $'
    crlf            db 0Dh, 0Ah, '$' ; Carriage Return and Line Feed

    vowels_msg      db 0Dh, 0Ah, 'Number of Vowels:     $'
    consonants_msg  db 0Dh, 0Ah, 'Number of Consonants: $'
    digits_msg      db 0Dh, 0Ah, 'Number of Digits:     $'
    spaces_msg      db 0Dh, 0Ah, 'Number of Spaces:     $'

    ; --- Buffer for user input ---
    ; First byte: max characters to read
    ; Second byte: actual number of characters read by INT 21h, AH=0Ah
    ; Following bytes: the input string itself
    input_buffer    db 255, 0, 255 dup('$')

    ; --- Variables for storing counts ---
    vowel_count     dw 0
    consonant_count dw 0
    digit_count     dw 0
    space_count     dw 0

.code
main proc
    ; --------------------------------------------------------------------------
    ; 1. Initialize Data Segment (DS)
    ; --------------------------------------------------------------------------
    mov ax, @data
    mov ds, ax

    ; --------------------------------------------------------------------------
    ; 2. Prompt for and read the input string
    ; --------------------------------------------------------------------------
    ; Display prompt message
    mov ah, 09h
    lea dx, prompt_msg
    int 21h

    ; Read a string from the keyboard
    mov ah, 0Ah
    lea dx, input_buffer
    int 21h

    ; --------------------------------------------------------------------------
    ; 3. Loop through the string and count character types
    ; --------------------------------------------------------------------------
    lea si, input_buffer + 2 ; Point SI to the start of the actual string
    mov cl, [input_buffer + 1] ; Get the actual length of the string into CL
    mov ch, 0                  ; Clear CH so CX holds the length
    jcxz end_processing        ; If string is empty (length 0), skip processing

process_loop:
    mov al, [si] ; Get the character into AL

    ; Check if it's a space
    cmp al, ' '
    je is_space

    ; Check if it's a digit ('0' through '9')
    cmp al, '0'
    jb check_letter
    cmp al, '9'
    ja check_letter
    jmp is_digit

check_letter:
    ; Convert to lowercase to simplify vowel/consonant checking
    ; This works for both uppercase ('A'-'Z') and lowercase ('a'-'z')
    or al, 20h ; 'A' (41h) | 20h = 'a' (61h)

    ; Check if it's a letter
    cmp al, 'a'
    jb other_char ; If less than 'a', it's not a letter (e.g., punctuation)
    cmp al, 'z'
    ja other_char ; If greater than 'z', it's not a letter

    ; Check if it's a vowel
    cmp al, 'a'
    je is_vowel
    cmp al, 'e'
    je is_vowel
    cmp al, 'i'
    je is_vowel
    cmp al, 'o'
    je is_vowel
    cmp al, 'u'
    je is_vowel

    ; If it's a letter but not a vowel, it's a consonant
    jmp is_consonant

; --- Handlers to increment the correct counter ---
is_space:
    inc space_count
    jmp next_char

is_digit:
    inc digit_count
    jmp next_char

is_vowel:
    inc vowel_count
    jmp next_char

is_consonant:
    inc consonant_count
    jmp next_char

other_char:
    ; This handles punctuation and other symbols, which are ignored.

next_char:
    inc si    ; Move to the next character in the string
    loop process_loop ; Decrement CX and jump if not zero

end_processing:
    ; --------------------------------------------------------------------------
    ; 4. Print the results
    ; --------------------------------------------------------------------------
    ; Print Vowels count
    mov ah, 09h
    lea dx, vowels_msg
    int 21h
    mov ax, vowel_count
    call print_number

    ; Print Consonants count
    mov ah, 09h
    lea dx, consonants_msg
    int 21h
    mov ax, consonant_count
    call print_number

    ; Print Digits count
    mov ah, 09h
    lea dx, digits_msg
    int 21h
    mov ax, digit_count
    call print_number

    ; Print Spaces count
    mov ah, 09h
    lea dx, spaces_msg
    int 21h
    mov ax, space_count
    call print_number

    ; --------------------------------------------------------------------------
    ; 5. Exit the program
    ; --------------------------------------------------------------------------
    mov ah, 4Ch
    int 21h

main endp



; ==============================================================================
; Procedure:    print_number
; Description:  Converts a 16-bit number in AX to an ASCII string and prints it.
; Input:        AX = the number to print.
; Output:       The number printed to the screen.
; ==============================================================================
print_number proc
    ; Handle the special case where the number is 0
    cmp ax, 0
    jne conversion_loop
    mov dl, '0'
    mov ah, 02h
    int 21h
    ret

conversion_loop:
    mov cx, 0   ; CX will count the number of digits
    mov bx, 10  ; Divisor for base 10 conversion

divide_loop:
    xor dx, dx  ; Clear DX before division (DX:AX is the dividend)
    div bx      ; AX = AX / 10, DX = remainder
    push dx     ; Push remainder onto the stack
    inc cx      ; Increment digit count
    cmp ax, 0   ; Is the quotient zero?
    jne divide_loop ; If not, repeat

print_loop:
    pop dx      ; Pop a digit's value
    add dl, '0' ; Convert to ASCII ('0' = 30h)
    mov ah, 02h ; DOS function to print a character
    int 21h
    loop print_loop ; Repeat for all digits

    ret
print_number endp

end main