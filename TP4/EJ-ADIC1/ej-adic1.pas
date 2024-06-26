{
    La compañía Canonical Llt. desea obtener estadísticas acerca del uso de Ubuntu Linux en La Plata. Para
    ello, debe realizar un programa que lea y almacene información sobre las computadoras con este
    sistema operativo (a lo sumo 10.000). De cada computadora se conoce: código de computadora, la
    versión de Ubuntu que utilizan (18.04, 17.10, 17.04, etc.), la cantidad de paquetes instalados y la
    cantidad de cuentas de usuario que poseen. La información debe almacenarse ordenada por código de
    computadora de manera ascendente. La lectura finaliza al ingresar el código de computadora -1, que no
    debe procesarse. Una vez almacenados todos los datos, se pide:

    a. Informar la cantidad de computadoras que utilizan las versiones 18.04 o 16.04.
    b. Informar el promedio de cuentas de usuario por computadora.
    c. Informar la versión de Ubuntu de la computadora con mayor cantidad de paquetes instalados.
    d. Eliminar la información de las computadoras con código entre 0 y 500.

}

program ej_adic1;
const 
    tot_pc = 10000;

type 
    rango_pcs = 0..10000;

    computadora = record 
        version: string[5];
        paquetes: integer;
        cuentas: integer;
    end;

    vector_computadoras = array[rango_pcs] of computadora;

    { Vector para hacer un "seed" del array de computadoras }
    vector_versiones = array[1..39] of string[5];


{ 
    ===========================================================
                Procedimientos auxiliar para seed 
    ===========================================================
}
procedure cargarVersiones(var v: vector_versiones);
begin
    v[1] := '4.10';
    v[2] := '5.04';
    v[3] := '5.10';
    v[4] := '6.06';
    v[5] := '6.10';
    v[6] := '7.04';
    v[7] := '7.10';
    v[8] := '8.04';
    v[9] := '8.10';
    v[10] := '9.04';
    v[11] := '9.10';
    v[12] := '10.04';
    v[13] := '10.10';
    v[14] := '11.04';
    v[15] := '11.10';
    v[16] := '12.04';
    v[17] := '12.10';
    v[18] := '12.04';
    v[19] := '12.10';
    v[20] := '13.04';
    v[21] := '13.10';
    v[22] := '14.04';
    v[23] := '14.10';
    v[24] := '15.04';
    v[25] := '15.10';
    v[26] := '16.04';
    v[27] := '16.10';
    v[28] := '17.04';
    v[29] := '17.10';
    v[30] := '18.04';
    v[31] := '19.04';
    v[32] := '19.10';
    v[33] := '20.04';
    v[34] := '21.04';
    v[35] := '21.10';
    v[36] := '22.04';
    v[37] := '23.04';
    v[38] := '23.10';
    v[39] := '24.04';
end;

procedure seed(var v: vector_computadoras; dimL: integer; vers: vector_versiones);
var 
    i: integer;
begin 
    for i := 1 to dimL do 
    begin 
        v[i].version := vers[random(38) + 1];
        v[i].paquetes := random(400) + 1;
        v[i].cuentas := random(25) + 1;
    end;
end;

{
    ===========================================================
                    Fin procedimientos para seed
    ===========================================================
}

procedure imprimir(v: vector_computadoras; dimL: integer);
var 
    i: integer;
begin 
    writeln('#'#9,'Ubuntu'#9, 'Versión'#9, 'Cuentas'#9);
    for i := 0 to dimL do 
    begin 
        writeln(i, #9, v[i].version,#9, v[i].paquetes,#9, v[i].cuentas);
    end;
    writeln();
end;

procedure leerComputadora(var cod: integer; var pc: computadora);
begin
    write('Código: ');
    readln(cod);

    if cod <> -1 then 
    begin 
        write('Versión de OS: ');
        readln(pc.version);
        write('Cantidad de paquetes instalados: ');
        readln(pc.paquetes);
        write('Cantidad de cuentas de usuario: ');
        readln(pc.cuentas);
    end;
    writeln();
end;

procedure cargarComputadoras(var v: vector_computadoras; var dimL: integer);
var 
    cod: integer;
    pc: computadora;
begin 
    dimL := -1;
    leerComputadora(cod, pc);

    while (cod <> -1) do 
    begin 
        v[cod] := pc;
        dimL := cod;

        leerComputadora(cod, pc);
    end;
end;


procedure procesar(v: vector_computadoras; dimL: integer);
var 
    i, cant_vers1618, cant_cuentas, max_paquetes: integer;
    top_version : string[5];
begin 
    cant_vers1618 := 0;
    cant_cuentas := 0;
    max_paquetes := 0;
    top_version := '';

    for i := 1 to dimL do 
    begin 
        { Punto a }
        if (v[i].version = '16.04') or (v[i].version = '18.04') then 
            cant_vers1618 := cant_vers1618 + 1;

        { Punto b }
        cant_cuentas := cant_cuentas + v[i].cuentas;

        { Punto c }
        if v[i].paquetes > max_paquetes then 
        begin 
            max_paquetes := v[i].paquetes;
            top_version := v[i].version;
        end;
    end;

    writeln('Cantidad de computadoras que utilizan las versiones 18.04 o 16.04: ', cant_vers1618);
    writeln('Promedio de cuentas de usuario por computadora: ', cant_cuentas / dimL:0:2);
    writeln('Versión de Ubuntu de la computadora con mayor cantidad de paquetes instalados: ', top_version);
end;

procedure eliminar(var v: vector_computadoras; var dimL: integer);
var 
    i: integer;
begin 
    { Si el vector tiene algún dato }
    if dimL >= 0 then
    begin 
        { Si tiene menos de 500 elementos (hasta 500) }
        if (dimL >= 0) and (dimL <= 500) then 
            dimL := -1
        else begin
            { 
                Tiene más de 500 elementos, entonces:
                    elem 501 => 0
                    elem 502 => 1
                    ...
                    elem dimL => dimL - 501
            }

            for i := 501 to dimL do 
            begin 
                v[i - 501] := v[i];
            end;

            dimL := dimL - 501;

        end;
    end;
end;

var 
    dimL: integer;
    pc: computadora;
    v: vector_computadoras;
    vers: vector_versiones;
begin 
    randomize();
    //cargarComputadoras(v, dimL);
    dimL := 550;
    cargarVersiones(vers);
    seed(v, dimL, vers);
    imprimir(v, dimL);
    procesar(v, dimL);
    eliminar(v, dimL);
    imprimir(v, dimL);
end.