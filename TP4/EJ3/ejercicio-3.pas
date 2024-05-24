program ejercicio_3;

const
    DIMENSION = 200;

type 
    viaje = record 
        dia: 1..31;
        monto: real;
        distancia: integer;
    end;

    vector = array[1..DIMENSION] of viaje;

procedure leer(var v: viaje);
begin 
    write('Ingrese día del mes: ');
    readln(v.dia);
    write('Ingrese el monto transportado: ');
    readln(v.monto);
    write('Ingrese la distancia recorrida (KM): ');
    readln(v.distancia);
end;

procedure cargarDatos(var viajes: vector; var dimL: integer);
var 
    v: viaje;
begin

    leer(v);

    while ((v.distancia <> 0) and (dimL <= DIMENSION)) do 
    begin 
        dimL := dimL + 1;
        viajes[dimL] := v;
        leer(v);
    end;
end;

procedure procesar(viajes: vector; dL: integer);
var 
    prom, min_cash: real;
    min_cash_km, pos: integer;
    min_cash_dia: 1..31;
    v: viaje;
begin

    min_cash := 99999999999999999;
    min_cash_km := 0;
    min_cash_dia:= 1;
    prom := 0;

    pos := 1;

    while (pos <= dL) do 
    begin 
        v := viajes[pos];

        prom := prom + v.monto;

        if (v.monto < min_cash) then 
        begin 

            min_cash := v.monto;
            min_cash_km := v.distancia;
            min_cash_dia := v.dia;

        end;

        pos := pos + 1;
    end;



    writeln('El monto promedio es: ', prom/dL:0:2);
    writeln('Distancia recorrida: ', min_cash_km, ', dia: ', min_cash_dia, ' con menos dinero transportado.');

end;



procedure eliminar(var viajes: vector; var dL:integer; var ok:boolean; pos: integer);
var
    i: integer;

begin
    ok := false;

    if ((pos >=1) and (pos <= dL)) then 
    begin 
        for i := pos to (dL -1) do 
            viajes[i] := viajes[i+1];

        ok := true;
        dL := dL - 1;
    end
    else 
    begin 
        ok := false;
    end;

    
end;

procedure eliminar100KM(var viajes: vector; var dL: integer);
var 
    i: integer;
    ok: boolean;
begin 
    for i := 1 to dL do 
    begin 
        if viajes[i].distancia = 100 then 
        begin 
            write('Viaje #', i, ' con 100KM recorridos ');
            eliminar(viajes, dL, ok, i);

            if (ok) then begin
                writeln('eliminado correctamente. Nueva dimL: ', dL);
            end
            else writeln('No se pudo eliminar');

        end;
    end;
end;




var 
    vjs: vector;
    dimL, i: integer;

begin 
    cargarDatos(vjs, dimL);

    for i := 1 to dimL  do 
    begin
        writeln('Monto: ', vjs[i].monto:0:2);
        writeln('KM: ', vjs[i].distancia);
        writeln('Dia: ', vjs[i].dia);
    end;

    procesar(vjs, dimL);
    eliminar100KM(vjs, dimL);

end.