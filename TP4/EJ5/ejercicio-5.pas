program ejercicio_5;

const 
    DIMENSION = 500;

type
    fecha = record 
        dia: integer;
        mes: 1..12;
        anio: integer;
    end;

    cliente = record 
        fecha: fecha;
        categoria: 'A'..'F';
        codigo: 1..2400;
        monto: real;
    end;

    { Almacena los clientes }
    info = array[1..500] of cliente;

    { Contador para los contratos por mes }
    cantMeses = array[1..12] of integer;

    { Vector contador para las categorias de monotributo }
    categorias = array['A'..'F'] of integer;

    { Registro auxiliar para guardar el código de ciudad y la cantidad de clientes }
    contadorCiudad = record
        codigo: integer;
        cantidad: integer;
    end;

    { Vector de ciudades }
    ciudades = array[1..10] of contadorCiudad;
    

procedure leerFecha(var f: fecha);
begin 
    write('Dia: ');
    readln(f.dia);

    if (f.dia <> 0) then 
    begin 
        write('Mes: ');
        readln(f.mes);
        write('Año: ');
        readln(f.anio);
    end;
end;


procedure leer(var c: cliente; f: fecha);
begin
    c.fecha := f;
    write('Categoria Monotributo (A -> F): ');
    readln(c.categoria);
    write('Código de ciudad: ');
    readln(c.codigo);
    write('Monto: ');
    readln(c.monto);    
    writeln();
end;


procedure inicializarCategorias(var cat: categorias);
var 
    i: 'A'..'F';
begin 
    for i := 'A' to 'F' do 
        cat[i] := 0;
end;


procedure imprimirCategorias(cat: categorias);
var
    i: 'A'..'F';
begin 
    for i := 'A' to 'F' do 
        writeln('Categoria ', i, ': ', cat[i]);

    writeln();
end;


procedure cargarClientes(var d: info; var dL: integer);
var 
    c: cliente;
    f: fecha;
begin 
    leerFecha(f);

    while (f.dia <> 0) and (dL <= DIMENSION) do 
    begin 

        leer(c, f);
        dl := dL + 1;
        d[dL] := c;

        leerFecha(f);
    end;
end;


// Cantidad de clientes para cada categoria de monotributo
procedure procesarCategorias(d: info; dL: integer; var cat: categorias);
var 
    i: integer;

begin 
    for i := 1 to dL do 
        cat[d[i].categoria] := cat[d[i].categoria] + 1;
end;


procedure ordenarPorCiudad(var d: info; dL: integer);
var 
  i, j, p: integer;
  item: cliente;
begin 
    for i := 1 to dL -1 do 
    begin // busca el mímino v[p] entre v[i], ... v[N]
      p := i;
      for j := i + 1 to dL do
          if d[j].codigo < d[p].codigo then
              p := j;

      // Intercambia v[i] y v[p]
      item := d[p];
      d[p] :=  d[i];
      d[i] := item;
    end;
end;


// TODO: ordenar por fechas
procedure ordenarPorFecha(var d: info; dL:integer);
var
    i, j, p: integer;
    item: cliente;
begin 
    for i := 1 to dL -1 do 
    begin 
        p := i;
        for j := i + 1 to dL do 
            if d[j].fecha.anio < d[p].fecha.anio then 
                p := j;

        // Intercambio d[i] y d[p]
        item := d[p];
        d[p] := d[i];
        d[i] := item;
    end;
end;


procedure imprimirVector(d: info; dL: integer);
var i: integer;
begin 
    for i := 1 to dL do
    begin
        writeln('Fecha: ', d[i].fecha.anio,'-',d[i].fecha.mes,'-',d[i].fecha.dia);
        writeln('Categoria: ', d[i].categoria);
        writeln('Código: ', d[i].codigo);
        writeln('Monto: ', d[i].monto:0:2);
        writeln();
    end;
end;


// Inicializo en  0 los contadores de las 10 ciudades con mayor cantidad de clientes.
procedure inicializarCiudades(var c: ciudades);
var 
    i: integer;
    d: contadorCiudad;

begin
    d.codigo := 0;
    d.cantidad := 0;

    for i := 1 to 10 do
        c[i] := d;
    
end;


procedure imprimirCiudades(c: ciudades);
var i: integer;
begin 
    i := 1;
    for i := 1 to 10 do 
    begin
        writeln('#', i, ': COD: ', c[i].codigo, ' CAN: ', c[i].cantidad);
    end;

    writeln();
end;


// Procedimiento para actualiar los valores de los contadores de ciudad
procedure shift(var c:ciudades; pos: integer; valor: contadorCiudad);
var 
    i: integer;
begin
    for i := 10 downto (pos + 1) do
        c[i] := c[i-1];

    c[pos] := valor;
end;


procedure inicializarMeses(var m: cantMeses);
var i: integer;
begin
    for i := 1 to 12 do 
        m[i] := 0;
end;

procedure imprimirMeses(m: cantMeses);
begin
    writeln('Enero: ', m[1]);
    writeln('Febrero: ', m[2]);
    writeln('Marzo: ', m[3]);
    writeln('Abril: ', m[4]);
    writeln('Mayo: ', m[5]);
    writeln('Junio: ', m[6]);
    writeln('Julio: ', m[7]);
    writeln('Agosto: ', m[8]);
    writeln('Septiembre: ', m[9]);
    writeln('Octubre: ', m[10]);
    writeln('Noviembre: ', m[11]);
    writeln('Diciembre: ', m[12]);
    writeln();
