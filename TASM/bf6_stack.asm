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
 mov DL, i           ; иначе загружаем
 push DX 
next5:
 cmp DL, 5Dh         ; ячейка содержит ]
 jne next6           ; нет, переходим на метку next6
 ;sub AX,AX
 pop AX
 mov BL, j
 mov DL, data_arr[BX]
 cmp DL, 00          ; да, проверяем текущий элемент data_arr на ноль  
 jz next6            ; если ноль, прыгаем дальше
 mov i, AL ; DL           ; в i_stor значение переменной i
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
; mov DL, 00h
; mov i, DL
; ;;;;;;;;;;;;;;;;;
; mov DL, data_arr      ; загружаем в DL 1ую команду 
; mov CX, 0Ah           ;  10 тактов
;_prev:                    
; cmp DL, 00h           ; ячейка содержит 0
; jne _next0            ; нет, переходим на метку _next  
; mov BL, i            
; mov data_arr[BX], 30h ; да, загружаем в BL символ "0"
;_next0: 
; cmp DL, 01h         
; jne _next1             
; mov BL, i 
; mov data_arr[BX], 31h     
;_next1: 
; cmp DL, 02h         
; jne _next2             
; mov BL, i 
; mov data_arr[BX], 32h               
;_next2: 
; cmp DL, 03h         
; jne _next3             
; mov BL, i 
; mov data_arr[BX], 33h
;_next3: 
; cmp DL, 04h         
; jne _next4             
; mov BL, i 
; mov data_arr[BX], 34h
;_next4:
; cmp DL, 05h         
; jne _next5           
; mov BL, i 
; mov data_arr[BX], 35h 
;_next5:
; cmp DL, 06h         
; jne _next6           
; mov BL, i 
; mov data_arr[BX], 36h
;_next6:
; cmp DL, 07h         
; jne _next7           
; mov BL, i 
; mov data_arr[BX], 37h
;_next7:
; cmp DL, 08h         
; jne _next8           
; mov BL, i 
; mov data_arr[BX], 38h
;_next8:
; cmp DL, 09h         
; jne _next9           
; mov BL, i 
; mov data_arr[BX], 39h     
;_next9:
; inc i               
; mov BL, i
; mov DL, data_arr[BX]   
; loop _prev          
;;;;;;;;;;;;;;;
 mov ah,09h
 mov dx,offset data_arr  ; указатель на массив символов
 		; вывести строку
 int 21h
 ;;;;;;;;;;;;;;;
 MOV    AH,2       ; переходим на новую строку
 MOV    DL,0Ah     
 INT    21h 
 ;;;;;;;;;;;;;;;        
 mov AX, 4c00h      ; завершение программы  
 int 21h 

END    start
;text ends

;data segment           
;  str_arr DB 256h DUP('$')	; буфер на 256 символов
; data_arr DB 0,0,0,0,0,0,0,0,0,0,'$'  ; данные
; i DB 0,'$'                              ;индекс элемента массива команд 
; j DB 0,'$'                            ;индекс элемента массива данных
; i_stor DB 0,'$'
;data ends

;stk segment para stack 
; db 100h dup (?)       ; резервируем 256 ячеек
;stk ends
;end begin 
