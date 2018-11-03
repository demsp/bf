text segment                      ; bf1.asm 
assume cs:text, ds:data, ss:stk
begin: 
  mov AX,data          ; set the data segment                                      
  mov DS,AX             
  mov DL, command_mem      ;  load the 1st command in the DL
  mov CX, 0Ah          ; 10 stages
prev:                    
 cmp DL, '+'           ; the cell contains +
 jne next              ; no, go to the label next:  
 mov BL, 00h           ; load into BL the index 
 inc data_mem[BX]      ; yes, we increase the value in the cell by 1 (inc means increment)
 next:
 inc i                 ; go to the next character in the array of commands
 mov BL, i
 mov DL, command_mem [BX]   
 loop prev 
         
  mov AX, 4c00h        ; terminate the program
  int 21h 
text ends

data segment           
command_mem DB  '+', '+', '+', '$' ;  
data_mem DB 1,1,1,1,1,1,1,1,1,1,'$' 
i DB 0                  ; command_mem index
data ends

stk segment stack      
 db 100h dup (0)       ;  reserve 256 cells
stk ends
end begin      
