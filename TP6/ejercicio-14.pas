{
  La oficina de becas y subsidios desea optimizar los distintos tipos de ayuda financiera que se brinda a
  alumnos de la UNLP. Para ello, esta oficina cuenta con un registro detallado de todos los viajes
  realizados por una muestra de 1300 alumnos durante el mes de marzo. De cada viaje se conoce el
  código de alumno (entre 1 y 1300), día del mes, Facultad a la que pertenece y medio de transporte (1.
  colectivo urbano; 2. colectivo interurbano; 3. tren universitario; 4. tren Roca; 5. bicicleta). Tener en
  cuenta que un alumno puede utilizar más de un medio de transporte en un mismo día.
  Además, esta oficina cuenta con una tabla con información sobre el precio de cada tipo de viaje.
  Realizar un programa que lea la información de los viajes de los alumnos y los almacene en una
  estructura de datos apropiada. La lectura finaliza al ingresarse el código de alumno -1, que no debe
  procesarse.
  
  Una vez finalizada la lectura, informar:
  a. La cantidad de alumnos que realizan más de 6 viajes por día
  b. La cantidad de alumnos que gastan en transporte más de $80 por día.
  c. Los dos medios de transporte más utilizados.
  d. La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte.
}

program ejercicio_14;
uses crt, sysutils;

type 
  //alumnoId = 1..1300;
  dd = 1..31;

  viaje = record 
    //codigoAlumno: alumnoId;
    codigoAlumno: integer;
    dia: dd;
    facultad: string;
    transporte: integer;
  end;

  lista = ^nodo;

  nodo = record 
    trip: viaje;
    sig: lista;
  end;

  mediosTransporte = array[1..5] of string;
  vectorPrecios = array[1..5] of real;
  vectorCostos = array[1..31] of real;
  contMedios = array[1..5] of integer;

procedure inicializarLista(var l: lista);
begin 
 l := nil;
end;

procedure inicializarMedios(var m: mediosTransporte);
begin 
  m[1] := 'Colectivo urbano';
  m[2] := 'Colectivo interurbano';
  m[3] := 'Tren universitario';
  m[4] := 'Tren Roca';
  m[5] := 'Bicicleta';
end;

procedure inicializarPrecios(var p: vectorPrecios);
begin 
  p[1] := 380.60;
  p[2] := 540.66;
  p[3] := 20.05;
  p[4] := 240.23;
  p[5] := 0;
end;

