var h:array[0..300,0..300,0..1] of longint;
    a:array[0..300,0..300] of longint;
    l,r:array[0..300] of longint;
    u:array[0..300] of boolean;
    i,j,m,n,k,x,y,z,ans:longint;
function try(father,now,need,d:longint):longint;
var k,nr,nl,hll,min:longint;
begin
  if now=0 then
    begin
      if need=0 then try:=0 else try:=-1;
      exit;
    end;
  if h[now,need,d]<>-1 then
    begin
      try:=h[now,need,d];
      exit;
    end;
  min:=maxlongint;
  for k:=0 to need do
    begin
      nr:=try(father,r[now],k,d);
      if k=need then nl:=-1 else nl:=try(now,l[now],need-k-1,1);
      if (nl>=0) and  (nr>=0) then
        begin
            if d=1 then hll:=nl+nr+a[father,now] else hll:=nl+nr;
                    if hll<min then min:=hll;
        end;
      nl:=try(now,l[now],need-k,0);
      if (nl>=0) and (nr>=0) then
        begin
          if (d=0) and (m=2) then hll:=nl+nr+a[father,now] else hll:=nl+nr;
          if hll<min then min:=hll;
        end;
    end;
  if min=maxlongint then
    begin
      try:=-2;
      h[now,need,d]:=-2;
    end
  else
    begin
      try:=min;
      h[now,need,d]:=min;

    end;
end;
procedure build(x:longint);
var i:longint;
begin
  u[x]:=true;
  for i:=n downto 1 do
    if not u[i] and (a[x,i]>=0) then
      begin
        r[i]:=l[x];
        l[x]:=i;
        build(i);
      end;

end;
begin
  readln(n,m,k);
  for i:=0 to 300 do
    for j:=0 to 300 do
    a[i,j]:=-1;
  for i:=1 to n-1 do
    begin
      readln(x,y,z);
      a[x,y]:=z;
      a[y,x]:=z;
    end;
  build(1);
  for x:=0 to 300 do
    for y:=0 to 300 do
      for z:=0 to 1 do
        h[x,y,z]:=-1;
    if n<k+m-1 then ans:=-1 else ans:=try(1,l[1],k-1,1);
  writeln(ans);
end.

