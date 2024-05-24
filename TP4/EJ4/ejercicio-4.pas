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

procedure cargarAlumnos(var v:catedra; var dL: integer);
var  
    a: alumno;
begin 
    leer(a);

    while (a.nro  <> 0) do 
    begin 
        dL := dL + 1;
        v[dL] := a;

        leer(a);
    end;

end;    

// Busqueda desordenada
procedure posAlu(cod: integer; c: catedra; dL: integer; var pos: integer; var ok:boolean);
var 
    i: integer;
begin 
    ok := false;
    i := 1;

    while (not ok) and (i <= dL) do 
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

// Busqueda mejorada
procedure buscarPosAluE(valor: integer; c: catedra; dL: integer; var pos: integer; var ok:boolean);

begin
    pos := 1;

    while (pos <= dL) and (c[pos].nro < valor) do 
    begin 
        pos := pos + 1;
    end;

    if ( pos <= dL) and (c[pos].nro = valor) then 
    begin 
        ok := true;
    end
    else ok := false;
end;

// TODO: Busqueda dicotomica

procedure insertar(var c: catedra; var dL: integer; a: alumno; var ok: boolean);
begin
    ok := false;

    if ((dl + 1) <= DIMENSION) then 
    begin 
        ok := true;
        dL := dL + 1;
        c[dL] := a;
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


procedure imprimirVector(c: catedra; dL:integer);
var 
    i: integer;
begin 
    for i := 1 to dL do
    begin 
        writeln('Código alumno: ', c[i].nro);
        writeln('Apellido: ', c[i].apellido);
        writeln('Nombre: ', c[i].nombre);
        writeln('Asistencias: ', c[i].asistencias);
        writeln();
    end;
end;

procedure borrarPorCod(var c: catedra; var dL: integer; valor: integer; var ok: boolean);
var 
    pos: integer;
    pude: boolean;
begin 
    buscarPosAluE(valor, c, dL, pos, ok);
    if ok then 
    begin
        eliminar(c, dL, pude, pos);
    end 
    else 
        pude := false;
        
end;

procedure eliminarAusentes(var c: catedra; var dL: integer);
var 
    pos: integer;
    ok: boolean;
begin 
    for pos := 1 to dL do 
    begin 
        if c[pos].asistencias = 0 then 
            eliminar(c, dL, ok, pos);
    end;
end;

var 
    alumnos: catedra;
    alu: alumno;
    dimL, pos: integer;
    ok: boolean;

begin 
    // TODO: DEBUG
    
    dimL := 0;
    pos := 0;

    cargarAlumnos(alumnos, dimL);
    buscarPosAluE(40, alumnos, dimL, pos, ok);

    writeln('Ingrese datos de alumno: ');
    leer(alu);
    insertar(alumnos, dimL, alu, ok);

    imprimirVector(alumnos, dimL);
    writeln('------------------------------------');

    borrarPorCod(alumnos, dimL, 40, ok);
    imprimirVector(alumnos, dimL);
    writeln('------------------------------------');
    
    eliminarAusentes(alumnos, dimL);
    writeln('------------------------------------');


end.