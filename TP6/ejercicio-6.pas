{
    La Agencia Espacial Europea (ESA) está realizando un relevamiento de todas las sondas espaciales
    lanzadas al espacio en la última década. De cada sonda se conoce su nombre, duración estimada de la
    misión (cantidad de meses que permanecerá activa), el costo de construcción, el costo de
    mantenimiento mensual y rango del espectro electromagnético sobre el que realizará estudios. Dicho
    rango se divide en 7 categorías: 1. radio; 2. microondas; 3.infrarrojo; 4. luz visible; 5. ultravioleta;
    6. rayos X; 7. rayos gamma.

    Realizar un programa que lea y almacene la información de todas las sondas espaciales. La lectura
    finaliza al ingresar la sonda llamada “GAIA”, que debe procesarse.
    Una vez finalizada la lectura, informar:

    a. El nombre de la sonda más costosa (considerando su costo de construcción y de mantenimiento).
    b. La cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético.
    c. La cantidad de sondas cuya duración estimada supera la duración promedio de todas las sondas.
    d. El nombre de las sondas cuyo costo de construcción supera el costo promedio entre todas las
    sondas.

    Nota: para resolver los incisos a), b), c) y d), la lista debe recorrerse la menor cantidad de veces posible
}

program ejercicio_6;

type
    rea = array[1..7] of string[50];

    sonda = record 
        nombre: string[50];
        duracion: integer;
        c_const: real;
        c_mant: real;
        rango: integer;
    end;

    lista = ^nodo;

    nodo = record 
        probe: sonda;
        sig: lista;
    end;


procedure inicializarArray(var r:rea);
begin 
    r[1] := 'Radio';
    r[2] := 'Microondas'; 
    r[3] := 'Infrarrojo';
    r[4] := 'Luz visible';
    r[5] := 'Ultravioleta';
    r[6] := 'Rayos X';
    r[7] := 'Rayos Gamma';
end;


{ Inicializa una nueva lista }
procedure inicializarLista(var l:lista); 
begin 
    l := nil;
end;


{ Lee los datos de una sonda }
procedure leerSonda(var s:sonda);
begin 
    write('Nombre: ');
    readln(s.nombre);
    write('Duración estimada de la misión: ');
    readln(s.duracion);
    write('Costo de construcción: ');
    readln(s.c_const);
    write('Costo de mantenimiento mensual: ');
    readln(s.c_mant);
    write('Rango del espectro electromagnético (1-7): ');
    readln(s.rango);
    writeln();
end;



{ Imprime la lista }
procedure imprimirLista(l: lista; r: rea);
begin 
    while (l <> nil) do 
    begin 

        writeln('Nombre: ', l^.probe.nombre);
        writeln('Duración estimada de la misión: ', l^.probe.duracion, ' meses');
        writeln('Costo de construcción: ', l^.probe.c_const:0:2);
        writeln('Costo de mantenimiento mensual: ', l^.probe.c_mant:0:2);
        writeln('Rango del espectro electromagnético: ', r[l^.probe.rango]);
        writeln();

        l := l^.sig;
    end
    
end;


{ Agregar un nodo al final de la lista }
procedure agregarAlFinal(var l:lista; s:sonda);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.probe := s;
    nue^.sig := nil;

    if ( l = nil) then 
        l := nue
    else begin
        aux := l;
        while (aux^.sig <> nil) do 
            aux := aux^.sig;
        
        aux^.sig := nue;
    end;

end;


{ Agrega un nodo a la lista }
procedure agregarAdelante(var l:lista; s:sonda);
var
    nue: lista;

begin
    new(nue);
    nue^.probe := s;
    nue^.sig := l;
    l := nue;
end;


{ Carga la lista }
procedure cargarLista(var l:lista);
var 
    s: sonda;
begin 

    repeat
        leerSonda(s);

        {usar cualquiera de los métodos agregarAlFinal o agregarAdelante}
        //agregarAdelante(l, s);
        agregarAlFinal(l, s);


    until (s.nombre = 'GAIA');

end;


{ Recibe una sonda y calcula su costo }
function calcularCosto(s:sonda): real;
begin 
    calcularCosto := (s.c_const + (s.c_mant * s.duracion));
end;


procedure procesar(l:lista; v:rea; var durProm: real; var costoProm: real);
type 
    rango = array[1..7] of integer;
var 
    dim, acumDuracion, i: integer;
    costoMax, costoActual, acumCosto: real;
    costoNombre: string[50];
    r: rango;


begin 
    dim := 0;
    costoMax := 0;
    costoNombre := '';
    acumDuracion := 0;
    acumCosto := 0;

    { Inicializo el vector de contadores de espectro de c/ sonda }
    for i := 1 to 7 do 
        r[i] := 0;

    

    while l <> nil do 
    begin 
        { Actualizo la dimensión de la lista }
        dim := dim + 1;


        { Calculo el costo de cada sonda }
        costoActual := calcularCosto(l^.probe);

        if (costoActual > costoMax) then
        begin 
            costoMax := costoActual;
            costoNombre := l^.probe.nombre;
        end;

        { Acumulo la sonda por tipo de espectro }
        r[l^.probe.rango] := r[l^.probe.rango] + 1;

        { Acumulo la duración de cada sonda para luego calcular el promedio (usando dim) }
        acumDuracion := acumDuracion + l^.probe.duracion;

        { Acumulo el costo de cada sonda para luego calcular el costo promedio (usando dim) }
        acumCosto := acumCosto + costoActual;

        { avanzo la lista }
        l := l^.sig;
    end;

    { Calculo la duración promedio de todas las sondas }
    durProm := acumDuracion / dim;

    { Calculo el costo promedio de todas las sondas }
    costoProm := acumCosto / dim;


    writeln(costoNombre, ' es la sonda más costosa (considerando su costo de construcción y de mantenimiento)');
    writeln();

    writeln('Cantidad de sondas que realizarán estudios en cada rango del espectro electromagnético:');
    for i := 1 to 7 do 
    begin 
        writeln(v[i], ': ', r[i]);
    end;
    writeln();


end;


procedure procesarPromedios(l:lista; durProm: real; costoProm: real);
var 
    sondas: integer;
begin 
    sondas := 0;

    while l <> nil do
    begin 

        if (l^.probe.duracion > durProm) then 
            sondas := sondas + 1;

        if (calcularCosto(l^.probe) > costoProm) then
            writeln(l^.probe.nombre, ' supera el costo promedio de todas las sondas (', costoProm:0:2, ').');


        l := l^.sig;
    end;

    writeln('La duración estimada de ', sondas, ' sonda(s) supera la duración promedio de todas las sondas');
end;




var
    r: rea;
    pri: lista;
    dim: integer;
    costo_promedio, dur_promedio : real;

begin
    { Inicializo vector del rango del espectro electromagnético }
    inicializarArray(r);

    { Inicializo la lista }
    inicializarLista(pri);

    { Cargo la lista hasta la sonda GAIA }
    cargarLista(pri);

    { Imprimo la lista }
    imprimirLista(pri, r);

    procesar(pri, r, dur_promedio, costo_promedio);

    procesarPromedios(pri, dur_promedio, costo_promedio);


end.