program ejercicio_8;

type
    docente = record
        dni: integer;
        nombre: string;
        apellido: string;
        email: string;
    end;

    proyecto = record
        codigo: integer;
        titulo: string;
        coordinador: docente;
        alumnos: integer;
        escuela: string;
        localidad: string;
    end;

procedure leerDocente(var d: docente);
begin
    write('Ingrese DNI del docente: ');
    readln(d.dni);
    write('Ingrese el nombre del docente: ');
    readln(d.nombre);
    write('Ingrese apellido del docente: ');
    readln(d.apellido);
    write('Ingrese el email: ');
    readln(d.email);
    writeln();
end;


procedure leerProyecto(var p: proyecto);
var
    doc: docente;
begin
    write('Ingrese código de proyecto: ');
    readln(p.codigo);
    write('Ingrese título del proyecto: ');
    readln(p.titulo);
    write('Ingrese la cantidad de alumnos: ');
    readln(p.alumnos);
    write('Ingrese el nombre de la escuela: ');
    readln(p.escuela);
    write('Ingrese la localidad: ');
    readln(p.localidad);
    writeln();

    writeln('DATOS DEL DOCENTE COORDINARDOR: ');
    leerDocente(doc);
    p.coordinador := doc;

end;

function esPar(num: integer): boolean;
begin
    esPar := (num MOD 2 = 0);
end;


function digParesImpares(cod: integer): boolean;
var
    resto, aux, pares, impares: integer;
begin
    pares := 0;
    impares := 0;

    aux := cod;
    
    while aux <> 0 do
    begin
        resto := aux MOD 10;

        if (esPar(resto)) then
        begin
            pares := pares + 1;
        end
        else
        begin
            impares := impares + 1;
        end;


        aux := aux DIV 10;
    end;

    digParesImpares := (pares = impares);
    
end;

procedure titulosDaireaux(p: proyecto);
begin
    if (p.localidad = 'Daireaux') and (digParesImpares(p.codigo)) then
        writeln('El proyecto ', p.titulo, ' es de la localidad de Daireaux');
        writeln();
end;

procedure actualizarMaximos(p: proyecto; var max1, max2: integer; var nom1, nom2: string);
begin
    if (p.alumnos > max1) then
    begin
        max2 := max1;
        max1 := p.alumnos;
        nom2 := nom1;
        nom1 := p.escuela;
    end
    else if (p.alumnos > max2) then
    begin
        max2 := p.alumnos;
        nom2 := p.escuela;
    end;
end;


var
    tot_escuelas, tot_localidad, max1, max2: integer;
    nombre_max1, nombre_max2, loc_actual: string;
    proy: proyecto;
    

begin
    tot_escuelas := 0;
    max1 := 0;
    max2 := 0;
    nombre_max1 := '';
    nombre_max2 := '';

    leerProyecto(proy);

    while proy.codigo <> -1 do
    begin
        tot_escuelas := tot_escuelas + 1;

        loc_actual := proy.localidad;
        tot_localidad := 0;

        while proy.localidad = loc_actual do
        begin
            tot_localidad := tot_localidad + 1;

            titulosDaireaux(proy);
            actualizarMaximos(proy, max1, max2, nombre_max1, nombre_max2);


            leerProyecto(proy);
        end;

        writeln('Escuelas de la localidad ', loc_actual, ': ', tot_localidad);


    end;

    writeln('Cantidad total de escuelas participants: ', tot_escuelas);


end.
