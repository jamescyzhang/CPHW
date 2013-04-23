program qweqwe;
	var
		x:array[1..100,1..100] of longint;
		w,f:array[1..100] of longint;
		t:array[1..100,1..100] of longint;
		tot,ans,n,i,j,where:longint;
	procedure cc(k:longint);
		var
			i,j:longint;
		begin
			for i:=1 to n do
				if x[k,i]<w[i] then begin
					w[i]:=x[k,i];
					if w[i]=0 then
						cc(i);
				end;
		end;
	function findmax:longint;
		var
			i,j:longint;
		begin
			j:=0;
			for i:=1 to n do
				if w[i]>j then j:=w[i];
			exit(j);
		end;
	begin
		readln(n);
		for i:=1 to n do
			for j:=1 to n do
				read(x[i,j]);
		fillchar(w,sizeof(w),$3f);
		tot:=0;
		ans:=0;
		w[1]:=0;
		cc(1);
		while findmax>0 do begin
			j:=maxlongint;
			for i:=1 to n do
				if (w[i]>0) and (w[i]<j) then begin
					j:=w[i];
					where:=i;
				end;
			ans:=ans+w[where];
			inc(tot);
			w[where]:=0;
			cc(where);
		end;
		writeln(tot);
		writeln(ans);
	end.
