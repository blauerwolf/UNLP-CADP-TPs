program ejercicio_5;

const 
    DIMENSION = 500;

type
    cliente = record 
        fecha: string;
        categoria: 'A'..'F';
        codigo: 1..2400;
        monto: real;
    end;

    info = array[1..500] of cliente;

    categorias = array['A'..'F'] of integer;

    ciudades = array[1..10] of integer;


procedure leer(var c: cliente);
begin
    write('Fecha de firma de contrato: ');
    readln(c.fecha);

    if (c.fecha <> '') then 
    begin 
        write('Categoria Monotributo (A -> F): ');
        readln(c.categoria);
        write('Código de ciudad: ');
        readln(c.codigo);
        write('Monto: ');
        readln(c.monto);
        writeln();
    end;
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
begin 
    leer(c);

    while (c.fecha <> '') and (dL <= DIMENSION) do 
    begin 
        dl := dL + 1;
        d[dL] := c;

        leer(c);
    end;
end;


// Cantidad de clientes para cada categoria de monotributo
procedure procesarCategorias(d: info; dL: integer; var cat: categorias);
var 
    i: integer;

begin 
    for i := 1 to dL do 
    begin 
        cat[d[i].categoria] := cat[d[i].categoria] + 1;
    end;
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


procedure imprimirVector(d: info; dL: integer);
var i: integer;
begin 
    for i := 1 to dL do
    begin
        writeln('Fecha: ', d[i].fecha);
        writeln('Categoria: ', d[i].categoria);
        writeln('Código: ', d[i].codigo);
        writeln('Monto: ', d[i].monto);
        writeln();
    end;
end;


// Inicializo en  0 los contadores de las 10 ciudades con mayor cantidad de clientes.
procedure inicializarCiudades(var c: ciudades);
var i: integer;
begin
    for i := 1 to 10 do
        c[i] := 0;
end;


// Procedimiento para actualiar los 
procedure shift(var c:ciudades; pos: integer; valor: integer);
var i: integer;
begin
    for i := 10 downto pos - 1 do
    begin 
        c[i] := c[i-1];
    end;

    c[pos] := valor;
end;


// Codigo de las 10 ciudades con mayor cantidad de clientes
procedure procesarCiudades(d: info; dL: integer; var c: ciudades);
var 
    i, cont: integer;
    cActual: ciudad;

begin
    cActual := d[i];

    while (i <= dL) do
    begin
        // (Re)inicializo el contador parcial de ciudad en 0
        cont := 0;

        while (cActual.ciudad = d[i].ciudad) do
        begin 
            cont := cont + 1;
        end;

        if cont > c[1] then
            shift(c, 1, cont);
        else if cont > c[2] then
            shift(c, 2, cont);
        else if cont > c[3] then
            shift(c, 3, cont);
        else if cont > c[4] then
            shift(c, 4, cont);
        else if cont > c[5] then 
            shift(c, 5, cont);
        else if cont > c[6] then
            shift(c, 6, cont);
        else if cont > c[7] then
            shift(c, 7, cont);
        else if cont > c[8] then
            shift(c, 8, cont);
        else if cont > c[9] then
            shift(c, 9, cont);
        else if cont > c[10] then
            shift(c, 10, cont);
          
    end;


    for i := 1 to dL do 
    begin 

    end;
end;

var 
    data: info;
    dimL: integer;
    cat: categorias;
begin 

    inicializarCategorias(cat);
    cargarClientes(data, dimL);
    imprimirVector(data, dimL);

    procesarCategorias(data, dimL, cat);
    writeln('Cantidad de clientes por cada categoría de monotributo.');
    imprimirCategorias(cat);

    ordenarPorCiudad(data, dimL);
    imprimirVector(data, dimL);
end.