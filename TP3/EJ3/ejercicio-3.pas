program unesco;

type
    escuela = record
        cue: integer;
        nombre: string;
        cant_doc: integer;
        cant_alu: integer;
        localidad: string;
    end;

const
    UNESCO_2015 = 23435;
    TOTAL_ESCUELAS = 2400;

procedure leer(var e: escuela);
begin
    write('Ingrese CUE: '); readln(e.cue);
    write('Ingrese Nombre de Establecimiento: '); readln(e.nombre);
    write('Ingrese cantidad de docentes: '); readln(e.cant_doc);
    write('Ingrese cantidad de alumnos: '); readln(e.cant_alu);
    write('Ingrese localidad: '); readln(e.localidad);
    writeln();
end;

function propUNESCO(alu: integer; doc: integer): real;
begin
    propUNESCO := (alu/doc);
end;

var
    e: escuela;
    i, cant_LP, cue_min1, cue_min2: integer;
    proporcion, prop_min1, prop_min2: real;
    nom_min1, nom_min2: string;

begin
    cant_LP := 0;
    prop_min1 := 999999999;
    prop_min2 := 999999999;
    nom_min1 := '';
    nom_min2 := '';

    for i := 1 to TOTAL_ESCUELAS do
    begin 
        leer(e);
        proporcion := propUNESCO(e.cant_alu, e.cant_doc);

        if e.localidad = 'La Plata' then
        begin
            if proporcion > UNESCO_2015 then    
                cant_LP := cant_LP + 1;
            
            if proporcion < prop_min1 then
            begin
                prop_min2 := prop_min1;
                prop_min1 := proporcion;
                cue_min2 := cue_min1;
                cue_min1 := e.cue;
                nom_min2 := nom_min1;
                nom_min1 := e.nombre;
            end
            else 
            if proporcion < prop_min2 then
            begin
                prop_min2 := proporcion;
                cue_min2 := e.cue;
                nom_min2 := e.nombre;
            end;
        end; { if }
    end; { for }

    writeln('Cantidad de escuelas en LP peor que UNESCO: ', cant_LP);
    writeln('CUE de la mejor escuela: ', cue_min1, ' Nombre del establecimiento: ', nom_min1);
    writeln('Segunda mejor escuela: ', cue_min2, ' Nombre del establecimiento: ', nom_min2);
end.