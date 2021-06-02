%TDA Usuario
%Composicion: [NombreUsuario, Contrasenia] -> [string, string]
%TDA que unicamente funciona como credenciales de cuentas

% Constructores
crearUsuario(Usuario, Pass, U) :- U = [Usuario, Pass].

% Selectores
obtenerNombreU(U, NombreU) :- [NombreU|_] = U.
obtenerPassU(U, PassU) :- [_|[PassU|_]] = U.

% Pertenencia
esUsuario(U) :- not(esLista(U)), !, fail. %En OperacionesListas
esUsuario(U) :- largo(U, L), L \== 2, !, fail. %En OperacionesListas
esUsuario(U) :- obtenerNombreU(U, NombreU), obtenerPassU(U, PassU), string(NombreU), string(PassU).

% Modificadores
% Otros
