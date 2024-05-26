{
    Se desea almacenar en memoria una secuencia de 2500 nombres de ciudades, cada nombre podrá
    tener una longitud máxima de 50 caracteres.

    a. Definir una estructura de datos estática que permita guardar la información leída. Calcular el
    tamaño de memoria que requiere la estructura.

    b. Dado que un compilador de Pascal típico no permite manejar estructuras de datos estáticas que
    superen los 64 Kb, pensar en utilizar un vector de punteros a palabras, como se indica en la
    siguiente estructura:
        Type
            Nombre = String[50];
            Puntero = ^Nombre;
            ArrPunteros = array[1..2500] of Puntero;
        Var
            Punteros: ArrPunteros;   

    i) Indicar cuál es el tamaño de la variable Punteros al comenzar el programa.
    ii) Escribir un módulo que permita reservar memoria para los 2500 nombres. ¿Cuál es la
        cantidad de memoria reservada después de ejecutar el módulo? ¿La misma corresponde a
        memoria estática o dinámica?
    iii) Escribir un módulo para leer los nombres y almacenarlos en la estructura de la variable
    Punteros.
}


{

    a. 
    type
        ciudades = array[1..2500] of String[50];

    Tamaño: 2500 x 51 = 127.500 bytes

    b.
    Type
        Nombre = String[50];                        -> 51 bytes
        Puntero = ^Nombre;                          -> 4 bytes
        ArrPunteros = array[1..2500] of Puntero;    -> 2500 x 4 = 10.000 bytes
    Var
        Punteros: ArrPunteros;                      -> 10.000 bytes

    i) 10 KB
    ii)
    procedure instanciar(p: ArrPunteros);
    begin
        new(p);
    end; 

    Se reserva 10.004 bytes (variable p declarada en la llamada). Corresponde a memoria dinámica (10k)
    y la declaración del puntero

    iii)
    procedure leer(Punteros: ArrPunteros);
    var 
        i: integer;
    begin 
        for i := 1 to 2500 do
        begin 
            write('Nombre de ciudad #', i, ': ');
            readln(Punteros^[i]);
        end;
    end;


}

