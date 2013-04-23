var
	n,i,ans,max,k,l,j:longint;
	f:array[1..100]of longint;
	a,b:array[1..100]of longint;
begin
	readln(n);
	ans:=0;
	max:=0;
	for i:=1 to n do
	begin
		read(a[i]);
		if (a[i]<=100)and(a[i]>max) then max:=a[i];
	end;
	readln;
	for i:=1 to n do
		read(b[i]);
	for i:=1 to max do f[i]:=0;
	for i:=1 to n do
		if a[i]>100 then ans:=ans+b[i]
		else
		if f[a[i]]=0 then f[a[i]]:=b[i]
		else
		begin
			k:=b[i];
			l:=a[i];
			while (l>0) and(f[l]<>0)do
			begin
				if k>f[l] then
				begin
					j:=f[l];
					f[l]:=k;
					k:=j;
				end;
				l:=l-1;
			end;
			if f[l]=0 then f[l]:=k;
	end;
	for i:=1 to max do ans:=ans+f[i];
	writeln(ans);
end.
