
program punteros;
type
    cadena = string[50];
    puntero_cadena = ^cadena;
var
    pc, pc2: puntero_cadena;
begin
    writeln(sizeof(pc), ' bytes');      // Tabla: 4 bytes. En mi PC imprime 8 bytes
    new(pc);
    writeln(sizeof(pc), ' bytes');      // Tabla: 4 bytes (sigue siendo puntero). PC: 8 bytes
    pc^:= 'un nuevo nombre';
    writeln(sizeof(pc), ' bytes');      // Tabla: 4 bytes. PC: 8 bytes
    writeln(sizeof(pc^), ' bytes');     // Tabla: 51 bytes. PC: 51 bytes
    pc^:= 'otro nuevo nombre distinto al anterior';
    writeln(sizeof(pc^), ' bytes');     // Tabla: 51 bytes. PC: 51 bytes

    pc^:='String muy largo para ver que sucede cuando supera el máxximo permitido';
    writeln(pc^ );
end.