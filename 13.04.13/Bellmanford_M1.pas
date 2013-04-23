//1071 Bellman-Ford求单源最短路

var
	ans:string;
	i,j,l,k,n,m,x,y:longint;
	d:array[1..100]of longint;
	w:array[1..100,1..100]of longint;
procedure Bellman_ford;
var flag:boolean;
	lx,v,u:longint;
 begin
	 for lx:=1 to n do
		 d[lx]:=maxlongint;
	 d[1]:=0;
	 for lx:=1 to n-1 do begin
		 flag:=false;
		 for u:=1 to n do
			 for v:=1 to n do
			 if (w[u,v]<>maxlongint)
			 and(d[u]+w[u,v]<d[v]) then begin
				 d[v]:=d[u]+w[u,v];
				 flag:=true;
			 end;
		 if flag=false then break;
	 end;
	 ans:='NO';
	 for u:=1 to n do
		 for v:=1 to n do
		 if (w[u,v]<>maxlongint)
		 and(d[v]>d[u]+w[u,v]) then begin
			 ans:='YES'; exit;
		 end;
 end;
begin
	readln(k);
	for i:=1 to k do begin
		readln(n,m);
		for j:=1 to n do
			for l:=1 to n do
				w[j,l]:=maxlongint;
		for j:=1 to m do
			readln(x,y,w[x,y]);
		Bellman_ford;
		writeln(ans);
	end;
end.
