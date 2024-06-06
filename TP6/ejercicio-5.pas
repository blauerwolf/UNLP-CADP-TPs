{
    Realizar un programa que lea y almacene la información de productos de un supermercado. De cada
    producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se
    ingresa el código -1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular
    e informar:
    a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
    b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
    c. Código de los dos productos más económicos.
}


program ejercicio_5;

//const 

type
    producto = record 
        cod: integer;
        descripcion: string[50];
        stock_actual: integer;
        stock_min: integer;
        precio: real;
    end;

    lista = ^nodo;

    nodo = record 
        prod: producto;
        sig: lista;
    end;

procedure leerProducto(var p: producto);
begin 
    write('Código: ');
    readln(p.cod);

    if (p.cod <> -1) then 
    begin
        write('Descripcion: ');
        readln(p.descripcion);
        write('Stock actual: ');
        readln(p.stock_actual);
        write('Stock minimo: ');
        readln(p.stock_min);
        write('Precio: ');
        readln(p.precio);
    end;

    writeln();
end;


{ Inicializa una nueva lista }
procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;  


{ Agregar un nodo al final de la lista }
procedure agregarAlFinal(var l:lista; p:producto);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.prod := p;
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
procedure agregarAdelante(var l:lista; p:producto);
var
    nue: lista;

begin
    new(nue);
    nue^.prod := p;
    nue^.sig := l;
    l := nue;
end;


{ Carga la lista }
procedure cargarLista(var l:lista);
var 
    p: producto;
begin 
    leerProducto(p);

    while p.cod <> -1 do 
    begin 
        {usar cualquiera de los métodos agregarAlFinal o agregarAdelante}
        //agregarAdelante(l, p);
        agregarAlFinal(l, p);

        leerProducto(p);
    end;
end;


{ Imprime la lista }
procedure imprimirLista(L: lista);
begin 
    while (L <> nil) do 
    begin 

        writeln('Código: ', L^.prod.cod);
        writeln('Descripcion: ', L^.prod.descripcion);
        writeln('Stock actual: ', L^.prod.stock_actual);
        writeln('Stock mínimo: ', L^.prod.stock_min);
        writeln('Precio: ', L^.prod.precio:0:2);
        writeln();
        L := L^.sig;
    end;
    
end;


{ Retorna el porcentaje de productos con stock actual por debajo del stock mínimo }
function debajoStock(L: lista): real;
var 
    tot, dim: integer;
begin
    tot := 0;
    dim := 0;

    while (L <> nil) do 
    begin 

        if (L^.prod.stock_actual < L^.prod.stock_min) then 
            tot := tot + 1;

        dim := dim + 1;
        L := L^.sig;
    end;

    debajoStock := (tot * 100 / dim);
end;


{ Determina el el número n es par }
function esPar(n:integer):boolean;
begin 
    esPar := (n MOD 2 = 0);
end;


{ Determina si el cod tiene cant o más dígitos pares}
function tieneDigitosPares(cod: integer; cant: integer): boolean;
var 
    aux, resto, pares: integer;
begin 

    aux := cod;
    pares := 0;
    
    while aux <> 0 do
    begin
        resto := aux MOD 10;

        if (esPar(resto)) then
            pares := pares + 1;

        aux := aux DIV 10;
    end;

    tieneDigitosPares := (pares >= cant);
end;


{ Descripción de aquellos productos con código compuesto por al menos tres dígitos pares. }
procedure descripcionCodPar(l:lista);
begin 
    while (l <> nil) do 
    begin 
        if tieneDigitosPares(l^.prod.cod, 3) then 
        begin 
            writeln(l^.prod.descripcion, ' tiene al menos 3 dígitos pares.');
            writeln();
        end;

        l := l^.sig;
    end;
end;


{ Código de los dos productos más económicos. }
procedure economicos(l:lista);
var 
    min1, min2 : integer;
    pre1, pre2 : real;
begin 
    min1 := -1;
    min2 := -1;

    { Le asigno un número lo suficientemente grande }
    pre1 := 999999999999;
    pre2 := 999999999999;

    while (l <> nil ) do 
    begin 
        if (l^.prod.precio < pre1) then 
        begin 
            pre2 := pre1;
            pre1 := l^.prod.precio;
            min2 := min1;
            min1 := l^.prod.cod;
        end
        else if (l^.prod.precio < pre2) then
        begin 
            pre2 := l^.prod.precio;
            min2 := l^.prod.cod;
        end;

        l := l^.sig;
    end;

    if (min1 > -1) or (min2 > -1) then 
    begin 
        if min1 > -1 then
            writeln('1° producto más económico: ', min1);

        if min2 > -1 then 
            writeln('2° producto más económico: ', min2);

        writeln();
    end
    else 
    begin 
        writeln('No hay productos económicos.');
        writeln();
    end;
end;



var
    pri: lista;

begin 
    { Inicializo la lista }
    inicializarLista(pri);

    { Cargo la lista hasta que se ingrese el codigo -1}
    cargarLista(pri);

    writeln('Contenido de la lista: ');
    imprimirLista(pri);

    { a. Porcentaje de productos con stock actual por debajo de su stock mínimo. }
    writeln('Porcentaje de productos con stock actual debajo del stock mímino: ', debajoStock(pri):0:2, '%');

    { b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares. }
    descripcionCodPar(pri);

    { c. Código de los dos productos más económicos. }
    economicos(pri);

end.