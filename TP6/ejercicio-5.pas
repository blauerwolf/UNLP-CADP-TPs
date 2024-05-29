{
    Realizar un programa que lea y almacene la información de productos de un supermercado. De cada
    producto se lee: código, descripción, stock actual, stock mínimo y precio. La lectura finaliza cuando se
    ingresa el código -1, que no debe procesarse. Una vez leída y almacenada toda la información, calcular
    e informar:
    a. Porcentaje de productos con stock actual por debajo de su stock mínimo.
    b. Descripción de aquellos productos con código compuesto por al menos tres dígitos pares.
    c. Código de los dos productos más económicos.
}


{
    TODO: En proceso. Aun no terminado
}
program ejercicio_5;

const 

type
    producto = record 
        cod: integer;
        stock_actual: integer;
        stock_min: integer;
        precio: real;
    end;

    lista = ^nodo;

    nodo = record 
        prod: producto;
        sig: lista;
    end;

procedure leerProducto(var p: producto);
begin 
    write('Código: '):
    readln(p.cod);

    if (p.cod <> -1) then 
    begin
        write('Stock actual: ');
        readln(p.stock_actual);
        write('Stock minimo: ');
        readln(p.stock_min);
        write('Precio: ');
        readln(p.precio);
    end;
end;

function debajoStock(L: lista): real;
var 
    tot, dim: integer;
begin
    tot := 0;
    dim := 0;

    while L <> nil do 
    begin 
        if (L^.prod.stock_actual < L^.stock_min) then 
            tot := tot + 1;

        dim := dim + 1;
        L := L^.sig;
    end;

    debajoStock := dim * 100 / tot;
end;

var

begin 


end;