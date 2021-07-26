%TDA ListaReacciones
% Composicion: [DatosReaccion1, DatosReaccion2, ..., DatosReaccionN] 
%               -> [TDA Reaccion, TDA Reaccion, ..., TDA Reaccion]

/*
%Dominio
LRH: TDA Reaccion, elemento principal TDA ListaReacciones
LRT: TDA ListaReacciones, resto de elementos TDA ListaReacciones
CommentId: Entero, identificador de comentario TDA reaccion
Reaccion: TDA Reaccion, retorno de TDA luego de encontrar coincidencia con CommentId
NuevaReaccion: TDA Reaccion, creado luego de llamar a los predicados principales respectivos (socialNetworkLike | socialNetworkComment)
LR: TDA ListaReacciones, contenedor de TDAs Reaccion
LRAct: TDA ListaReacciones, contenedor de TDAs Reaccion con NuevaReaccion agregada al inicio
UL: Usuario de cuenta logueada al momento de crear la reaccion


%Predicados
esListaReacciones([])
esListaReacciones([LRH|_])
esListaReacciones([_|LRT])
getReaccionXIdR(_, [], _)
getReaccionXIdR(CommentId, [LRH|_], Reaccion) 
getReaccionXIdR(CommentId, [_|LRT], Reaccion)
agregarReaccion(NuevaReaccion, LR, LRAct)
existeReaccion(_, [])
existeReaccion(CommentId, [LRH|_])
existeReaccion(CommentId, [_|LRT])
noSeRepiteLike(_, _, _, []).
noSeRepiteLike(PostId, CommentId, UL, [LRH|_]) 
noSeRepiteLike(PostId, CommentId, UL, [_|LRT])


%Metas
%Principales
esListaReacciones
getReaccionXIdR
agregarReaccion
existeReaccion
noSeRepiteLike

%Secundarias
getReaccionXIdR


%Clausulas
%Hechos y reglas
*/

% Constructores
tdaLRVacio(LR) :- LR = [].

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
% Verificar que no se repita un like en una publicacion o comentario de una misma cuenta
noSeRepiteLike(_, _, _, []).
noSeRepiteLike(PostId, CommentId, UL, [LRH|_]) :- getIdPR(LRH, IdPR), getIdRR(LRH, IdRR), getAutorR(LRH, AutorR), IdPR == PostId, IdRR == CommentId, AutorR == UL, !, fail.
noSeRepiteLike(PostId, CommentId, UL, [_|LRT]) :- noSeRepiteLike(PostId, CommentId, UL, LRT).
