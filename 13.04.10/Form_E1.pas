//2164 报表统计

type
	treetype=^abc;
	abc=record
		data,pri,total:longint;
		left,right:treetype;
	end;
var
	n,m,i,j,l,k,min,tmp,temp,nn:longint;
	root,t,root1,none:treetype;
	a,b:array [1..500000]of longint;
	ch:char;
	s:string;
procedure remain(var h:treetype);
begin
	h^.total:=1+h^.left^.total+h^.right^.total;
end;
function leftrotate(t:treetype):treetype;
begin
	leftrotate:=t^.right;
	t^.right:=leftrotate^.left;
	leftrotate^.left:=t;
end;
function rightrotate(t:treetype):treetype;
begin
	rightrotate:=t^.left;
	t^.left:=rightrotate^.right;
	rightrotate^.right:=t;
end;
function instree(data:longint;h:treetype):treetype;
begin
	if h=none then
	begin
		new(h);
		h^.data:=data;
		h^.pri:=random(maxlongint);
		h^.left:=none;
		h^.right:=none;
		h^.total:=1;
		exit(h);
	end;
	if data<h^.data then
	begin
		h^.left:=instree(data,h^.left);
		if h^.left^.pri>h^.pri then begin h:=rightrotate(h);remain(h^.right);end;
		remain(h);
	end
	else
	begin
		h^.right:=instree(data,h^.right);
		if h^.right^.pri>h^.pri then begin h:=leftrotate(h);remain(h^.left);end;
		remain(h);
	end;
	exit(h);
end;
function deltree(data:longint;h:treetype):treetype;
begin
	if data<h^.data then h^.left:=deltree(data,h^.left)
	else if data>h^.data then h^.right:=deltree(data,h^.right)
	else
	begin
		if h^.left^.pri>h^.right^.pri then
		begin
			h:=rightrotate(h);
			if h=none then
			begin
				dispose(none^.right);
				none^.right:=nil;
				exit(none);
			end;
			h^.right:=deltree(data,h^.right);
			remain(h);
		end
		else
		begin
			h:=leftrotate(h);
			if h=none then
			begin
				dispose(none^.left);
				none^.left:=nil;
				exit(none);
			end;
			h^.left:=deltree(data,h^.left);
			remain(h);
		end;
	end;
	exit(h);
end;
function get(x:longint;h:treetype):longint;
begin
	if x<h^.data then get:=get(x,h^.left)
	else if x>h^.data then get:=h^.left^.total+1+get(x,h^.right)
	else exit(h^.left^.total+1);
end;
function find(x:longint;h:treetype):longint;
begin
	if h^.left^.total+1=x then exit(h^.data)
	else if h^.left^.total<x then exit(find(x-h^.left^.total-1,h^.right))
	else exit(find(x,h^.left));
end;
begin
	readln(n,m);
	new(none);
	none^.data:=0;
	none^.pri:=-1;
	none^.total:=0;
	none^.left:=nil;
	none^.right:=nil;
	root:=none;root1:=none;
	min:=maxlongint;
	read(a[1]);b[1]:=a[1];root:=instree(a[1],root);
	for i:=2 to n do
	begin
		read(a[i]);
		b[i]:=a[i];
		root:=instree(a[i],root);
		root1:=instree(abs(a[i]-b[i-1]),root1);
		k:=a[i];
		tmp:=get(k,root);
		if tmp<i then
			begin
				temp:=find(tmp+1,root);
				if abs(k-temp)<min then min:=abs(temp-k);
			end;
		if tmp>1 then
			begin
				temp:=find(tmp-1,root);
				if abs(temp-k)<min then min:=abs(temp-k);
			end;
	end;
	readln;
	nn:=n;
	for i:=1 to m do
	begin
		read(ch);
		if ch='I' then
		begin
			inc(nn);
			while ch<>' ' do read(ch);
			readln(l,k);
			if l<n then
			begin
				root1:=deltree(abs(b[l]-a[l+1]),root1);
				root1:=instree(abs(k-a[l+1]),root1);
			end;
			root1:=instree(abs(k-b[l]),root1);
			b[l]:=k;
			root:=instree(k,root);
			tmp:=get(k,root);
			if tmp<nn then
			begin
				temp:=find(tmp+1,root);
				if abs(k-temp)<min then min:=abs(temp-k);
			end;
			if tmp>1 then
			begin
				temp:=find(tmp-1,root);
				if abs(temp-k)<min then min:=abs(temp-k);
			end;
		end
		else
		begin
			readln(s);
			if s[4]='S' then
			begin
				writeln(min);
			end
			else
			begin
				writeln(find(1,root1));
			end;
		end;
	end;
end.

