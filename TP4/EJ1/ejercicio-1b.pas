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
        v[i] := i + 100;
        writeln(v[i]);
    end;
end;


//function existe(v:vector; value: integer): boolean;
function existe(v: vector; dL: integer; value: integer): boolean;
var 
    pos: integer;
begin

    pos := 1;

    while ( (pos <= dL) and (v[pos] < value)) do 
    begin 
        pos := pos + 1;
    end;

    if ( (pos <= dL) and (v[pos] = value)) then 
    begin existe := true;
    end else existe := false;
end;


var
    v: vector;
    valor: integer;

begin
    cargarVector(v);

    write('Ingrese un valor a buscar: ');
    readln(valor);

    if (existe(v, DIMENSION, valor)) then
    begin
        writeln('El valor ', valor, ' se encuentra en el vector!');
    end 
    else begin
        writeln('El valor ', valor, ' *NO se encuentra* en el vector.');
    end;
end.
