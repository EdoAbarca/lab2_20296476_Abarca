%TDA ListaPublicaciones
% Composicion: [DatosPublicacion1, DatosPublicacion2, ...,
% DatosPublicacionN] -> [TDA Publicacion, TDA Publicacion, ...,
% TDA Publicacion]

% Constructores
% En proceso...

% Pertenencia
esListaPublicaciones([]).
esListaPublicaciones([CabezaLP|_]) :- not(esPublicacion(CabezaLP)), !, fail.
esListaPublicaciones([_|RestoLP]) :- esListaCuentas(RestoLP).

% Selectores
% En proceso...

% Modificadores
agregarPublicacion(NuevaP, LP, LPAct) :- concatenar([NuevaP], LP, LPAct).

% Otros
% En proceso...