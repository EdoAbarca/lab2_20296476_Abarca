% TDA Publicacion
% Composicion: [IdP, FechaP, CuentaCreadoraP, ContenidoP,
% ListaCompartidos] -> [integer, TDA Fecha, string,
% string, list] *SUJETO A CAMBIOS*

% Constructores
crearPublicacion(IdP, FechaP, CuentaCreadoraP, ContenidoP, ListaCompartidos, P) :- P = [IdP, FechaP, CuentaCreadoraP, ContenidoP, ListaCompartidos].

% Selectores
getIdP(P, Id) :- [Id|_] = P.
getFechaP(P, F) :- [_|[F|_]] = P.
getCuentaP(P, C) :- [_|[_|[C|_]]] = P.
getContenidoP(P, Cont) :- [_|[_|[_|[Cont|_]]]] = P.
getCompartidosP(P, Comp) :- [_|[_|[_|[_|[Comp|_]]]]] = P.

% Pertenencia
esPublicacion(P) :- not(esLista(P)), !, fail.
esPublicacion(P) :- largo(P, L), L \== 5, !, fail.
esPublicacion(P) :- getIdP(P, Id), getFechaP(P, F), getCuentaP(P, C), getContenidoP(P, Cont), getCompartidosP(P, Comp),
    integer(Id), esFecha(F), string(C), string(Cont), esLista(Comp).

% Modificadores
% Otros
