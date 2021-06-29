%TDA ListaCuentas
% Composicion: [DatosCuenta1, DatosCuenta2, ..., DatosCuentaN]
%              -> [TDA CuentaUsuario, TDA CuentaUsuario, ..., TDA CuentaUsuario]

% Constructores
% En proceso...

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

% Pasar de TDA ListaCuentas a string
listaCuentasAString([], StringAux, StringLC) :- string_concat(StringAux, "\n\n", StringFinal), StringLC = StringFinal.
listaCuentasAString([LCH|LCT], StringAux, StringLC) :- cuentaAString(LCH, StringCuenta), string_concat(StringAux, StringCuenta, StringTemp), listaCuentasAString(LCT, StringTemp, StringLC).
