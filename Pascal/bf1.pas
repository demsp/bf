var
 data_arr:array[1..10] of integer;    // массив данных
 str_arr: string;                     // команды  
 i, j: integer;                       // индексы строки и массива
begin
 j:=1;                  // нумерация элементов массива (внезапно) начинается с единицы
 readln(str_arr);       //считываем строку

 for i:=1 to length(str_arr) do begin    // в цикле обрабатываем строку
  if (str_arr[i]='+') then data_arr[j]:= data_arr[j]+1;
  if (str_arr[i]='.') then write(chr(data_arr[j]));
 end;
end.
