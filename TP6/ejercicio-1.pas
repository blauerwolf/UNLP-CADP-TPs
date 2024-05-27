{
    a. Inserta un nodo adelante de la lista mientras el valor sea distinto de 0
    b. L:[48, 13, 21, 10]
    c. procedure imprimirLista(L: lista)
    d. imcrementarTodo(L: lista; v: integer);
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
end.