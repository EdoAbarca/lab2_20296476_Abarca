% TDA Publicacion
% Composicion: [IdP, IdOriginalP, FechaP, TipoP, ContenidoP, AutorP, MuroP, ComparteP, RecibeP] 
%                -> [integer, integer, TDA Fecha, string, string, string, string, string, string] 

/*
%Dominio
IdP: Entero, identificador unico para TDA Publicacion
IdOriginalP: Entero, identificador de publicacion original para TDA Publicacion (Para compartidos, si no, es 0)
FechaP: TDA Fecha, fecha creacion de publicacion
TipoP: String, identificador de tipo de publicacion (Por defecto, "Texto")
ContenidoP: String, contenido de TDA Publicacion
AutorP: String, nombre cuenta que creo la publicacion
MuroP: String, usuario al que se le destino la publicacion
ComparteP: String, usuario que compartio la publicacion (Para compartidos, si no, es "")
RecibeP: String, usuario que recibe la publicacion compartida (Para compartidos, si no, es "")
Publicacion: TDA Publicacion, materializacion del TDA
PCompartida: TDA Publicacion, materializacion del TDA con los datos adicionales respectivos a una publicacion compartida
StringP: String, conversion del TDA Publicacion a un string con todos sus datos

%Predicados
crearPublicacion(IdP, FechaP, ContenidoP, AutorP, MuroP, Publicacion)
crearPublicacionCompartida(IdP, IdOriginalP, FechaP, ContenidoP, AutorP, MuroP, ComparteP, RecibeP, PCompartida)
getIdP(Publicacion, IdP) 
getIdOriginalP(Publicacion, IdOriginalP) 
getFechaP(Publicacion, FechaP) 
getTipoP(Publicacion, TipoP) 
getContenidoP(Publicacion, ContenidoP) 
getAutorP(Publicacion, AutorP) 
getMuroP(Publicacion, MuroP) 
getComparteP(Publicacion, ComparteP) 
getRecibeP(Publicacion, RecibeP)
esPublicacion(Publicacion) 
publicacionAString(Publicacion, StringP)

%Metas
%Principales
crearPublicacion
crearPublicacionCompartida
esPublicacion
publicacionAString

%Secundarias
getIdP
getIdOriginalP
getFechaP
getTipoP
getContenidoP
getAutorP
getMuroP
getComparteP
getRecibeP

%Clausulas
%Hechos y reglas
*/

% Constructores
%Publicacion original
crearPublicacion(IdP, FechaP, ContenidoP, AutorP, MuroP, Publicacion) :- Publicacion = [IdP, 0, FechaP, "Texto", ContenidoP, AutorP, MuroP, "", ""].

%Publicacion compartida
crearPublicacionCompartida(IdP, IdOriginalP, FechaP, ContenidoP, AutorP, MuroP, ComparteP, RecibeP, PCompartida) :- PCompartida = [IdP, IdOriginalP, FechaP, "Texto", ContenidoP, AutorP, MuroP, ComparteP, RecibeP].

/*
Para la publicacion compartida, lo que va a variar respecto a una publicacion original es:
 - IdOriginalP -> Guardara el Id por correlativo de la publicacion original
 - ComparteP -> Guardara el usuario de la cuenta que compartio la publicacion (Usuario logueado)
 - RecibeP -> Guardara el usuario que recibe la publicacion compartida (Usuario en contactos del usuario logueado).
              Se usara como referencia al muro del usuario a la hora de generar el string.
*/

