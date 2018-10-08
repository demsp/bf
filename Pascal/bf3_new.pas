LABEL prev,next;
var
 data_arr:array[1..10] of integer;    // массив данных
 str_arr: string;                     // команды  
 i,j,k: integer;                       // индексы строки и массива
 i_stor: integer; 
begin
 j:=1;                  // нумерация элементов массива (внезапно) начинается с единицы
 i:=1;
 //readln(str_arr);       //считываем строку
 str_arr:='+++[>+>++<<-]';
 
 prev:
 if i>length(str_arr) then goto next; 
    if (str_arr[i]='+') then data_arr[j]:= data_arr[j]+1;
    if (str_arr[i]='-') then data_arr[j]:= data_arr[j]-1;
    if (str_arr[i]='>') then j:=j+1;
    if (str_arr[i]='<') then j:=j-1;
    if (str_arr[i]='.') then write(chr(data_arr[j]));
    // скобки [ и ]
    if (str_arr[i]='[') and (data_arr[j]>0) then
     begin  
      i_stor:=i;
      i := i+1;
      goto prev;
     end;
    if (str_arr[i]=']') and (data_arr[j]>0) then
     begin  
       i:=i_stor;
       i:=i+1;
       goto prev;
      
     end;
    
 i:=i+1;
 goto prev;
 next:
for k:=1 to 10 do begin 
write(data_arr[k]);
write(' ');
end;
end.
