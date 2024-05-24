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
    i: 'A'..'F';

begin 
    for i := 'A' to 'F' do 
    begin 
        cat[d[dL].categoria] := cat[d[dL].categoria] + 1;

    end;
end;

// TODO: Ordenar por ciudad
procedure ordenarPorCiudad(var d: info; dL: integer);
begin 

end;

// Codigo de las 10 ciudades con mayor cantidad de clientes
procedure procesarCiudades(d: info; dL: integer);
var 
    i: integer;
begin 

end;

var 
    data: info;
    dimL: integer;
    cat: categorias;
begin 

    inicializarCategorias(cat);
    cargarClientes(data, dimL);

    procesarCategorias(data, dimL, cat);

    imprimirCategorias(cat);
end.