//2168 食物链
const
 MaxN = 50010;
var
 add, root: array[0..MaxN] of longint;
 delta, ans, n, m, i, a, b, c, p, q: longint;

function get(v: longint): longint;
 var
  d: longint;
 begin
  if root[v] <> v then
   begin
    d:= root[v];
    root[v]:= get(root[v]);
    add[v]:= (add[d] + add[v]) mod 3;
   end;
  exit(root[v]);
 end;

begin
  readln(n, m);
  for i:= 1 to n do
   root[i]:= i;
  for i:= 1 to m do
   begin
    read(a, b, c);
    if (b <= n) and (c <= n) then
     begin
      p:= get(b);
      q:= get(c);
      if a = 1 then
       begin
        if p <> q then
         begin
          if add[b] <> add[c] then
           add[p]:= (add[c] - add[b] + 3) mod 3;
          root[p]:= q;
         end else
          if add[b] <> add[c] then
           inc(ans);
       end else
       begin
        if p <> q then
        begin
         if (add[b] + 1) mod 3 <> add[c] then
          add[q]:= (add[b] - add[c] + 4) mod 3;
          root[q]:= p;
        end else
         if (add[b] + 1) mod 3 <> add[c] then
          inc(ans);
       end;
     end else inc(ans);
   end;
  writeln(ans);
 end.

