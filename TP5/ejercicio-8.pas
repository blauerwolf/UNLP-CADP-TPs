program memoria;
type
    datos = array [1..20] of integer;
    punt = ^datos;

procedure procesarDatos(v : datos; var v2 : datos);
var
    i, j : integer;

begin
    for i := 1 to 20 do
    v2[21 - i] := v[i];
end;

var
    vect : datos;
    pvect : punt;
    i : integer;

begin
    for i:= 1 to 20 do
        vect[i] := i;

    new(pvect);

    for i:= 20 downto 1 do
        pvect^[i] := 0;
        procesarDatos(pvect^, vect);
        writeln('fin');
end.