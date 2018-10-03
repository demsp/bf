text segment
assume cs:text,ds:data,ss:stk
begin: 
 ;Подготовим все необходимое
  mov AX,data          ; настраиваем сегмент данных                                       
  mov DS,AX             
  mov DL, str_arr      ; загружаем в DL 1ую команду 
  mov CX, 0Ah          ; 10 тактов
prev:                    
 cmp DL, 2Bh           ; ячейка содержит +
 jne next              ; нет, переходим на метку next  
 mov BL, 00h           ; загружаем в BL индекс массива комманд
 inc data_arr[BX]      ; да, увеличиваем  значение в ячейке на 1
 next:
 inc i                 ; переходим на следующий символ массива команд
 mov BL, i
 mov DL, str_arr [BX]   
 loop prev 
         
  mov AX, 4c00h        ; завершение программы  
  int 21h 
text ends

data segment           
str_arr DB  2Bh,2Bh,2Bh,'$' ; инструкции "+++"
data_arr DB 1,1,1,1,1,1,1,1,1,1,'$' ; данные
i DB 0                  ;индекс элемента массива команд 
data ends

stk segment stack      
 db 256 dup (0)        ; помещаем нули в стек
stk ends
end begin      
