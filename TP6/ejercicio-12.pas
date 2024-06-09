{
	Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de
	todos los dispositivos que poseen sus juegos instalados. De cada dispositivo se conoce la versión de
	Android instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee
	(medida en GB). La información disponible se encuentra ordenada por versión de Android. Realizar un
	programa que procese la información disponible de todos los dispositivos e informe:

	a. La cantidad de dispositivos para cada versión de Android.
	b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
	c. El tamaño promedio de las pantallas de todos los dispositivos.
}

program ejercicio_11;

type 
  dispositivo = record 
    androidVersion: string[50];
    screenSize: integer;
    ram: integer;
  end;

  lista = ^nodo;
  nodo = record 
    disp: dispositivo;
    sig: lista;
  end;


procedure leerDispositivo(var d: dispositivo);
begin 
  write('Versión de android: ');
  readln(d.androidVersion);

  if (d.androidVersion <> '') then 
  begin 
    write('Tamaño de pantalla (pulgadas): ');
    readln(d.screenSize);
    write('RAM instalada: ');
    readln(d.ram);
  end;

  writeln();
end;

procedure inicializarLista(var l:lista);
begin 
  l := nil;
end;


{ Inserta un dispositivo ordenado por versión de android }
procedure insertarOrdenado(var l: lista; d: dispositivo);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.disp := d;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.disp.androidVersion < nuevo^.disp.androidVersion) do 
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

procedure cargarDispositivos(var l: lista);
var 
  d: dispositivo;
begin 
  leerDispositivo(d);

  while (d.androidVersion <> '') do 
  begin 
    insertarOrdenado(l, d);

    leerDispositivo(d);
  end;
end;

procedure imprimirLista(l: lista);
begin 
  while (l <> nil) do 
  begin 
    writeln('Versión Android: ', l^.disp.androidVersion);
    writeln('Tamaño de pantalla ', l^.disp.screenSize);
    writeln('RAM instalada: ', l^.disp.ram);
    writeln();

    l := l^.sig;
  end;
end;


procedure procesar(l: lista);
var 
  actual: dispositivo;
  totAndroid, totDisp, totDispRamScreen: integer;
  acum_screenSize: real;

begin

  acum_screenSize := 0;
  totDisp := 0;
  totDispRamScreen := 0;

  while (l <> nil) do 
  begin 
    actual := l^.disp;

    totAndroid := 0;

    
    while (l <> nil) and (actual.androidVersion = l^.disp.androidVersion) do 
    begin   

      totDisp := totDisp + 1;
      totAndroid := totAndroid + 1;

      if (actual.ram >= 3) and (actual.screenSize <= 5) then 
        totDispRamScreen := totDispRamScreen + 1;

      acum_screenSize := acum_screenSize + actual.screenSize;

      l := l^.sig;
      
    end;

    
    writeln('Versión de Android: ', actual.androidVersion, '. Total de dispositivos: ', totAndroid);
    writeln();

  end;

  writeln('Cantidad de dispositivos con más de 3GB de ram y al menos 5" de pantalla: ', totDispRamScreen);
  writeln();
  writeln('Tamaño promedio de las pantallas de todos los dispositivos: ', acum_screenSize/totDisp:0:2, '"');
end;




var 
  l: lista;
begin 
  { Inicializo la lista }
  inicializarLista(l);

  { Cargo la lista hasta ingresar la versión de android '' }
  cargarDispositivos(l);

  imprimirLista(l);

  procesar(l);
end.