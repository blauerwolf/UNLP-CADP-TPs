{
    Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. Su
    funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un
    número (que es el siguiente al último número entregado). El cliente quedará esperando a ser llamado
    por su número, en cuyo caso sale de la lista de espera. 
    
    Se pide:
    a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.
    b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de
    clientes en espera, asigna un número al cliente y retorna la lista de espera actualizada.
    c. Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera,
    y retorna el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe
    eliminarse de la lista de espera.
    d. Implementar un programa que simule la atención de los clientes. En dicho programa, primero
    llegarán todos los clientes juntos, se les dará un número de espera a cada uno de ellos, y luego se
    los atenderá de a uno por vez. El ingreso de clientes se realiza hasta que se lee el DNI 0, que no
    debe procesarse.
}

program ejercicio_10;

type 
    clIente = record 
        dni: integer;
        cod: integer;
    end;

    lista = ^nodo;

    nodo = record 
        cli: cliente;
        sig: lista;
    end;


{ Inicializa una nueva lista }
procedure inicializarLista(var l:lista);
begin 
    l := nil;
end;


{ Agregar un nodo al final de la lista }
procedure agregarAlFinal(var l:lista; dni: integer);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.cli.dni := dni;
    nue^.sig := nil;

    if ( l = nil) then
    begin 
        nue^.cli.cod := 1;
        l := nue;
    end 
    else 
    begin
        aux := l;

        while (aux^.sig <> nil) do 
            aux := aux^.sig;
        
        nue^.cli.cod := aux^.cli.cod + 1;
        aux^.sig := nue;
    end;
end;



{ Carla la lista de clintes adelante }
procedure agregarAdelante(var l:lista; dni:integer);
var 
    nue: lista;

begin 
    new(nue);
    nue^.cli.dni := dni;
    
    { Evaluo el caso ue sea el primer elemento que inserto en la lista }
    if (l = nil) then 
        nue^.cli.cod := 1
    else 
        nue^.cli.cod := l^.cli.cod + 1;

    nue^.sig := l;
    l := nue;
end;


{ Carga la lista de clientes hasta el DNI = 0 que no procesa }
procedure RecibirCliente(var l:lista);
var 
    d: integer;
begin 
    write('DNI: ');
    readln(d);

    while (d <> 0) do 
    begin 
        //agregarAdelante(l, d);
        agregarAlFinal(l, d);

        write('DNI: ');
        readln(d);
    end;
    writeln();
end;


procedure imprimirLista(l: lista);
begin 
    while (l <> nil) do 
    begin 
        writeln('DNI: ', l^.cli.dni);
        writeln('Numero: ', l^.cli.cod);
        writeln();

        l := l^.sig;
    end;
    writeln();
end;

var 
    pri: lista;
begin 
    inicializarLista(pri);
    RecibirCliente(pri);

    imprimirLista(pri);

end.