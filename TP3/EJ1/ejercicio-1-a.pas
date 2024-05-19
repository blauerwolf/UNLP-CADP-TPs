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
    writeln('Ingrese el código del alumno');
    read(alu.codigo);
    if (alu.codigo <> 0) then begin
        writeln('Ingrese el nombre del alumno'); read(alu.nombre);
        writeln('Ingrese el promedio del alumno'); read(alu.promedio);
    end;
end;

{ declaración de variables del programa principal }
var
    a : alumno;
    cant: integer;

{ cuerpo del programa principal }
begin
    cant := 0;
    leer(a);

    while a.codigo <> 0 do 
    begin
        cant := cant + 1;
        leer(a);
    end;

    writeln('Cantidad de Alumnos leidos: ', cant);

end.