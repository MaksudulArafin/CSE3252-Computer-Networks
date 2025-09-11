;Write an assembly language program to implement a prime number testing program that will 
;read a number N as input and then determine whether N is a prime number or not.



.MODEL SMALL

.STACK 100h

.DATA

    input DB 100 DUP('$')
    output DB 100 DUP('$')              
    newline DB 0Dh,0Ah,'$'
    notprime DB ' is not prime.$' 
    prime DB ' is prime.$'
    value DB ?      
                          
                          
                          

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    
     LEA DX,input
     MOV AH,0Ah
     INT 21h
     
     XOR AX,AX
     XOR CH,CH
     MOV CL,input+1   ;STRING SIZE
     LEA SI,input+2   ;CHARACTER START FROM
     
     
CONVERT_LOOP: 
    XOR BX,BX
    MOV BL,[SI]
    SUB BL,30h 
    
    MOV DX,AX
    MOV AX,10
    MUL DX
    ADD AX,BX
     
    INC SI
    LOOP CONVERT_LOOP 
    
    MOV WORD PTR value,AX
                             
    MOV CX,2                    
FIND_PRIME:
    XOR DX,DX 
    MOV AX,WORD PTR value             
    DIV CX 
    CMP DX,0
    JE NOT_PRIME
    
    INC CX 
    MOV AX,WORD PTR value
    CMP CX,AX
    JB  FIND_PRIME 
    
    
    MOV AX,WORD PTR value
     
    ;PRIME
    MOV CX,0
    MOV BX,10
CONVERT_ASCII1:
    XOR DX,DX
    DIV BX 
    PUSH DX 
    INC CX
    CMP AX,0
    JNE CONVERT_ASCII1
                     
                     
    LEA DI,output
PRINT_LOOP1: 
    POP DX
    ADD DX,30h
    MOV [DI], DX
    INC DI               
    LOOP PRINT_LOOP1 


          
    ;PRINT OUTPUT
    LEA DX,newline
    MOV AH,09h
    INT 21h
    
    LEA DX,output
    MOV AH,09h
    INT 21h
    
    LEA DX,prime
    MOV AH,09h
    INT 21h 
    
    JMP EXIT                         
    
    
NOT_PRIME: 
     MOV AX,WORD PTR value
           
    MOV CX,0
    MOV BX,10
CONVERT_ASCII2:
    XOR DX,DX
    DIV BX 
    PUSH DX 
    INC CX
    CMP AX,0
    JNE CONVERT_ASCII2
                     
                     
    LEA DI,output
PRINT_LOOP2: 
    POP DX
    ADD DX,30h
    MOV [DI], DX
    INC DI               
    LOOP PRINT_LOOP2 


          
    ;PRINT OUTPUT
    LEA DX,newline
    MOV AH,09h
    INT 21h
    
    LEA DX,output
    MOV AH,09h
    INT 21h
    

    LEA DX,notprime
    MOV AH,09h
    INT 21h

EXIT:
    ;EXIT PROGRAM
    MOV AH,4Ch
    INT 21h
    
    
MAIN ENDP
END MAIN