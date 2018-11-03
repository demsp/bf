text segment                      ; bf3.asm 
assume cs:text, ds:data, ss:stk
begin: 
mov AX,data        ; set the data segment                                       
  mov DS,AX             
  mov DL, command_mem  
  mov CX, 50h        
  
prev:                    
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
 cmp DL, '['          ; the cell contains [      
 jne next5            ; no, go to the label next5:      
 mov BL, j
 mov DL, data_mem[BX]
 cmp DL, 00h          ; yes, check the current data_mem element for zero            
 jz next5             ; if zero, jump further
 mov DL, i            ; otherwise load i to i_stor
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
 loop prev            
         
  mov AX, 4c00h        
  int 21h 
text ends

data segment           
command_mem DB  '+','+','+','+','[','>','+','<','-',']', '$'   
data_mem DB 0,0,0,0,0,0,0,0,0,0,'$' 
i DB 0                  ; command_mem index
j DB 0                  ; data_mem index
i_stor DB 0
data ends

stk segment stack      
 db 100h dup (0)       ;  reserve 256 cells
stk ends
end begin      
