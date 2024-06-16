{
    Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100 camiones.
    De cada camión se tiene: patente, año de fabricación y capacidad (peso máximo en toneladas que puede
    transportar).
    Realizar un programa que lea y almacene la información de los viajes realizados por la empresa. De cada
    viaje se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros recorrida, 
    ciudad de destino, año en que se realizó el viaje y DNI del chofer. La lectura finaliza cuando se lee el código
    de viaje -1.

    Una vez leída y almacenada la información, se pide:
    1. Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que
    menos kilómetros recorridos posee.
    2. Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5 toneladas
    y que posean una antigüedad mayor a 5 años al momento de realizar el viaje (año en que se realizó el
    viaje).
    3. Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
    Nota: Los códigos de viaje no se repiten.
}

program ejercicio_5;
const 
    dimFC = 100;
    dimFV = 100;

type
    camion = record 
        patente: string[7];
        fabricacion: integer;
        tara: real;
    end;

    viaje = record 
        id: integer;
        camion_id: integer;
        distancia: integer;
        destino: string;
        anio: integer;
        dni_chofer: Longword;
    end;

    vectorViajes = array[1..100] of viaje;
    vectorCamiones = array [1..100] of camion;
    contadores = array[1..dimFC] of integer;


{ Posiblemente no lo use y cargue automáticamente los camiones }
procedure leerCamion(var c: camion);
begin 
    write('Patente: ');
    readln(c.patente);
    write('Año de fabricación: ');
    readln(c.fabricacion);
    write('Capacidad: ');
    readln(c.tara);
    writeln();
end;

procedure imprimirCamion(c: camion);
begin 
    writeln('Patente: ', c.patente);
    writeln('Año de fabricación: ', c.fabricacion);
    writeln('Capacidad: ', c.tara:0:2);
    writeln();
end;


procedure imprimirListaCamiones(vC: vectorCamiones);
var 
    i: integer;
begin
    for i := 1 to dimFC do
    begin 
        imprimirCamion(vC[i]);
    end;
end;


procedure leerViaje(var v: viaje);
begin 
    write('Código de viaje: ');
    readln(v.id);

    if (v.id <> -1) then 
    begin 
        write('Código del camión: ');
        readln(v.camion_id);
        write('Distancia (KMs recorridos): ');
        readln(v.distancia);
        write('Ciudad de destino: ');
        readln(v.destino);
        write('Año del viaje: ');
        readln(v.anio);
        write('DNI del chofer: ');
        readln(v.dni_chofer);
    end;

    writeln();
end;


procedure cargarViajes(var vV: vectorViajes; var dimL: integer);
var 
    v: viaje;
begin 
    leerViaje(v);

    while (v.id <> -1) and (dimL + 1 <= dimFV) do 
    begin 
        dimL := dimL + 1;

        vV[dimL] := v;

        leerViaje(v);

    end;
end;

{ Carga automáticamente los 100 camiones }
// Excede a CADP pero quería que se ejecute en PC
procedure seedCamion(var c: camion);
var 
    patente: string[7];
    fabricacion, i: integer;
    tara: real;
    alf: string;

begin


    alf := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    { Formo la patente aleatoriamente }
    // 2 Primeras letras:
    patente := alf[random(26) + 1];
    patente := patente + alf[random(26) + 1];
    
    for i := 1 to 3 do 
        patente := patente + Chr(Ord('0') + random(10));
        
    // Genero las últimas 2 letras
    patente := patente + alf[random(26) + 1];
    patente := patente + alf[random(26) + 1];
    
    fabricacion := 1995 + random(30);
    tara := 3.0 + (45.0 - 3.0) * Random;

    c.patente := patente;
    c.fabricacion := fabricacion;
    c.tara := tara;

end;


procedure cargarCamiones(var vC: vectorCamiones);
var 
    i: integer;
begin 
    for i := 1 to dimFC do 
    begin 
        seedCamion(vC[i]);
    end;
end;


function esPar(num: integer): boolean;
begin
    esPar := (num MOD 2 = 0);
end;


function digImpares(cod: integer): boolean;
var
    resto, aux: integer;
    ok: boolean;
begin

    ok := true;

    aux := cod;
    
    while aux <> 0 do
    begin
        resto := aux MOD 10;

        if (esPar(resto)) then
            ok := false;

        aux := aux DIV 10;
    end;

    digImpares := ok;
    
end;

procedure procesarViajes(vV: vectorViajes; dimL: integer; vC: vectorCamiones);
var 
    i, k1, k2, id1, id2, viajes: integer;
    c: contadores;

begin 
    { Inicializo contadores }
    for i := 1 to dimFC do 
        c[i] := 0;

    k1 := 0;
    k2 := 32767;
    id1 := 0;
    id2 := 0;
    viajes := 0;

    { Sumo los KMs de cada camión... }
    for i := 1 to dimL do
    begin
        c[vV[i].camion_id] := c[vV[i].camion_id] + vV[i].distancia;

        if (vC[vV[i].camion_id].tara > 30.5) and ( (vV[i].anio - vC[vV[i].camion_id].tara) > 5 ) then 
            viajes := viajes + 1;

        { Punto 3 - Opción 1: lo imprimo acá }
        {
        if (digImpares(vV[i].dni_chofer)) then
            writeln(vV[i].id);
        } 

    end;

    { Calculo el máximo / mínimo }
    for i := 1 to dimFC do 
    begin 
        if (c[i] > k1) then 
        begin 
            k1 := c[i];
            id1 := i;
        end;

        if (c[i] < k2) then 
        begin 
            k2 := c[i];
            id2 := i;
        end;
    end;

    writeln('Camión con más KM recorridos DOMINIO: ', vC[id1].patente);
    writeln('Camión con menos KM recorridos DOMINIO: ', vC[id2].patente);
    writeln();

    writeln('Cantidad de viajes realizados en camiones con capacidad mayor a 30.5t y antigüedad > 5 años: ', viajes);
    writeln();


    for i := 1 to dimL do 
    begin 
        if (digImpares(vV[i].dni_chofer)) then
            writeln(vV[i].id);
    end;

end;

var 
    vC: vectorCamiones;
    vV: vectorViajes;
    dimL: integer;

begin 
    cargarCamiones(vC);
    //imprimirListaCamiones(vC);

    dimL := 0;
    cargarViajes(vV, dimL);

    procesarViajes(vV, dimL, vC);



    
end.