{
    Una maternidad dispone información sobre sus pacientes. De cada una se conoce: nombre, apellido y peso
    registrado el primer día de cada semana de embarazo (a lo sumo 42). La maternidad necesita un programa
    que analice esta información, determine e informe:
    
    a. Para cada embarazada, la semana con mayor aumento de peso.
    b. El aumento de peso total de cada embarazada durante el embarazo.
}

program ejercicio_4;
type 
    paciente = record
        nombre: string;
        apellido: string;
        peso: real;
        semana: integer;
    end;

    lista = ^nodo;

    nodo = record 
        pac: paciente;
        sig: lista;
    end;


procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;

procedure insertarOrdenado(var l: lista; p: paciente);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.pac := p;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.pac.apellido < nuevo^.pac.apellido) do 
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

procedure leerPaciente(var p: paciente);
begin 
    write('Nombre: ');
    readln(p.nombre);

    if (p.nombre <> '') then 
    begin 
        write('Apellido: ');
        readln(p.apellido);
        write('Peso: ');
        readln(p.peso);
        write('Semana: ');
        readln(p.semana);
    end;
    
    writeln();
end;

procedure imprimirLista(l: lista);
begin 
    while (l <> nil) do 
    begin 
        writeln('Apellido: ', l^.pac.apellido);
        writeln('Nombre: ', l^.pac.nombre);
        writeln('Peso: ', l^.pac.peso:0:2);
        writeln('Semana: ', l^.pac.semana);
        writeln();

        l := l^.sig;
    end;
end;

procedure cargarPacientes(var l: lista);
var 
    p: paciente;
begin 
    leerPaciente(p);

    while (p.nombre <> '') do 
    begin 
        insertarOrdenado(l, p);
        leerPaciente(p);
        writeln();
    end;
end;

procedure procesarPacientes(l: lista);
var 
  anterior: lista;
  pac: paciente;
  pac_peso, pac_peso_total: real;
  pac_semana: integer;

begin

  while (l <> nil) do 
  begin 

    anterior := l;

    { Reinicializo los contadores parciales }
    pac_peso := 0;
    pac_peso_total := 0;

    pac := l^.pac;

    while (l <> nil) and (l^.pac.apellido = pac.apellido) do
    begin 

      { Calculo el mayor peso y obtengo la semana }
      if (l^.pac.peso > pac_peso) then 
      begin
        pac_peso := l^.pac.peso;
        pac_semana := l^.pac.semana;
      end;

      { Calculo el peso total acumulado durante el embarazo }
      pac_peso_total := pac_peso_total + (anterior^.pac.peso - l^.pac.peso);

      l := l^.sig;
    end;

    writeln('Paciente: ', anterior^.pac.apellido, ' ', anterior^.pac.nombre);
    writeln('- Semana con mayor aumento de peso: ' , pac_semana);
    writeln('- Aumento total de peso durante todo el embarazo: ', pac_peso_total:0:2);
    writeln();
  end;
end;


var 
    l: lista;

begin 
    inicializarLista(l);
    cargarPacientes(l);
    imprimirLista(l);

    procesarPacientes(l);
end.
