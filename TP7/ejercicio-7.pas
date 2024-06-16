{
    La Facultad de Informática desea procesar la información de los alumnos que finalizaron la carrera de
    Analista Programador Universitario. Para ello se deberá leer la información de cada alumno, a saber:
    número de alumno, apellido, nombres, dirección de correo electrónico, año de ingreso, año de egreso y las
    notas obtenidas en cada una de las 24 materias que aprobó (los aplazos no se registran).
    1. Realizar un módulo que lea y almacene la información de los alumnos hasta que se ingrese el alumno
    con número de alumno -1, el cual no debe procesarse. Las 24 notas correspondientes a cada alumno
    deben quedar ordenadas de forma descendente.
    2. Una vez leída y almacenada la información del inciso 1, se solicita calcular e informar:
    a. El promedio de notas obtenido por cada alumno.
    b. La cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto únicamente
    por dígitos impares.
    c. El apellido, nombres y dirección de correo electrónico de los dos alumnos que más rápido se
    recibieron (o sea, que tardaron menos años)
    3. Realizar un módulo que, dado un número de alumno leído desde teclado, lo busque y elimine de la
    estructura generada en el inciso 1. El alumno puede no existir.
}

program ejercicio_7;
type 
    vNotas = array[1..24] of real;

    alumno = record 
        numero: integer;
        apellido: string;
        nombres: string;
        email: string;
        ingreso: integer;
        egreso: integer;
        notas: vNotas;
    end;

    lista = ^nodo;

    nodo = record 
        alu: alumno;
        sig: lista;
    end;


procedure inicializarLista(var l: lista);
begin 
    l := nil;
end;


procedure ordenarNotas(var n: vNotas);
var 
    i, j, p: integer;
    item: real;
begin
    for i := 1 to (24 -1) do 
    begin 
        p := i;

        for j := i + 1 to 24 do 
        begin
            if n[j] > n[p] then 
                p := j;
        end;

        if p <> i then 
        begin 

            item := n[p];
            n[p] := n[i];
            n[i] := item;
        end;
    end;
end;


procedure leerAlumno(var a: alumno);
var 
    n: vNotas;
    i: integer;

begin
  
    write('Número: ');
    readln(a.numero);

    if (a.numero <> -1) then 
    begin 
        write('Apellido: ');
        readln(a.apellido);
        write('Nombres: ');
        readln(a.nombres);
        write('e-mail: ');
        readln(a.email);
        write('Año de ingreso: ');
        readln(a.ingreso);
        write('Año de egreso: ');
        readln(a.egreso);
        writeln('Notas: ');

        for i := 1 to 24 do 
        begin 
            write('Materia #', i, ': ');
            readln(n[i]);
        end;

        ordenarNotas(n);
        a.notas := n;

    end;

    writeln();
end;

procedure imprimirAlumno(a: alumno);
var i: integer;
begin 
    writeln('N° alumno: ', a.numero);
    writeln('Apellido: ', a.apellido);
    writeln('Nombres: ', a.nombres);
    writeln('e-mail: ', a.email);
    writeln('Año de ingreso: ', a.ingreso);
    writeln('Año de egreso: ', a.egreso);
    writeln('Notas: ');

    for i := 1 to 23 do 
        write(a.notas[i]:0:2, ', ');
    write(a.notas[24]:0:2);
    writeln();
end;

procedure imprimirLista(l: lista);
begin 
    while (l <> nil) do 
    begin 
        imprimirAlumno(l^.alu);
        writeln();
        l := l^.sig;
    end;
end;


{ Agrega un nodo a la lista }
procedure agregarAdelante(var l:lista; a:alumno);
var
    nue: lista;

begin
    new(nue);
    nue^.alu := a;
    nue^.sig := l;
    l := nue;
end;


procedure insertarOrdenado(var l: lista; a: alumno);
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

    while (actual <> nil) and (actual^.alu.numero < nuevo^.alu.numero) do 
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

        if (actual^.alu.numero <> cod) then 
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
            exit;
            actual := ant;
        end;
    end;

end;


procedure cargarAlumnos(var l: lista);
var     
    a: alumno;
begin 
    leerAlumno(a);

    while (a.numero <> -1) do 
    begin 
        insertarOrdenado(l, a);
        //agregarAdelante(l, a);

        leerAlumno(a);
    end;
end;


function calcularPromedio(n: vNotas): real;
var 
    i: integer;
    acum: real;
begin 
    acum := 0;

    for i := 1 to 24 do 
        acum := acum + n[i];

    calcularPromedio := acum / 24;
end;


function esPar(num: integer): boolean;
begin
    esPar := (num MOD 2 = 0);
end;


function digImpares(cod: integer): boolean;
var
    resto, aux: integer;
    ok: boolean;
begin

    ok := true;

    aux := cod;
    
    while aux <> 0 do
    begin
        resto := aux MOD 10;

        if (esPar(resto)) then
            ok := false;

        aux := aux DIV 10;
    end;

    digImpares := ok;
    
end;

function recibido(a1: integer; a2: integer): integer;
begin 
    recibido := a2 - a1;
end;


procedure procesarAlumnos(l: lista);
var 
    cant_alu_2012, min_alu1, min_alu2, dif_egreso: integer;
    ape1, ape2, nom1, nom2, email1, email2: string;
begin 
    cant_alu_2012 := 0;
    min_alu1 := 32767;
    min_alu2 := 32767;
    ape1 := '';
    ape2 := '';
    nom1 := ''; 
    nom2 := '';
    email1 := '';
    email2 := '';

    while (l <> nil) do 
    begin 
        writeln('Alumno: ', l^.alu.apellido, ' ', l^.alu.nombres, '. Promedio: ', calcularPromedio(l^.alu.notas):0:2);
        
        if (l^.alu.ingreso = 2012) and (digImpares(l^.alu.numero)) then 
            cant_alu_2012 := cant_alu_2012 + 1;


        dif_egreso := recibido(l^.alu.egreso, l^.alu.ingreso);

        if ( dif_egreso < min_alu1) then 
        begin 
            min_alu2 := min_alu1;
            ape2 := ape1;
            nom2 := nom1;
            email2 := email1;

            min_alu1 := dif_egreso;
            ape1 := l^.alu.apellido;
            nom1 := l^.alu.nombres;
            email1 := l^.alu.email;
        end
        else if (dif_egreso < min_alu2) then 
        begin 
            min_alu2 := dif_egreso;
            ape2 := l^.alu.apellido;
            nom2 := l^.alu.nombres;
            email2 := l^.alu.email;
        end;

        l := l^.sig;
    end;

    writeln('Cantidad de alumnos ingresantes 2012 cuyo número de alumno está compuesto únicamente por dígitos impares: ', cant_alu_2012);
    writeln();
    writeln('Alumnos que más rápido se recibieron: ');
    writeln(' - ', ape1, ' ', nom1, ', email: ', email1);
    writeln(' - ', ape2, ' ', nom2, ', email: ', email2);
    writeln();
end;

var
    l: lista;
    id: integer;


begin  
    inicializarLista(l);
    cargarAlumnos(l);

    imprimirLista(l);

    procesarAlumnos(l);
    

    write('Número de alumno a eliminar: ');
    readln(id);
    eliminar(l, id);

    imprimirLista(l);

    
end.