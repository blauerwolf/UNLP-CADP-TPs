{
    Programa de 50KB
    memoria estática 4k
}

program ejercicio_6c;

type 
    vector = array[1..46] of integer;
    puntero = ^vector;

var
    p1: puntero;


begin 
    new(p1);

    writeln(sizeof(p1^));
    writeln(sizeof(p1));

    dispose(p1);
end.