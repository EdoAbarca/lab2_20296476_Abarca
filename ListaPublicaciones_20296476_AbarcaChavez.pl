%TDA ListaPublicaciones
% Composicion: [DatosPublicacion1, DatosPublicacion2, ...,
% DatosPublicacionN] -> [TDA Publicacion, TDA Publicacion, ...,
% TDA Publicacion]

% Constructores
% En proceso...

% Pertenencia
esListaPublicaciones([]).
esListaPublicaciones([LPH|_]) :- not(esPublicacion(LPH)), !, fail.
esListaPublicaciones([_|LPT]) :- esListaCuentas(LPT).

% Selectores
getPublicacionXId(_, [], _) :- !, fail.
getPublicacionXId(PostId, [LPH|_], Publicacion) :- getIdP(LPH, IdP), IdP == PostId, Publicacion = LPH.
getPublicacionXId(PostId, [_|LPT], Publicacion) :- getPublicacionXId(PostId, LPT, Publicacion).

% Modificadores
agregarPublicacion(Publicacion, LP, LPAct) :- concatenar([Publicacion], LP, LPAct).

% Otros
% Generador de publicaciones creadas a contactos de usuario
generarPublicacionesADirigir([], _, _, _, LP, LPOut) :- LPOut = LP.
generarPublicacionesADirigir([DestinoActual|RestoDestinos], Fecha, UL, Contenido, LP, LPOut) :- largo(LP, LargoLP), Id is LargoLP + 1, crearPublicacion(Id, Fecha, Contenido, UL, DestinoActual, Publicacion), agregarPublicacion(Publicacion, LP, LPAct), generarPublicacionesADirigir(RestoDestinos, Fecha, UL, Contenido, LPAct, LPOut). 

% Generador de publicaciones compartidas
generarPublicacionesACompartir([], _, _, _, LP, LPOut) :- LPOut = LP.
generarPublicacionesACompartir([DestinoActual|RestoDestinos], PostId, Fecha, UL, LP, LPOut) :- largo(LP, LargoLP), IdP is LargoLP + 1, getPublicacionXId(PostId, LP, Publicacion), getContenidoP(Publicacion, ContenidoP), getAutorP(Publicacion, AutorP), getMuroP(Publicacion, MuroP), crearPublicacionCompartida(IdP, PostId, Fecha, ContenidoP, AutorP, MuroP, UL, DestinoActual, PComp), agregarPublicacion(PComp, LP, LPAct), generarPublicacionesACompartir(RestoDestinos, PostId, Fecha, UL, LPAct, LPOut). 

%Pasar de TDA ListaPublicaciones a string
listaPublicacionesAString([], StringAux, StringLP) :- string_concat(StringAux, "\n\n", StringFinal), StringLP = StringFinal.
listaPublicacionesAString([LPH|LPT], StringAux, StringLP) :- cuentaAString(LPH, StringPublicacion), string_concat(StringAux, StringPublicacion, StringTemp), listaPublicacionesAString(LPT, StringTemp, StringLP).
