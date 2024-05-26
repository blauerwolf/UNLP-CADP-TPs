program punteros;
type
    cadena = string[50];
    puntero_cadena = ^cadena;
var
    pc: puntero_cadena;
    
begin
    new(pc);
    pc^:= 'un nuevo nombre';
    writeln(sizeof(pc^), ' bytes');
    writeln(pc^);
    pc^:= 'otro nuevo nombre';
    dispose(pc);
end.