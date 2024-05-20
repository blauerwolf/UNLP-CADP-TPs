program ejercicio_7;

type
    ciuns = record
        nombre: string[10];
        universidad: string[50];
        investigadores: integer;
        becarios: integer;
    end;

procedure leer(var c: ciuns);
begin
    write('Ingrese nombre abreviado: ');
    readln(c.nombre);
    write('Ingrese Universidad a la que pertenece: ');
    readln(c.universidad);
    write('Ingrese cantidad de investigadores: ');
    readln(c.investigadores);
    write('Ingrese cantidad de becarios: ');
    readln(c.becarios);
end;

var
    centros: ciuns;
    min_bec1, min_bec2: integer;
    min_bec1_nombre, min_bec2_nombre: string[10];
    tot_centros, uni_tot_inv, tot_inv: integer;
    universidad_actual, top_uni: string[50];


begin   
    top_uni := '';
    min_bec1 := 0;
    min_bec2 := 0;
    tot_inv := 0;
    uni_tot_inv := 0;



    leer(centros);

    while (centros.investigadores <> 0) do
    begin
        universidad_actual := centros.universidad;
        tot_centros := 0;

        while (centros.universidad = universidad_actual) do
        begin
            tot_centros := tot_centros + 1;
            uni_tot_inv := uni_tot_inv + centros.investigadores;


            leer(centros);

        end;

        if (uni_tot_inv > tot_inv) then
        begin
            tot_inv := uni_tot_inv;
            top_uni := universidad_actual;
        end;

        writeln('La universidad ', universidad_actual, ' posee ', tot_centros, ' centros');



    end;

    writeln('La universidad con mayor cantida de investigadores en sus centros es: ', top_uni);
end.
