LABEL prev,next;
var
 data_arr:array[1..10] of integer;    // массив данных
 str_arr: string;                     // команды  
 i,j,k: integer;                      // индексы строки и массива
begin
 i:=1;                  
 j:=1;
 readln(str_arr);       //считываем строку
 prev:
 if i>length(str_arr) then goto next; 
    if (str_arr[i]='+') then data_arr[j]:= data_arr[j]+1;
    if (str_arr[i]='-') then data_arr[j]:= data_arr[j]+1;
    if (str_arr[i]='>') then j:=j+1;
    if (str_arr[i]='<') then j:=j-1;
    if (str_arr[i]='.') then write(chr(data_arr[j])); 
    
 i:=i+1;
 goto prev;
 next:
// Выводим массив 
for k:=1 to 10 do begin 
write(data_arr[k]);
write(' ');
end;
end.
