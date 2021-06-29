%TDA CuentaUsuario
% Composicion: [NombreUsuario, Contrasenia, FechaRegistroC, ListaSeguidos, ListaSeguidores] 
%            -> [string, string, TDA Fecha, list, list]

% Constructores
crearCuentaUsuario(NombreUsuario, Contrasenia, FechaRegistroC, Cuenta) :- Cuenta = [NombreUsuario, Contrasenia, FechaRegistroC, [], []].

% Selectores
getUsuarioC(Cuenta, NombreUsuario) :-        [NombreUsuario|_] = Cuenta.
getConstraseniaC(Cuenta, Contrasenia) :-     [_|[Contrasenia|_]] = Cuenta.
getFechaC(Cuenta, FechaRegistroC) :-         [_|[_|[FechaRegistroC|_]]] = Cuenta.
getSeguidosC(Cuenta, ListaSeguidos) :-       [_|[_|[_|[ListaSeguidos|_]]]] = Cuenta.
getSeguidoresC(Cuenta, ListaSeguidores) :-   [_|[_|[_|[_|[ListaSeguidores|_]]]]] = Cuenta.

% Pertenencia
esCuentaUsuario(Cuenta) :- not(esLista(Cuenta)), !, fail.
esCuentaUsuario(Cuenta) :- largo(Cuenta, L), L =\= 5, !, fail.
esCuentaUsuario(Cuenta) :- getUsuarioC(Cuenta, NombreUsuario), getConstraseniaC(Cuenta, Contrasenia), getFechaC(Cuenta, Fecha), getSeguidosC(Cuenta, ListaSeguidos), getSeguidoresC(Cuenta, ListaSeguidores),
    string(NombreUsuario), string(Contrasenia), esFecha(Fecha), esLista(ListaSeguidos), esLista(ListaSeguidores).

% Modificadores
% Agregar seguidor
agregarSeguidor(NuevoSeguidor, ListaSeguidores, ListaSeguidoresAct) :- concatenar([NuevoSeguidor], ListaSeguidores, ListaSeguidoresAct).

% Agregar seguimiento
agregarSeguimiento(NuevoSeguimiento, ListaSeguidos, ListaSeguidosAct) :- concatenar([NuevoSeguimiento], ListaSeguidos, ListaSeguidosAct).

% Actualizar seguidos cuenta
actualizarSeguidosCuenta(Cuenta, ListaSeguidos, ListaSeguidosAct, CuentaAct) :- reemplazar(Cuenta, ListaSeguidos, ListaSeguidosAct, CuentaAct).

% Actualizar seguidores cuenta
actualizarSeguidoresCuenta(Cuenta, ListaSeguidores, ListaSeguidoresAct, CuentaAct) :- reemplazar(Cuenta, ListaSeguidores, ListaSeguidoresAct, CuentaAct).

% Otros
% Validador de usuario en lista seguidos
estaEnSeguidores(UsuarioC1, [UsuarioC1|_]).
estaEnSeguidores(UsuarioC1, [_|SeguidoresC2]) :- estaEnSeguidores(UsuarioC1, SeguidoresC2).

% Validador de usuario en lista seguidores
estaEnSeguidos(UsuarioC1, [UsuarioC1|_]).
estaEnSeguidos(UsuarioC1, [_|SeguidosC2]) :- estaEnSeguidos(UsuarioC1, SeguidosC2).

% Validador que verifica si ambas cuentas se tienen en contactos
% Se asumira que para ser contacto, el usuario apuntado debe ser seguido por el usuario logueado
esContactos(UsuarioC1, UsuarioC2, SeguidosC1, SeguidosC2) :- estaEnSeguidos(UsuarioC1, SeguidosC2), estaEnSeguidos(UsuarioC2, SeguidosC1).

%Conversor de lista seguidos a string
seguidosCAString([], StringAux, StringListaSeguidos) :- StringListaSeguidos = StringAux.
seguidosCAString([SeguidoActual|RestoSeguidos], StringAux, StringListaSeguidos) :- string_concat(SeguidoActual, "\n", SeguidoActualFinal), string_concat(StringAux, SeguidoActualFinal, StringTemp), seguidosCAString(RestoSeguidos, StringTemp, StringListaSeguidos).

%Conversor de lista seguidores a string
seguidoresCAString([], StringAux, StringListaSeguidores) :- StringListaSeguidores = StringAux.
seguidoresCAString([SeguidorActual|RestoSeguidores], StringAux, StringListaSeguidores) :- string_concat(SeguidorActual, "\n", SeguidorActualFinal), string_concat(StringAux, SeguidorActualFinal, StringTemp), seguidoresCAString(RestoSeguidores, StringTemp, StringListaSeguidores).

%Conversor de TDA CuentaUsuario a string
cuentaAString(Cuenta, StringCuenta) :- getUsuarioC(Cuenta, NombreUsuario), getFechaC(Cuenta, FechaRegistroC), getSeguidoresC(Cuenta, Seguidores), getSeguidosC(Cuenta, Seguidos),
        string_concat("\nUsuario cuenta: ", NombreUsuario, StringUsuario), fechaAString(FechaRegistroC, StringFechaTemp), string_concat(" | Fecha registro: ", StringFechaTemp, StringFecha),
        seguidoresCAString(Seguidores, "", StringSeguidoresTemp), string_concat("\nSeguidores:\n", StringSeguidoresTemp, StringSeguidores),
        seguidosCAString(Seguidos, "", StringSeguidosTemp), string_concat("\nSeguidos:\n", StringSeguidosTemp, StringSeguidos),
        string_concat(StringUsuario, StringFecha, Parte1String), string_concat(StringSeguidores, StringSeguidos, Parte2String),
        string_concat(Parte1String, Parte2String, StringFinal), StringCuenta = StringFinal.

/*
DETALLE RESPECTO A ESTE TDA Y EL TDA LISTACUENTAS:
Originalmente, este TDA estaba dividido en 2 (Usuario y Cuenta).
¿Por qué se fusionaron?
Para reducir procesamiento y hacer mas legible la implementacion. 
A la hora de convertir a string, se omitira la muestra de contrasenia de cada cuenta.
*/