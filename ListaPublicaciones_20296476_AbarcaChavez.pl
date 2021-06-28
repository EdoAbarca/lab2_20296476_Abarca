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
getPublicacionXId(IdPost, [], P) :- !, fail.
getPublicacionXId(IdPost, [PActual|_], P) :- getIdP(PActual, IdP), IdP == IdPost, P = PActual.
getPublicacionXId(IdPost, [_|RestoLP], P) :- getPublicacionXId(IdPost, RestoLP, P).

% Modificadores
agregarPublicacion(NuevaP, LP, LPAct) :- concatenar([NuevaP], LP, LPAct).

% Otros
% Generador de publicaciones creadas a contactos de usuario
generarPublicacionesADirigir([], Fecha, UL, Cont, LP, LPOut) :- LPOut = LP.
generarPublicacionesADirigir([DestinoActual|RestoDestinos], Fecha, UL, Cont, LP, LPOut) :- largo(LP, LargoLP), Id is LargoLP + 1, crearPublicacion(Id, Fecha, Cont, UL, DestinoActual, P), agregarPublicacion(P, LP, LPAct), generarPublicacionesADirigir(RestoDestinos, Fecha, UL, Cont, LPAct, LPOut). 

% Generador de publicaciones compartidas
generarPublicacionesACompartir([], IdPost, Fecha, UL, LP, LPOut) :- LPOut = LP.
generarPublicacionesACompartir([DestinoActual|RestoDestinos], IdPost, Fecha, UL, LP, LPOut) :- largo(LP, LargoLP), Id is LargoLP + 1, getPublicacionXId(IdPost, LP, P), ObtenerLasweas, crearPublicacionCompartida(Id, IdOP, Fecha, ContenidoP, AutorP, MuroP, UL, DestinoActual, PComp), agregarPublicacion(PComp, LP, LPAct), generarPublicacionesACompartir(RestoDestinos, Fecha, UL, Cont, LPAct, LPOut). 
