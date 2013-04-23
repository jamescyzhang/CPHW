var
a:array[1..60000]of longint;
n,m,i,o,t,x:longint;
procedure qsort(h,l:longint);
var i,j,x,t:longint;
begin
  i:=h;
  j:=l;
  x:=a[(i+j) shr 1];
  repeat
    while a[i]<x do inc(i);
    while a[j]>x do dec(j);
    if i<=j then
      begin
        t:=a[i];
        a[i]:=a[j];
        a[j]:=t;
        inc(i);
        dec(j);
      end;
  until i>j;
  if i<l then qsort(i,l);
  if j>h then qsort(h,j);
end;
procedure swap(var x,y:longint);
var t:longint;
begin
  t:=x;
  x:=y;
  y:=t;
end;
begin
  readln(n);
  readln(m);
  for i:=1 to n do read(a[i]);
  for o:=1 to m do
    begin
      for i:=n downto 1 do
        begin
          if a[i]>a[i-1] then
            begin
              t:=i;
              break;
            end;
        end;
      x:=t;
      for i:=t+1 to n do
        if (a[i]>a[t-1]) and (a[i]<a[x]) then x:=i;
      swap(a[t-1],a[x]);
      qsort(t,n);
    end;
  for i:=1 to n do write(a[i],' ');
end.
