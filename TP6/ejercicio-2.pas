{
    Dado el siguiente código que lee información de personas hasta que se ingresa la persona con dni 0 y
    luego imprime dicha información en el orden inverso al que fue leída, identificar los 9 errores.

    01 - Falta inicializar l
    02 - El argumento de leerPersona es de tipo persona, no 'nodo'
    03 - el registro es dato.nombre
    04 - el registro es dato.apellido
    05 - La estructura es p.dato o p.sig
    06 - agregarAdelante espera como segundo argumento tipo persona, no nodo
    07 - Falta hacer new de aux
    08 - No pasar por referencia, pierde el puntero
    09 - no modifica el valor de p, parámetro pasado por valor
}

program ejercicio2;
type
    lista = ^nodo;

    persona = record
        dni: integer;
        nombre: string;
        apellido: string;
    end;

    nodo = record
        dato: persona;
        sig: lista;
    end;

procedure leerPersona(p: persona);  // 09 - no modifica el valor de p, parámetro pasado por valor
begin
    read(p.dni);

    if (p.dni <> 0)then begin
        read(p.nombre);
        read(p.apellido);
    end;
end;

{Agrega un nodo a la lista}
procedure agregarAdelante(l:lista; p:persona);
var
    aux: lista;
begin
    // 06 - Falta hacer new de aux
    aux^.dato:= p;
    aux^.sig:= l;
    l:= aux;
end;

{Carga la lista hasta que llega el dni 0}
procedure generarLista(var l:lista);
var
    p:nodo;
begin
    leerPersona(p); // 02 - El argumento de leerPersona es de tipo persona, no 'nodo'
    while (p.dni <> 0) do begin // 05 - La estructura es p.dato o p.sig
        agregarAdelante(l,p);   // 06 - agregarAdelante espera como segundo argumento tipo persona, no nodo
    end;
end;

procedure imprimirInformacion(var l:lista); // 08 - No pasar por referencia, pierde el puntero
begin
    while (l <> nil) do begin
        writeln('DNI: ', l^.dato.dni, 'Nombre:',
        l^.nombre, 'Apellido:', l^.apellido);   // 03/04 - el registro es dato.nombre, dato.apellido
        l:= l^.sig;
    end;
end;


{Programa principal}
var
    l:lista;
begin
    // 01 - Falta inicializar l
    generarLista(l);
    imprimirInformacion(l);
end.