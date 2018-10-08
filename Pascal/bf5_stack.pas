type
  //Указатель на элемент стека.
  TPElem = ^TElem;
  //Элемент стека.
  TElem = record
    Data : Integer;
    PNext : TPElem;
  end;
 
//Добавление элемента на вершину стека.
procedure StackPush(var aPStack, aPElem : TPElem);
begin
  if aPElem = nil then Exit;
  aPElem^.PNext := aPStack;
  aPStack := aPElem
end;
 
//Изъятие элемента с вершины стека.
function StackPop(var aPStack, aPElem : TPElem) : Boolean;
begin
  Result := False;
  if aPStack = nil then Exit;
  aPElem := aPStack;
  aPStack := aPElem^.PNext;
  Result := True;
end;
 
//Удаление стека из памяти (очистка стека).
procedure StackFree(var aPStack : TPElem);
var
  PDel : TPElem;
begin
  while aPStack <> nil do begin
    PDel := aPStack;
    aPStack := aPStack^.PNext;
    Dispose(PDel);
  end;
end;
///
LABEL prev,next;

var
  PSt1, PElem : TPElem;
 data_arr:array[1..10] of integer;    // массив данных
 str_arr: string;                     // команды  
 i,j,k: integer;                      // индексы строки и массива
 i_stor: integer; 

begin
 j:=1;                  // нумерация элементов массива начинается с единицы
 i:=1;
 //readln(str_arr);       //считываем строку
  
 str_arr:='+++[>+++[>+++[>+<-]<-]<-]'; // 3^3=27;
 PSt1 := nil;
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
      New(PElem);
      PElem^.Data := i;
      StackPush(PSt1, PElem);
      if (data_arr[j]>0) then 
       begin
       i := i+1;
       goto prev;
       end;
      end;
    if (str_arr[i]=']') then
      begin
      StackPop(PSt1, PElem); 
      if (data_arr[j]>0) then 
       begin
        i := PElem^.Data;
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
