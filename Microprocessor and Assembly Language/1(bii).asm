;Write an assembly language program to implement a string reversal program that will read a 
;string (a line of characters of letters, digits, punctuation symbols, and others) as input and then 
;make the reverse form of the string as output. You have to solve this problem in two ways such 
;as (ii) using stack 


.MODEL SMALL  

.STACK 100h 

.DATA
    msg DB 'Enter a String: $'
    input DB 100 DUP('$')
    outmsg DB 0Dh,0Ah,'Revered String: $'

.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    ;PROMPT FOR INPUT
    LEA DX,msg
    MOV AH,09h
    INT 21h
    
    ;TAKE INPUT FROM USER
    LEA DX,input
    MOV AH,0Ah 
    INT 21h 
    
    
    ;FIXED SIZE OF INPUT
    MOV SI,2
    MOV CH,0
    MOV CL,input[1]
    MOV DI,CX
    
PUSH_LOOP:
    CMP DI,0
    JE POP_START
    
    MOV AH,0
    MOV AL,input[SI]
    PUSH AX
    INC SI
    DEC DI
    JMP PUSH_LOOP
    
POP_START:
    MOV SI,2 
    MOV CH,0
    MOV CL,input[1]
    MOV DI,CX
    
    
POP_LOOP:
    CMP DI,0
    JE REVERSED_DONE
    
    POP AX
    MOV input[SI],AL
    INC SI
    DEC DI
    JMP POP_LOOP
    
    
    
REVERSED_DONE:
    LEA DX,outmsg
    MOV AH,09h 
    INT 21h
    
    LEA DX,input+2
    MOV AH,09h 
    INT 21h

    ;EXIT PROGRAM
    MOV AH,4Ch
    INT 21h
    
    
MAIN ENDP
END MAIN