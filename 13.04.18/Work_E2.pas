const
  maxn=60010;
  maxm=500000;

type
  data=record
         num,q,next,rev:longint;
       end;

var
  h,l,p,high:array [1..maxn] of longint;
  g:array [1..maxm] of data;
  c,u:array [1..maxm] of longint;
  s,t,ans,n,m,now:longint;
  v:array [1..maxn] of boolean;

procedure add_edge(x,y,q:longint);
begin
  inc(now);
  g[now].next:=h[x];
  c[now]:=q;
  g[now].num:=y;
  g[now].rev:=now+1;
  u[now]:=q;
  h[x]:=now;
  inc(now);
  g[now].next:=h[y];
  c[now]:=0;
  u[now]:=0;
  g[now].num:=x;
  g[now].rev:=now-1;
  h[y]:=now;
end;

procedure init;
var i,tmp,x,y:longint;
begin
  readln(n,m);
  s:=n+m+1;
  t:=n+m+2;
  for i:=1 to n do
    begin
      read(tmp);
      add_edge(s,i,tmp);
    end;
  for i:=1 to m do
    begin
      readln(x,y,tmp);
      inc(ans,tmp);
      add_edge(x,n+i,maxlongint);
      add_edge(y,n+i,maxlongint);
      add_edge(n+i,t,tmp);
    end;
  close(input);
  n:=t;
end;

 procedure bfs;
  var nownode,head,tail,now:longint;

  procedure put(p:longint);
   var i:longint;
   begin
     inc(head);
     l[head]:=p;
   end;

  function get:longint;
   begin
     get:=l[tail];
     inc(tail);
   end;

  begin
    head:=0;
    tail:=1;
    fillchar(high,sizeof(high),127);
    high[t]:=0;
    put(t);
    while tail<=head do
     begin
       now:=get;
       nownode:=h[now];
       while nownode<>0 do
        begin
          if (high[g[nownode].num]>n shl 1) and (u[g[nownode].rev]>0) then
           begin
             high[g[nownode].num]:=high[now]+1;
             put(g[nownode].num);
           end;
          nownode:=g[nownode].next;
        end;
     end;
  end;

 function dfs(now,low:longint):longint;
  var nownode,tmp:longint;
  begin
    if now=t then exit(low);
    dfs:=0;
    nownode:=l[now];
    while (low>0) and (nownode<>0) do
     begin
       if (u[nownode]>0) and (l[g[nownode].num]<>0) and (high[g[nownode].num]+1=high[now]) then
        begin
          if u[nownode]<low then tmp:=dfs(g[nownode].num,u[nownode])
                            else tmp:=dfs(g[nownode].num,low);
          dec(low,tmp);
          dec(u[nownode],tmp);
          inc(u[g[nownode].rev],tmp);
          inc(dfs,tmp);
        end;
       if low>0 then nownode:=g[nownode].next;
     end;
    l[now]:=nownode;
  end;

function dinic:longint;
begin
  bfs;
  dinic:=0;
  while high[s]<n shl 1 do
    begin
      l:=h;
      inc(dinic,dfs(s,maxlongint));
      bfs;
    end;
end;

procedure print;
begin
  writeln(ans-dinic);
end;

begin
  init;
  print;
end.

