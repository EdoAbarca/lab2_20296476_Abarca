% TDA Publicacion
% Composicion: [IdP, IdOriginalP, FechaP, TipoP, ContenidoP, AutorP, MuroP, ComparteP, RecibeP] 
%                -> [integer, integer, TDA Fecha, string, string, string, string, string, string] 

% Constructores
%Publicacion original
crearPublicacion(IdP, FechaP, ContenidoP, AutorP, MuroP, P) :- P = [IdP, IdP, FechaP, "Texto", ContenidoP, AutorP, MuroP, "", ""].

%Publicacion compartida
crearPublicacionCompartida(IdP, IdOriginalP, FechaP, ContenidoP, AutorP, MuroP, ComparteP, RecibeP, PComp) :- PComp = [IdP, IdOriginalP, FechaP, "Texto", ContenidoP, AutorP, MuroP, ComparteP, RecibeP].

/*
Para la publicacion compartida, lo que va a variar respecto a una publicacion original es:
 - IdOriginalP -> Guardara el Id por correlativo de la publicacion original
 - ComparteP -> Guardara el usuario de la cuenta que compartio la publicacion (Usuario logueado)
 - RecibeP -> Guardara el usuario que recibe la publicacion compartida (Usuario en contactos del usuario logueado).
              Se usara como referencia al muro del usuario a la hora de generar el string.
*/

% Selectores
getIdP(P, Id) :-            [Id|_] = P. %Id actual por correlativo
getIdOriginalP(P, IdOP) :-  [_|[IdOP|_]] = P. %Id publicacion original (Si Id == IdOP, esta es una publicacion original, a diferencia de una compartida, donde Id != IdOP)
getFechaP(P, Fecha) :-      [_|[_|[Fecha|_]]] = P. %Fecha creacion publicacion
getAutorP(P, Cuenta) :-     [_|[_|[_|[Cuenta|_]]]] = P. %Cuenta que originalmente creo la publicacion
getTipoP(P, Tipo) :-        [_|[_|[_|[_|[Tipo|_]]]]] = P. %Tipo de publicacion (Por defecto, siempre sera "Texto")
getContenidoP(P, Cont) :-   [_|[_|[_|[_|[_|[Cont|_]]]]]] = P. %Contenido de la publicacion
getMuroP(P, Muro) :-        [_|[_|[_|[_|[_|[_|[Muro|_]]]]]]] = P. %Muro de usuario al que pertenece esta publicacion
getComparteP(P, UComp) :-   [_|[_|[_|[_|[_|[_|[_|[UComp|_]]]]]]]] = P. %Usuario que comparte la publicacion
getRecibeP(P, URec) :-      [_|[_|[_|[_|[_|[_|[_|[_|[URec|_]]]]]]]]] = P. %Usuario que recibe la publicacion compartida

% Pertenencia
esPublicacion(P) :- not(esLista(P)), !, fail.
esPublicacion(P) :- largo(P, L), L =\= 9, !, fail.
esPublicacion(P) :- getIdP(P, Id), getIdOriginalP(P, IdOP), getFechaP(P, Fecha), getAutorP(P, Cuenta), getTipoP(P, Tipo), getContenidoP(P, Cont), getMuroP(P, Muro), getComparteP(P, UComp), getRecibeP(P, URec),
                    integer(Id), integer(IdOP), esFecha(Fecha), string(Cuenta), string(Tipo), string(Cont), string(Muro), string(UComp), string(URec).
                 
% Modificadores

% Otros