procedure imprimirMedios(m: mediosTransporte);
var i: integer;
begin 
  for i := 1 to 5 do 
    writeln(#9, i, '. ', m[i]);
end;

procedure leerViaje(var v: viaje; m: mediosTransporte);

begin 
  write('Código de Alumno: ');
  readln(v.codigoAlumno);

  if (v.codigoAlumno <> -1) then 
  begin 
    write('día del mes: ');
    readln(v.dia);
    write('Facultad: ');
    readln(v.facultad);
    writeln('Transporte: ');

    imprimirMedios(m);
    writeln();
    write(#9);

    read(v.transporte);
    gotoXY(12 + length(IntToStr(v.transporte)) + 1, WhereY - 1);
    writeln('(', m[v.transporte], ')');
  end;

  writeln();
end;



{ Inserta un viaje ordenado por código de Alumno }
procedure insertarOrdenado(var l: lista; v: viaje);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.trip := v;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.trip.codigoAlumno < nuevo^.trip.codigoAlumno) do 
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

procedure imprimirViaje(v: viaje; m:mediosTransporte);
begin 
    writeln('Código de Alumno: ', v.codigoAlumno);
    writeln('Día del mes: ', v.dia);
    writeln('Facultad: ', v.facultad);
    writeln('Medio de transporte: ', m[v.transporte]);
    writeln();
end;


procedure imprimirLista(l: lista; m: mediosTransporte);
begin 

  while (l <> nil) do 
  begin 

    imprimirViaje(l^.trip, m);

    l := l^.sig;
  end;
end; 

procedure cargarViajes(var l: lista; m: mediosTransporte);
var 
  v: viaje;

begin 
  leerViaje(v, m);

  while (v.codigoAlumno <> -1) do 
  begin 
    insertarOrdenado(l, v);

    leerViaje(v, m);
  end;
end;

function superaGasto(v:vectorCostos; valor: real): boolean;
var 
  i: integer;
  ok: boolean;
begin 
  ok := true;

  for i := 1 to 31 do 
  begin 
    if (v[i] < valor) then 
      ok := false;
  end;

  superaGasto := ok;
end;

function combinaTransporte(cm: contMedios): boolean;
var 
  combina: boolean;
  i: integer;

begin 
  combina := true;

  if (cm[5] > 0) then 
  begin 
    if (cm[1] = 0) and (cm[2] = 0) and (cm[3] = 0) and (cm[4] = 0) then
      combina := false
  end
  else 
    combina := false;

  combinaTransporte := combina;
end;


procedure procesarViajes(l: lista; pre: vectorPrecios; m: mediosTransporte);  
var
  actual: viaje;
  totMas6Viajes, aluViajesXDia, tot80, m1, m2, c1, c2, aluCombina, i: integer;
  aluCostoViajes: vectorCostos;
  tm, cm: contMedios;
begin 

  totMas6Viajes := 0;
  tot80 := 0;
  aluCombina := 0;

  for i := 1 to 5 do 
    tm[i] := 0;


  while (l <> nil) do 
  begin 
    actual := l^.trip;

    { Reinicializo el contador parcial de viajes por día de Alumno }
    aluViajesXDia := 0;

    { Reinicializo el contador parcial de costo de viaje por dia de Alumno }
    for i := 1 to 31 do 
      aluCostoViajes[i] := 0;

    { Reinicializo el contador parcial de medios utilizados por el Alumno }
    for i := 1 to 5 do 
      cm[i] := 0;

    while (l <> nil) and (actual.codigoAlumno = l^.trip.codigoAlumno) do 
    begin

      { Incremento contador de viajes del alumno }
      aluViajesXDia := aluViajesXDia + 1;

      { Incremento el sumador de costo de viajes }
      aluCostoViajes[l^.trip.dia] := aluCostoViajes[l^.trip.dia] + pre[l^.trip.transporte];

      { Incremento el contador del tipo de transporte utilizado }
      cm[l^.trip.transporte] := cm[l^.trip.transporte] + 1;


      l := l^.sig;
    end;



    if (aluViajesXDia > 6) then 
      totMas6Viajes := totMas6Viajes + 1;

    if (superaGasto(aluCostoViajes, 80)) then
      tot80 := tot80 + 1;

    { Actualizo el contador total de medios utilizados }
    for i := 1 to 5 do 
      tm[i] := tm[i] + cm[i];

    { Determino si el alumno combina bicicleta con otro medio }
    if (combinaTransporte(cm)) then 
      aluCombina := aluCombina + 1;

  end;

  writeln('Cantidad de alumnos que realizaron más de 6 viajes por día: ', totMas6Viajes);
  writeln('Cantidad de alumnos que gastan más de $80 por día: ', tot80);

  m1 := 0;
  m2 := 0;
  c1 := 0;
  c2 := 0;

  for i := 1 to 5 do 
  begin 
    if (cm[i] > m1) then 
    begin 
      m2 := m1;
      m1 := cm[i];
      c2 := c1;
      c1 := i;
    end 
    else begin
      m2 := cm[i];
      c2 := i;
    end;
  end;

  writeln('Los 2 medios de transporte más utilizados son: ', m[c1], ' y ', m[c2]);
  writeln('Cantidad de alumnos que combinan bicicleta con otro medio de transporte: ', aluCombina);

end;


var 
  m: mediosTransporte;
  l: lista;
  v: viaje;
  p: vectorPrecios;

begin 
  inicializarPrecios(p);
  inicializarMedios(m);
  inicializarLista(l);
  
  cargarViajes(l, m);

  imprimirLista(l, m);

  procesarViajes(l, p, m);

end.