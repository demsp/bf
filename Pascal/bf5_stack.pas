begin
 j:=1;                  // нумерация элементов массива (внезапно) начинается с единицы
 ii:=1;
 //readln(str_arr);       //считываем строку
 str_arr:='+++[>+++[>+<-]<-]'; // 3*3 = 9
 PSt1 := nil;
 prev:
 if ii>length(str_arr) then goto next; 
    if (str_arr[ii]='+') then data_arr[j]:= data_arr[j]+1;
    if (str_arr[ii]='-') then data_arr[j]:= data_arr[j]-1;
    if (str_arr[ii]='>') then j:=j+1;
    if (str_arr[ii]='<') then j:=j-1;
    if (str_arr[ii]='.') then write(chr(data_arr[j]));
    // скобки
    {
    if (str_arr[ii]='[') and (data_arr[j]>0) then
     begin  
      New(PElem);
      PElem^.Data := ii;
      StackPush(PSt1, PElem);
      ii := ii+1;
      goto prev;
     end;
     }
     if (str_arr[ii]='[') then 
      begin
      New(PElem);
      PElem^.Data := ii;
      StackPush(PSt1, PElem);
      if (data_arr[j]>0) then 
       begin
       ii := ii+1;
       goto prev;
       end;
      end;
     
    {
    if (str_arr[ii]=']') and (data_arr[j]>0) then
     begin  
       //ii:=i_stor;
       StackPop(PSt1, PElem); 
       ii := PElem^.Data;
       ii := ii+1;
       goto prev;
       end;
     }
     
     if (str_arr[ii]=']') then
      begin
      StackPop(PSt1, PElem); 
      if (data_arr[j]>0) then 
       begin
        ii := PElem^.Data;
        //ii := ii+1;
        goto prev;
       end;
      end;
     
     
    
 ii:=ii+1;
 goto prev;
 next:
for k:=1 to 10 do begin 
write(data_arr[k]);
write(' ');
end;