end;

function totalContratosAnio(m: cantMeses): integer;
var i, tot: integer;
begin 
    tot := 0;
    for i := 1 to 12 do 
        tot := tot + m[i];

    totalContratosAnio := tot;
end;

// procesa las fechas
procedure procesarFechas(d: info; dL: integer);
var 
    i, anioActual, topAnio, topContratos, contratosActual: integer;
    contador: cantMeses;
begin 
    i := 1;
    topContratos := 0;
    topAnio := 0;

    inicializarMeses(contador);

    while (i <= dL) do 
    begin 
        anioActual := d[i].fecha.anio;

        { Reinicializo el contador de cantidad de contratos anuales del año en estudio }
        contratosActual := 0;

        while (d[i].fecha.anio = anioActual) do 
        begin 
            contador[d[i].fecha.mes] := contador[d[i].fecha.mes] + 1;
            i := i + 1;
        end;

        writeln('Cantidad de contratos por mes del año ', anioActual);
        imprimirMeses(contador);

        contratosActual := totalContratosAnio(contador);

        if (contratosActual > topContratos) then 
        begin 
            topContratos := contratosActual;
            topAnio := anioActual;
        end;


    end;

    writeln('Año en que se firmó la mayor cantidad de contratos: ', topAnio);
    writeln();
end;


// Codigo de las 10 ciudades con mayor cantidad de clientes
procedure procesarCiudades(d: info; dL: integer; var c: ciudades);
var 
    i, cont: integer;
    cActual: contadorCiudad;

begin

    i := 1;
    cActual.codigo := 0;
    cActual.cantidad := 0;

    while (i <= dL) do
    begin
        
        { (Re)inicializo el contador parcial de ciudad en 0 }
        cont := 0;
	    cActual.codigo := d[i].codigo;

        while (cActual.codigo = d[i].codigo) do
        begin 
            cont := cont + 1;
	        i := i + 1;
        end;

        cActual.cantidad := cont;

        if (cont > c[1].cantidad) then
            shift(c, 1, cActual)
        else if (cont > c[2].cantidad) then
            shift(c, 2, cActual)
        else if (cont > c[3].cantidad) then
            shift(c, 3, cActual)
        else if (cont > c[4].cantidad) then
            shift(c, 4, cActual)
        else if (cont > c[5].cantidad) then
	        shift(c, 5, cActual)
	    else if (cont > c[6].cantidad) then
	        shift(c, 6, cActual)
	    else if (cont > c[7].cantidad) then
	        shift(c, 7, cActual)
	    else if (cont > c[8].cantidad) then
	        shift(c, 8, cActual)
	    else if (cont > c[9].cantidad) then
	        shift(c, 9, cActual)
	    else if (cont > c[10].cantidad) then
	        shift(c, 10, cActual);

    end;
end;


{ Calcula el monto promedio de todos los clientes }
function montoPromedio(d: info; dL: integer): real;
var 
    i: integer;
    monto: real;
begin 
    monto := 0;
    for i := 1 to dL do 
    begin 
        monto := monto + d[i].monto;
    end;

    montoPromedio := monto / dL;
end;

function superanPromedio(d: info; dL: integer): integer;
var 
    i, cant: integer;
    monto: real;
begin 
    cant := 0;
    monto := montoPromedio(d, dL);

    for i := 1 to dL do
    begin 
        if d[i].monto > monto then 
            cant := cant + 1;
    end;

    superanPromedio := cant;
end;


{ Variables del programa }
var 
    data: info;
    dimL, i: integer;
    cat: categorias;
    ciu: ciudades;


{ Cuerpo principal del programa }
begin 

    inicializarCategorias(cat);
    cargarClientes(data, dimL);

    if (dimL > 0) then 
    begin
        writeln('Vector cargado: ');
        imprimirVector(data, dimL);

        { Inciso a }
        ordenarPorFecha(data, dimL);
        writeln('Clientes ordenado por fecha:');
        writeln('============================');
        imprimirVector(data, dimL);
        procesarFechas(data, dimL);


        { Inciso b }
        procesarCategorias(data, dimL, cat);
        writeln('Cantidad de clientes por cada categoría de monotributo:');
        writeln('=======================================================');
        imprimirCategorias(cat);

        { Inciso c }
        inicializarCiudades(ciu);

        ordenarPorCiudad(data, dimL);
        writeln('Clientes ordenado por ciudad:');
        writeln('=============================');
        imprimirVector(data, dimL);

        procesarCiudades(data, dimL, ciu);

        writeln('Código de las 10 ciudades con mayor cantidad de clientes: ');
        writeln();
        for i := 1 to 10 do
            writeln('#', i, ' ', ciu[i].codigo);
        writeln();

        { Inciso d }
        writeln('Cantidad de clientes que superan mensualmente el monto de todos los clientes: ', superanPromedio(data, dimL));
        writeln();
    end
    else 
        writeln('No hay registros.');

end.
