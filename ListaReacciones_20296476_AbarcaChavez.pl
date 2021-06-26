%TDA ListaReacciones
% Composicion: [DatosReaccion1, DatosReaccion2, ...,
% DatosReaccionN] -> [TDA Reaccion, TDA Reaccion, ..., TDA Reaccion]

% Constructores
% En proceso...

% Pertenencia
esListaReacciones([]).
esListaReacciones([CabezaLR|_]) :- not(esReaccion(CabezaLR)), !, fail.
esListaReacciones([_|RestoLR]) :- esListaReacciones(RestoLR).

% Selectores
% En proceso...

% Modificadores
agregarReaccion(NuevaReaccion, LR, LRAct) :- concatenar([NuevaReaccion], LR, LRAct).

% Otros
% En proceso...