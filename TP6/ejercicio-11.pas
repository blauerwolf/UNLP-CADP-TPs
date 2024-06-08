{
  La Facultad de Informática debe seleccionar los 10 egresados con mejor promedio a los que la UNLP les
  entregará el premio Joaquín V. González. De cada egresado se conoce su número de alumno, apellido y
  el promedio obtenido durante toda su carrera.
  
  Implementar un programa que:
  a. Lea la información de todos los egresados, hasta ingresar el código 0, el cual no debe procesarse.
  b. Una vez ingresada la información de los egresados, informe el apellido y número de alumno de los
  egresados que recibirán el premio. La información debe imprimirse ordenada según el promedio
  del egresado (de mayor a menor).
}

program ejercicio_11;

type 
  alumno = record 
    numero: integer;
    apellido: string[50];
    promedio: real;
  end;

  lista = ^nodo;

  nodo = record 
    alu: alumno;
    sig: lista;
  end;

  premiados = record 
    numero: integer;
    apellido: string[50];
  end;

  vectorProm = array[1..10] of real;
  vectorAlu = array[1..10] of premiados;


procedure leerEgresado(var a:alumno);
begin 
  write('Número de alumno: ');
  readln(a.numero);

  if (a.numero <> 0) then 
  begin 
      write('Apellido: ');
      readln(a.apellido);
      write('Promedio: ');
      readln(a.promedio);
  end;
      
  writeln();
end;


procedure inicializarVector(var v:vectorProm);
var 
  i: integer;
begin 
  for i := 1 to 10 do
    v[i] := -1;
end;


procedure inicializarLista(var l:lista);
begin 
  l := nil;
end;


procedure insertarOrdenado(var l: lista; a:alumno);
var 
  actual, anterior, nuevo: lista;
begin
  new(nuevo);
  nuevo^.alu := a;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.alu.promedio < nuevo^.alu.promedio) do 
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

procedure cargarAlumnos(var l:lista);
var 
  a: alumno;
begin 
  leerEgresado(a);

  while(a.numero <> 0) do 
  begin 

    insertarOrdenado(l, a);

    leerEgresado(a);
  end;

end;


procedure imprimirLista(l:lista);
begin 
  while (l <> nil) do 
  begin 

    writeln('Número: ', l^.alu.numero);
    writeln('Apellido: ', l^.alu.apellido);
    writeln('Promedio: ', l^.alu.promedio:0:2);
    writeln();
    l := l^.sig;
  end;
end;


procedure shift(alu: alumno; pos: integer; var vProm: vectorProm; var vAlu: vectorAlu);
var 
    i: integer;
begin
    for i := 10 downto (pos + 1) do
    begin 
      vProm[i] := vProm[i - 1];
      vAlu[i] := vAlu[i - 1];
    end;

    vProm[pos] := alu.promedio;
    vAlu[pos].numero := alu.numero;
    vAlu[pos].apellido := alu.apellido; 

end;


procedure actualizarVectores(alu: alumno; var vProm: vectorProm; var vAlu: vectorAlu);

begin 
  
  if (alu.promedio > vProm[1]) then
    shift(alu, 1, vProm, vAlu)
  else if (alu.promedio > vProm[2]) then 
    shift(alu, 2, vProm, vAlu)
  else if (alu.promedio > vProm[3]) then 
    shift(alu, 3, vProm, vAlu)
  else if (alu.promedio > vProm[4]) then 
    shift(alu, 4, vProm, vAlu)
  else if (alu.promedio > vProm[5]) then 
    shift(alu, 5, vProm, vAlu)
  else if (alu.promedio > vProm[6]) then 
    shift(alu, 6, vProm, vAlu)
  else if (alu.promedio > vProm[7]) then 
    shift(alu, 7, vProm, vAlu)
  else if (alu.promedio > vProm[8]) then 
    shift(alu, 8, vProm, vAlu)
  else if (alu.promedio > vProm[9]) then 
    shift(alu, 9, vProm, vAlu)
  else if (alu.promedio > vProm[10]) then 
    shift(alu, 10, vProm, vAlu);

end;


procedure procesarAlumnos(l:lista; var vProm:vectorProm; var vAlu: vectorAlu);
var 
  i: integer;
begin 


  while (l <> nil) do 
  begin 
    actualizarVectores(l^.alu, vProm, vAlu);
    l := l^.sig;
  end;

  writeln('PREMIADOS');
  writeln('=========');
  for i := 1 to 10 do 
  begin 
    writeln('Apellido: ', vAlu[i].apellido, '. Número de alumno: ', vAlu[i].numero);
  end;
  writeln();
end;


var 
  l: lista;
  vProm: vectorProm;
  vAlu: vectorAlu;
begin 

  inicializarLista(l);

  cargarAlumnos(l);

  imprimirLista(l);

  inicializarVector(vProm);
  
  procesarAlumnos(l, vProm, vAlu);

end.