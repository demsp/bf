type
  //Указатель на элемент стека.
  PointoElem =^Stack_elem;
  //Элемент стека - это запись.
  Stack_elem = record
    Data : Integer;
    PNext : PointoElem;
  end;
//Добавление элемента на вершину стека.
procedure StackPush(var innerStack, innerElem : PointoElem);
begin
  if innerElem = nil then Exit;
  innerElem^.PNext := innerStack;
  innerStack := innerElem
end;
//Изъятие элемента с вершины стека.
function StackPop(var innerStack, innerElem : PointoElem) : Boolean;
begin
  Result := False;
  if innerStack = nil then Exit;
  innerElem := innerStack;
  innerStack := innerElem^.PNext;
  Result := True;
end;
//Удаление стека из памяти (очистка стека).
procedure StackFree(var innerStack : PointoElem);
var
  PDel : PointoElem;
begin
  while innerStack <> nil do begin
    PDel := innerStack;
    innerStack := innerStack^.PNext;
    Dispose(PDel);
  end;
end;
{Процедура вывода стека}
procedure Print(stack1:PointoElem);
begin
  if stack1=nil then {проверка на пустоту стека}
  begin
    writeln('Стек пуст.');
    exit;
  end;
  while stack1<>nil do {пока указатель stek1 не станет указывать в пустоту}
  begin   {а это произойдёт как только он перейдёт по ссылке последнего элемента}
    Write(stack1^.Data, ' '); {выводить данне}
    stack1:=stack1^.PNext  {и переносить указатель вглубь по стеку}
  end;
end;
{--------------------------------------------------}
LABEL prev,next;
var
 newStack, newElem: PointoElem;
 data_arr:array[1..10] of integer;    // массив данных
 str_arr: string;                     // команды  
 i,j,k: integer;                      // индексы строки и массива
 i_stor: integer; 
{---------------------------------------------------}
begin
 j:=1;   // нумерация элементов массива начинается с единицы
 i:=1;
 //readln(str_arr);       //считываем строку
 //str_arr:='++[>++[>++[>+<-]<-]<-]'; // 3^3=27;
 str_arr:='++++[>+++[>+<-]<-]'; //2*2=4
 newStack := nil;
 prev:
 if i>length(str_arr) then goto next; 
    if (str_arr[i]='+') then data_arr[j]:= data_arr[j]+1;
    if (str_arr[i]='-') then data_arr[j]:= data_arr[j]-1;
    if (str_arr[i]='>') then j:=j+1;
    if (str_arr[i]='<') then j:=j-1;
    if (str_arr[i]='.') then write(chr(data_arr[j]));
    // скобки
    if (str_arr[i]='[') then 
      begin
      New(newElem);
      newElem^.Data := i;
      StackPush(newStack, newElem);
      write('In [ ');
      Print(newStack);
      writeln();
      if (data_arr[j]>0) then 
       begin
       i := i+1;
       goto prev;
       end;
      end;
    
    if (str_arr[i]=']') then
      begin
      StackPop(newStack, newElem);
      write('In ] ');
      Print(newStack);
      writeln();
      if (data_arr[j]>0) then 
       begin
        i := newElem^.Data;
        //i := i+1;
        goto prev;
       end;
      end;
 i:=i+1;
 goto prev;
 next:
for k:=1 to 10 do begin 
write(data_arr[k]);
write(' ');
end;
end.
