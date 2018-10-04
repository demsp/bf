; 16bit exe
model tiny
jumps
;.startup ;для MASM
.386
ORG    100h
.stack 100 
.data
;str_arr DB 100h DUP('$') ; буфер на 256 символов
;str_arr DB  2Bh,2Bh,2Bh, '$'   ; код +++
;str_arr DB  2Bh,2Bh,2Bh,5Bh, 2Eh,2Dh ,5Dh, '$'  ;код +++[.-]

;str_arr DB  2Bh,2Bh,2Bh,5Bh, 3Eh,2Bh,3Ch,2Dh ,5Dh,2bh, 2eh,3eh,2eh, '$'    ; код +++[>+<-]
;str_arr DB  2Bh,2Bh,2Bh,5Bh,  3Eh,2Bh,3Ch,2Dh,   5Dh,2Eh, 3Eh,2Bh,2Eh, '$' ; код +++[>+<-]>+
;str_arr DB  2Bh,2Bh,2Bh,5Bh,  3Eh,2Bh,3Ch,2Dh,   5Dh,2eh,  3Eh,2eh, '$'   ; код +++[>+<-].>.

 data_arr DB 0,0,0,0,0,0,0,0,0,0,'$'  ; данные
 i DB 0,'$'                           ;индекс элемента массива команд 
 j DB 0,'$'                           ;индекс элемента массива данных
 i_stor DB 0,'$'                        
.code
start: 

mov AX, @data        ; настраиваем сегмент данных                                       
  mov DS,AX             
  mov DL, str_arr    ; загружаем в DL 1ую команду 
  mov CX, 100h        ; 80 тактов  50
prev:                    
 cmp DL, 2Bh         ; ячейка содержит +
 jne next            ; нет, переходим на метку next  
 mov BL, j           ; загружаем в BL индекс данных
 inc data_arr[BX]    ; да, увеличиваем  значение в ячейке на 1
next: 
 cmp DL, 2Dh         ; ячейка содержит -
 jne next1           ; нет, переходим на метку next1  
 mov BL, j 
 dec data_arr[BX]    ;BX, но не Bl 
next1: 
 cmp DL, 3Eh         ; ячейка содержит >
 jne next2           ; нет, переходим на метку next2  
 inc j               ; да, переходим на сдедующий элемент массива data_arr
next2: 
 cmp DL, 3Ch         ; ячейка содержит <
 jne next3           ; нет, переходим на метку next3  
 dec j               ; да, переходим на предыдущий элемент массива data_arr
next3: 
 cmp DL, 2Eh         ; ячейка содержит .
 jne next4           ; нет, переходим на метку next4  
 mov AH,2            ; да, выводим содержимое ячейки
 mov BL, j
 mov DL, data_arr[BX]
 int 21h
next4:
 cmp DL, 5Bh         ; ячейка содержит [
 jne next5           ; нет, переходим на метку next5
 mov BL, j
 mov DL, data_arr[BX]
 cmp DL, 00          ; да, проверяем текущий элемент data_arr на ноль  
 jz next5            ; если ноль, прыгаем дальше
 mov DL, i           ; иначе загружаем 
 mov i_stor, Dl      ; в i_stor значение переменной i 
next5:
 cmp DL, 5Dh         ; ячейка содержит ]
 jne next6           ; нет, переходим на метку next6
 mov BL, j
 mov DL, data_arr[BX]
 cmp DL, 00          ; да, проверяем текущий элемент data_arr на ноль  
 jz next6            ; если ноль, прыгаем дальше
 mov DL, i_stor      ; иначе загружаем 
 mov i, Dl           ; в i_stor значение переменной i 
 
next6:
 inc i               ; переходим к следующей команде
 mov BL, i
 mov DL, str_arr[BX]   
 loop prev          ; прыгаем на метку prev:
         
 mov AX, 4c00h      ; завершение программы  
 int 21h 

 END    start  
