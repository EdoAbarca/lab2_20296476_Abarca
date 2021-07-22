%TDA ListaPublicaciones
% Composicion: [DatosPublicacion1, DatosPublicacion2, ..., DatosPublicacionN] 
%               -> [TDA Publicacion, TDA Publicacion, ..., TDA Publicacion]

/*
%Dominio
LPH: TDA Publicacion, elemento principal TDA ListaPublicaciones
LPT: TDA ListaPublicaciones, resto de elementos TDA Lista publicaciones
PostId: Entero, identificador de TDA Publicacion a crear | encontrar | compartir
Publicacion: TDA Publicacion, retorno luego de coincidencia de identificador con IdPost
LP: TDA ListaPublicaciones, contenedor de TDAs Publicacion
LPAct: TDA ListaPublicaciones, luego de agregar Publicacion al inicio
LPOut: TDA ListaPublicaciones, luego de agregar todos los TDAs Publicacion creados, ya sea a destinar o a compartir
DestinoActual: String, contacto actual a destinar | compartir publicacion
RestoDestinos: Lista, destinos restantes a destinar | compartir publicacion
Fecha: TDA Fecha, fecha en la que se destina | comparte publicacion
UL: String, usuario de cuenta logueada en el momento de destinar | compartir las publicaciones
Contenido: String, contenido a asignar en el|los TDA Publicacion a crear | compartir
PostId: Entero, identificador de TDA Publicacion a compartir


%Predicados
esListaPublicaciones([]).
esListaPublicaciones([LPH|_])
esListaPublicaciones([_|LPT])
getPublicacionXId(_, [], _)
getPublicacionXId(PostId, [LPH|_], Publicacion)
getPublicacionXId(PostId, [_|LPT], Publicacion)
agregarPublicacion(Publicacion, LP, LPAct)
generarPublicacionesADirigir([], _, _, _, LP, LPOut)
generarPublicacionesADirigir([DestinoActual|RestoDestinos], Fecha, UL, Contenido, LP, LPOut)
generarPublicacionesACompartir([], _, _, _, LP, LPOut)
generarPublicacionesACompartir([DestinoActual|RestoDestinos], PostId, Fecha, UL, LP, LPOut)

%Metas
%Principales
esListaPublicaciones
agregarPublicacion
generarPublicacionesADirigir
generarPublicacionesACompartir

%Secundarias
getPublicacionXId


%Clausulas
%Hechos y reglas
*/

% Constructor
tdaLPVacio(LP) :- LP = [].

% Pertenencia
esListaPublicaciones([]).
esListaPublicaciones([LPH|_]) :- not(esPublicacion(LPH)), !, fail.
esListaPublicaciones([_|LPT]) :- esListaPublicaciones(LPT).

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
generarPublicacionesACompartir([DestinoActual|RestoDestinos], PostId, Fecha, UL, LP, LPOut) :- largo(LP, LargoLP), IdP is LargoLP + 1, getPublicacionXId(PostId, LP, Publicacion), getContenidoP(Publicacion, ContenidoP), getAutorP(Publicacion, AutorP), getMuroP(Publicacion, MuroP),
                                                                                        crearPublicacionCompartida(IdP, PostId, Fecha, ContenidoP, AutorP, MuroP, UL, DestinoActual, PComp), agregarPublicacion(PComp, LP, LPAct), generarPublicacionesACompartir(RestoDestinos, PostId, Fecha, UL, LPAct, LPOut).
