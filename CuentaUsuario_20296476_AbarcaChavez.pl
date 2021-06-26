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
% Agregar seguimiento

% Otros
% Validador que verifica si el usuario esta en la lista de contactos
% (de momento, se entiende que tal usuario debe seguirme (¿Debo seguirlo yo a el?))

/*
DETALLE RESPECTO A ESTE TDA Y EL TDA LISTACUENTAS:
Originalmente, este TDA estaba dividido en 2 (Usuario y Cuenta).
¿Por qué se fusionaron?
Para reducir el procesamiento y hacer mas legible la implementacion. 
A la hora de convertir a string, se omitirá la contrasenia de cada cuenta.

¿Es necesario agregar la fecha de cada seguido/seguidor? (No se puede pasar por parametro, pero se puede generar internamente)
Temporalmente, se decide que NO es necesario.
*/