.model tiny
jumps
.data
 str_arr DB 256h DUP('$')	       
  data_arr DB 0,0,0,0,0,0,0,0,0,0,'$'   
 i DB 0,'$'                           
 j DB 0,'$'                           
 i_stor DB 0,'$'

.code
ORG    100h
start:

  mov AX, @data                                              
  mov DS,AX
  ;;;
  mov ah, 3fh          
  mov cx, 100h	       
  mov dx,OFFSET str_arr
  int 21h
  ;;;             
  mov DL, str_arr      
prev:
 cmp DL, 24h          
 je  exit_loop
                  
 cmp DL, 2Bh                                
 jne next             
 mov BL, j                        
 inc data_arr[BX]     
next: 
 cmp DL, 2Dh                                
 jne next1             
 mov BL, j 
 dec data_arr[BX]     
next1: 
 cmp DL, 3Eh         
 jne next2            
 inc j               
next2: 
 cmp DL, 3Ch         
 jne next3            
 dec j               
next3: 
 cmp DL, 2Eh         
 jne next4           
 mov AH,2            
 mov BL, j
 mov DL, data_arr[BX]
 int 21h
next4:
 cmp DL, 5Bh         
 jne next5           
 ;mov BL, j
 ;mov DL, data_arr[BX]
 ;cmp DL, 00            
 ;jz next5            
 mov DL, i            
 mov i_stor, Dl      
next5:
 cmp DL, 5Dh         
 jne next6           
 mov BL, j
 mov DL, data_arr[BX]
 cmp DL, 00            
 jz next6            
 mov DL, i_stor       
 mov i, DL            
next6:
 inc i               
 mov BL, i
 mov DL, str_arr[BX] 
; loop prev          
 jmp prev
 exit_loop: 
 ;;;;;;;;;;;;;;;;
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
  
 mov AX, 4c00h     ; завершение программы
 int 21h 
end start
