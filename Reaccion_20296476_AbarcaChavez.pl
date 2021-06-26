% TDA Reaccion
% Composicion: [IdPR, IdR, FechaR, CuentaAutorR, TipoR, ContenidoR]
% CuentaDestinoP] -> [integer, integer, TDA Fecha, string, string,
% string] *SUJETO A CAMBIOS*

% Constructores
crearReaccion(IdPR, IdR, FechaR, CuentaCreadoraR, TipoR, ContenidoR, R) :- R = [IdPR, IdR, FechaR, CuentaCreadoraR, TipoR, ContenidoR].

% Selectores
getIdPR(R, IdPR) :-             [IdPR|_] = R.
getIdR(R, IdR) :-               [_|[IdR|_]] = R.
getFechaR(R, Fecha) :-          [_|[_|[Fecha|_]]] = R.
getCuentaR(R, Cuenta) :-        [_|[_|[_|[Cuenta]]]] = R.
getTipoR(R, TipoR) :-           [_|[_|[_|[_|[TipoR|_]]]]] = R.
getContenidoR(R, ContenidoR) :- [_|[_|[_|[_|[_|[ContenidoR|_]]]]]] = R.

% Pertenencia
esReaccion(R) :- not(esLista(R)), !, fail.
esReaccion(R) :- largo(R, L), L =\= 6, !, fail.
esReaccion(R) :- getIdPR(R, IdPR), getIdR(R, IdR), getFechaR(R, Fecha), getCuentaR(R, Cuenta), getTipoR(R, TipoR), getContenidoR(R, ContenidoR),
    integer(IdPR), integer(IdR), esFecha(Fecha), string(Cuenta), string(TipoR), string(ContenidoR).

% Modificadores

% Otros