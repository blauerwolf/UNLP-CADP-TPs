{
    Implementar un programa que lea y almacene información de clientes de una empresa aseguradora
    automotriz. De cada cliente se lee: código de cliente, DNI, apellido, nombre, código de póliza contratada
    (1..6) y monto básico que abona mensualmente. La lectura finaliza cuando llega el cliente con código 1122,
    el cual debe procesarse.
    
    La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el cliente
    debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene contratada.
    Una vez finalizada la lectura de todos los clientes, se pide:
    a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente por su
    seguro automotriz (monto básico + monto adicional).
    b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9.
    c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la
    estructura.
}

program ejercicio_2;

type
    rango_cod = 1..6;
    adicionales = array[rango_cod] of real;

    cliente = record
        codigo: integer;
        dni: Longword;
        apellido: string;
        nombre: string;
        cod_poliza: rango_cod;
        monto: real;
    end;

    lista = ^nodo;

    nodo = record
        cli: cliente;
        sig: lista;
    end;

procedure inicializarAdicionales(var a: adicionales);
begin
    a[1] := 1250.23;
    a[2] := 1796.34;
    a[3] := 2614.51;
    a[4] := 2916.74;
    a[5] := 3899.60;
    a[6] := 7980.97;
end;

procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;


procedure insertarOrdenado(var l: lista; c: cliente);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.cli := c;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.cli.codigo < nuevo^.cli.codigo) do 
    begin 
      anterior := actual;
      actual := actual^.sig;
    end;

    if (actual = l) then 
    begin 
      nuevo^.sig := l;
      l := nuevo;
    end 
    else begin 
      anterior^.sig := nuevo;
      nuevo^.sig := actual;
    end;
  end;
end;


{ Elimina el valor de la lista si existe }
procedure eliminar(var l:lista; cod:integer);
var 
    actual, ant : lista;
begin 

    actual := l;

    while (actual <> nil) do 
    begin 
        if (actual^.cli.codigo <> cod) then 
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


procedure leerCliente(var c: cliente);
begin 
    write('Código de cliente: ');
    readln(c.codigo);
    write('DNI: ');
    readln(c.dni);
    write('Apellido: ');
    readln(c.apellido);
    write('Nombre: ');
    readln(c.nombre);
    write('Código de póliza: ');
    readln(c.cod_poliza);
    write('Monto: ');
    readln(c.monto);
end;

procedure cargarClientes(var l: lista);
var 
    c: cliente;
begin 

    repeat 
        leerCliente(c);

        insertarOrdenado(l, c);

        writeln();



    until c.codigo = 1122;

end;

procedure imprimirLista(l: lista);
begin 
    while (l <> nil) do 
    begin 
        writeln('Código: '#9, l^.cli.codigo);
        writeln('DNI: '#9#9, l^.cli.dni);
        writeln('Apellido: '#9, l^.cli.apellido);
        writeln('Nombre: '#9, l^.cli.nombre);
        writeln('Cód. póliza: '#9, l^.cli.cod_poliza);
        writeln('Monto: '#9#9, l^.cli.monto:0:2);
        writeln();

        l := l^.sig;
    end;
end;


procedure procesar(l: lista; ad: adicionales);


begin 
    writeln('DNI'#9#9, 'Apellido'#9#9, 'Nombre'#9#9, 'Monto');
    writeln('----------------------------------------------------------------------');

    while (l <> nil) do 
    begin 
        writeln(l^.cli.dni,#9,l^.cli.apellido, #9#9#9, l^.cli.nombre, #9#9, (l^.cli.monto + ad[l^.cli.cod_poliza]):0:2);

        l := l^.sig;
    end;
    writeln();
end;

function tieneDigitos9(dni: Longword): boolean;
var 
    cont: integer;
    aux, resto: Longword;
begin 
    cont := 0;
    aux := dni;

    while (aux <> 0) do 
    begin 
        resto := aux MOD 10;
        if resto = 9 then 
            cont := cont + 1;

        aux := aux DIV 10;
    end;

    tieneDigitos9 := (cont >= 2);
end;

procedure procesarDni(l: lista);
begin 
    while (l <> nil) do
    begin 
        if (tieneDigitos9(l^.cli.dni)) then 
            writeln('Apellido: ', l^.cli.apellido, ' Nombre: ', l^.cli.nombre);

        l := l^.sig;    
    end;
    writeln();
end; 


var 
    l: lista;
    ad: adicionales;
    c: integer;

begin 
    inicializarAdicionales(ad);
    inicializarLista(l);

    cargarClientes(l);

    imprimirLista(l);

    procesar(l, ad);
    
    writeln('Clientes con DNI con al menos 2 dígitos 9:');
    procesarDni(l);

    write('Código de cliente a eliminar: ');
    readln(c);
    eliminar(l, c);
    writeln();

    writeln('Lista actualizada: ');
    imprimirLista(l);




end.