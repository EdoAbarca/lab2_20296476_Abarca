%Laboratorio 2 Paradigmas de Programacion
%Archivo de requerimientos funcionales pedidos por enunciado
%Objetivo: Simular la interaccion de un usuario en una red social,
%implementando la variante usando el paradigma logico,
%en el lenguaje de programacion Prolog
%Nombre alumno: Eduardo Abarca
%RUT: 20.296.476-1
%Seccion: C-3
%Profesor: Daniel Gacitua
%Entrega: Original (2-7-2021)

%Aca iniciar documentacion de archivo

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
                                UL == "", validarCredenciales(Username, Password, LU),
                                actualizarContenidoSN(Username, LC, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkPost ///////////////////////////////////////////////
/*
Predicado socialNetworkPost, debe realizar una publicacion en la red social al usuario con sesion iniciada
Entrada:
Salida:
*/
socialNetworkPost(Sn1, Fecha, Texto, ListaUsernamesDest, Sn2) :- esSocialNetwork(Sn1), (var(Sn2);esSocialNetwork(Sn2)), esLista(ListaUsernamesDest), 
                                getContenidoSn(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL \== "", filtrarDestinos(ListaUsernamesDest, LU, UL ,ListaUserAct), largo(LP, LLP), Id is LLP + 1, crearPublicacion(Id, Fecha, UL, Texto, ListaUserAct, NewP), agregarPublicacion(LP, NewP, LP2),
                                actualizarContenidoSN("", LU, LC, LP2, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkFollow ///////////////////////////////////////////////
/*
Predicado socialNetworkFollow, debe realizar la actualizacion de seguimiento del usuario logueado al usuario apuntado
Entrada:
Salida:
*/
socialNetworkFollow(Sn1, Username, Sn2) :- esSocialNetwork(Sn1), string(Username),
                                getContenidoSn(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL \== "", getCuentaXUsuario(LC, Username, C1), agregarSeguidor(), getCuentaXUsuario(LC, UL, C2), agregarSeguimiento(), actualizarCuenta(),
                                actualizarContenidoSN("", LU, LC2, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkShare ///////////////////////////////////////////////
/*
Predicado socialNetworkShare, debe compartir una publicacion, sea en espacio del usuario logueado o en contacto de este
Entrada:
Salida:
*/
socialNetworkShare(Sn1, Fecha, PostId, ListaUsernamesDest, Sn2). :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), esLista(ListaUsernamesDest),
                            getContenidoSn(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                            UL \== "", filtrarContactos(ListaUsernamesDest, UL, ListaDestAct), getPublicacionXId(LP, PostId, P), agregarCompartidos(ListaDestAct, P, PAct), actualizarPublicaciones(LP, PAct, LP2),
                            actualizarContenidoSN("", LU, LC2, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// socialNetworkToString ///////////////////////////////////////////////
/*
Predicado socialNetworkToString, debe convertir el contenido de la red social a un gran string
Entrada:
Salida:
*/

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
                        getContenidoSn(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaUsuarios(ContSN, LU), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        /*Procesamiento*/,
                        actualizarContenidoSN("", LU, LC, LP, LR2, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
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
                        getContenidoSn(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaUsuarios(ContSN, LU), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        /*Procesamiento*/,
                        actualizarContenidoSN("", LU, LC, LP, LR2, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Ejemplos de uso:



*/

%//////////////////////////////////////////// Fin archivo ///////////////////////////////////////////////