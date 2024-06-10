{
    Utilizando el programa del ejercicio 1, realizar los siguientes módulos:

    a. EstáOrdenada: recibe la lista como parámetro y retorna true si la misma se encuentra ordenada, o
    false en caso contrario.
    b. Eliminar: recibe como parámetros la lista y un valor entero, y elimina dicho valor de la lista (si
    existe). Nota: la lista podría no estar ordenada.
    c. Sublista: recibe como parámetros la lista L y dos valores enteros A y B, y retorna una nueva lista
    con todos los elementos de la lista L mayores que A y menores que B.
    d. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada
    de manera ascendente.
    e. Modifique el módulo Sublista del inciso anterior, suponiendo que la lista L se encuentra ordenada
    de manera descendente.
}

program ejercicio_9;

type
    lista = ^nodo;

    nodo = record
        num : integer;
        sig : lista;
    end;

procedure armarNodo(var L: lista; v: integer);
var
    //aux : lista;
    nue: lista;
    act, ant: lista; { punteros auxiliares para recorrido }
begin
    new(nue);
    nue^.num := v;
    act := L;
    ant := L;

    while (act <> nil) and (v > act^.num) do 
    begin 
        ant := act;
        act := act^.sig;
    end;

    if (act = ant) then { al inicio o lista vacía }
        L := nue
    else { al medio o al final }
        ant^.sig := nue;

    nue^.sig := act;
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

function EstaOrdenada(l:lista):boolean;
var 
    ok: boolean;
    ant, act: lista;
begin 
    ok := true;

    ant := l;
    act := l;

    while (act <> nil) and (ok) do 
    begin 
        ant := act;
        act := act^.sig;

        if (act <> nil) and (ant^.num > act^.num) then 
            ok := false;
    end;

    EstaOrdenada := ok;
end;

{ Elimina el valor de la lista si existe }
procedure eliminar(var l:lista; n:integer);
var 
    actual, ant : lista;
begin 

    actual := l;

    while (actual <> nil) do 
    begin 
        if (actual^.num <> n) then 
        begin 
            ant := actual;
            actual := actual^.sig;
        end
        else begin 
            if (actual = l) then 
                l := l^.sig
            else 
                ant^.sig := actual^.sig;

            dispose(actual);
            actual := ant;
        end;
    end;
end;


{ Inicializa una nueva lista }
procedure inicializarLista(var l:lista);
begin 
    l := nil;
end;


{ Retorna una nueva lista con todos los elementos de la lista L mayores que A y menores que B. }
procedure sublista(l:lista; var l1: lista; A: integer; B: integer);
begin 
    while (l <> nil) do 
    begin 
        if (l^.num > A) and (l^.num < B) then 
            armarNodo(l1, l^.num);

        l := l^.sig;
    end;
end;


{ 
    Retorna una nueva lista con todos los elementos de la lista L mayores que A y menores que B.
    supongo que la lista L se encuentra ordenada de manera ascendente.
}
procedure sublista_d(l:lista; var l1: lista; A:integer; B:integer);
begin 

    while (l <> nil) and (l^.num <= B) do 
    begin 
        if (l^.num > A) and (l^.num < B) then 
            armarNodo(l1, l^.num);

        l := l^.sig;
    end;
end;


{ 
    Retorna una nueva lista con todos los elementos de la lista L mayores que A y menores que B.
    supongo que la lista L se encuentra ordenada de manera ascendente.
}
procedure sublista_e(l:lista; var l1: lista; A:integer; B:integer);
begin 
    while (l <> nil) and (l^.num < A) do 
    begin 
        if (l^.num < A) and (l^.num > B) then 
            armarNodo(l1, l^.num);

        l := l^.sig;
    end;
end;


var
    pri, pri2, pri3 : lista;
    valor : integer;

begin
    inicializarLista(pri);
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

    writeln('Lista ordenada?: ', EstaOrdenada(pri));

    imprimirLista(pri);
    write('Elegir un elento a eliminar: ');
    readln(valor);


    eliminar(pri, valor);
    imprimirLista(pri);

    inicializarLista(pri2);
    sublista(pri, pri2, 15, 30);
    writeln('Lista con elementos de la primera, mayores que 15 y menores que 30');
    imprimirLista(pri2);

    inicializarLista(pri3);
    sublista_d(pri, pri3, 15, 30);
    writeln('Lista ordenada asendente');
    imprimirLista(pri3);
end.