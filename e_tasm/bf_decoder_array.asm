.model tiny
jumps
.data
 str_arr DB 256h DUP('$')	       ;  256 symbols
 data_arr DB 0,0,0,0,0,0,0,0,0,0,'$'   ;  data array
 i DB 0,'$'                            ; index of string element 
 j DB 0,'$'                            ; index of data element
 i_stor DB 0,'$'

.code
ORG    100h
start:

  mov AX, @data          ; set DS                                       
  mov DS,AX
  ;;;
  mov ah, 3fh          ; input function of 21h
  mov cx, 100h	        ; 256 symbols
  mov dx,OFFSET str_arr
  int 21h
  ;;;             
  mov DL, str_arr      ; load 1st command to DL 
prev:
 cmp DL, 24h           ; symbol '$'
 je  exit_loop
                  
 cmp DL, 2Bh         ; if cell contains +                        
 jne next            ; if no, go to  next   
 mov BL, j           ; load data index to BL              
 inc data_arr[BX]    ; if yes, inc cell to 1  
next: 
 cmp DL, 2Dh         ; if cell contains -                       
 jne next1           ; if no, go to next1  
 mov BL, j 
 dec data_arr[BX]    ; dec cell to 1 
next1: 
 cmp DL, 3Eh         ; if cell contains >
 jne next2           ; if no, go to next2  
 inc j               ; if yes, go to next element of data_arr
next2: 
 cmp DL, 3Ch         ; if cell contains <
 jne next3           ; if no, go to  next3  
 dec j               ; if yes, go to previous element of data_arr
next3: 
 cmp DL, 2Eh         ; if cell contains .
 jne next4           ; if no, go to next4  
 mov AH,2            ; if yes, output cell
 mov BL, j
 mov DL, data_arr[BX]
 int 21h
next4:
 cmp DL, 5Bh         ; if cell contains [
 jne next5           ; if no, go to next5
 ;mov BL, j
 ;mov DL, data_arr[BX]
 ;cmp DL, 00          ; if yes, check current data_arr element by zero  
 ;jz next5            ; if zero, jump further
 mov DL, i           ; otherwise  
 mov i_stor, Dl      ; load i to i_stor
next5:
 cmp DL, 5Dh         ; if cell contains ]
 jne next6           ; if no, go to next6
 mov BL, j
 mov DL, data_arr[BX]
 cmp DL, 00          ; if yes, check current data_arr element by zero  
 jz next6            ;  if zero, jump further
 mov DL, i_stor      ; otherwise 
 mov i, DL           ; load i to i_stor 
next6:
 inc i               ; increment index of str_arr
 mov BL, i
 mov DL, str_arr[BX] ; go to next bf-command  
 jmp prev            ; jump to prev:
 exit_loop: 
 
 MOV    AH,2         ; new line
 MOV    DL,0Ah       ; mew line
 INT    21h          ; new line

; output data_arr    
mov CX, 0Ah          ; 10 count of cycles
sub AL,AL            ; zeroize AL
mov i, AL            ; load zero to i
_prev:
;output ascii_digit

 sub AH, AH             ; zeroize AH
 mov AL, data_arr[BX]   ; dividend
 mov BL, 10             ; divisor
 div BL                 ; quotient  AL=tens and AH=units 
 mov BX,AX
 add BX,3030h
 mov AH,2            ; output func of 21h 
 mov DL,BL           ; output tens  
 int 21h 
 mov DL, BH          ; output units
 int 21h
               ; output empty symbol
sub DL, DL          
int 21h 
;;;
sub BX,BX
inc i                ; increment counter of index          
mov BL, i
loop _prev
;;;;;;;;;;
 MOV    AH,2       ; new line
 MOV    DL,0Ah     ; new line
 INT    21h        ; new line 
  
 mov AX, 4c00h     ; terminate programm  
 int 21h 
end start
