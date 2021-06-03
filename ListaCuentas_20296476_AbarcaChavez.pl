%TDA ListaCuentas
% Composicion: [DatosCuenta1, DatosCuenta2, ..., DatosCuentaN]
%              -> [TDA Cuenta, TDA Cuenta, ..., TDA Cuenta]

% Constructores
% En proceso...

% Pertenencia
esListaCuentas([]).
esListaCuentas([CabezaLC|_]) :- not(esCuenta(CabezaLC)), !, fail.
esListaCuentas([_|RestoLC]) :- esListaCuentas(RestoLC).

% Selectores
% En proceso...

% Modificadores
% Agregar nueva cuenta
agregarCuenta(ListaCuentas, NuevaCuenta, ListaCuentasAct) :- concatenar([NuevaCuenta], ListaCuentas, ListaCuentasAct).

% Modificar cuenta (principalmente por temas de seguidores/seguidos)
% En proceso...

% Otros
% En proceso...
