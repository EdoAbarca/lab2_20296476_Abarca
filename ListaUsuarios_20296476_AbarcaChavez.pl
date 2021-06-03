%TDA ListaUsuarios
% Composicion: [DatosUsuario1, DatosUsuario2, ..., DatosUsuarioN]
%              -> [TDA Usuario, TDA Usuario, ..., TDA Usuario]

% Constructores
% En proceso...

% Pertenencia
esListaCuentas([]).
esListaCuentas([CabezaLU|_]) :- not(esCuenta(CabezaLU)), !, fail.
esListaCuentas([_|RestoLU]) :- esListaCuentas(RestoLU).

% Selectores
% En proceso...

% Modificadores
% Agregar usuario
agregarUsuario(NuevoUsuario, LU, LUAct) :- concatenar([NuevoUsuario, LU, LUAct]).

% Otros
