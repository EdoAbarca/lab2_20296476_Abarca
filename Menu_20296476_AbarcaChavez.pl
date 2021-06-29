%Laboratorio 2 Paradigmas de Programacion
%Archivo de requerimientos funcionales exigidos por enunciado
%Objetivo: Simular la interaccion de un usuario en una red social, implementando la variante usando el paradigma logico, en el lenguaje de programacion Prolog
%Nombre alumno: Eduardo Abarca
%RUT: 20.296.476-1
%Seccion: C-3
%Profesor: Daniel Gacitua
%Entrega: Original (2-7-2021)

%Clausulas

%////////////////////////////// REQUERIMIENTOS FUNCIONALES EXIGIDOS POR ENUNCIADO /////////////////////////////////

% OBLIGATORIOS:
%//////////////////////////////////////////// socialNetworkRegister ///////////////////////////////////////////////
/*
Predicado socialNetworkRegister, debe registrar un nueva cuenta en la red social
Entrada:
Salida:
*/
socialNetworkRegister(Sn1, Fecha, Username, Password, Sn2) :- esSocialNetwork(Sn1), (var(Sn2);esSocialNetwork(Sn2)),
                                    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                    UL == "", crearCuentaUsuario(Username, Password, Fecha, NuevaCuenta), esCuentaUsuario(NuevaCuenta), estaUsuarioDisponible(NuevaCuenta, LC), agregarCuenta(LC, NuevaCuenta, LCAct),
                                    actualizarContenidoSN("", LCAct, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkLogin ///////////////////////////////////////////////
/*
Predicado socialNetworkLogin, debe permitir iniciar sesion a un usuario ya registrado
Entrada:
Salida:
*/
socialNetworkLogin(Sn1, Username, Password, Sn2) :- esSocialNetwork(Sn1), (var(Sn2);esSocialNetwork(Sn2)),
                                getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL == "", validarCredenciales(Username, Password, LC),
                                actualizarContenidoSN(Username, LC, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkPost ///////////////////////////////////////////////
/*
Predicado socialNetworkPost, debe realizar una publicacion en la red social
Entrada:
Salida:

Se uso predicado corte para abarcar los 2 casos de este predicado (Publicacion propia | dirigida a usuarios en contactos)
*/
%Fallo 1: Los datos de entrada son incorrectos respecto a la entrada
socialNetworkPost(Sn1, _, Texto, ListUsernamesDest, Sn2) :- not(esSocialNetwork(Sn1)); not(var(Sn2);esSocialNetwork(Sn2)); not(esLista(ListUsernamesDest)); not(string(Texto)), !, fail.
socialNetworkPost(Sn1, _, _, _, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), UL == "", !, fail.
socialNetworkPost(Sn1, _, _, ListUsernamesDest, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), not(validarDestinos(ListUsernamesDest, UL, LC)), !, fail.

%Caso 1: No hay destinatarios, se realiza solo 1 publicacion, con destino el usuario logueado
socialNetworkPost(Sn1, Fecha, Texto, ListUsernamesDest, Sn2) :- largo(ListUsernamesDest, L), L == 0, 
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    largo(LP, LargoLP), Id is LargoLP + 1, crearPublicacion(Id, Fecha, Texto, UL, UL, NuevaP), agregarPublicacion(LP, NuevaP, LPAct),
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.

%Caso 2: Hay destinatarios, se realiza 1 publicacion por cada usuario destino
socialNetworkPost(Sn1, Fecha, Texto, ListUsernamesDest, Sn2) :- largo(ListUsernamesDest, L), L > 0,
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    generarPublicacionesADirigir(ListUsernamesDest, Fecha, UL, Texto, LP, LPAct), 
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.

/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkFollow ///////////////////////////////////////////////
/*
Predicado socialNetworkFollow, debe realizar la actualizacion de seguimiento de la cuenta logueada a la cuenta apuntada
Entrada:
Salida:
*/
socialNetworkFollow(Sn1, Username, Sn2) :- esSocialNetwork(Sn1), (var(Sn2);esSocialNetwork(Sn2)), string(Username),
                                getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL \== "", Username \== UL, sePuedeSeguir(Username, UL, LC), getCuentaXUsuario(Username, LC, CuentaUsername), getCuentaXUsuario(UL, LC, CuentaUL), getSeguidosC(CuentaUL, SeguidosUL), getSeguidoresC(CuentaUsername, SeguidoresUsername),
    							agregarSeguidor(SeguidoresUsername, UL, SeguidoresUsernameAct), agregarSeguimiento(SeguidosUL, Username, SeguidosULAct), actualizarSeguidosCuenta(CuentaUL, SeguidosUL, SeguidosULAct, CuentaULAct), actualizarSeguidoresCuenta(CuentaUsername, SeguidoresUsername, SeguidoresUsernameAct, CuentaUsernameAct), 
                                actualizarListaCuentas(LC, CuentaUsername, CuentaUsernameAct, LC2), actualizarListaCuentas(LC2, CuentaUL, CuentaULAct, LC3), actualizarContenidoSN("", LC3, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkShare ///////////////////////////////////////////////
/*
Predicado socialNetworkShare, debe compartir una publicacion, sea en espacio de la cuenta logueada o en contacto de este
Entrada:
Salida:

Se uso predicado corte para abarcar los 2 casos de este predicado (Compartir en espacio propio/De usuarios en contactos)
*/
socialNetworkShare(Sn1, _, PostId, ListUsernamesDest, Sn2) :- not(esSocialNetwork(Sn1)); not(var(Sn2);esSocialNetwork(Sn2)); not(integer(PostId)); not(esLista(ListUsernamesDest)), !, fail.
socialNetworkShare(Sn1, _, _, _, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), UL == "", !, fail.
socialNetworkShare(Sn1, _, _, ListUsernamesDest, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), not(validarDestinos(ListUsernamesDest, UL, LC)), !, fail.

%Caso 1: No hay destinatarios, se comparte en el muro del usuario logueado
socialNetworkShare(Sn1, Fecha, PostId, ListUsernamesDest, Sn2) :- largo(ListUsernamesDest, L), L == 0,
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    largo(LP, LargoLP), Id is LargoLP + 1 , getPublicacionXId(Id, LP, P), getContenidoP(P, ContenidoP), getAutorP(P, AutorP), getMuroP(P, MuroP),
    crearPublicacionCompartida(Id, PostId, Fecha, ContenidoP, AutorP, MuroP, UL, UL, NuevaPComp), agregarPublicacion(NuevaPComp, LP, LPAct),
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.

%Caso 2: Hay destinatarios, se debe crear una publicacion compartida para cada uno
socialNetworkShare(Sn1, Fecha, PostId, ListUsernamesDest, Sn2) :- largo(ListUsernamesDest, L), L > 0, 
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    generarPublicacionesACompartir(ListUsernamesDest, PostId, Fecha, UL, LP, LPAct),
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkToString ///////////////////////////////////////////////
/*
Predicado socialNetworkToString, debe convertir el contenido de la red social a un gran string
Entrada:
Salida:

Predicado dividido en 2: Sin sesion iniciada/Con sesion iniciada
*/

socialNetworkToString(Sn1, StrOut) :- esSocialNetwork(Sn1), var(StrOut),
    getNombreSN(Sn1, NombreSN), getFechaRegistroSN(Sn1, FechaSN), getContenidoSN(Sn1, ContSN),
    fechaAString(FechaSN, StringFechaSN), string_concat("########### RED SOCIAL: ", NombreSN, TempNombreSN), string_concat(TempNombreSN, " ##########\n", NombreSNFinal),
    string_concat("Fecha registro red social: ", StringFechaSN, StringFechaSNFinal), string_concat(NombreSNFinal, StringFechaSNFinal, StringInfoRedSocial), contenidoSNAString(ContSN, StringContSN),
    string_concat(StringInfoRedSocial, StringContSN, StringPreFinal), string_concat(StringPreFinal, "\n\n### FIN INFORMACION RED SOCIAL ###", StringFinal), StrOut = StringFinal.

/*
Ejemplos de uso:



*/

% OPTATIVOS (OJALA LLEGAR HASTA ACA):

%//////////////////////////////////////////// socialNetworkComment ///////////////////////////////////////////////
/*
Predicado socialNetworkComment, debe comentar una publicacion ya realizada
Entrada:
Salida:
*/
socialNetworkComment(Sn1, Fecha, PostId, CommentId, TextoComentario, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), string(TextoComentario),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        getPublicacionXId(PostId, LC, _), CommentId == 0, largo(LR, LargoLR), IdR is LargoLR+1, crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Comentario", TextoComentario, Reaccion), agregarReaccion(Reaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn2 = Sn1Act.

socialNetworkComment(Sn1, Fecha, PostId, CommentId, TextoComentario, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), string(TextoComentario),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        getPublicacionXId(PostId, LP, _), CommentId =\= 0, getReaccionXIdR(CommentId, LR, _), largo(LR, LargoLR), IdR is LargoLR+1,
    					crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Comentario", TextoComentario, Reaccion), agregarReaccion(Reaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkLike ///////////////////////////////////////////////
/*
Predicado socialNetworkLike, realiza un like, ya sea en una publicacion o comentario
Entrada:
Salida:
*/
socialNetworkLike(Sn1, Fecha, PostId, CommentId, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        getPublicacionXId(PostId, LC, _), CommentId == 0, largo(LR, LargoLR), IdR is LargoLR+1,
    					crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Like", "", Reaccion), agregarReaccion(Reaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.

socialNetworkLike(Sn1, Fecha, PostId, CommentId, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        getPublicacionXId(PostId, LC, _), CommentId =\= 0, getReaccionXId(CommentId, LR, _), largo(LR, LargoLR), IdR is LargoLR+1,
    					crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Like", "", Reaccion), agregarReaccion(Reaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/
%//////////////////////////////////////////// Fin archivo ///////////////////////////////////////////////