{
  El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte
  de los usuarios. Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal. De
  cada usuario se conoce su email, su rol (1: Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que
  participa y cantidad de días desde el último acceso.
  a. Imprimir el nombre de usuario y la cantidad de días desde el último acceso de todos los usuarios
  de la revista Económica. El listado debe ordenarse a partir de la cantidad de días desde el último
  acceso (orden ascendente).
  b. Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
  c. Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.
}

program ejercicio_13;

type
  usuario = record 
    email: string;
    rol: roles;
    revista: string;
    ultimoAcceso: integer;
  end;

  lista = ^nodo;

  nodo = record 
    usr: usuario;
    sig: lista;
  end;

procedure inicializarLista(var l: lista);
begin 
  l := nil;
end;

procedure leerUsuario(var u: usuario);
begin 
  write('email: ');
  readln(u.email);

  if (u.email <> '') then 
  begin 
    write('Rol: ');
    readln(u.rol);
    write('Revista: ');
    readln(u.revista);
    write('Días desde el último acceso: ');
    readln(u.ultimoAcceso);
    writeln();
  end;
end;


{ Inserta un dispositivo ordenado por versión de android }
procedure insertarOrdenado(var l: lista; u: usuario);
var 
  actual, anterior, nuevo: lista;

begin 
  new(nuevo);
  nuevo^.usr := u;
  nuevo^.sig := nil;

  if (l = nil) then 
    l := nuevo
  else begin 
    anterior := l;
    actual := l;

    while (actual <> nil) and (actual^.disp.androidVersion < nuevo^.disp.androidVersion) do 
    begin 
      anterior := actual;
      actual := actual^.sig;
    end;

    if (actual = l) then 
    begin 
      nuevo^.sig := l;
      l := nuevo;
    end 
    else begin 
      anterior^.sig := nuevo;
      nuevo^.sig := actual;
    end;
  end;
end;



var

begin
end.