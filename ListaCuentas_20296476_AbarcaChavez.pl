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
% En proceso...

% Modificadores
% Agregar nueva cuenta
agregarCuenta(ListaCuentas, NuevaCuenta, ListaCuentasAct) :- concatenar([NuevaCuenta], ListaCuentas, ListaCuentasAct).

% Modificar cuenta (principalmente por temas de seguidores/seguidos)
% En proceso...

% Otros
% Verificar que el usuario no esté en uso
estaUsuarioDisponible(_, []).
estaUsuarioDisponible(U, [HLU|_]) :- getUsuarioC(U, NombreAUsar), getUsuarioC(HLU, NombreEnUso), NombreAUsar == NombreEnUso, !, fail.
estaUsuarioDisponible(U, [_|ALU]) :- estaUsuarioDisponible(U, ALU).

%Validar credenciales ingresadas para iniciar sesion
validarCredenciales(_, _, []) :- !, fail.
validarCredenciales(User, Pass, [HLU|_]) :- getUsuarioC(HLU, Usuario), getConstraseniaC(HLU, Contra), User == Usuario, Pass == Contra.
validarCredenciales(User, Pass, [_|ALU]) :- validarCredenciales(User, Pass, ALU).