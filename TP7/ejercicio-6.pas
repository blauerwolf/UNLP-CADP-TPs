{
    El Observatorio Astronómico de La Plata ha realizado un relevamiento sobre los distintos objetos
    astronómicos observados durante el año 2015. Los objetos se clasifican en 7 categorías: 1: estrellas, 2:
    planetas, 3: satélites, 4: galaxias, 5: asteroides, 6: cometas y 7: nebulosas.
    Al observar un objeto, se registran los siguientes datos: código del objeto, categoría del objeto (1..7),
    nombre del objeto, distancia a la Tierra (medida en años luz), nombre del descubridor y año de su
    descubrimiento.

    A. Desarrolle un programa que lea y almacene la información de los objetos que han sido observados.
    Dicha información se lee hasta encontrar un objeto con código -1 (el cual no debe procesarse). La
    estructura generada debe mantener el orden en que fueron leídos los datos.
    B. Una vez leídos y almacenados todos los datos, se pide realizar un reporte con la siguiente
    información:
    
    1. Los códigos de los dos objetos más lejanos de la tierra que se hayan observado.
    2. La cantidad de planetas descubiertos por "Galileo Galilei" antes del año 1600.
    3. La cantidad de objetos observados por cada categoría.
    4. Los nombres de las estrellas cuyos códigos de objeto poseen más dígitos pares que impares.
}

program ejercicio_6;
type
    categorias = array[1..7] of string;
    cont_categorias = array[1..7] of integer;

    objeto = record 
        codigo: integer;
        categoria: 1..7;
        nombre: string;
        distancia: real;
        descubridor: string;
        anio_descubrimiento: integer;
    end;

    lista = ^nodo;

    nodo = record 
        elem: objeto;
        sig: lista;
    end;

procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;

procedure inicializarCategorias(var c: categorias);
begin 
    c[1] := 'Estrellas';
    c[2] := 'Planetas';
    c[3] := 'Satélites';
    c[4] := 'Galaxias'; 
    c[5] := 'Asteroides'; 
    c[6] := 'Cometas';
    c[7] := 'Nebulosas';
end;


procedure agregarAlFinal(var l:lista; o: objeto);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.elem := o;
    nue^.sig := nil;

    if ( l = nil) then
        l := nue
    else 
    begin
        aux := l;

        while (aux^.sig <> nil) do 
            aux := aux^.sig;
        
        aux^.sig := nue;
    end;
end;


procedure leerObjeto(var o: objeto);
begin 
    write('Código: ');
    readln(o.codigo);

    if (o.codigo <> -1) then 
    begin 
        write('Categoría: ');
        readln(o.categoria);
        write('Nombre: ');
        readln(o.nombre);
        write('Distancia en Años Luz: ');
        readln(o.distancia);
        write('Descubridor: ');
        readln(o.descubridor);
        write('Año de descubrimiento: ');
        readln(o.anio_descubrimiento);
    end;
    writeln();
end;

procedure cargarObjetos(var l: lista);
var 
    o: objeto;
begin 
    leerObjeto(o);

    while (o.codigo <> -1) do
    begin 
        agregarAlFinal(l, o);
        leerObjeto(o);
    end;
end;

procedure imprimirLista(l: lista; c: categorias);
begin 
    while (l <> nil) do 
    begin 
        writeln('Código: ', l^.elem.codigo);
        writeln('Categoría: ', l^.elem.categoria, ' (', c[l^.elem.categoria], ')');
        writeln('Nombre: ', l^.elem.nombre);
        writeln('Distancia: ', l^.elem.distancia:0:2);
        writeln('Descubridor: ', l^.elem.descubridor);
        writeln('Año de descubrimiento: ', l^.elem.anio_descubrimiento);
        writeln();


        l := l^.sig;
    end;
end;


function esPar(num: integer): boolean;
begin
    writeln('esPar');
    esPar := (num MOD 2 = 0);
end;

function masImpares(cod: integer): boolean;
var
    aux, resto, pares, impares: integer;
begin
    writeln('masImpares');
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

    masImpares := (impares > pares);   
end;

procedure procesarObjetos(l: lista; c: categorias);
var
    cod_lej1, cod_lej2, cant_galileo, i: integer;
    dist1, dist2: real;
    cant_objs: cont_categorias;
begin 
    writeln('procesar');
    cod_lej1 := 0;
    cod_lej2 := 0;
    dist1 := 0;
    dist2 := 0;
    cant_galileo := 0;

    for i := 1 to 7 do 
        cant_objs[i] := 0;

    while (l <> nil) do 
    begin 

        { 1. Los códigos de los dos objetos más lejanos de la tierra que se hayan observado. }
        if (l^.elem.distancia > dist1) then 
        begin 
            dist2 := dist1;
            dist1 := l^.elem.distancia;
            cod_lej2 := cod_lej1;
            cod_lej1 := l^.elem.codigo;
        end
        else if (l^.elem.distancia > dist2) then 
        begin 
            dist2 := l^.elem.distancia;
            cod_lej2 := l^.elem.codigo;
        end;

        { 2. La cantidad de planetas descubiertos por "Galileo Galilei" antes del año 1600. }
        if (l^.elem.descubridor = 'Galileo Galilei') 
            and (l^.elem.anio_descubrimiento < 1600) 
            and (l^.elem.categoria = 2) then 
            cant_galileo := cant_galileo + 1;

        { 3. La cantidad de objetos observados por cada categoría. }
        cant_objs[l^.elem.categoria] := cant_objs[l^.elem.categoria] + 1;


        { 4. Los nombres de las estrellas cuyos códigos de objeto poseen más dígitos pares que impares. }
        if (l^.elem.categoria = 1) and (masImpares(l^.elem.codigo)) then 
            writeln('El código de la estrella "', l^.elem.nombre, '" posee más dígitos pares que impares: ', l^.elem.codigo);
            


        l := l^.sig;
    end;

    { 1. Los códigos de los dos objetos más lejanos de la tierra que se hayan observado. }
    writeln('Códigos de los dos objetos más lejandos a la tierra observados:');
    writeln(' * ', cod_lej1);
    writeln(' * ', cod_lej2);
    writeln();


    { 2. La cantidad de planetas descubiertos por "Galileo Galilei" antes del año 1600. }
    writeln('Cantidad de planetas descubiertos por Galileo Galilei antes de año 1600: ', cant_galileo);
    writeln();


    { 3. La cantidad de objetos observados por cada categoría. }
    writeln('Cantidad de objetos observados por categoría: ');
    for i := 1 to 7 do 
    begin 
        writeln(i, ' (', c[i], '):'#9, cant_objs[i]);
    end;
end;


var 
    l: lista;
    c: categorias;

begin 
    inicializarCategorias(c);
    inicializarLista(l);
    cargarObjetos(l);

    imprimirLista(l, c);

    procesarObjetos(l, c);
end.




