//2165 排名系统
type
	nametype=^cba;
	treaptype=^abc;
	abc=record
		data,pri,time,total:longint;
		left,right:treaptype;
		opp:nametype;
	end;
	cba=record
		pri:longint;
		nam:string[10];
		left,right:nametype;
		opp:treaptype;
	end;

var
	n,i,j,temp,code,tot,number:longint;
	root,t,tmp:treaptype;
	root1,t1,tmp1:nametype;
	ch,ch1:char;
	s:string;
	bj:boolean;
	ans:array [1..10]of string;

procedure remain(var t:treaptype);
begin
	t^.total:=1;
	if t^.left<>nil then inc(t^.total,t^.left^.total);
	if t^.right<>nil then inc(t^.total,t^.right^.total);
end;

procedure build(var t:treaptype);
begin
	new(t);
	t^.data:=0;t^.pri:=random(maxlongint);
	t^.left:=nil;t^.right:=nil;
	t^.total:=0;
end;

procedure build1(var t:nametype);
begin
	new(t);
	t^.nam:='';t^.pri:=random(maxlongint);
	t^.right:=nil;t^.left:=nil;
end;

function rightrotate(t:treaptype):treaptype;
begin
	rightrotate:=t^.left;
	t^.left:=t^.left^.right;
	rightrotate^.right:=t;
end;

function rightrotate(t:nametype):nametype;
begin
	rightrotate:=t^.left;
	t^.left:=t^.left^.right;
	rightrotate^.right:=t;
end;

function leftrotate(t:treaptype):treaptype;
begin
	leftrotate:=t^.right;
	t^.right:=t^.right^.left;
	leftrotate^.left:=t;
end;

function leftrotate(t:nametype):nametype;
begin
	leftrotate:=t^.right;
	t^.right:=t^.right^.left;
	leftrotate^.left:=t;
end;

function instreap(t,h:treaptype):treaptype;
begin
	if h=nil then exit(t);
	if (h^.data<t^.data)or(h^.data=t^.data)and(h^.time>t^.time) then
	begin
		h^.left:=instreap(t,h^.left);
		if h^.left^.pri>h^.pri then begin h:=rightrotate(h);remain(h^.right);end;
		remain(h);
		exit(h);
	end
	else
	begin
		h^.right:=instreap(t,h^.right);
		if h^.right^.pri>h^.pri then begin h:=leftrotate(h);remain(h^.left);end;
		remain(h);
		exit(h);
	end;
end;

function insname(t,h:nametype):nametype;
begin
	if h=nil then exit(t);
	if h^.nam>t^.nam then
	begin
		h^.left:=insname(t,h^.left);
		if h^.left^.pri>h^.pri then h:=rightrotate(h);
		exit(h);
	end
	else
	begin
		h^.right:=insname(t,h^.right);
		if h^.right^.pri>h^.pri then h:=leftrotate(h);
		exit(h);
	end;
end;

function deltreap(now,t:treaptype):treaptype;
begin
	if t=nil then exit(nil);
	if (t^.data>now^.data)or(t^.data=now^.data)and(t^.time<now^.time) then
	begin
		t^.right:=deltreap(now,t^.right);
		remain(t);
		exit(t)
	end
	else if t<>now then
	begin
		t^.left:=deltreap(now,t^.left);
		remain(t);
		exit(t);
	end;
	if (t^.left=nil)and(t^.right=nil) then begin dispose(t);exit(nil);end;
	if (t^.left<>nil)and(t^.right<>nil)and(t^.left^.pri>t^.right^.pri) or (t^.right=nil)then
	begin
		deltreap:=rightrotate(t);
		deltreap^.right:=deltreap(now,deltreap^.right);
		remain(deltreap);
	end
	else
	begin
		deltreap:=leftrotate(t);
		deltreap^.left:=deltreap(now,deltreap^.left);
		remain(deltreap);
	end;
end;

function search(s:string;t:nametype):nametype;
begin
	if t=nil then exit(nil);
	if s<t^.nam then exit(search(s,t^.left))
	else if s>t^.nam then exit(search(s,t^.right))
	else exit(t);
end;

procedure rank(t,h:treaptype);
begin
	if (t^.data<h^.data)or(t^.data=h^.data)and(t^.time>h^.time) then
	begin
		if h^.left<>nil then inc(tot,H^.left^.total);
		inc(tot);
		rank(t,h^.right);
	end
	else if t<>h then rank(t,h^.left)
	else
	begin
		if h^.left<>nil then inc(tot,h^.left^.total);
		inc(tot);
	end;
end;

procedure print(tot:longint;h:treaptype);
begin
	if h=nil then exit;
	if number>=10 then exit;
	if bj then
	begin
		print(tot,h^.left);
		if number<10 then begin inc(number);ans[number]:=h^.opp^.nam;end;
		print(tot,h^.right);
		exit;
	end;
	if h^.left<>nil then
		if h^.left^.total>=tot then
		begin
			print(tot,h^.left);
			if number<10 then
			begin
				inc(number);
				ans[number]:=h^.opp^.nam;
			end;
			print(tot,h^.right);
		end
		else
		begin
			if h^.left^.total+1=tot then
			begin
				if number<10 then
				begin
					inc(number);
					ans[number]:=h^.opp^.nam;
				end;
				bj:=true;
			end;
			print(tot-1-h^.left^.total,h^.right);
		end
	else
	begin
		if tot=1 then
		begin
			if number<10 then begin inc(number);ans[number]:=h^.opp^.nam;end;
			bj:=true;
		end;
		print(tot-1,h^.right);
	end;
end;

begin
	readln(n);
	root:=nil;
	for i:=1 to n do begin
		read(ch);
		if ch='+' then begin
			build(t);build1(t1);
			t^.time:=i;
			t^.opp:=t1;
			t^.total:=1;
			t1^.opp:=t;
			read(ch1);
			while ch1<>' ' do
			begin
				t1^.nam:=t1^.nam+ch1;
				read(ch1);
			end;
			readln(t^.data);
			tmp1:=search(t1^.nam,root1);
			if tmp1<>nil then
			begin
				tmp:=tmp1^.opp;
				root:=deltreap(tmp,root);
				dispose(t1);
				t^.opp:=tmp1;
				tmp1^.opp:=t;
				root:=instreap(t,root);
			end
			else
			begin
				root:=instreap(t,root);
				root1:=insname(t1,root1);
			end;
		end
		else
		begin
			readln(s);
			if s[1]in ['0'..'9'] then
			begin
				val(s,temp,code);
				number:=0;
				bj:=false;
				print(temp,root);
				for j:=1 to number-1 do
				write(ans[j],' ');
				writeln(ans[number]);
			end
			else
			begin
				tmp1:=search(s,root1);
				tot:=0;
				rank(tmp1^.opp,root);
				writeln(tot);
			end;
		end;
	end;
end.
