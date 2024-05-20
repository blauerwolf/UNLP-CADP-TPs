program ejercicio_6;


type   
    microprocesador = record
        marca: string[50];
        linea: string[50];
        cores: integer;
        frecuencia: real;
        litografia: integer;
    end;

procedure leer(var m: microprocesador);
begin
    write('Ingrese marca: ');
    readln(m.marca);
    write('Ingrese linea: ');
    readln(m.linea);
    write('Ingrese cantidad de cores o núcleos: ');
    readln(m.cores);
    write('Ingrese frecuencia de reloj: ');
    readln(m.frecuencia);
    write('Ingrese dimensión del proceso litográfico: ');
    readln(m.litografia);
    writeln();
end;

procedure actualizarMulticores(cpu: microprocesador; var total: integer);
begin
    if (cpu.marca = 'AMD') or (cpu.marca = 'Intel') then
    begin
        if (cpu.frecuencia > 2) then
            total := total + 1;
    end;
end;

procedure informarCPUMulticore22(cpu: microprocesador);
begin
    if (cpu.cores > 2) and (cpu.litografia <= 22) then
        writeln('Procesador con más de 2 cores y transistores de hasta 22nm. Marca: ', cpu.marca, ' Línea: ', cpu.linea);
end;

procedure actualizar14Nm(cpu: microprocesador; var total: integer);
begin
    if (cpu.litografia = 14) then
        total := total + 1;
end;

var
    tot_14nm, tot_2ghz_multicore, top1, top2: integer;
    marca_max1, marca_max2, marca_actual: string[50];
    cpu: microprocesador;

begin

    tot_2ghz_multicore := 0;
    top1 := 0;
    top2 := 0;
    marca_max1 := '';
    marca_max2 := '';

    leer(cpu);

    while (cpu.cores <> 0) do
    begin
        
        

        { Analizo por marca }
        marca_actual := cpu.marca;
        tot_14nm := 0;

        while (cpu.marca = marca_actual) do
        begin
            informarCPUMulticore22(cpu);
            actualizarMulticores(cpu, tot_2ghz_multicore);
            actualizar14Nm(cpu, tot_14nm);
            leer(cpu);
        end;

        { Actualizo los valores de las marcas }
        if tot_14nm > top1 then
        begin
            top2 := top1;
            top1 := tot_14nm;

            marca_max2 := marca_max1;
            marca_max1 := cpu.marca;
        end
        else if tot_14nm > top2 then
        begin
            top2 := tot_14nm;
            marca_max2 := cpu.marca;
        end;




    end;

    if (top1 = 0) and (top2 = 0) then
    begin
        writeln('No hay procesadores con litografía en 14nm');
    end
    else
    begin
        writeln(marca_max1, ' es la marca con mayor cantidad de procesadores con transistores de 14nm');
        writeln(marca_max2, ' es la segunda marca con mayor cantidad de procesadores con transistores de 14nm');
    end;

    writeln('Cantidad de procesadores multicore AMD o Intel de frecuencia de al menos 2GHz: ', tot_2ghz_multicore);


end.
