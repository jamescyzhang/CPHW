const
	a:array[1..14] of char=('`','1','2','3','4','5','6','7','8','9','0','-','=','\');
	b:array[1..12] of char=('Q','W','E','R','T','Y','U','I','O','P','[',']');
	c:array[1..10] of char=('A','S','D','F','G','H','J','K','L',';');
	d:array[1..10] of char=('Z','X','C','V','B','N','M',',','.','/');
	q:array[1..5] of longint=(1,16,8,8,15);

var
	wa:array[1..14,1..2] of longint;
	wb:array[1..12,1..2] of longint;
	wc:array[1..11,1..2] of longint;
	wd:array[1..10,1..2] of longint;
	tot:array[1..100] of longint;
	ch:char;
	w:array[1..5,1..2] of longint;
	k,min,where,t,big,n,i,j,ans:longint;
	bo:boolean;
begin
	ans:=0;
	fillchar(wa,sizeof(wa),0);
	fillchar(wb,sizeof(wb),0);
	fillchar(wc,sizeof(wc),0);
	fillchar(wd,sizeof(wd),0);
	fillchar(tot,sizeof(tot),0);
	for i:=1 to 5 do begin
	    read(w[i,2]);
	    w[i,1]:=i;
	end;
	for i:=1 to 14 do wa[i,1]:=ord(a[i]);
	for i:=1 to 12 do wb[i,1]:=ord(b[i]);
	for i:=1 to 10 do wc[i,1]:=ord(c[i]);
	for i:=1 to 10 do wd[i,1]:=ord(d[i]);
	wc[11,1]:=39;
	readln;
	readln(n);
	for j:=1 to n do begin
	    read(ch);
	    bo:=false;
	    for i:=1 to 14 do
			if ord(ch)=ord(wa[i,1]) then begin
		    	inc(wa[i,2]);
			    bo:=true;
			    break;
			end;
	    if bo then continue;
	    {
	    	Il n'a pas de sens. Je ne pense pas que ce programme va marcher.
	    }
	    for i:=1 to 12 do
			if ord(ch)=ord(wb[i,1]) then begin
			    inc(wb[i,2]);
		    	bo:=true;
		    	break;
			end;
	    if bo then continue;
	    for i:=1 to 11 do
			if ord(ch)=ord(wc[i,1]) then begin
		    	inc(wc[i,2]);
			    bo:=true;
			    break;
			end;
	    if bo then continue;
	    for i:=1 to 10 do
			if ord(ch)=ord(wd[i,1]) then begin
			    inc(wd[i,2]);
			    bo:=true;
		    	break;
			end;
	    if bo then continue;
	    inc(tot[1]);
	end;
	for i:=1 to 4 do
	    for j:=1 to 5-i do
			if w[j,2]<w[j+1,2] then begin
			    t:=w[j,2];
		    	w[j,2]:=w[j+1,2];
			    w[j+1,2]:=t;
			    t:=w[j,1];
			    w[j,1]:=w[j+1,1];
		    	w[j+1,1]:=t;
			end;
	for i:=2 to 15 do
	    tot[i]:=wa[i-1,2];
	for i:=1 to 12 do
	    tot[15+i]:=wb[i,2];
	for i:=1 to 11 do
	    tot[27+i]:=wc[i,2];
	for i:=1 to 10 do
	    tot[38+i]:=wd[i,2];
	for i:=1 to 5 do
	    for k:=1 to q[w[i,1]] do begin
			min:=maxlongint;
			for j:=1 to 48 do
			    if tot[j]<min then begin
				min:=tot[j];
				where:=j;
			    end;
			ans:=ans+w[i,2]*min;
			tot[where]:=maxlongint;
	    end;
	writeln(ans);
	readln;
	readln;
end.
