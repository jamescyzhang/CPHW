type
    sol = record
        x, y: int64;
    end;
var
    x, y, m, n, l, d: longint;
    p: sol;

function advMod(x, y: int64): int64;
begin
    exit((x mod y + y) mod y);
end;

function gcd(x, y: int64): sol;
var
    n: sol;
begin
    if y = 0 then
    begin
        d :=  x;
        gcd.x :=  1;
        gcd.y :=  0;
        exit;
    end;
    n :=  gcd(y, advMod(x, y));
    gcd.x :=  n.y;
    gcd.y :=  n.x-(x div y)*n.y;
end;

begin
    read(x, y, m, n, l);
    p :=  gcd(m-n, l);
    if (y-x)mod d = 0 then writeln(advMod(p.x*((y-x)div d), (l div d)))
    else writeln('Impossible');
end.
