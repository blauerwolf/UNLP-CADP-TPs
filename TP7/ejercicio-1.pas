{
    Una productora nacional realiza un casting de personas para la selección de actores extras de una nueva
    película, para ello se debe leer y almacenar la información de las personas que desean participar de dicho
    casting. De cada persona se lee: DNI, apellido y nombre, edad y el código de género de actuación que
    prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). La lectura finaliza cuando llega una
    persona con DNI 33555444, la cual debe procesarse.

    Una vez finalizada la lectura de todas las personas, se pide:
    a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares.
    b. Informar los dos códigos de género más elegidos.
    c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no existir.
    Invocar dicho módulo en el programa principal.
}

program ejercicio_1;
uses crt, sysutils;
type
    genero_actuacion = array[1..5] of string;
    contador_genero = array[1..5] of integer;


    persona = record 
        dni: Longword;
        apellido: string;
        nombre: string;
        edad: integer;
        genero_actuacion: integer;
    end;

    lista = ^nodo;
    
    nodo = record 
        pers: persona;
        sig: lista;
    end;


procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;


procedure inicializarGeneros(var g: genero_actuacion);
begin 
    g[1] := 'Drama';
    g[2] := 'Romántico';
    g[3] := 'Acción';
    g[4] := 'Suspenso'; 
    g[5] := 'Terror';
end;

procedure inicializarContadorGeneros(var g: contador_genero);
var i: integer;
begin 
  for i := 1 to 5 do 
    g[i] := 0;
end;


procedure imprimirLista(l: lista; g: genero_actuacion);
begin 
    while (l <> nil) do 
    begin 
        writeln('DNI: ', l^.pers.dni);
        writeln('Apellido: ', l^.pers.apellido);
        writeln('Nombre: ', l^.pers.nombre);
        writeln('Edad: ', l^.pers.edad);
        writeln('Género de actuación: ',g[l^.pers.genero_actuacion]);
        writeln();

        l := l^.sig;
    end;
end;


procedure leerPersona(var p: persona; g: genero_actuacion);
begin 
    write('DNI: ');
    readln(p.dni);
    writeln(p.dni);

    write('Apellido: ');
    readln(p.apellido);
    write('Nombre: ');
    readln(p.nombre);
    write('Edad: ');
    readln(p.edad);
    write('Género de actuación: ');
    readln(p.genero_actuacion);

    gotoXY(22 + length(IntToStr(p.genero_actuacion)) + 1, WhereY - 1);
    writeln('(', g[p.genero_actuacion], ')');

    writeln();

end;


procedure insertarOrdenado(var l: lista; p: persona);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.pers := p;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.pers.dni < nuevo^.pers.dni) do 
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


procedure cargarPersonas(var l: lista; g: genero_actuacion);
var 
    p: persona;
begin 
    
    repeat
        leerPersona(p, g);
        insertarOrdenado(l, p);

    until p.dni = 33555444;
end;


function esPar(num: integer): boolean;
begin
    esPar := (num MOD 2 = 0);
end;

function dniConMasDigitosPares(dni: Longword): boolean;
var
    resto, aux, pares, impares: Longword;
begin
    pares := 0;
    impares := 0;

    aux := dni;
    
    while aux <> 0 do
    begin
        resto := aux MOD 10;

        if (esPar(resto)) then
            pares := pares + 1
        else
            impares := impares + 1;



        aux := aux DIV 10;
    end;

    dniConMasDigitosPares := (pares > impares);
    
end;

procedure actualizarContadorGeneros(var cg: contador_genero; idx: integer);
begin 
  cg[idx] := cg[idx] + 1;
end;


procedure getTopGeneros(cg: contador_genero; var g1: integer; var g2: integer);
var 
  i, t1, t2: integer;
begin 
  t1 := 0;
  t2 := 0;
  g1 := 0;
  g2 := 0;

  for i := 1 to 5 do
  begin 
    if cg[i] > t1 then 
    begin 
      t2 := t1;
      t1 := cg[i];
      g2 := g1;
      g1 := i;
    end 
    else if cg[i] > t2 then 
    begin 
      t2 := cg[i];
      g2 := i;
    end;
  end;
end;


procedure procesar(l: lista; g: genero_actuacion);
var 
  cantDni, i: integer;
  cg: contador_genero;
  t1, t2: integer;

begin 

  cantDni := 0;

  inicializarContadorGeneros(cg);

  while (l <> nil) do 
  begin 

    { Actualizo el contador de las personas cuyo DNI contiene más dígitos pares que impares. }
    if (dniConMasDigitosPares(l^.pers.dni)) then 
      cantDni := cantDni + 1;

    actualizarContadorGeneros(cg, l^.pers.genero_actuacion);

    l := l^.sig;
  end;


  writeln('Cantidad de personas cuyo DNI contiene más dígitos pares que impares: ', cantDni);

  getTopGeneros(cg, t1, t2);
  writeln('Códigos de géneros más elegidos: ', t1, ' (', g[t1], '), ', t2, ' (', g[t2], ')');
  writeln();
end;


{ Elimina el valor de la lista si existe }
procedure eliminar(var l:lista; dni:Longword);
var 
    actual, ant : lista;
begin 

    actual := l;

    while (actual <> nil) do 
    begin 
        if (actual^.pers.dni <> dni) then 
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


var 
    g: genero_actuacion;
    l: lista;
    p: persona;
    dni: Longword;
begin 
    inicializarGeneros(g);
    inicializarLista(l);

    cargarPersonas(l, g);

    procesar(l, g);

    write('Ingrese DNI para eliminar: ');
    readln(dni);
    eliminar(l, dni);
    writeln();

    writeln('Lista actualizada:');
    writeln('==================');
    imprimirLista(l, g);

end.