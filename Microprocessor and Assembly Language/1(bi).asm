;Write an assembly language program to implement a string reversal program that will read a 
;string (a line of characters of letters, digits, punctuation symbols, and others) as input and then 
;make the reverse form of the string as output. You have to solve this problem in two ways such 
;as (i) using array (ii) using stack


.MODEL SMALL  

.STACK 100h

.DATA
    msg DB 'Enter a String: $'
    input DB 100 DUP('$')
    outmsg DB 0Dh,0Ah,'Converted String: $'
    
    
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
    
    ;FIND LENGTH OF INPUT
    MOV CL,input[1]
    MOV CH,0
    
    ;FIX THE POINTER FOR OUTPUT
    MOV SI,2
    MOV DI,SI
    ADD DI,CX
    DEC DI
    
    
    ;SWAPPING THE CHARACTERS
REVERSE_LOOP:
    CMP SI,DI
    JGE REVERSE_DONE

    MOV AL,input[SI]
    MOV BL,input[DI]
    MOV input[SI],BL
    MOV input[DI],AL
    
    INC SI
    DEC DI
    JMP REVERSE_LOOP
    
  
    
    
REVERSE_DONE:
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
