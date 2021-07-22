%TDA CuentaUsuario
% Composicion: [NombreUsuario, Contrasenia, FechaRegistroC, ListaSeguidos, ListaSeguidores] 
%            -> [string, string, TDA Fecha, list, list]

/*
%Dominio
NombreUsuario: String, credencial que llevara el nombre de la cuenta
Contrasenia: String, credencial que llevara la cadena de texto que protege la cuenta
FechaRegistroC: TDA Fecha, fecha de registro cuenta
Cuenta: TDA Cuenta, materializacion de TDA Cuenta
ListaSeguidos: Lista, contactos de la cuenta
ListaSeguidores: Lista, cuentas que tienen en sus contactos a esta cuenta
NuevoSeguidor: String, nombre de cuenta que agrego a sus contactos a cuenta actual
ListaSeguidoresAct: Lista, con el nuevo seguidor agregado al inicio
NuevoSeguimiento: String, nombre cuenta que se acaba de agregar a los contactos
ListaSeguidosAct: Lista, contactos de la cuenta con NuevoSeguido agregado al inicio
CuentaAct: TDA Cuenta, con la lista de seguidores | seguidos actualizada
UsuarioC1: String, nombre cuenta a encontrar
SeguidosC2: Lista, contactos de la cuenta que pretende seguir
SeguidoresC2: Lista, seguidores de la cuenta que se pretende seguir
SeguidoActual: String, nombre cuenta al inicio de la lista de seguidos
RestoSeguidos: Lista, resto de la lista de seguidos
SeguidorActual: String, nombre cuenta al inicio de la lista de seguidores
RestoSeguidores: Lista, resto de la lista de seguidores
StringAux: String, string de apoyo que recibira todos los substrings
StringListaSeguidos: String, conversion de todos los seguidos en un string
StringListaSeguidores: String, conversion de todos los seguidores en un string
StringCuenta: String, conversion de toda la informacion relativa al TDA CuentaUsuario en un string

%Predicados
crearCuentaUsuario(NombreUsuario, Contrasenia, FechaRegistroC, Cuenta)
getUsuarioC(Cuenta, NombreUsuario)
getConstraseniaC(Cuenta, Contrasenia) 
getFechaC(Cuenta, FechaRegistroC) 
getSeguidosC(Cuenta, ListaSeguidos) 
getSeguidoresC(Cuenta, ListaSeguidores)
esCuentaUsuario(Cuenta)
agregarSeguidor(NuevoSeguidor, ListaSeguidores, ListaSeguidoresAct)
agregarSeguimiento(NuevoSeguimiento, ListaSeguidos, ListaSeguidosAct)
actualizarSeguidosCuenta(Cuenta, ListaSeguidos, ListaSeguidosAct, CuentaAct)
actualizarSeguidoresCuenta(Cuenta, ListaSeguidores, ListaSeguidoresAct, CuentaAct)
estaEnSeguidores(UsuarioC1, [UsuarioC1|_])
estaEnSeguidores(UsuarioC1, [_|SeguidoresC2])
estaEnSeguidos(UsuarioC1, [UsuarioC1|_])
estaEnSeguidos(UsuarioC1, [_|SeguidosC2]) 
seguidosCAString([SeguidoActual|RestoSeguidos], StringAux, StringListaSeguidos)
seguidoresCAString([SeguidorActual|RestoSeguidores], StringAux, StringListaSeguidores)
cuentaAString(Cuenta, StringCuenta)

%Metas
%Principales
crearCuentaUsuario
esCuentaUsuario
agregarSeguidor
agregarSeguimiento
actualizarSeguidosCuenta
actualizarSeguidoresCuenta
esContactos
cuentaAString


%Secundarias
getUsuarioC
getConstraseniaC
getFechaC
getSeguidosC
getSeguidoresC
estaEnSeguidores
estaEnSeguidos
seguidosCAString
seguidoresCAString

%Clausulas
%Hechos y reglas
*/

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
actualizarSeguidosCuenta(Cuenta, ListaSeguidosAct, CuentaAct) :- getUsuarioC(Cuenta, NombreUsuario), getConstraseniaC(Cuenta, Contrasenia), getFechaC(Cuenta, FechaRegistroC), getSeguidoresC(Cuenta, ListaSeguidores), 
                                                                CuentaAct = [NombreUsuario, Contrasenia, FechaRegistroC, ListaSeguidosAct, ListaSeguidores].

% Actualizar seguidores cuenta
actualizarSeguidoresCuenta(Cuenta, ListaSeguidoresAct, CuentaAct) :- getUsuarioC(Cuenta, NombreUsuario), getConstraseniaC(Cuenta, Contrasenia), getFechaC(Cuenta, FechaRegistroC), getSeguidosC(Cuenta, ListaSeguidos), 
                                                                CuentaAct = [NombreUsuario, Contrasenia, FechaRegistroC, ListaSeguidos, ListaSeguidoresAct].

% Otros
% Validador de usuario en lista seguidores
estaEnSeguidores(UsuarioC1, [UsuarioC1|_]).
estaEnSeguidores(UsuarioC1, [_|SeguidoresC2]) :- estaEnSeguidores(UsuarioC1, SeguidoresC2).

% Validador de usuario en lista seguidos
estaEnSeguidos(UsuarioC1, [UsuarioC1|_]).
estaEnSeguidos(UsuarioC1, [_|SeguidosC2]) :- estaEnSeguidos(UsuarioC1, SeguidosC2).

% Conversor de lista seguidos a string
seguidosCAString([], StringAux, StringListaSeguidos) :- StringListaSeguidos = StringAux.
seguidosCAString([SeguidoActual|RestoSeguidos], StringAux, StringListaSeguidos) :- string_concat(SeguidoActual, "\n", SeguidoActualFinal), string_concat(StringAux, SeguidoActualFinal, StringTemp), seguidosCAString(RestoSeguidos, StringTemp, StringListaSeguidos).

% Conversor de lista seguidores a string
seguidoresCAString([], StringAux, StringListaSeguidores) :- StringListaSeguidores = StringAux.
seguidoresCAString([SeguidorActual|RestoSeguidores], StringAux, StringListaSeguidores) :- string_concat(SeguidorActual, "\n", SeguidorActualFinal), string_concat(StringAux, SeguidorActualFinal, StringTemp), seguidoresCAString(RestoSeguidores, StringTemp, StringListaSeguidores).

% Conversor de TDA CuentaUsuario a string
cuentaAString(Cuenta, StringCuenta) :- getUsuarioC(Cuenta, NombreUsuario), getFechaC(Cuenta, FechaRegistroC), getSeguidoresC(Cuenta, Seguidores), getSeguidosC(Cuenta, Seguidos),
        string_concat("\nUsuario cuenta: ", NombreUsuario, StringUsuario), fechaAString(FechaRegistroC, StringFechaTemp), string_concat(" | Fecha registro: ", StringFechaTemp, StringFecha),
        seguidoresCAString(Seguidores, "", StringSeguidoresTemp), string_concat("\n\nSeguidores:\n", StringSeguidoresTemp, StringSeguidores),
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
