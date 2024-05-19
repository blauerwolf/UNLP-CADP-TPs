program Registros;
type
    str20 = string[20];
    alumno = record
        codigo : integer;
        nombre : str20;
        promedio : real;
    end;

procedure leer(var alu : alumno);
begin
    write('Ingrese el código del alumno: ');
    readln(alu.codigo);

    if (alu.codigo <> 0) then begin
        write('Ingrese el nombre del alumno: '); readln(alu.nombre);
        write('Ingrese el promedio del alumno: '); readln(alu.promedio);
    end;
end;

{ declaración de variables del programa principal }
var
    a : alumno;
    prom_max: real;
    cant: integer;
    nom: string;

{ cuerpo del programa principal }
begin
    cant := 0;
    prom_max := -1;
    nom := '';

    leer(a);

    while a.codigo <> 0 do 
    begin
        cant := cant + 1;
        if a.promedio > prom_max then
        begin
            prom_max := a.promedio;
            nom := a.nombre;
        end;
        leer(a);
    end;

    writeln('Cantidad de Alumnos leidos: ', cant);
    writeln('Alumno con mayor promedio: ', nom);

end.