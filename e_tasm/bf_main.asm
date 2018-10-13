.model tiny            ; it works correctly
jumps
.data
 str_arr DB 256h DUP('$')	         ; 256 symbols buffer
 data_arr DB 0,0,0,0,0,0,0,0,0,0,'$'  ; data 'tape'
 i DB 0,'$'                           ;index of command array's element   
 j DB 0,'$'                           ;index of data array's element 
 i_stor DB 0,'$'

.code
ORG    100h
start:
  mov AX, @data       ; set DS                                       
  mov DS,AX  
                           
  mov ah, 3fh        ; input function
  mov bx, 0          ; keyboard descriptor
  mov cx, 10h	       ; 16 symbols
  mov dx,OFFSET str_arr
  int 21h
  ;;;             
  mov DL, str_arr    ; load 1st command to DL  
  mov CX, 100h       ; 256 number of occurrences
prev:                    
 cmp DL, 2Bh         ; if cell contains +
 jne next            ; if no, go to  next  
 mov BL, j           ; load data index to BL 
 inc data_arr[BX]    ; if yes, inc cell to 1
next: 
 cmp DL, 2Dh         ; if cell contains -
 jne next1           ; if no, go to  next 1  
 mov BL, j 
 dec data_arr[BX]    ;BX, not Bl 
next1: 
 cmp DL, 3Eh         ; if cell contains >
 jne next2           ; if no, go to  next2  
 inc j               ; if yes, go to next element of data_arr
next2: 
 cmp DL, 3Ch         ; if cell contains <
 jne next3           ; if no, go to next3  
 dec j               ; if yes, go to previous element of data_arr
next3: 
 cmp DL, 2Eh         ; if cell contains .
 jne next4           ; if no, go to next4  
 mov AH,2            ; yes, output cell
 mov BL, j
 mov DL, data_arr[BX]
 int 21h
next4:
 cmp DL, 5Bh         ; if cell contains [
 jne next5           ; if no, go to  next5
 ;mov BL, j
 ;mov DL, data_arr[BX]
 ;cmp DL, 00           
 ;jz next5            
 mov DL, i           
 mov i_stor, DL       ; load i to i_stor
next5:
 cmp DL, 5Dh          ; if cell contains ]
 jne next6            ; if no, go to next6
 mov BL, j
 mov DL, data_arr[BX]
 cmp DL, 00           ; if yes, check current data_arr element by zero  
 jz next6             ; if zero, jump further
 mov DL, i_stor       ; otherwise 
 mov i, Dl            ; load i  to i_stor 
 
 next6:              
 inc i                ; increment index of str_arr
 mov BL, i
 mov DL, str_arr[BX]  ; go to next bf-command
 loop prev            ; jump to prev:
 
 
 MOV    AH,2          ;  new line
 MOV    DL,0Ah        ;  new line
 INT    21h           ;  new line
 mov AX, 4c00h        ; terminate 
 int 21h 
end start
