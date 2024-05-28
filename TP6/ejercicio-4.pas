{
    a. Inserta un nodo adelante de la lista mientras el valor sea distinto de 0
    b. L:[48, 13, 21, 10]
    c. procedure imprimirLista(L: lista)
    d. imcrementarTodo(L: lista; v: integer);
}

{
    Utilizando el programa del ejercicio 1, realizar los siguientes módulos:

    a. Máximo: recibe la lista como parámetro y retorna el elemento de valor máximo.
    b. Mínimo: recibe la lista como parámetro y retorna el elemento de valor mínimo.
    c. Múltiplos: recibe como parámetros la lista L y un valor entero A, y retorna la cantidad de
    elementos de la lista que son múltiplos de A.
}

program JugamosConListas;
type
    lista = ^nodo;

    nodo = record
        num : integer;
        sig : lista;
    end;

procedure armarNodo(var L: lista; v: integer);
var
    aux : lista;
begin
    new(aux);
    aux^.num := v;
    aux^.sig := L;
    L := aux;
end;

procedure imprimirLista(L: lista);
begin 
    while (L <> nil) do 
    begin 
        writeln(L^.num);
        L := L^.sig;
    end;
    writeln();
end;

procedure incrementarTodo(L: lista; v: integer);
begin
    while (L <> nil) do 
    begin 
        L^.num := L^.num + v;
        L := L^.sig;
    end;
end;

function maximo(L: lista): integer;
var max: integer;
begin 
    max := -32768;

    while L <> nil do 
    begin 
        if (L^.num > max) then 
            max := L^.num;

        L := L^.sig;
    end;

    maximo := max;
end;

function minimo(L: lista): integer;
var min: integer;
begin 
    min := 32767;
    while L <> nil do
    begin 

        if (L^.num < min) then
            min := L^.num;

        L := L^.sig;
    end;

    minimo := min;
end;

function multiplos(L: lista; A: integer): integer;
var cant: integer;
begin 
    cant := 0;
    while L <> nil do 
    begin 
        if ((L^.num MOD A) = 0) then 
            cant := cant + 1;

        L := L^.sig;
    end;

    multiplos := cant;
end;

procedure sonMultiplos(L: lista; A: integer);
begin 
    while L <> nil do 
    begin 
        if ((L^.num MOD A) = 0) then 
            writeln(L^.num);

        L := L^.sig;
    end;
    writeln();
end;

var
    pri : lista;
    valor, A : integer;

begin
    A := 2; // Contaré Multiplos de 2

    pri := nil;
    write('Ingrese un numero: ');
    readln(valor);

    while (valor <> 0) do 
    begin
        armarNodo(pri, valor);
        write('Ingrese un numero: ');
        readln(valor);
    end;
    { imprimir lista }
    imprimirLista(pri);
    
    { d. Incremento la lista con un valor fijo }
    incrementarTodo(pri, 10);
    imprimirLista(pri);

    writeln('Número máximo: ', maximo(pri));
    writeln('Numero mínimo: ', minimo(pri));
    writeln();
    writeln('Multiplos de ', A, ': ', multiplos(pri, A));
    writeln('Los múltiplos son: ');
    sonMultiplos(pri, A);


end.