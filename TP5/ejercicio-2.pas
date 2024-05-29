program punteros;
type
    cadena = string[9];         // size: 10 bytes
    producto = record           // size: Tabla: 16B. PC: 20B. Ejecución: 24B 🤔
        codigo: integer;        //      size Tabla: 2B. PC: 2B
        descripcion: cadena;    //      size: 10B
        precio: real;           //      size: Tabla: 4B. PC: 8B
    end;
    
    puntero_producto = ^producto;

    prod2 = record
    end;
var
    p: puntero_producto;
    prod: producto;
    c: cadena;
    cod: integer;
    d: prod2;
    r: real;
begin
    writeln(sizeof(cod),  ' ', sizeof(c), ' ',sizeof(r),  ' ', sizeof(prod2));

    writeln(sizeof(p), ' bytes');       //T: 4B. PC: 8B
    writeln(sizeof(prod), ' bytes');    //T: 16B. PC: 24B
    new(p);
    writeln(sizeof(p), ' bytes');       //T: 4B. PC: 8B
    p^.codigo := 1;
    p^.descripcion := 'nuevo producto';
    writeln(sizeof(p^), ' bytes');      //T: 16B. PC: 24B
    p^.precio := 200;
    writeln(sizeof(p^), ' bytes');      //T: 16B. PC: 24B
    prod.codigo := 2;
    prod.descripcion := 'otro nuevo producto'; 
    writeln(sizeof(prod), ' bytes');    //T: 16B. PC:
end.