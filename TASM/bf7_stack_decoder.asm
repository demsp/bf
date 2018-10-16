.model tiny                      
jumps
.data
 str_arr DB 256h DUP('$')	; буфер на 256 символов
 data_arr DB 0,0,0,0,0,0,0,0,0,0,'$'  ; данные
 i DB 0,'$'                              ;индекс элемента массива команд 
 j DB 0,'$'                            ;индекс элемента массива данных
 i_stor DB 0,'$'

.code
ORG    100h
start:
 ;Подготовим все необходимое
  mov AX,@data          ; настраиваем сегмент данных                                       
  mov DS,AX
  ;;;
  mov ah, 3fh          ; функция ввода
  mov cx, 100h	        ; 256 символов
  mov dx,OFFSET str_arr
  int 21h
  ;;;             
  mov DL, str_arr      ; загружаем в DL 1ую команду 
  ;mov CX, 100h        ; 256 тактов
prev:
 cmp DL, 24h ; символ '$'
 je  exit_loop
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
 inc j               ; да, переходим на следующий элемент массива data_arr
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
 ;sub DX,DX
 mov AL, i           ; иначе загружаем
 push AX 
next5:
 cmp DL, 5Dh         ; ячейка содержит ]
 jne next6           ; нет, переходим на метку next6
 sub AX,AX
 pop AX
 mov BL, j
 mov DL, data_arr[BX]
 cmp DL, 00          ; да, проверяем текущий элемент data_arr на ноль  
 jz next6            ; если ноль, прыгаем дальше
 mov i, AL           ; в i_stor значение переменной i
 mov BL, i
 mov DL, str_arr[BX]   
 jmp prev
next6:
 inc i               ; переходим к следующей команде
 mov BL, i
 mov DL, str_arr[BX]   
 jmp prev
 exit_loop: 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;Выод ascii-символов чисел;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MOV    AH,2         ; новая строка
 MOV    DL,0Ah       ; новая строка
 INT    21h          ; новая строка

; output data_arr    
mov CX, 0Ah          ; 10 тактов
sub AL,AL            ; обнуляем AL
mov i, AL            ; обнуляем счётчик
sub BX,BX            ; обнуляем BX
_prev:
; incorrect 1st element
 sub AH, AH             ; обнуляем AH
 mov AL, data_arr[BX]   ; делимое
 ;mov AL, data_arr+1 
 mov BL, 10             ; делитель
 div BL                 ; частное  AL=десятки и AH=единицы
 mov BX,AX
 add BX,3030h
 mov AH,2            ; функция вывода 2 прерывания 21h 
 mov DL,BL           ; выводим десятки  
 int 21h 
 mov DL, BH          ; выводим единицы
 int 21h
               ; выводим пробел (пустой символ)
sub DL, DL          
int 21h 
;;;
sub BX,BX
inc i                ; увеличиваем индекс массива
mov BL, i
loop _prev
;;;;;;;;;;
 MOV    AH,2       ; новая строка
 MOV    DL,0Ah     ; новая строка
 INT    21h        ; новая строка 
 ;;;;;;;;;;;;;;;        
 mov AX, 4c00h      ; завершение программы  
 int 21h 

END    start
