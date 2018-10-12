.model tiny                 ; ascii-decoder1.asm
jumps
.data
 data_arr DB 3,5,12,0,11,6,23,0,0,0,'$' ; данные
 i DB 0,'$' 

.code
ORG    100h
start:
;Подготовим все необходимое
  mov AX, @data               ; настраиваем сегмент данных                                       
  mov DS,AX
;;;;;;;;;;;;;;;;
 MOV    AH,2                  ; переходим на новую строку
 MOV    DL,0Ah     
 INT    21h 
;mov dx,offset data_arr       ; указатель на массив символов
;mov ah,09h		      ; вывести строку
;int 21h                    
    
mov CX, 0Ah
_prev:
;;выводим число
; mov BL,i
 sub AH, AH             ; обнуляем AH
 mov AL, data_arr[BX]    ; делимое
 mov BL, 10             ; делитель
 div BL                 ; теперь в AL=десятки, в AH=единицы
 mov BX,AX
 add BX,3030h
 mov AH,2            ; функция вывода символа прерывания 21h 
 mov DL,BL           ; выводим старший разряд 
 int 21h 
 mov DL, BH          ; выводим младший разряд
 int 21h
; выводим пустой символ
sub DL, DL          
int 21h 
;;;
sub BX,BX
inc i                ; увеличиваем счётчик          
mov BL, i
loop _prev
;;;;;;;;;;
 MOV    AH,2       ; переходим на новую строку
 MOV    DL,0Ah     
 INT    21h        
  
 mov AX, 4c00h      ; завершение программы  
 int 21h 
end start
