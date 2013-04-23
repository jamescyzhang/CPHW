//2051 营救皮卡丘

//œẇé®þ¥üơ
//ø,“‘«āßð
//ƒ©ˍőo̊ł…æ
//ˀạçǚŭñą≤

{
	Reason: DP Skill.
}

type    edge=record
	x,y,c,f,r,next:longint;
	end;
const   qu=10001;
var     n,m,i,cost,t1,t2,t3,x,y,k,tot,st,ed,j:longint;
	e:array[0..300001] of edge;
	f:array[0..151,0..151] of longint;
	s,b,pre:array[0..1001] of longint;
	v:array[0..1001] of boolean;
	q:array[0..qu] of longint;
function ac_min(a,b:longint):longint;
begin
	if a<b then exit(a) else exit(b);
end;
function ac_fun(k:longint):longint;
begin
	if k=0 then exit(x) else exit(k+n);
end;
procedure ac_add(x,y,c,f:longint);
begin
	inc(tot); e[tot].x:=x; e[tot].y:=y; e[tot].c:=c; e[tot].f:=f;
	e[tot].next:=b[x]; b[x]:=tot;
	inc(tot); e[tot].x:=y; e[tot].y:=x; e[tot].f:=-f; e[tot].next:=b[y];
	b[y]:=tot;
	e[tot].r:=tot-1; e[tot-1].r:=tot;
end;
procedure ac_spfa;
var     x,i,h,hh,t,tt:longint;
begin
	while true do
	begin
		h:=1; t:=1; hh:=1; tt:=1; q[1]:=st;
		fillchar(s,sizeof(s),$7f); s[st]:=0;
		repeat
			x:=q[h]; inc(h); inc(hh); v[x]:=false; h:=h mod qu;
			i:=b[x];
			while i<>-1 do
				with e[i] do
				begin
					if (c>0) and (s[y]>s[x]+f) then
					begin
						s[y]:=s[x]+f; pre[y]:=i;
						if not(v[y]) and (s[y]<s[ed]) then
						begin
							if s[y]<s[q[h]] then
							begin
								dec(h); dec(hh);
								h:=(h+qu) mod qu;
								q[h]:=y;
							end
							else
							begin
								inc(t); inc(tt);
								t:=t mod qu;
								q[t]:=y;
							end;
							v[y]:=true;
						end;
					end;
					i:=next;
				end;
		until hh>tt;
		if s[ed]>maxlongint>>1 then break;
		i:=pre[ed];
		while i<>0 do
			with e[i] do
			begin
				dec(c); inc(e[r].c); inc(cost,f);
				i:=pre[x];
			end;
	end;
end;
begin
	readln(n, m, k);
	x:=n*2+1;
	y:=x+1;
	st:=y+1;
	ed:=st+1;
	fillchar(b,sizeof(b),255);
	for i:=1 to n do
	begin
		ac_add(i,i+n,1,0); ac_add(i+n,y,1,0);
		ac_add(st,i+n,1,0); ac_add(i,ed,1,0);
	end;
	ac_add(y,x,k,0);
	for i:=0 to n do
	begin
		for j:=0 to n do f[i,j]:=maxlongint>>2;
		f[i,i]:=0;
	end;
	for i:=1 to m do
	begin
		readln(t1,t2,t3);
		if t3<f[t1,t2] then
		begin
			f[t1,t2]:=t3; f[t2,t1]:=t3;
		end;
	end;
	for k:=0 to n do
	begin
		for i:=0 to n do
		for j:=0 to n do
			f[i,j]:=ac_min(f[i,j],f[i,k]+f[k,j]);
		for i:=0 to k-1 do
			ac_add(ac_fun(i),k,1,f[i,k]);
	end;
	ac_spfa;
	writeln(cost);
end.