% Selectores
getIdP(Publicacion, IdP) :-                     [IdP|_] = Publicacion.                          %Id actual por correlativo
getIdOriginalP(Publicacion, IdOriginalP) :-     [_|[IdOriginalP|_]] = Publicacion.              %Id publicacion original (Si IdOriginalP == 0, esta es una publicacion original, a diferencia de una compartida, donde Id != IdOP)
getFechaP(Publicacion, FechaP) :-               [_|[_|[FechaP|_]]] = Publicacion.               %Fecha creacion publicacion
getTipoP(Publicacion, TipoP) :-     	        [_|[_|[_|[TipoP|_]]]] = Publicacion.            %Tipo de publicacion (Por defecto, siempre sera "Texto")
getContenidoP(Publicacion, ContenidoP) :-       [_|[_|[_|[_|[ContenidoP|_]]]]] = Publicacion.   %Contenido de la publicacion
getAutorP(Publicacion, AutorP) :-   	        [_|[_|[_|[_|[_|[AutorP|_]]]]]] = Publicacion.   %Cuenta que originalmente creo la publicacion
getMuroP(Publicacion, MuroP) :-                 [_|[_|[_|[_|[_|[_|[MuroP|_]]]]]]] = Publicacion. %Muro de usuario al que pertenece esta publicacion
getComparteP(Publicacion, ComparteP) :-         [_|[_|[_|[_|[_|[_|[_|[ComparteP|_]]]]]]]] = Publicacion. %Usuario que comparte la publicacion
getRecibeP(Publicacion, RecibeP) :-             [_|[_|[_|[_|[_|[_|[_|[_|[RecibeP|_]]]]]]]]] = Publicacion. %Usuario que recibe la publicacion compartida

% Pertenencia
esPublicacion(Publicacion) :- not(esLista(Publicacion)), !, fail.
esPublicacion(Publicacion) :- largo(Publicacion, L), L =\= 9, !, fail.
esPublicacion(Publicacion) :- getIdP(Publicacion, IdP), getIdOriginalP(Publicacion, IdOriginalP), getFechaP(Publicacion, FechaP), getTipoP(Publicacion, TipoP), getContenidoP(Publicacion, ContenidoP), getAutorP(Publicacion, AutorP), getMuroP(Publicacion, MuroP), getComparteP(Publicacion, ComparteP), getRecibeP(Publicacion, RecibeP),
                    integer(IdP), integer(IdOriginalP), esFecha(FechaP), string(TipoP), string(ContenidoP), string(AutorP), string(MuroP), string(ComparteP), string(RecibeP).
                 
% Modificadores
% Sin modificadores

% Otros
% Transformar de TDA Publicacion a string
publicacionAString(Publicacion, StringP) :- getIdP(Publicacion, IdP), getIdOriginalP(Publicacion, IdOriginalP), getFechaP(Publicacion, FechaP), getTipoP(Publicacion, TipoP), getContenidoP(Publicacion, ContenidoP),
                                  getAutorP(Publicacion, AutorP), getMuroP(Publicacion, MuroP), getComparteP(Publicacion, ComparteP), getRecibeP(Publicacion, RecibeP),
                                  number_string(IdP, StringIdP), number_string(IdOriginalP, StringIdOriginalP), fechaAString(FechaP, StringFechaP),
                                  string_concat("\nId publicacion: ", StringIdP, StringIdPOut), string_concat("\nId publicacion original: ", StringIdOriginalP, StringIdOriginalPOut), 
                                  string_concat("\nFecha publicacion: ", StringFechaP, StringFechaOut), string_concat("\nTipo publicacion: ", TipoP, TipoPOut),
                                  string_concat("\nContenido publicacion: ", ContenidoP, ContenidoPOut), string_concat("\nCuenta que creo publicacion: ", AutorP, AutorPOut),
                                  string_concat("\nPublicacion dirigida a: ", MuroP, MuroPOut), string_concat("\nCuenta que compartio publicacion: ", ComparteP, CompartePOut),
                                  string_concat("\nCuenta que recibio publicacion compartida: ", RecibeP, RecibePOut), string_concat(RecibePOut, "\n\n", RecibePFinal),
                                  string_concat(StringIdPOut, StringIdOriginalPOut, S1), string_concat(StringFechaOut, TipoPOut, S2), string_concat(ContenidoPOut, AutorPOut, S3), string_concat(MuroPOut, CompartePOut, S4),
                                  string_concat(S1, S2, Parte1S), string_concat(S3, S4, Parte2S),
                                  string_concat(Parte1S, Parte2S, Final1S), string_concat(Final1S, RecibePFinal, StringFinalPublicacion), StringP = StringFinalPublicacion.
                                  