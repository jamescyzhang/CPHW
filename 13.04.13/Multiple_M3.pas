var
	a:array[1..10]of longint;
	b:array[1..500]of longint;
	d,l:array[0..500,0..4999]of longint;
	f:array[0..500,0..4999]of boolean;
	n,m,i,j,cf,temp,k,p:longint;

begin
	read(n);
	read(m);
	for i:=1 to m do read(a[i]);
	for i:=1 to m-1 do
		for j:=i+1 to m do
			if a[i]>a[j] then
			begin
				temp:=a[i];
				a[i]:=a[j];
				a[j]:=temp;
			end;
	cf:=1; b[1]:=1;
	for i:=2 to 500 do
	begin
		cf:=(cf*10)mod n;
		b[i]:=cf;
	end;
	fillchar(f,sizeof(f),false);
	f[0,0]:=true;
	for i:=0 to 499 do
	begin
		for k:=1 to m do
			for j:=0 to n-1 do
				if f[i,j] then
		if not ((j=0)and(a[k]=0)) then
		if not f[i+1,(j+a[k]*b[i+1])mod n] then
		begin
			d[i+1,(j+a[k]*b[i+1])mod n]:=a[k];
			l[i+1,(j+a[k]*b[i+1])mod n]:=j;
			f[i+1,(j+a[k]*b[i+1])mod n]:=true;
		end;
		if f[i+1,0] then
		begin
			k:=i+1;
			p:=0;
			while k>0 do
			begin
				write(d[k,p]);
				p:=l[k,p];
				k:=k-1;
			end;
			writeln;
			halt;
		end;
	end;
	writeln(0);
end.
