% TDA Publicacion
% Composicion: [IdP, IdOriginalP, FechaP, CuentaAutorP, TipoP, ContenidoP, MuroP, CompartidoP] 
%                -> [integer, integer, TDA Fecha, string, string, string, string, list] 
%                *SUJETO A CAMBIOS, CONSIDERAR REACCIONES A FUTURO*

% Constructores
crearPublicacion(IdP, FechaP, CuentaAutorP, ContenidoP, MuroP, P) :- P = [IdP, IdP, FechaP, CuentaAutorP, "Texto", ContenidoP, MuroP, []].
crearPublicacionCompartida(IdP, IdOriginalP, FechaP, CuentaAutorP, ContenidoP, MuroP, CompartidoP, P) :- P = [IdP, IdOriginalP,  FechaP, CuentaAutorP, "Texto", ContenidoP, MuroP, CompartidoP].

% Selectores
getIdP(P, Id) :-                [Id|_] = P.
getIdOriginalP(P, IdOP) :-      [_|[IdOP|_]] = P.
getFechaP(P, Fecha) :-          [_|[_|[Fecha|_]]] = P.
getCuentaAutorP(P, Cuenta) :-   [_|[_|[_|[Cuenta|_]]]] = P.
getTipoP(P, Tipo) :-            [_|[_|[_|[_|[Tipo|_]]]]] = P.
getContenidoP(P, Cont) :-       [_|[_|[_|[_|[_|[Cont|_]]]]]] = P.
getMuroP(P, Muro) :-            [_|[_|[_|[_|[_|[_|[Muro|_]]]]]]] = P.
getCompartidoP(P, Comp) :-      [_|[_|[_|[_|[_|[_|[_|[Comp|_]]]]]]]] = P.

% Pertenencia
esPublicacion(P) :- not(esLista(P)), !, fail.
esPublicacion(P) :- largo(P, L), L \== 8, !, fail.
esPublicacion(P) :- getIdP(P, Id), getIdOriginalP(P, IdOP), getFechaP(P, Fecha), getCuentaAutorP(P, Cuenta), getTipoP(P, Tipo), getContenidoP(P, Cont), getMuroP(P, Muro), getCompartidoP(P, Comp),
                    integer(Id), integer(IdOP), esFecha(Fecha), string(Cuenta), string(Tipo), string(Cont), string(Muro), esLista(Comp).

% Modificadores

% Otros
compartirPublicacion(P, Id, CompP, Pout) :- getIdOriginalP(P, IdOP), getFechaP(P, Fecha), getCuentaAutorP(P, Cuenta), getContenidoP(P, Cont), getMuroP(P, Muro),
                                    crearPublicacionCompartida(Id, IdOP, Fecha, Cuenta, Cont, Muro, CompP, PComp), Pout = PComp.