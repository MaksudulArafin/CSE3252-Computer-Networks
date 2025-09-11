;Write an assembly language program to implement an even-odd testing program that will read 
;a number N as input and then determine whether N is an even number or an odd number.  

                                                                       
.MODEL SMALL

.STACK 100h

.DATA
    inputmsg DB 'Enter a Number: $'
    arr DB 100 DUP('$')
    num DB ? 
    output_even DB ' is Even.$'  
    output_odd DB ' is Odd.$'
    newline DB 0Dh,0Ah,'$'


.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    
    
    
    ;PROMPT FORM INPUT
    LEA DX,inputmsg 
    MOV AH,09h
    INT 21h          
    
    MOV SI,0           
    
    ;TAKE INPUT FROM USER
READ_LOOP:
   
    MOV AH,01h
    INT 21h
    
    
    ;ENTER CHECKING
    CMP AL,0Dh
    JE EVEN_ODD
    
  
    
    MOV BL,AL
    MOV arr[SI],AL
    INC SI
    SUB BL,30h 
    
    JMP  READ_LOOP
    
    
    
   ;CHECK IT IS EVEN OR ODD
EVEN_ODD:
    

   AND BL,1 
   CMP BL,0
   JE EVEN
   

ODD:
    LEA DX,newline
    MOV AH,09h
    INT 21h
      
    LEA DX,arr
    MOV AH,09h
    INT 21h


    LEA DX,output_odd
    MOV AH,09h
    INT 21h
    
    JMP EXIT
   
   
EVEN: 


    LEA DX,newline
    MOV AH,09h
    INT 21h
      
    LEA DX,arr
    MOV AH,09h
    INT 21h

    LEA DX,output_even
    MOV AH,09h
    INT 21h
    
EXIT:
   ;EXIT PROGRAM
   MOV AH,4Ch
   INT 21h
    
    
    
MAIN ENDP
END MAIN
                                                                       
