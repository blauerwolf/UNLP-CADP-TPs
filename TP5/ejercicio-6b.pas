{
    Programa que utiliza únicamente 50KB,
    50% estática, 50% dinámica
}

program ejercicio_6b;
type 
    cadena = string[24];            // 25 bytes
    cadenita = string[17];
    puntero = ^cadena;              // 4 bytes - 8 bytes en 64 bits
var 
    p1, p2: puntero;                // 8 bytes
    c: cadenita;                    // 17 bytes


begin
    new(p1);                        // 25 bytes

    p1^ := 'una cadena';
    writeln(p1^);

    p2 := p1;
    writeln(p2^);

    c := p2^;
    writeln(c);

    dispose(p1);
end.