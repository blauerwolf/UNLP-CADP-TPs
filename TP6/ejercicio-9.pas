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

var
    pri : lista;
    valor : integer;

begin
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

    writeln(EstaOrdenada(pri));
end.