{
    a. Inserta un nodo adelante de la lista mientras el valor sea distinto de 0
    b. L:[48, 13, 21, 10]
    c. procedure imprimirLista(L: lista)
    d. imcrementarTodo(L: lista; v: integer);
}

{
    Utilizando el programa del ejercicio 1, realizar los siguientes cambios:
    
    a. Modificar el módulo armarNodo para que los elementos se guarden en la lista en el orden en que
    fueron ingresados (agregar atrás).
}

program JugamosConListas;
type
    lista = ^nodo;

    nodo = record
        num : integer;
        sig : lista;
    end;


// Agrega atras los nuevos elementos
procedure armarNodo(var L, ULT: lista; v: integer);
var
    nue : lista;
begin

    
    new(aux);
    nue^.num := v;
    nue^.sig := nil;
    if ( L = nil) then 
        L := nue
    else 
        ULT^.sig := nue;

    ULT := nue;

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