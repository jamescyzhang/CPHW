var
  s,w,f:array[1..30000] of longint;
  ch:char;
  t,i,j,a,b,f1,f2:longint;

function fa(x:longint):longint;
  begin
    if f[x]=x then exit(x);
    fa:=fa(f[x]);
    w[x]:=w[f[x]]+w[x];
    f[x]:=fa;
  end;

begin
  for i:=1 to 30000 do
    begin
      s[i]:=1;
      w[i]:=0;
      f[i]:=i;
    end;
  readln(t);
  for i:=1 to t do
    begin
      read(ch);
      readln(a,b);
      f1:=fa(a); f2:=fa(b);
      case ch of
        'M':begin
              f[f1]:=f2;
              w[f1]:=s[f2]+w[f1];
              s[f2]:=s[f1]+s[f2];
            end;
        'C':begin
              if f1<>f2 then writeln(-1)
                        else writeln(abs(w[a]-w[b])-1);
            end;
      end;
    end;

end.
