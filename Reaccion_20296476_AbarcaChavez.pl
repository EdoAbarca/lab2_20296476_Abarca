% TDA Reaccion
% Composicion: [IdR, IdPR, IdRR, FechaR, AutorR, TipoR, ContenidoR]
%                -> [integer, integer, integer, TDA Fecha, string, string, string]

% Constructores
crearReaccion(IdR, IdPR, IdRR, FechaR, AutorR, TipoR, ContenidoR, Reaccion) :- Reaccion = [IdR, IdPR, IdRR, FechaR, AutorR, TipoR, ContenidoR].

% Selectores
getIdR(Reaccion, IdR) :-               [IdR|_] = Reaccion.
getIdPR(Reaccion, IdPR) :-             [_|[IdPR|_]] = Reaccion.
getIdRR(Reaccion, IdRR) :-             [_|[_|[IdRR|_]]] = Reaccion.
getFechaR(Reaccion, FechaR) :-         [_|[_|[_|[FechaR|_]]]] = Reaccion.
getCuentaR(Reaccion, AutorR) :-        [_|[_|[_|[_|[AutorR|_]]]]] = Reaccion.
getTipoR(Reaccion, TipoR) :-           [_|[_|[_|[_|[_|[TipoR|_]]]]]] = Reaccion.
getContenidoR(Reaccion, ContenidoR) :- [_|[_|[_|[_|[_|[_|[ContenidoR|_]]]]]]] = Reaccion.

% Pertenencia
esReaccion(Reaccion) :- not(esLista(Reaccion)), !, fail.
esReaccion(Reaccion) :- largo(Reaccion, L), L =\= 7, !, fail.
esReaccion(Reaccion) :- getIdR(Reaccion, IdR), getIdPR(Reaccion, IdPR), getIdRR(Reaccion, IdRR), getFechaR(Reaccion, FechaR), getCuentaR(Reaccion, AutorR), getTipoR(Reaccion, TipoR), getContenidoR(Reaccion, ContenidoR),
    integer(IdR), integer(IdPR), integer(IdRR), esFecha(FechaR), string(AutorR), string(TipoR), string(ContenidoR).

% Modificadores

% Otros
% Convertir de TDA Reaccion a string
reaccionAString(Reaccion, StringR) :- getIdR(Reaccion, IdR), getIdPR(Reaccion, IdPR), getIdRR(Reaccion, IdRR), getFechaR(Reaccion, FechaR), getCuentaR(Reaccion, AutorR), getTipoR(Reaccion, TipoR), getContenidoR(Reaccion, ContenidoR),
                    number_string(IdR, StringIdR), number_string(IdPR, StringIdPR), number_string(IdRR, StringIdRR), fechaAString(FechaR, StringFecha),
                    string_concat("\nID reaccion: ", StringIdR, StringIdROut), string_concat("\nID publicacion reaccionada: ", StringIdPR, StringIdPROut),
                    string_concat("\nID reaccion reaccionada: ", StringIdRR, StringIdRROut), string_concat("\nFecha reaccion: ", StringFecha, StringFechaOut),
                    string_concat("\nCuenta que realiza reaccion: ", AutorR, AutorROut), string_concat("\nTipo de reaccion: ", TipoR, TipoROut),
                    string_concat("\nContenido de la reaccion: ", ContenidoR, ContenidoROut), string_concat(ContenidoROut, "\n\n", ContenidoROutFinal),
                    string_concat(StringIdROut, StringIdPROut, S1), string_concat(StringIdRROut, StringFechaOut, S2), string_concat(AutorROut, TipoROut, S3),
                    string_concat(S1, S2, Parte1S), string_concat(S3, ContenidoROutFinal, Parte2S), string_concat(Parte1S, Parte2S, StringFinalR), StringR = StringFinalR.
