{
    La tienda de libros Amazon Books está analizando información de algunas editoriales. Para ello, Amazon
    cuenta con una tabla con las 35 áreas temáticas utilizadas para clasificar los libros (Arte y Cultura, Historia,
    Literatura, etc.).
    De cada libro se conoce su título, nombre de la editorial, cantidad de páginas, año de edición, cantidad de veces
    que fue vendido y código del área temática (1..35).
    Realizar un programa que:
    A) Invoque a un módulo que lea la información de los libros hasta ingresar el título “Relato de un
    náufrago” (que debe procesarse) y devuelva en una estructura de datos adecuada para la editorial
    “Planeta Libros”, con la siguiente información:
    - Nombre de la editorial
    - Año de edición del libro más antiguo
    - Cantidad de libros editados
    - Cantidad total de ventas entre todos los libros
    - Detalle con título, nombre del área temática y cantidad de páginas de todos los libros con más
    de 250 ventas.
    B) Invoque a un módulo que reciba la estructura generada en A) e imprima el nombre de la editorial y el
    título de cada libro con más de 250 ventas.
}

program ejercicio_13;
type
    tematica = array[1..35] of string;

    libro = record 
        titulo: string;
        editorial: string;
        paginas: integer;
        anio_edicion: integer;
        vendido: integer;
        codigo: 1..35;
    end;

    detalle = record 
        titulo: string;
        tematica: 1..35;
        paginas: integer;
    end;

    lista = ^nodo;

    nodo = record
        elem: detalle;
        sig: lista;
    end;

    editorial = record 
        nombre: string;
        anio_libro_antiguo: integer;
        cant_libros_editados: integer;
        tot_ventas: integer;
        libros: lista;
    end;

    


{ A efectos de poder correr el programa }
procedure inicializarTematicas(var t: tematica);
begin 
    t[1] := 'Arte y Cultura';
    t[2] := 'Historia';
    t[3] := 'Literatura';
    t[4] := 'Ficción';
    t[5] := 'Bibliotecología y museología';
    t[6] := 'Ciencias de la Tierra';
    t[7] := 'Ciencias y matemáticas';
    t[8] := 'Computación y tecnología de la información';
    t[9] := 'Deportes y actividades al aire libre';
    t[10] := 'Derecho';
    t[11] := 'Economía, finanzas, empresa y gestión';
    t[12] := 'Filosofía';
    t[13] := 'Religión';
    t[14] := 'Historia';
    t[15] := 'Arqueología';
    t[16] := 'Infantil';
    t[17] := 'Juvenil';
    t[18] := 'Lenguaje';
    t[19] := 'Lingüística';
    t[20] := 'Narrativas ilustradas';
    t[21] := 'Ocio y tiempo libre';
    t[22] := 'Salud';
    t[23] := 'Relaciones y desarrollo personal';
    t[24] := 'Sociedad';
    t[25] := 'Ciencias Sociales';
    t[26] := 'Autoayuda';
    t[27] := 'Música';
    t[28] := 'Ingeniería';
    t[29] := 'Botánica';
    t[30] := 'Diccionarios';
    t[31] := 'Agricultura';
    t[32] := 'Cuentos';
    t[33] := 'Bricolage';
    t[34] := 'Animales';
    t[35] := 'No categorizado';
end;


procedure inicializarEditorial(var e: editorial; nombre: string);
begin 
    e.nombre := nombre;
    e.anio_libro_antiguo := 0;
    e.cant_libros_editados := 0;
    e.tot_ventas := 0;
    e.libros := nil;
end;


procedure agregarAlFinal(var l:lista; b:libro);
var 
    nue, aux: lista;
begin 

    new(nue);
    nue^.elem.titulo := b.titulo;
    nue^.elem.tematica := b.codigo;
    nue^.elem.paginas := b.paginas;


    nue^.sig := nil;

    if ( l = nil) then
        l := nue
    else 
    begin
        aux := l;

        while (aux^.sig <> nil) do 
            aux := aux^.sig;
        
        aux^.sig := nue;
    end;
end;


procedure agregarLibro(var e: editorial; b:libro);
var 
    l: lista;

begin 
    l := e.libros;

    agregarAlFinal(l, b);


    { Actualizo el registro }
    if (e.anio_libro_antiguo > b.anio_edicion) then
        e.anio_libro_antiguo := b.anio_edicion;

    e.cant_libros_editados := e.cant_libros_editados + 1;
    e.tot_ventas := e.tot_ventas + b.vendido;
    e.libros := l;
    
end;


procedure leerLibro(var l: libro);
begin 
    write('Título: ');
    readln(l.titulo);
    write('Editorial: ');
    readln(l.editorial);
    write('Cantidad de páginas: ');
    readln(l.paginas);
    write('Año de edición: ');
    readln(l.anio_edicion);
    write('Cantidad de veces vendido: ');
    readln(l.vendido);
    write('Código de temática: ');
    readln(l.codigo);

    writeln();
end;


procedure cargarLibros(var e:editorial);
var 
    b: libro;

begin 
    repeat
        leerLibro(b);

        if (b.editorial = 'Planeta Libros') then
            agregarLibro(e, b);

    until b.titulo = 'Relato de un náufrago';
    
end;


procedure imprimirEditorial(e: editorial; t: tematica);
var 
    l: lista;
begin
    writeln('Editorial: ', e.nombre);
    writeln('=========================');
    writeln('> Año de libro más antiguo: ', e.anio_libro_antiguo);
    writeln('> Cantidad de libros editados: ', e.cant_libros_editados);
    writeln('> Total de ventas: ', e.tot_ventas);
    writeln('** Libros (más de 250 páginas) **');

    l := e.libros;

    while (l <> nil) do 
    begin
        if (l^.elem.paginas > 250) then 
        begin 
            writeln('Título: ', l^.elem.titulo);
            writeln('Temática: ', t[l^.elem.tematica]);
            writeln('Páginas: ', l^.elem.paginas);
            writeln();
        end;


        l := l^.sig;
    end;

    writeln();
end;

var 
    l: lista;
    t: tematica;
    e: editorial;

begin 
    inicializarTematicas(t);
    inicializarEditorial(e, 'Planeta Libros');
    cargarLibros(e);
    imprimirEditorial(e, t);
end.