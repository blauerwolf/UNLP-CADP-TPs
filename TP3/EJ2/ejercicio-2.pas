program ejercicio_2;

type
    fecha = record
        dia: 1..31;
        mes: 1..12;
        anio: integer;
    end;

procedure leer(var f: fecha);
begin
    write('Ingrese día: ');
    readln(f.dia);
    write('Ingrese mes: ');
    readln(f.mes);
    write('Ingrese año: ');
    readln(f.anio);
end;

const ANIO = 2020;

var
    cant_verano, cant_10: integer;
    f: fecha;

begin
    cant_verano := 0;
    cant_10 := 0;

    leer(f);

    while f.anio <> ANIO do
    begin
        if (f.mes = 1) or (f.mes = 2) or (f.mes = 3) then
            cant_verano := cant_verano + 1;
        
        if f.dia <= 10 then
            cant_10 := cant_10 + 1;

        leer(f);

    end;

    writeln('Casamientos en verano: ', cant_verano);
    writeln('Cantidad de casamientos realizados en los primeros 10 días de cada mes: ', cant_10);
end.