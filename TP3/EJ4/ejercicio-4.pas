program ejercicio_4;

const
    TOT_CLIENTES = 9300;
    COSTO_MINUTO = 3.40;
    COSTO_MB = 1.35;

type
    linea = record
        numero_telef: integer;
        minutos: integer;
        mb_consumidos: integer;
    end;

    cliente = record
        codigo: integer;
        cant_lineas: integer;
    end;



procedure leerLinea(var l: linea);
begin
    write('Ingrese Número de teléfono: ');
    readln(l.numero_telef);
    write('Ingrese minutos consumidos: ');
    readln(l.minutos);
    write('Ingrese cantidad de MB consumidos en el mes: ');
    readln(l.mb_consumidos);
    writeln();
end;

procedure leerCliente(var c: cliente);
begin
    write('Ingrese Código de cliente: ');
    readln(c.codigo);
    write('Ingrese cantidad de líneas asociadas: ');
    readln(c.cant_lineas);
    writeln();
end;

procedure calcular(c: cliente; var minutos, mb: integer);
var
    i: integer;
    l: linea;
begin
    minutos := 0;
    mb := 0;

    for i := 1 to c.cant_lineas do
    begin
        writeln('Línea #', i);
        leerLinea(l);
        minutos := minutos + l.minutos;
        mb := mb + l.mb_consumidos;
    end;
end;

var
    cli: cliente;
    i, min_factura, mb_factura: integer;
    sub_min, sub_mb: real;


begin
    for i := 1 to TOT_CLIENTES do
    begin
        min_factura := 0;
        mb_factura := 0;
        sub_min := 0;
        sub_mb := 0;

        leerCliente(cli);
        calcular(cli, min_factura, mb_factura);

        sub_min := min_factura * COSTO_MINUTO;
        sub_mb := mb_factura * COSTO_MB;

        writeln('Factura #', i);
        writeln('------------------');
        writeln('Cliente: ', cli.codigo);
        writeln('Minutos consumidos: ', min_factura, ' Subtotal: $', sub_min:0:2);
        writeln('MB consumidos: ', mb_factura, ' Subtotal: $', sub_mb:0:2);
        writeln('TOTAL A PAGAR: $', sub_min + sub_mb:0:2);
        writeln();

    end;
end.





