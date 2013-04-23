var
 p,d:array[0..1000000]of longint;
 s,t:ansistring;
 i,j,k,l,lx,len,now:longint;

 function max(i,j:longint):longint;
 begin
  if i<j then max:=j else max:=i;
 end;

begin
 readln(t);
 s:=t+t;

 j:=0;
 while (2+j<=length(T)) and (T[1+j]=T[2+j]) do inc(j);
 p[1]:=length(T); p[2]:=j;
 k:=2;
 for i:=3 to length(t) do
 begin
  len:=k+p[k]-1;
  now:=p[i-k+1];
  if now<len-i+1 then p[i]:=now
  else begin
	j:=max(0,len-i+1);
	while (i+j<=length(T))and(T[i+j]=T[1+j]) do inc(j);
	p[i]:=j; k:=i;
  end;
 end;
 for i:=2 to length(t) do
	if i+p[i]-1=length(t) then begin
	 lx:=i-1; break;
 end;

 j:=0;
 while (j<length(S))and(j<length(T))and(T[1+j]=S[1+j]) do inc(j);
 d[1]:=j; k:=1;
 for i:=2 to length(s) do
 begin
  len:=k+d[k]-1;
  now:=p[i-(k-1)];
  if now<len-i+1 then d[i]:=now
  else begin
	j:=max(0,len-i+1);
	while(i+j<=length(S))and(j<length(T))and(S[i+j]=T[1+j]) do inc(j);
	d[i]:=j; k:=i;
  end;
 end;
 j:=0; k:=0; l:=0;
 for i:=1 to lx do begin
  if d[i]=length(t) then inc(k)
  else if s[d[i]+i]>t[d[i]+1] then inc(l)
  else inc(j);
 end;
 writeln(j,' ',k,' ',l);
end.
