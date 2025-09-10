;Write an assembly language program to implement a sorting program that will read an array of 
;numbers as input and then sort the numbers in (i) ascending order (ii) descending order as 
;output.


.MODEL SMALL

.STACK 100h

.DATA
   inputmsg DB 'Sample Input(0-9): $'
   arr DB 100 DUP('$')
   output DB 0Dh,0Ah,'Output: $'
   n DB ?
   space DB ' '
   newline DB 0Dh,0Ah,'$'
    
    
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    ;PROMPT FOR INPUT
    LEA DX,inputmsg
    MOV AH,09h
    INT 21h
    
     
    
TOTAL_NUM:
    MOV AH,01h
    INT 21h
    
    
    
    CMP AL,0Dh
    JE SORT_ASCENDING
    
    CMP AL,' '
    JE TOTAL_NUM
    
    
    
    CMP AL,'0'
    JB TOTAL_NUM
    CMP AL,'9'
    JA TOTAL_NUM
    
    MOV BYTE PTR arr[SI],AL
    
    INC SI
    
    JMP TOTAL_NUM
    
    
SORT_ASCENDING:

    


    MOV word ptr n,SI
         
         
    XOR CX,CX
       
    MOV CX,SI
    DEC CX
     
 
ASC_OUTERLOOP:
    PUSH CX
    MOV SI,0
    MOV DX,CX
     
    ; Swap
ASC_INNERLOOP:   
    MOV AL, arr[SI]
    MOV AH, arr[SI+1]
    CMP AL,AH
    JBE NO_SWAP
    
    MOV arr[SI],AH
    MOV arr[SI+1],AL
      
NO_SWAP:
    INC SI
    DEC DX
    JNZ ASC_INNERLOOP
     
    POP CX
    DEC CX
    JNZ ASC_OUTERLOOP
    
        
    ;print newline
    LEA DX, newline
    MOV AH,09h
    INT 21h    
        
    ; Display ascending order
    LEA DX,output
    MOV AH,09h
    INT 21h 
    
    MOV CX,word ptr n
    MOV SI,0 
    
    
    
    
PRINT_ASC:
    CMP CX,0
    JE SORT_DESC
    
    MOV DL, arr[SI]
    MOV AH,02h
    INT 21h 
    
    MOV DL, space
    MOV AH,02h
    INT 21h
    
    INC SI
    DEC CX
    JMP PRINT_ASC
    
    
              
SORT_DESC: 
    XOR CX,CX
    MOV CX, word ptr n
    DEC CX 
    
DESC_OUTER:
     PUSH CX
     MOV SI,0
     MOV DX,CX
     
DESC_INNER:
     MOV AL, arr[SI]
     MOV AH, arr[SI+1]
     CMP AL, AH
     JAE NO_SWAP_DESC
     
     ; Swap
     MOV arr[SI], AH
     MOV arr[SI+1], AL
     
NO_SWAP_DESC:
     INC SI
     DEC DX
     JNZ DESC_INNER
     POP CX
     DEC CX
     JNZ DESC_OUTER

    ; --- Print Descending Order ---
    ; print newline
    LEA DX, newline
    MOV AH,09h
    INT 21h

    LEA DX, output
    MOV AH,09h
    INT 21h

    MOV CX, word ptr n   ; reload total count
    MOV SI,0

PRINT_DESC:
    CMP CX,0
    JE END_PROGRAM       ; finish program

    MOV DL, arr[SI]
    MOV AH,02h
    INT 21h 
    
    MOV DL, space
    MOV AH,02h
    INT 21h
    
    INC SI
    DEC CX
    JMP PRINT_DESC

END_PROGRAM:    
    MOV AH,4Ch
    INT 21h

    
    
    ;EXIT PROGRAM
    MOV AH,4Ch
    INT 21h
    
    

MAIN ENDP
END MAIN
                      
                      