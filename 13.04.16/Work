var
  w:array[1..500,1..500] of longint;
  lx,ly,ma,stack:array[1..500] of longint;
  vx,vy:array[1..500] of boolean;
  n,m,k,i,j,x,y,ans,d:longint;

function find(x:longint):boolean;
  var i:longint;
  begin
    vx[x]:=true;
    for i:=1 to n do
      if (not vy[i]) and (lx[x]+ly[i]=w[x,i])
        then begin
               vy[i]:=true;
               if (ma[i]=0) or (find(ma[i])) then begin
                                                    ma[i]:=x;
                                                    exit(true);
                                                  end;
             end
        else if lx[x]+ly[i]>w[x,i]
               then if lx[x]+ly[i]-w[x,i]<stack[i]
                      then stack[i]:=lx[x]+ly[i]-w[x,i];
    exit(false);
  end;

begin

  fillchar(w,sizeof(w),0);
  fillchar(ma,sizeof(ma),0);
  fillchar(lx,sizeof(lx),0);
  fillchar(ly,sizeof(ly),0);
  readln(n,m,k);
  if m>n then n:=m;
  for i:=1 to k do
    begin
      readln(x,y,w[x,y]);
      if w[x,y]>lx[x] then lx[x]:=w[x,y];
    end;

  for i:=1 to n do
    repeat

      fillchar(vx,sizeof(vx),false);
      fillchar(vy,sizeof(vy),false);
      fillchar(stack,sizeof(stack),$7f);
      if find(i) then break;

      d:=maxlongint;
      for j:=1 to n do if stack[j]<d then d:=stack[j];
      for j:=1 to n do
        begin
          if vx[j] then dec(lx[j],d);
          if vy[j] then inc(ly[j],d);
        end;

    until false;

  ans:=0;
  for i:=1 to n do inc(ans,w[ma[i],i]);

  writeln(ans);

end.
