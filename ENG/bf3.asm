text segment                      ; bf3.asm 
assume cs:text, ds:data, ss:stk
begin: 
mov AX,data        ; set the data segment                                       
  mov DS,AX             
  mov DL, command_mem  
  mov CX, 50h        
  
prev:                    
 cmp DL, '+'         ; ячейка содержит +
 jne next            ; нет, переходим на метку next  
 mov BL, j           ; загружаем в BL индекс данных
 inc data_mem[BX]    ; да, увеличиваем  значение в ячейке на 1
next: 
 cmp DL, '-'         ; ячейка содержит -
 jne next1           ; нет, переходим на метку next1  
 mov BL, j 
 dec data_mem[BX]    ;BX, но не Bl 
next1: 
 cmp DL, '>'         ; ячейка содержит >
 jne next2           ; нет, переходим на метку next2  
 inc j               ; да, переходим на сдедующий элемент массива data_arr
next2: 
 cmp DL, '<'         ; ячейка содержит <
 jne next3           ; нет, переходим на метку next3  
 dec j               ; да, переходим на предыдущий элемент массива data_arr
next3: 
 cmp DL, '.'         ; ячейка содержит .
 jne next4           ; нет, переходим на метку next4  
 mov AH,2            ; да, выводим содержимое ячейки
 mov BL, j
 mov DL, data_mem[BX]
 int 21h
next4:
 cmp DL, '['         ; ячейка содержит [
 jne next5           ; нет, переходим на метку next5
 mov BL, j
 mov DL, data_mem[BX]
 cmp DL, 00          ; да, проверяем текущий элемент data_arr на ноль  
 jz next5            ; если ноль, прыгаем дальше
 mov DL, i           ; иначе загружаем 
 mov i_stor, DL      ; в i_stor значение переменной i 
next5:
 cmp DL, ']'         ; ячейка содержит ]
 jne next6           ; нет, переходим на метку next6
 mov BL, j
 mov DL, data_mem[BX]
 cmp DL, 00          ; да, проверяем текущий элемент data_arr на ноль  
 jz next6            ; если ноль, прыгаем дальше
 mov DL, i_stor      ; иначе загружаем 
 mov i, DL           ; в i_stor значение переменной i 
next6:
 inc i               ; переходим к следующей команде
 mov BL, i
 mov DL, command_mem[BX]   
 loop prev          ; прыгаем на метку prev:  
         
  mov AX, 4c00h        ; terminate program
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
