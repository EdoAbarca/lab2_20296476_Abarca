%TDA ListaCuentas
% Composicion: [DatosCuenta1, DatosCuenta2, ..., DatosCuentaN]
%              -> [TDA CuentaUsuario, TDA CuentaUsuario, ..., TDA CuentaUsuario]

/*
%Dominio
LCH: TDA CuentaUsuario, elemento principal de LC
LCT: TDA ListaCuentas, resto de elementos en LC
Usuario: String, nombre de cuenta
Cuenta: TDA CuentaUsuario
LC: TDA ListaCuentas, coleccion de TDA CuentaUsuario
LCAct: TDA ListaCuentas, con nuevo TDA Cuenta agregado al inicio
CuentaAct: TDA CuentaUsuario, con lista seguidos | seguidores actualizado
UObj: String, nombre cuenta apuntada
UL: String, nombre cuenta logueada
Username: String, credencial de usuario cuenta para iniciar sesion
Password: String, credencial de contrasenia cuenta para iniciar sesion

%Predicados
esListaCuentas([]).
esListaCuentas([LCH|_])
esListaCuentas([_|LCT])
getCuentaXUsuario([], _, _)
getCuentaXUsuario([LCH|_], Usuario, Cuenta)
getCuentaXUsuario([_|LCT], Usuario, Cuenta)
agregarCuenta(Cuenta, LC, LCAct)
actualizarListaCuentas(LC, Cuenta, CuentaAct, LCAct)
estaUsuarioDisponible(_, []).
estaUsuarioDisponible(Cuenta, [LCH|_])
estaUsuarioDisponible(Cuenta, [_|LCT])
sePuedeSeguir(UObj, UL, LC)
validarCredenciales(_, _, []) :- !, fail.
validarCredenciales(Username, Password, [LCH|_])
validarCredenciales(Username, Password, [_|LCT])

%Metas
%Principales
esListaCuentas
agregarCuenta
actualizarListaCuentas
estaUsuarioDisponible
sePuedeSeguir
validarCredenciales

%Secundarias
getCuentaXUsuario

%Clausulas
%Hechos y reglas
*/

% Constructor
tdaLCVacio(LC) :- LC = [].

% Pertenencia
esListaCuentas([]).
esListaCuentas([LCH|_]) :- not(esCuentaUsuario(LCH)), !, fail.
esListaCuentas([_|LCT]) :- esListaCuentas(LCT).

% Selectores
getCuentaXUsuario([], _, _) :- !, fail.
getCuentaXUsuario([LCH|_], Usuario, Cuenta) :- getUsuarioC(LCH, UActual), UActual == Usuario, Cuenta = LCH.
getCuentaXUsuario([_|LCT], Usuario, Cuenta) :- getCuentaXUsuario(LCT, Usuario, Cuenta).

% Modificadores
% Agregar nueva cuenta
agregarCuenta(Cuenta, LC, LCAct) :- concatenar([Cuenta], LC, LCAct).

% Actualizar cuenta (principalmente por temas de seguidores/seguidos)
actualizarListaCuentas(LC, Cuenta, CuentaAct, LCAct) :- reemplazar(LC, Cuenta, CuentaAct, LCAct).

% Otros
% Verificar que el usuario no esté en uso
estaUsuarioDisponible(_, []).
estaUsuarioDisponible(Cuenta, [LCH|_]) :- getUsuarioC(Cuenta, NombreAUsar), getUsuarioC(LCH, NombreEnUso), NombreAUsar == NombreEnUso, !, fail.
estaUsuarioDisponible(Cuenta, [_|LCT]) :- estaUsuarioDisponible(Cuenta, LCT).

% Validador para revisar si es posible seguir a usuario
sePuedeSeguir(UObj, UL, LC) :- getCuentaXUsuario(LC, UObj, Cuenta), getSeguidoresC(Cuenta, ListaSeguidores), not(estaEnSeguidores(UL, ListaSeguidores)).

% Validar credenciales ingresadas para iniciar sesion
validarCredenciales(_, _, []) :- !, fail.
validarCredenciales(Username, Password, [LCH|_]) :- getUsuarioC(LCH, NombreUsuario), getConstraseniaC(LCH, Contrasenia), Username == NombreUsuario, Password == Contrasenia.
validarCredenciales(Username, Password, [_|LCT]) :- validarCredenciales(Username, Password, LCT).

% Verificador que revisa si los usuarios ingresados como destinatarios estan en los contactos del usuario logueado
validarDestinos([], _, _).
validarDestinos([DestActual|_], UL, LC) :- getCuentaXUsuario(LC, UL, CuentaUL), getSeguidosC(CuentaUL, SeguidosUL), not(estaEnSeguidos(DestActual, SeguidosUL)), !, fail.
validarDestinos([_|RestoDestinos], UL, LC) :- validarDestinos(RestoDestinos, UL, LC).
