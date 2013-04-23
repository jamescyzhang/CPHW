type
  edge=record
    x,y,zong:longint;
    st:boolean;
  end;
  arr=array[1..10000] of edge;
var
  x,y:arr;
  dep:array[-10000..10000] of longint;
  i,j,n,x1,y1,x2,y2,ans:longint;

function check(x,y:edge):longint;inline;
  begin
    if x.zong<y.zong then exit(1);
    if x.zong>y.zong then exit(-1);
    if x.st>y.st then exit(1);
    if x.st<y.st then exit(-1);
    if x.x<y.x then exit(1);
    if x.x>y.x then exit(-1);
    if x.y<y.y then exit(1);
    if x.y>y.y then exit(-1);
    exit(0);
  end;

procedure sort(x,y:longint;var a:arr);
  var xx,yy:longint; mid,temp:edge;
  begin
    xx:=x;  yy:=y;  mid:=a[(xx+yy) div 2];
    repeat
      while check(a[xx],mid)>0 do inc(xx);
      while check(a[yy],mid)<0 do dec(yy);
      if xx<=yy then begin
                       temp:=a[xx]; a[xx]:=a[yy]; a[yy]:=temp;
                       inc(xx);dec(yy);
                     end;
    until xx>yy;
    if x<yy then sort(x,yy,a);
    if xx<y then sort(xx,y,a);
  end;

procedure scanpicture(a:arr);
  begin
    fillchar(dep,sizeof(dep),0);
    for i:=1 to n do
      if a[i].st then begin
                        for j:=a[i].x to a[i].y-1 do
                          begin
                            inc(dep[j]);
                            if dep[j]=1 then inc(ans);
                          end;
                      end
                 else begin
                        for j:=a[i].x to a[i].y-1 do
                          begin
                            dec(dep[j]);
                            if dep[j]=0 then inc(ans);
                          end;
                      end;
  end;

begin
  readln(n);
  for i:=1 to n do
    begin
      readln(x1,y1,x2,y2);
      x[i*2-1].x:=x1; x[i*2-1].y:=x2; x[i*2-1].zong:=y1; x[i*2-1].st:=true;
      x[i*2].x:=x1;   x[i*2].y:=x2;   x[i*2].zong:=y2;   x[i*2].st:=false;
      y[i*2-1].x:=y1; y[i*2-1].y:=y2; y[i*2-1].zong:=x1; y[i*2-1].st:=true;
      y[i*2].x:=y1;   y[i*2].y:=y2;   y[i*2].zong:=x2;   y[i*2].st:=false;
    end;
  n:=n*2;
  ans:=0;
  sort(1,n,x);  sort(1,n,y);
  scanpicture(x);
  scanpicture(y);
  writeln(ans);
end.
