%TDA Cuenta
% Composicion: [UsuarioCuenta, FechaRegistroC, ListaSeguidos,
% ListaSeguidores] -> [string, TDA Fecha, list, list] *SUJETO A
% CAMBIOS, SE EVALUA CREAR TDA CONTACTOS*

% Constructores
crearCuenta(UsuarioCuenta, FechaRegistro, Cuenta) :- Cuenta = [UsuarioCuenta, FechaRegistro, [], []].

% Selectores
getUsuarioC(C, Us) :- [Us|_] = C.
getFechaC(C, Fecha) :- [_|[Fecha|_]] = C.
getSeguidosC(C, Seguidos) :- [_|[_|[Seguidos|_]]] = C.
getSeguidoresC(C, Seguidores) :- [_|[_|[_|[Seguidores|_]]]] = C.

% Pertenencia
esCuenta(C) :- not(esLista(C)), !, fail.
esCuenta(C) :- largo(C, L), L \== 4, !, fail.
esCuenta(C) :- getUsuarioC(C, Us), getFechaC(C, Fecha), getSeguidosC(C, Seguidos), getSeguidoresC(C, Seguidores),
    string(Us), esFecha(Fecha), esLista(Seguidos), esLista(Seguidores).

% Modificadores
% Agregar seguidor
% Agregar seguimiento

% Otros
% Validador que verifica que el usuario esta en la lista de contactos
% (de momento, se entiende que tal usuario debe seguirme (debo
% seguirlo yo a el?))
