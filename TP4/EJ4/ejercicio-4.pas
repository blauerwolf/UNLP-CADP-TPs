program ejercicio_4;

const 
    DIMENSION = 1000;

type 
    alumno = record 
        nro: integer;
        apellido: string[50];
        nombre: string[50];
        asistencias: integer;
    end;

    catedra = array[1..DIMENSION] of alumno;

procedure leer(var a: alumno);
begin 
    write('Ingrese Nro de alumno: ');
    readln(a.nro);
    write('Ingrese apellido: ');
    readln(a.apellido);
    write('Ingrese nombre: ');
    readln(a.nombre);
    write('Ingrese asistencias: ');
    readln(a.asistencias);
end;

// TODO: búsqueda mejorada
procedure posAlu(cod: integer; c: catedra; dL: integer; var pos: integer; var ok:boolean);
var 
    i: integer;
begin 
    ok := false;
    i := 1;

    while (not ok) and (i <= dimL) do 
    begin 
        if (c[i].nro = cod) then 
        begin 
            ok := true;
            pos := i;
        end
        else 
        begin 
            i := i + 1;
        end;
    end;
end;

// c: Recibe la posición de un alumno dentro del vector y lo elimina
procedure eliminar(var c: catedra; var dL:integer; var ok:boolean; pos: integer);
var
    i: integer;

begin
    ok := false;

    if ((pos >=1) and (pos <= dL)) then 
    begin 
        for i := pos to (dL -1) do 
            c[i] := c[i+1];

        ok := true;
        dL := dL - 1;
    end
    else 
    begin 
        ok := false;
    end;
end;



