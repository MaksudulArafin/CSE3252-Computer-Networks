;Write an assembly language program to implement a case conversion program that will read a 
;string (a line of characters of letters, digits, punctuation symbols, and others) as input and then 
;convert the letters into its opposite case as output. Here, the characters which are not belonged 
;to letters will remain be unchanged 




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
    
    ;STRING START FROM [MAXLEN][LENGTH][CHARACTERS.....]
    MOV SI,2
    
    
CONVERT_STRING:
    MOV AL,input[SI]
    CMP AL,0Dh
    JE  CONVERT_DONE
    
    
    ;CHECK LETTER IS IN LOWER CASE 
    CMP AL,'a'
    JL TO_LOWER
    CMP AL,'z'
    JG INCREMENT
    SUB AL,20h  ;CHANGE IT TO UPPERCASE
    MOV input[SI], AL
    JMP INCREMENT
       
        
      
    ;CHECK LETTER IS IN UPPER CASE
TO_LOWER:
    CMP AL,'A'
    JL INCREMENT
    CMP AL,'Z'
    JG INCREMENT
    ADD AL,20h  ;CHANGE IT TO LOWERCASE
    MOV input[SI], AL
    
    
INCREMENT:
    INC SI
    JMP CONVERT_STRING    
    
    
            
    ;PRINT OUTPUT
CONVERT_DONE:
    LEA DX,outmsg
    MOV AH,09h
    INT 21h
    
    LEA DX,input+2
    MOV AH,09h
    INT 21h
    
    
    
    ;EXIT PROGRAM
    MOV AH,4Ch
    INT 21H
    
    
 
MAIN ENDP 
END MAIN
 