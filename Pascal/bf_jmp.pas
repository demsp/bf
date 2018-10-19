// jmp from { to }
 LABEL prev,prev1,next,cond;
var
 data_arr:array[1..10] of integer;    // массив данных
 str_arr: string;                     // команды  
 i,j,k: integer;                       // индексы строки и массива
 i_stor: integer;
 flag: integer;
begin
 j:=1;                  // нумерация элементов массива начинается с единицы
 i:=1;
 //readln(str_arr);       //считываем строку
 
 //str_arr:='+++{[-]}';
 str_arr:='+++{[>+<-]}';
 prev:
 if i>length(str_arr) then goto next;
 
 if (str_arr[i]='{') then 
 begin
 prev1:
  i:=i+1;
  if (str_arr[i]<>'}') then goto prev1; 
 end;
 
    if (str_arr[i]='+') then data_arr[j]:= data_arr[j]+1;
    if (str_arr[i]='-') then data_arr[j]:= data_arr[j]-1;
    if (str_arr[i]='>') then j:=j+1;
    if (str_arr[i]='<') then j:=j-1;
    if (str_arr[i]='.') then write(chr(data_arr[j]));
    // скобки [ и ]
    if (str_arr[i]='[') then
     begin  
      if data_arr[j]>0 then i_stor:=i;
     end;
    if (str_arr[i]=']') then
     begin  
      if data_arr[j]>0 then 
       begin
       i:=i_stor;
       goto prev;
       end;
     end;
  
 i+=1; 
 //прыгаем в prev 
 goto prev;
 next:
for k:=1 to 10 do begin 
write(data_arr[k]);
write(' ');
end;
end.
