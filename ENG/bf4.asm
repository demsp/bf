JUMPS                                ; bf4.asm
text segment                    
assume cs:text,ds:data, ss: stk
begin:  
  mov AX,data                                             
  mov DS,AX
  ;;;
  mov ah, 3fh                 ; input function
  mov cx, 100h	              ; the number of bytes you want to read from the input
  mov dx,OFFSET command_mem
  int 21h
  ;;;             
  mov DL, command_mem    
  ;mov CX, 100h        
prev:
 cmp DL, '$' 
 je  exit_loop
 cmp DL, '+'                                
 jne next             
 mov BL, j                        
 inc data_mem[BX]     
next: 
 cmp DL, '-'                                
 jne next1             
 mov BL, j 
 dec data_mem[BX]     
next1: 
 cmp DL, '>'         
 jne next2             
 inc j               
next2: 
 cmp DL, '<'         
 jne next3             
 dec j               
next3: 
 cmp DL, '.'         
 jne next4             
 mov AH,2            
 mov BL, j
 mov DL, data_mem[BX]
 int 21h
next4:
 cmp DL, '['         
 jne next5           
 mov BL, j
 mov DL, data_mem[BX]
 cmp DL, 00            
 jz next5            
 mov DL, i           
 mov i_stor, DL      
next5:
 cmp DL, ']'         
 jne next6           
 mov BL, j
 mov DL, data_mem[BX]
 cmp DL, 00            
 jz next6            
 mov DL, i_stor      
 mov i, DL            
next6:
 inc i               
 mov BL, i
 mov DL, command_mem[BX]   
 jmp prev
 exit_loop: 
 
 MOV    AH,2       
 MOV    DL,0Ah     
 INT    21h        
 mov AX, 4c00h        
 int 21h 
text ends

data segment           
 command_mem DB 256h DUP('$')	
 data_mem DB 0,0,0,0,0,0,0,0,0,0,'$'  
 i DB 0,'$'                              
 j DB 0,'$'                            
 i_stor DB 0,'$'
data ends

stk segment para stack 
 db 100h dup (0)       
stk ends
end begin 
