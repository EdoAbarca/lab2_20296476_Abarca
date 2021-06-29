%TDA ListaReacciones
% Composicion: [DatosReaccion1, DatosReaccion2, ...,
% DatosReaccionN] -> [TDA Reaccion, TDA Reaccion, ..., TDA Reaccion]

% Constructores
% En proceso...

% Pertenencia
esListaReacciones([]).
esListaReacciones([LRH|_]) :- not(esReaccion(LRH)), !, fail.
esListaReacciones([_|LRT]) :- esListaReacciones(LRT).

% Selectores
getReaccionXIdR(_, [], _) :- !, fail.
getReaccionXIdR(CommentId, [LRH|_], Reaccion) :- getIdR(LRH, IdR), IdR == CommentId, Reaccion = LRH.
getReaccionXIdR(CommentId, [_|LRT], Reaccion) :- getReaccionXIdR(CommentId, LRT, Reaccion).

% Modificadores
agregarReaccion(NuevaReaccion, LR, LRAct) :- concatenar([NuevaReaccion], LR, LRAct).

% Otros

%Pasar de TDA ListaReacciones a string
listaReaccionesAString([], StringAux, StringLR) :- string_concat(StringAux, "\n\n", StringFinal), StringLR = StringFinal.
listaReaccionesAString([LRH|LRT], StringAux, StringLR) :- cuentaAString(LRH, "", StringReaccion), string_concat(StringAux, StringReaccion, StringTemp), listaReaccionesAString(LRT, StringTemp, StringLR).
