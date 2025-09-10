; Write an assembly language program to implement a searching program that will read a string 
;(a line of letters of English alphabet) as input and then find out the first capital letter which is 
;occurred first and last capital letter which is occurred last in the alphabetical order as output. 
;Your program will display a message with “No Capitals” when there is no capital letter in the 
;string.     



.MODEL SMALL

.STACK 100h

.DATA

   inputmsg DB 'Enter the String: $'
   input_buffer DB 100
                DB  ?
   storage_buffer DB 100 DUP('$')
   
   firstChar DB '{'    ;ASCII [ = 91
   lastChar  DB '@'    ;ASCII @ = 64
   capital DB 0
   
   newline DB 0Dh,0Ah,'$'
   output_noCapital DB 0Dh,0Ah,'No Capital Found.$'
   output_noString DB   0Dh,0Ah,'No String given.$'
   output_1stCapital   DB   0Dh,0Ah,'First Capital: $' 
   output_lastCapital   DB   0Dh,0Ah,'Last Capital: $'
   
   
   
.CODE 
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
        
    ;PROMPT FOR INPUT
    LEA DX,inputmsg
    MOV AH,09h
    INT 21h   
    
    ;TAKE STRING FROM USER
    LEA DX,input_buffer
    MOV AH,0Ah                        
    INT 21h 
    
    ; A NEWLINE
    LEA DX,newline
    MOV AH,09h
    INT 21h
                              
    
    
    LEA SI, storage_buffer  ; SI CONTAIN THE ADDRESS OF THE 1ST CHARACTER OF STRING
    
    XOR CH,CH
    MOV CL, input_buffer[1] ; OR  MOV CL, input_buffer+1  // CL WILL HOLD THE LENGTH OF STRING
    

    JCXZ NO_STRING   ; IF CX IS ZERO THAN NO STRING IS ENTERED
    

START_LOOP:
    MOV AL, [SI]    ; IT WILL MOV THE VALUE OF SI INTO AL // MOV AL, SI WILL MOVE ADDRESS TO AL
    
    ;CHECKING IF LETTER IS CAPITAL OR NOT IF NOT ESCAPE TO NET CHARACTER
    CMP AL, 'A'
    JB  NEXT_CHAR 
    CMP AL, 'Z'
    JA  NEXT_CHAR 
                 
    ;MAKED CAPITAL=1 IF WE GET ANY CAPITAL IN STRING
    MOV  capital,1
    
                        
    ; WE CHECK 
    CMP AL, firstChar
    JAE NEXT_CAPITAL
    MOV  firstChar,AL
    
    
    
    
NEXT_CAPITAL:
    CMP AL,lastChar
    JBE NEXT_CHAR
    MOV lastChar,AL
    
    
    
    
    
    
NEXT_CHAR: 
    INC SI
    LOOP START_LOOP
   
    CMP capital,0
    JE PRINT_NO_CAPITAL
    
    
    
    LEA DX,output_1stCapital
    MOV AH,09h
    INT 21h 
     
   
    MOV DL,firstChar
    MOV AH,02h
    INT 21h

    
    LEA DX,newline
    MOV AH,09h
    INT 21h
    
    
    LEA DX,output_lastCapital
    MOV AH,09h
    INT 21h
            
   
    MOV DL,lastChar
    MOV AH,02h
    INT 21h 
    
    JMP EXIT_PROGRAM
            
    

    
PRINT_NO_CAPITAL:
    LEA DX,output_noCapital
    MOV AH,09h
    INT 21h
    
     JMP EXIT_PROGRAM


NO_STRING:
    LEA DX,output_noString
    MOV AH,09h
    INT 21h
    

   ;check the letter is capital or not
    
EXIT_PROGRAM:
    MOV AH,4Ch
    INT 21h
       
    
MAIN ENDP
END MAIN