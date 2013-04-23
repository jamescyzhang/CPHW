var
tt,tot,totwei,nowi,nowj,min,mini,nowwei,f,k,n,m,i,j,ans,t,ti:longint;
aa:array[0..10,0..10]of integer;
ai,aj,a:array[0..100]of integer;
weiup,weidown:array[0..100]of longint;
bl:array[0..100]of boolean;

begin
readln(n,m,t);
k:=0;
for i:=1 to n do
begin
for j:=1 to m do
begin
read(aa[i,j]);
if aa[i,j]<>0 then
begin
inc(k);
a[k]:=aa[i,j];
ai[k]:=i;
aj[k]:=j;
end;
end;
readln;
end;

for i:=1 to k-1 do
for j:=i+1 to k do
if a[j]>a[i] then
begin
tt:=a[i];
a[i]:=a[j];
a[j]:=tt;
tt:=ai[i];
ai[i]:=ai[j];
ai[j]:=tt;
tt:=aj[i];
aj[i]:=aj[j];
aj[j]:=tt;
end;

weiup[1]:=1;
totwei:=1;
weidown[1]:=1;
i:=2;
while i<=k do
begin
if a[i]<>a[i-1] then
begin
inc(totwei);
weiup[totwei]:=i;
weidown[totwei]:=i;
end
else inc(weidown[totwei]);
inc(i);
end;

ans:=0;
ti:=0;

nowi:=0;
for i:=1 to k do bl[i]:=true;

min:=1000;
for i:=1 to weidown[1] do
if ai[i]<min then
begin
min:=ai[i];
mini:=i;
end;
if (ai[mini]*2+1<=t) then
begin
ans:=a[mini];
ti:=ai[mini]+1;
nowi:=ai[mini];
nowj:=aj[mini];
bl[mini]:=false;
tot:=1;
end
else begin
writeln(0);
halt;
end;

nowwei:=1;
while true do
begin
if tot=weidown[nowwei] then inc(nowwei);
if nowwei>totwei then break;

min:=1000;
for i:=weiup[nowwei] to weidown[nowwei] do
if bl[i] and (abs(ai[i]-nowi)+abs(aj[i]-nowj)<min)and(ai[i]+1+ti+abs(ai[i]-nowi)+abs(aj[i]-nowj)<=t) then
begin
min:=abs(ai[i]-nowi)+abs(aj[i]-nowj);
mini:=i;
end;

if (min=1000)then break
else begin
ans:=ans+a[mini];
ti:=ti+abs(ai[mini]-nowi)+abs(aj[mini]-nowj)+1;
nowi:=ai[mini];
nowj:=aj[mini];
inc(tot);
bl[mini]:=false;
end;
end;

writeln(ans);
readln;
end.
