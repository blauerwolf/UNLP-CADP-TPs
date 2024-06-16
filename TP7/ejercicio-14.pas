{
    La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar información de
    préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información de los préstamos
    realizados. De cada préstamo se lee: nro. de préstamo, ISBN del libro prestado, nro. de socio al que se prestó el
    libro, día del préstamo (1..31). La información de los préstamos se lee de manera ordenada por ISBN y finaliza
    cuando se ingresa el ISBN -1 (que no debe procesarse).
    Se pide:
    A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado.
    Esta estructura debe quedar ordenada por ISBN de libro.
    B) Calcular e informar el día del mes en que se realizaron menos préstamos.
    C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par.
}

program ejercicio_14;
type 
    vPrestamos = array[1..31] of integer;

    prestamo = record 
        numero: integer;
        isbn: int64;
        nro_socio: integer;
        dia: 1..31;
    end;

    data = record 
        isbn: int64;
        prestado: integer;
    end;


    lista = ^nodo;
    lista2 = ^nodo2;

    nodo = record 
        elem: prestamo;
        sig: lista;
    end;

    nodo2 = record 
        elem: data;
        sig: lista2;
    end;

procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;


procedure inicializarLista2(var l: lista2);
begin 
    l := nil;
end;


procedure agregarAlFinal(var l:lista; p: prestamo);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.elem := p;
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

procedure agregarAlFinal2(var l:lista2; isbn: int64; cont: integer);
var 
    nue, aux: lista2;
begin 
    new(nue);
    nue^.elem.isbn := isbn;
    nue^.elem.prestado := cont;
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


procedure leerPrestamo(var p: prestamo);
begin 
    write('ISBN: ');
    readln(p.isbn);

    if (p.isbn <> -1) then 
    begin 
        write('Número de préstamo: ');
        readln(p.numero);
        write('Nro de socio: ');
        readln(p.nro_socio);
        write('Dia del mes: ');
        readln(p.dia);
    end;

    writeln();
end;

procedure cargarPrestamos(var l: lista);
var 
    p: prestamo;
begin 
    leerPrestamo(p);

    while (p.isbn <> -1) do 
    begin 
        agregarAlFinal(l, p);
        leerPrestamo(p);
    end;
end;


procedure imprimirLista(l: lista);
begin 
    while (l <> nil) do 
    begin

        writeln('Número de préstamo: ', l^.elem.numero);
        writeln('ISBN: ', l^.elem.isbn);
        writeln('Número de Socio: ', l^.elem.nro_socio);
        writeln('Día del mes: ', l^.elem.dia);
        writeln();

        l := l^.sig;
    end;
end;

procedure imprimirLista2(l: lista2);
begin 
    while (l <> nil) do 
    begin 
        writeln('ISBN: ', l^.elem.isbn);
        writeln('Cantidad de veces prestado: ', l^.elem.prestado);
        writeln();

        l := l^.sig;
    end;
end;


function diaMenosPrestamos(v: vPrestamos): integer;
var i, min, dia: integer;
begin 
    min := 32767;
    dia := 0;

    for i := 1 to 31 do 
    begin 
        if (v[i] < min) then
        begin 
            min := v[i];
            dia := i;
        end;
    end;

    diaMenosPrestamos := dia;
end;


function esPar(num: integer): boolean;
begin
    esPar := (num MOD 2 = 0);
end;


procedure procesarPrestamos(l: lista; var l2: lista2);
var
    actual: prestamo;
    cont_prestamos, i, tot_registros, cant_par_impar: integer;
    vContador: vPrestamos;
begin
    { Inicializo el contador de total de registros de la lista }
    tot_registros := 0;

    { Inicializo el contador de pŕestamos con código impar y nro socio par }
    cant_par_impar := 0;

    { Inicializo el contador de préstamos por día del mes }
    for i := 1 to 31 do 
        vContador[i] := 0;


    while (l <> nil) do 
    begin 
        
        actual := l^.elem;

        { Reinicializo el contador parcial por isbn }
        cont_prestamos := 0;

        while (l <> nil) and (l^.elem.isbn = actual.isbn) do 
        begin 

            { Actualizo el contador de registros totales }
            tot_registros := tot_registros + 1;

            { Actualizo el contador de préstamos por libro }
            cont_prestamos := cont_prestamos + 1;

            { Actualizo los contadores de préstamos por día }
            vContador[l^.elem.dia] := vContador[l^.elem.dia] + 1;

            { Actualizo el contador de préstamos con cod impar y nro socio par}
            if (not esPar(l^.elem.numero)) and (esPar(l^.elem.nro_socio)) then 
                cant_par_impar := cant_par_impar + 1;


            { 
                A) Generar una estructura que contenga, para cada ISBN de libro, 
                la cantidad de veces que fue prestado.
                Esta estructura debe quedar ordenada por ISBN de libro. 
            }
            agregarAlFinal2(l2, l^.elem.isbn, cont_prestamos);

            { Avanzo sl siguiente nodo de la lista }
            l := l^.sig;
        end;               
    end;

    { B) Calcular e informar el día del mes en que se realizaron menos préstamos. }
    writeln('Día del mes con menos préstamos: ', diaMenosPrestamos(vContador));
    writeln();

    { C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio par. }
    writeln('Porcentaje de pŕestamos con Nro impar y Nro de socio par: ', (cant_par_impar * 100 / tot_registros):0:2);
    writeln();
end;



var 
    l: lista;
    l2: lista2;

begin
    inicializarLista(l);
    cargarPrestamos(l);
    imprimirLista(l);

    inicializarLista2(l2);
    procesarPrestamos(l, l2);

    imprimirLista2(l2);
end.
