var i,j,m,n,l,k,s,t,x,y:longint;
    a:array[0..20001] of longint;
    ch:char;
function lowbit(x:longint):longint;
begin
  exit(x and -x);
end;
procedure add(x:longint);
var k:longint;
begin
  k:=x;
  while x<=20000 do
    begin
      a[x]:=a[x] xor k;
      x:=x+lowbit(x);
    end;
end;
function sum(x:longint):longint;
begin
  sum:=0;
  while x>0 do
    begin
       sum:=sum xor a[x];
       x:=x-lowbit(x);
    end;
end;
begin
  while not eof do
    begin
      read(ch);
      if ch='A' then
        begin
          for i:=1 to 2 do read(ch);
          readln(x);
          add(x);
        end;
      if ch='R' then
        begin
          for i:=1 to 5 do read(ch);
          readln(x);
          add(x);
        end;
      if ch='X' then
        begin
          for i:=1 to 10 do read(ch);
          read(x);
          for i:=1 to 4 do read(ch);
          readln(y);
          if x>y then writeln(0) else
          writeln(sum(y) xor sum(x-1));
        end;
    end;
end.
