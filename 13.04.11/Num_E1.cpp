//2163 最多的数字
program therefore;
type
 aa=record
  l,r,rand,v,sum:longint;
 end;
var
 i,j,add,k,tail,min,n,m,tt,root,tot:longint;
 ch:char;
 p:boolean;
 tree:array[0..100000] of aa;
function rightrotate(now:longint):longint;
 begin
  rightrotate:=tree[now].l;
  tree[now].l:=tree[tree[now].l].r;
  tree[rightrotate].r:=now;
  tree[rightrotate].sum:=tree[now].sum;
  tree[now].sum:=tree[tree[now].l].sum+tree[tree[now].r].sum+1;
 end;
function leftrotate(now:longint):longint;
 begin
  leftrotate:=tree[now].r;
  tree[now].r:=tree[tail].l;
  tree[leftrotate].l:=now;
  tree[leftrotate].sum:=tree[now].sum;
  tree[now].sum:=tree[tree[now].l].sum+tree[tree[now].r].sum+1;
 end;
procedure insert(var now:longint);
 begin
  if now=0 then
   begin
    inc(tail);
    now:=tail;
    tree[tail].v:=k;
    tree[tail].sum:=1;
    tree[tail].rand:=random(500000);
    exit;
   end;
  if k<=tree[now].v then
   begin
    insert(tree[now].l);
    if tree[tree[now].l].rand<tree[now].rand then now:=rightrotate(now);
   end
   else
    begin
     insert(tree[now].r);
     if tree[tree[now].r].rand<tree[now].rand then now:=leftrotate(now);
    end;
   tree[now].sum:=tree[tree[now].l].sum+tree[tree[now].r].sum+1;
 end;
function select(var now:longint):longint;
var tt:longint;
 begin
  if now=0 then exit(0);
  if tree[now].v+add<min then
   begin
    tt:=tree[tree[now].l].sum;
    now:=tree[now].r;
    select:=select(now)+tt+1;
   end
   else select:=select(tree[now].l);
  if now<>0 then tree[now].sum:=tree[tree[now].r ].sum+tree[tree[now].l].sum+1;
 end;
 procedure find(now:longint);
 begin
  if now=0 then exit;
  if k=tree[tree[now].r].sum+1 then
   begin
    writeln(tree[now].v+add);
   end
  else if k<tree[tree[now].r].sum+1 then find(tree[now].r)
   else
    begin
     dec(k,tree[tree[now].r].sum+1);
     find(tree[now].l);
    end;
  end;
begin
 readln(n,min);
 for i:=1 to n do
  begin
   read(ch);
   readln(k);
   case ch of
    'I':
      begin
       if k<min then continue;
       k:=k-add;
       insert(root);
      end;
    'A':add:=add+k;
    'S':
     begin
      add:=add-k;
      {if add<0 then }inc(tot,select(root));
     end;
     'F':
      begin
       p:=false;
       {if root=0 then
        begin
         writeln('-1');
         continue;
        end;      }
      if k>tree[root].sum then writeln(-1)
                          else find(root);
      end;
     end;

  end;

 writeln(tot);
end.

