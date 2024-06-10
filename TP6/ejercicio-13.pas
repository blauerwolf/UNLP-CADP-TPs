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
uses crt, sysutils;
type

  roles = array[1..4] of string;

  contadorRoles = array[1..4] of integer;

  usuario = record 
    email: string;
    rol: integer;
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

procedure inicializarRoles(var r: roles);
begin 
  r[1] := 'Editor';
  r[2] := 'Autor';
  r[3] := 'Revisor';
  r[4] := 'Lector';
end;

procedure inicializarContadorRoles(var r:contadorRoles);
var i: integer;
begin 
  for i := 1 to 4 do 
    r[i] := 0;
end;

procedure leerUsuario(var u: usuario; r: roles);
begin 
  write('email: ');
  readln(u.email);

  if (u.email <> '') then 
  begin 
    write('Rol: ');
    readln(u.rol);
    gotoXY(6 + length(IntToStr(u.rol)) + 1, WhereY - 1);
    writeln('(', r[u.rol], ')');

    write('Revista: ');
    readln(u.revista);
    write('Días desde el último acceso: ');
    readln(u.ultimoAcceso);
  end;

  writeln();
end;



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

    while (actual <> nil) and (actual^.usr.ultimoAcceso < nuevo^.usr.ultimoAcceso) do 
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

procedure cargarUsuarios(var l: lista; r: roles);
var 
  u: usuario;
begin 
  leerUsuario(u, r);

  while (u.email <> '') do 
  begin 
    insertarOrdenado(l, u);

    leerUsuario(u, r);
  end;
end;

procedure imprimirLista(l:lista; reducido: boolean);
begin 
  while (l <> nil) do 
  begin 
    writeln('email:'#9, l^.usr.email);

    if (not reducido) then 
    begin 
      writeln('Rol:'#9, l^.usr.rol);
      writeln('Revista:'#9, l^.usr.revista);
    end;
    writeln('Días desde el último acceso'#9, l^.usr.ultimoAcceso);
    writeln();

    l := l^.sig;
  end;
end;

procedure actualizarContadorRoles(var r: contadorRoles; rol: integer);
begin
  if (rol >= 1) and (rol <= 4) then 
    r[rol] := r[rol] + 1;
end;

procedure cargarListaEconomica(l: lista; var le: lista);
 

begin
  while (l <> nil) do 
  begin
    if (l^.usr.revista = 'Económica') then 
      insertarOrdenado(le, l^.usr);

    l := l^.sig;
  end;
end;


procedure procesar(l: lista; r: roles);
var 
  cr: contadorRoles;
  i, t1, t2: integer;
  e1, e2: string;
begin

  t1 := 0;
  t2 := 0;

  e1 := '';
  e2 := '';

  inicializarContadorRoles(cr);

  while (l <> nil) do 
  begin 
    actualizarContadorRoles(cr, l^.usr.rol);

    if (l^.usr.ultimoAcceso > t1) then 
    begin 
      t2 := t1;
      t1 := l^.usr.ultimoAcceso;
      e2 := e1;
      e1 := l^.usr.email;
    end 
    else begin 
      t2 := l^.usr.ultimoAcceso;
      e2 := l^.usr.email;
    end;


    l := l^.sig;
  end;


  { Cantidad de usuarios por cada rol }
  writeln('Cantidad de usuarios por cada rol');
  writeln('=================================');
  for i := 1 to 4 do 
  begin 
    writeln(r[i], ':'#9, cr[i], ' usuarios');
  end;

  writeln();
  writeln('Usuarios que hace más tiempo que no ingresan al portal: ');
  writeln('========================================================');
  writeln(' - ',e1);
  writeln(' - ',e2);
  writeln();

end;



var
  r: roles;
  l, le: lista;
begin
  inicializarRoles(r);
  inicializarLista(l);

  writeln('Carga de usuarios:');
  writeln('==================');
  cargarUsuarios(l, r);

  imprimirLista(l, false);

  { Creo la lista para la revista económica, inserto ordenado por día }
  inicializarLista(le);
  cargarListaEconomica(l, le);
  writeln('Usuarios de la revista económica');
  writeln('================================');
  imprimirLista(le, true);

  procesar(l, r);
end.