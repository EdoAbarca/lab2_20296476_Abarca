%TDA CuentaUsuario
% Composicion: [NombreUsuario, Contrasenia, FechaRegistroC, ListaSeguidos, ListaSeguidores] 
%            -> [string, string, TDA Fecha, list, list] 
%*SUJETO A CAMBIOS, SE EVALUA CREAR TDA CONTACTOS*

% Constructores
crearCuentaUsuario(NombreUsuario, Contrasenia, FechaRegistro, Cuenta) :- Cuenta = [NombreUsuario, Contrasenia, FechaRegistro, [], []].

% Selectores
getUsuarioC(C, Us) :- [Us|_] = C.
getConstraseniaC(C, Pass) :- [_|[Pass|_]] = C.
getFechaC(C, Fecha) :- [_|[_|[Fecha|_]]] = C.
getSeguidosC(C, Seguidos) :- [_|[_|[_|[Seguidos|_]]]] = C.
getSeguidoresC(C, Seguidores) :- [_|[_|[_|[_|[Seguidores|_]]]]] = C.

% Pertenencia
esCuentaUsuario(C) :- not(esLista(C)), !, fail.
esCuentaUsuario(C) :- largo(C, L), L =\= 5, !, fail.
esCuentaUsuario(C) :- getUsuarioC(C, Us), getConstraseniaC(C, Pass), getFechaC(C, Fecha), getSeguidosC(C, Seguidos), getSeguidoresC(C, Seguidores),
    string(Us), string(Pass), esFecha(Fecha), esLista(Seguidos), esLista(Seguidores).

% Modificadores
% Agregar seguidor
agregarSeguidor(SeguidosOr, NuevoSeguidor, SeguidosAct) :- concatenar([NuevoSeguidor], SeguidosOr, SeguidosAct).

% Agregar seguimiento
agregarSeguimiento(SeguidoresOr, NuevoSeguimiento, SeguidoresAct) :- concatenar([NuevoSeguimiento], SeguidoresOr, SeguidoresAct).

%Actualizar seguidos cuenta
actualizarSeguidosCuenta(C, SeguidosOr, SeguidosAct, Cout) :- reemplazar(C, SeguidosOr, SeguidosAct, Cout).

%Actualizar seguidores cuenta
actualizarSeguidoresCuenta(C, SeguidoresOr, SeguidoresAct, Cout) :- reemplazar(C, SeguidoresOr, SeguidoresAct, Cout).

% Otros
% Validador de usuario en lista seguidos
estaEnSeguidores(UsuarioC1, [UsuarioC1|_]).
estaEnSeguidores(UsuarioC1, [_|SeguidoresC2]) :- estaEnSeguidores(UsuarioC1, SeguidoresC2).

% Validador de usuario en lista seguidores
estaEnSeguidos(UsuarioC1, [UsuarioC1|_]).
estaEnSeguidos(UsuarioC1, [_|SeguidosC2]) :- estaEnSeguidos(UsuarioC1, SeguidosC2).

% Validador para revisar si es posible seguir a usuario
sePuedeSeguir(UObj, UL, LC) :- getCuentaXUsuario(UObj, CObj), getSeguidoresC(CObj, SeguidoresObj) ,not(estaEnSeguidores(UL, SeguidoresObj)).

% Validador que verifica si ambas cuentas se tienen en contactos
% Se asumira que para ser contacto, el usuario apuntado debe ser seguido por el usuario logueado
esContactos(UsuarioC1, UsuarioC2, SeguidosC1, SeguidosC2) :- estaEnSeguidos(UsuarioC1, SeguidosC2), estaEnSeguidos(UsuarioC2, SeguidosC1).

/*
DETALLE RESPECTO A ESTE TDA Y EL TDA LISTACUENTAS:
Originalmente, este TDA estaba dividido en 2 (Usuario y Cuenta).
¿Por qué se fusionaron?
Para reducir el procesamiento y hacer mas legible la implementacion. 
A la hora de convertir a string, se omitira la muestra de contrasenia de cada cuenta.

¿Es necesario agregar la fecha de cada seguido/seguidor? (No se puede pasar por parametro, pero se puede generar internamente)
Temporalmente, se decide que NO es necesario.
*/