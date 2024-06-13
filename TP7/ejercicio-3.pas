{
    Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de 2020. De
    cada viaje se conoce: número de viaje, código de auto, dirección de origen, dirección de destino y
    kilómetros recorridos durante el viaje. Esta información se encuentra ordenada por código de auto y para
    un mismo código de auto pueden existir 1 o más viajes. Se pide:
    a. Informar los dos códigos de auto que más kilómetros recorrieron.
    b. Generar una lista nueva con los viajes de más de 5 kilómetros recorridos, ordenada por número de
    viaje.
}

program ejercicio_3;
type
    viaje = record 
        numero: integer;
        cod_auto: integer;
        dir_origen: string;
        dir_destino: string;
        kms: integer;
    end;

    lista = ^nodo;

    nodo = record 
        trip: viaje;
        sig: lista;
    end;

procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;

procedure insertarOrdenado(var l: lista; v: viaje);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.trip := v;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.trip.cod_auto < nuevo^.trip.cod_auto) do 
    begin 
      anterior := actual;
      actual := actual^.sig;
    end;

    if (actual = l) then 
    begin 
      nuevo^.sig := l;
      l := nuevo;
    end 
    else begin 
      anterior^.sig := nuevo;
      nuevo^.sig := actual;
    end;
  end;
end;


procedure insertarOrdenado2(var l: lista; v: viaje);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.trip := v;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.trip.numero < nuevo^.trip.numero) do 
    begin 
      anterior := actual;
      actual := actual^.sig;
    end;

    if (actual = l) then 
    begin 
      nuevo^.sig := l;
      l := nuevo;
    end 
    else begin 
      anterior^.sig := nuevo;
      nuevo^.sig := actual;
    end;
  end;
end;

procedure leerViaje(var v: viaje);
begin 
    write('Número de viaje: ');
    readln(v.numero);

    if (v.numero <> -1) then 
    begin 
        write('Código de Auto: ');
        readln(v.cod_auto);
        write('Dirección de Origen: ');
        readln(v.dir_origen);
        write('Dirección de Destino: ');
        readln(v.dir_destino);
        write('Kilómetros: ');
        readln(v.kms);
    end;

    writeln();
end;

procedure cargarViajes(var l: lista);
var 
    v: viaje;
begin 
    leerViaje(v);

    while(v.numero <> -1) do 
    begin 
        insertarOrdenado(l, v);
        leerViaje(v);
        writeln();
    end;
end;


procedure procesarViajes(l: lista; var max_cod1: integer; var max_cod2: integer);
var 
    max_km1, max_km2: integer;

begin 
    max_km1 := -1;
    max_km2 := -1;
    max_cod1 := -1;
    max_cod2 := -1;

    while (l <> nil) do 
    begin 
        if (l^.trip.kms > max_km1) then 
        begin
            max_km2 := max_km1;
            max_km1 := l^.trip.kms;
            max_cod2 := max_cod1;
            max_cod1 := l^.trip.cod_auto;
        end 
        else if (l^.trip.kms > max_km2) then 
        begin 
            max_km2 := l^.trip.kms;
            max_cod2 := l^.trip.cod_auto;
        end;


        l := l^.sig;
    end;
end;

procedure generarListaViajes5k(l: lista; var l2: lista);

begin 
    while (l <> nil) do 
    begin 
        if (l^.trip.kms > 5) then 
            insertarOrdenado2(l2, l^.trip);

        l := l^.sig;
    end;
end;


procedure imprimirLista(l: lista);
begin 

    while (l <> nil) do 
    begin 
        writeln('Número de viaje: ', l^.trip.numero);
        writeln('Código de Auto: ', l^.trip.cod_auto);
        writeln('Dirección de Origen: ', l^.trip.dir_origen);
        writeln('Dirección de Destino: ', l^.trip.dir_destino);
        writeln('Kilómetros: ', l^.trip.kms);
        writeln();

        l := l^.sig;
    end;

end;


var 
    l, l2: lista;
    c1, c2: integer;
begin 
    inicializarLista(l);
    cargarViajes(l);
    imprimirLista(l);
    writeln();

    procesarViajes(l, c1, c2);
    writeln('Códigos de auto que más KMs realizaron: ', c1, ' y ', c2);

    inicializarLista(l2);
    generarListaViajes5k(l, l2);
    writeln();

    writeln('Viajes de más de 5KM:');
    writeln('=====================');
    writeln();
    imprimirLista(l2);
end.