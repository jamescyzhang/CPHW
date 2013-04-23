var
  n,i,j,k:integer;
  a:array[1..10000] of integer;
  t:array[1..10] of integer;

procedure dfs();
	var
		ii,jj,kk,nn,mm:integer;
	begin
		exit(0);
	end;

begin
  readln(n);
  for i:=1 to n do
    readln(a[i]);
  for i:=1 to m do
    readln(t[i]);
  dfs();
end.
