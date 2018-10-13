.model tiny                     ; ascii-decoder
jumps
.data
 data_arr DB 3,5,12,0,11,6,23,0,0,0,'$' ; data array
 i DB 0,'$' 

.code
ORG    100h
start:
;Подготовим все необходимое
  mov AX, @data               ; set DS
  mov DS,AX
;;;;;;;;;;;;;;;;
 MOV    AH,2                  ; new line
 MOV    DL,0Ah                ; new line
 INT    21h                   ; new line
    
mov CX, 0Ah                   ; count of cycles
_prev:
 sub AH, AH                   ; zeroize AH
 mov AL, data_arr[BX]         ; dividend
 mov BL, 10                   ; divisor
 div BL                       ; quotient  AL=tens and AH=units 
 mov BX,AX
 add BX,3030h
 mov AH,2              ; output func of 21h 
 mov DL,BL                    ; output tens 
 int 21h 
 mov DL, BH                   ; output units
 int 21h

; output empty symbol
sub DL, DL          
int 21h 
;;;
sub BX,BX
inc i                          ; increment counter of index
mov BL, i
loop _prev
;;;;;;;;;;
 MOV    AH,2                   ; new line
 MOV    DL,0Ah                 ; new line
 INT    21h                    ; new line
  
 mov AX, 4c00h                 ; terminate
 int 21h 
end start
