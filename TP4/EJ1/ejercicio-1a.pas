program ejercicio_1;

const 
    DIMENSION = 500;
type
    vector = array[1..DIMENSION] of integer;

procedure cargarVector(var v: vector);
var
    i: integer;

begin
    for i := 1 to DIMENSION do
    begin
        v[i] := random(32767);
        writeln(v[i]);
    end;
end;


function existe(v:vector; value: integer): boolean;
var 
    i: integer;
    ok: boolean;
begin
    ok := false;
    i := 1;

    while (not ok) and (i <= DIMENSION) do
    begin
        if v[i] = value then
        begin
            ok := true;
        end
        else begin
            i := i + 1;
        end;
    end;

    existe := ok;

end;

var
    v: vector;
    valor: integer;

begin
    cargarVector(v);

    write('Ingrese un valor a buscar: ');
    readln(valor);

    if (existe(v, valor)) then
    begin
        writeln('El valor ', valor, ' se encuentra en el vector!');
    end 
    else begin
        writeln('El valor ', valor, ' *NO se encuentra* en el vector.');
    end;
end.
