program ejercicio_5;


type
    auto = record
        marca: string;
        modelo: string;
        precio: real;
    end;

procedure leerAuto(var a: auto);
begin
    write('Ingrese marca: ');
    readln(a.marca);
    write('Ingrese modelo: ');
    readln(a.modelo);
    write('Ingrese precio: ');
    readln(a.precio);
    writeln();
end;

procedure actualizarPrecio(c: auto; var ac: real);
begin
    ac := ac + c.precio;
end;

procedure actualizarMasCaro(a: auto; var precio: real; var marca, modelo: string);
begin
    if (a.precio > precio) then
    begin
        precio := a.precio;
        marca := a.marca;
        modelo := a.modelo;
    end;
end;


var
    total_marca: integer;
    car: auto;
    acum_precio, precio_top: real;
    marca_actual, marca_top, modelo_top: string;
begin
    precio_top := 0;


    leerAuto(car);

    while (car.marca <> 'ZZZ') do
    begin
        marca_actual := car.marca;
        actualizarMasCaro(car, precio_top, marca_top, modelo_top);

        { Reinicializo el contador de marca }
        total_marca := 0;
        acum_precio := 0;

        while (car.marca = marca_actual) do
        begin
            total_marca := total_marca + 1;

            actualizarPrecio(car, acum_precio);  
            leerAuto(car); 
                     
        end;

        writeln('El precio promedio de la marca ', marca_actual, ' es: $', (acum_precio / total_marca):0:2);

        //leerAuto(car);
    end;

    writeln('Vehíuclo más caro: ', marca_top, ' ', modelo_top);
end.