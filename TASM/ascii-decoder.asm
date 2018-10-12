.model tiny                 ; ascii-decoder.asm
jumps
.data
 data_arr DB 10,12,0,0,0,0,0,0,0,0,'$' ; данные

.code
ORG    100h
start:
;Подготовим все необходимое
  mov AX, @data          ; настраиваем сегмент данных                                       
  mov DS,AX
;;;;;;;;;;;;;;;;
 MOV    AH,2              ; переходим на новую строку
 MOV    DL,0Ah     
 INT    21h 
;mov dx,offset data_arr  	; указатель на массив символов
;mov ah,09h		            ; вывести строку
;int 21h        

;;выводим перое число
sub AH, AH          ; обнуляем AH
mov AL, data_arr    ; делимое
mov BL, 10          ; делитель
div BL              ; теперь в AL=десятки, в AH=единицы
mov BX,AX
add BX,3030h
mov AH,2            ; функция вывода символа прерывания 21h 
mov DL,BL           ; выводим старший разряд 
int 21h 
mov DL, BH          ; выводим младший разряд
int 21h
;выводим второе число
sub AH, AH           ; обнуляем AH
mov AL, data_arr+1   ; делимое
mov BL, 10           ; делитель
div BL               ; теперь в AL=десятки, в AH=единицы
mov BX,AX
add BX,3030h
mov AH,2            ; функция вывода символа прерывания 21h 
mov DL,BL           ; выводим старший разряд 
int 21h 
mov DL, BH          ; выводим младший разряд
int 21h
;;;;;;;;;;
 MOV    AH,2       ; переходим на новую строку
 MOV    DL,0Ah     
 INT    21h        
  
 mov AX, 4c00h      ; завершение программы  
 int 21h 
end start
