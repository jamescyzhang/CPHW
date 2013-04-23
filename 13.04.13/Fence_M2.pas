//2157 牛场围栏

var n,m,i,max,l,d,j,x,k:longint;
    min,len,v:array[-1..3000]of longint;
  function gcd(a,b:longint):longint;
  var p:longint;
  begin
    repeat
      p:=a mod b;
      a:=b;
      b:=p;
    until b=0;
    gcd:=a;
  end;
begin
  readln(n,m);
  for i:=1 to n do
  begin
    readln(l);
    if m=0 then
      if i=1 then d:=l
      else d:=gcd(l,d);
    for j:=l downto l-m do
      if j<=0 then break
      else len[j]:=1;
  end;
  if (len[1]=1) or ((m=0)and(d>1)) then begin writeln(-1);exit;end;
  max:=0;
  x:=1;
  while len[x]=0 do x:=x+1;
  for i:=0 to x-1 do
    min[i]:=-1;
  for i:=3000 downto x do
    if len[i]=1 then min[i mod x]:=i;
  repeat
    j:=-1;
    for i:=0 to x-1 do
      if (v[i]=0)and(min[i]<>-1)and((j=-1)or(min[i]<min[j])) then j:=i;
    if j=-1 then
    begin
      writeln(max);
      exit;
    end;
    v[j]:=1;
    if min[j]-x>max then max:=min[j]-x;
    for i:=0 to x-1 do
      if v[i]=1 then
      begin
        k:=(i+j)mod x;
        l:=min[i]+min[j];
        if (min[k]=-1)or(l<min[k]) then min[k]:=l;
      end;
  until false;
end.
