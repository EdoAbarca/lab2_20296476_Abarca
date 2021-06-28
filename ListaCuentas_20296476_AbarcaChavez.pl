%TDA ListaCuentas
% Composicion: [DatosCuenta1, DatosCuenta2, ..., DatosCuentaN]
%              -> [TDA Cuenta, TDA Cuenta, ..., TDA Cuenta]

% Constructores
% En proceso...

% Pertenencia
esListaCuentas([]).
esListaCuentas([CabezaLC|_]) :- not(esCuentaUsuario(CabezaLC)), !, fail.
esListaCuentas([_|RestoLC]) :- esListaCuentas(RestoLC).

% Selectores
getCuentaXUsuario([], _, _) :- !, fail.
getCuentaXUsuario([LCH|_], Usuario, Cuenta) :- getUsuarioC(LCH, UActual), UActual == Usuario, Cuenta = LCH.
getCuentaXUsuario([_|LCT], Usuario, Cuenta) :- getCuentaXUsuario(LCT, Usuario, Cuenta).

% Modificadores
% Agregar nueva cuenta
agregarCuenta(ListaCuentas, NuevaCuenta, ListaCuentasAct) :- concatenar([NuevaCuenta], ListaCuentas, ListaCuentasAct).

% Actualizar cuenta (principalmente por temas de seguidores/seguidos)
actualizarListaCuentas(ListaCuentas, CuentaOr, CuentaAct, ListaCuentasAct) :- reemplazar(ListaCuentas, CuentaOr, CuentaAct, ListaCuentasAct).

% Otros
% Verificar que el usuario no esté en uso
estaUsuarioDisponible(_, []).
estaUsuarioDisponible(U, [HLU|_]) :- getUsuarioC(U, NombreAUsar), getUsuarioC(HLU, NombreEnUso), NombreAUsar == NombreEnUso, !, fail.
estaUsuarioDisponible(U, [_|ALU]) :- estaUsuarioDisponible(U, ALU).

%Validar credenciales ingresadas para iniciar sesion
validarCredenciales(_, _, []) :- !, fail.
validarCredenciales(User, Pass, [HLU|_]) :- getUsuarioC(HLU, Usuario), getConstraseniaC(HLU, Contra), User == Usuario, Pass == Contra.
validarCredenciales(User, Pass, [_|ALU]) :- validarCredenciales(User, Pass, ALU).

%Verificador que revisa si los usuarios ingresados como destinatarios estan en los contactos del usuario logueado
validarDestinos([], _, _).
validarDestinos([DestActual|_], UL, LC) :- getCuentaXUsuario(LC, UL, CuentaUL), getSeguidosC(CuentaUL, SeguidosUL), not(estaEnSeguidos(DestActual, SeguidosUL)), !, fail.
validarDestinos([_|RestoDestinos], UL, LC) :- validarDestinos(RestoDestinos, UL, LC).
