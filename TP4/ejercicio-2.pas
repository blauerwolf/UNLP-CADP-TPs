{
    Realice un programa ue resuelva os siguientes incisos:

    - Lea nombres de alumnos y los almacene en un vector de a lo sumo 500 elementos.
    la lectura finalza cuando se lee el nombre ZZZ que no debe procesarse
    - Lea un nombre y elimine la primera ocurrencia de dicho nombre en el vector.
    - Lea un nombre y lo inserte en  la posicion 4 del vector.
    - Lea un nombre y lo agregue al vector

    Realizar todas las validaciiones necesarias
}

program ejercicio_2;
const 
    TOTAL_ALUMNOS = 500;

type
    alumnos = array[1..500] of string;

procedure leer(var alus: alumnos; var dimL: integer);
var
    a: string;
begin
    dimL := 0;
    write('Ingrese nombre de alumno: ');
    readln(a);

    while (a <> 'ZZZ') and (dimL <= TOTAL_ALUMNOS) do 
    begin 
        dimL := dimL + 1;
        alus[dimL] := a;

        write('Ingrese nombre de alumno: ');
        readln(a);
        
    end;
end;

procedure buscar(nombre: string; var alus: alumnos; var dimL: integer; var ok: boolean; var pos: integer);
var 
    i: integer;
begin 
    ok := false;
    i := 1;

    while (not ok) and (i <= dimL) do 
    begin
        if (alus[i] = nombre) then 
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

procedure eliminar(var a:alumnos; var dimL:integer; var ok:boolean; pos: integer);
var
    i: integer;

begin
    ok := false;

    if ((pos >=1) and (pos <= dimL)) then 
    begin 
        for i := pos to (dimL -1) do 
            a[i] := a[i+1];

        ok := true;
        dimL := dimL - 1;
    end
    else 
    begin 
        ok := false;
    end;

    
end;

procedure imprimirVector(a: alumnos; dimL: integer);
var i: integer;
begin 
    for i := 1 to dimL do 
    begin 
        writeln(a[i]);
    end;
end;

procedure insertar(nombre: string; var a: alumnos; var dimL: integer; pos: integer; var ok: boolean);
var i: integer;
begin  
    ok := false;

    if ((dimL + 1) <= TOTAL_ALUMNOS) and (pos >= 1) and (pos <= dimL) then 
    begin 
        for i := dimL downto pos do 
        begin 
            a[i+1] := a[i];
        end;

        ok := true;
        a[pos] := nombre;
        dimL := dimL + 1;
    end;
end;

procedure agregar(nombre: string; var a: alumnos; var dimL: integer; var ok:boolean);
begin 
    ok := false;

    if ((dimL + 1) <= TOTAL_ALUMNOS) then 
    begin 
        ok := true;
        dimL := dimL + 1;
        a[dimL] := nombre;
    end; 

end;

var 
    a: alumnos;
    dimL, pos: integer;
    nombre: string;
    ok: boolean;

begin 

    leer(a, dimL);


    write('Ingrese nombre a eliminar ');
    readln(nombre);

    buscar(nombre, a, dimL, ok, pos);
    writeln('posicion encontrada: ', pos);
    eliminar(a, dimL, ok, pos);

    imprimirVector(a, dimL);

    write('Ingrese un nombre a insertar en pos 4: ');
    readln(nombre);

    insertar(nombre, a, dimL, pos, ok);
    imprimirVector(a, dimL);

    write('Ingrese un nombre a agregar: ');
    readln(nombre);

    agregar(nombre, a, dimL, ok);
    imprimirVector(a, dimL);

end.