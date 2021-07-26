%Laboratorio 2 Paradigmas de Programacion
%Archivo de requerimientos funcionales exigidos por enunciado
%Objetivo: Simular la interaccion de un usuario en una red social, implementando la variante usando el paradigma logico, en el lenguaje de programacion Prolog
%Nombre alumno: Eduardo Abarca
%RUT: 20.296.476-1
%Seccion: C-3
%Profesor: Daniel Gacitua
%Entrega: Original (12-7-2021)

/*
%Dominio
Sn1: TDA SocialNetwork
Fecha: TDA Fecha, fecha actual ingresada por el usuario
Username: Credencial usuario de TDA Cuenta
Password: Credencial contrasenia de TDA Cuenta
Texto: String, contenido de la pregunta para TDA Publicacion a crear
ListUsernameDest: Lista, destinos escogidos por el usuario logueado a destinar la publicacion
PostId: Entero, identificador de TDA Publicacion a compartir
StrOut: Variable, retornara un string luego del procesamiento del predicado
CommentId: Entero, identificador de TDA Reaccion a reaccionar
TextoComentario: String, contenido del comentario para agregar a TDA Reaccion a crear
Sn2: Variable | TDA SocialNetwork, resultado de aplicar el predicado sobre Sn1

%Predicados
socialNetworkRegister(Sn1, Fecha, Username, Password, Sn2)
socialNetworkLogin(Sn1, Username, Password, Sn2)
socialNetworkPost(Sn1, Fecha, Texto, ListUsernameDest, Sn2) 
socialNetworkFollow(Sn1, Username, Sn2)
socialNetworkShare(Sn1, Fecha, PostId, ListUsernameDest, Sn2)
socialNetworkToString(Sn1, StrOut) 
socialNetworkComment(Sn1, Fecha, PostId, CommentId, TextoComentario, Sn2)
socialNetworkLike(Sn1, Fecha, PostId, CommentId, Sn2)

%Metas
%Principales
socialNetworkRegister
socialNetworkLogin
socialNetworkPost
socialNetworkFollow
socialNetworkShare
socialNetworkToString
socialNetworkComment
socialNetworkLike

%Clausulas
%Hechos y reglas
*/

%////////////////////////////// REQUERIMIENTOS FUNCIONALES EXIGIDOS POR ENUNCIADO /////////////////////////////////

% OBLIGATORIOS:
%//////////////////////////////////////////// socialNetworkRegister ///////////////////////////////////////////////
/*
Predicado socialNetworkRegister, debe registrar un nueva cuenta en la red social
Entrada: Sn1 (TDA SocialNetwork), Fecha (TDA Fecha), Username (String), Password (String) y Sn2 (variable | TDA SocialNetwork)
Salida: Sn2 (TDA SocialNetwork luego de aplicar socialNetworkRegister)
*/
socialNetworkRegister(Sn1, Fecha, Username, Password, Sn2) :- esSocialNetwork(Sn1), (var(Sn2);esSocialNetwork(Sn2)),
                                    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                    UL == "", crearCuentaUsuario(Username, Password, Fecha, NuevaCuenta), esCuentaUsuario(NuevaCuenta), estaUsuarioDisponible(NuevaCuenta, LC), agregarCuenta(NuevaCuenta, LC, LCAct),
                                    actualizarContenidoSN("", LCAct, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Pruebas: 10
 - Exitosas: 7
 - Fallidas: 3

Ejemplos de uso:

1) Registro de una cuenta
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2).

2) Mismo caso anterior, pero se toman los resultados de las variables para demostrar el retorno 'true.' cuando Sn2 no es variable. 
socialNetworkRegister(["InstaBook", [25, 6, 2021], ["", [], [], []]], [25, 6, 2021], "A", "B", ["InstaBook", [25, 6, 2021], ["", [["A", "B", [25, 6, 2021], [], []]], [], []]]).

3) Error: Registro de un usuario que ya estaba registrado
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkRegister(Sn2, F, "UsuarioGenerico", "PassGenerica", Sn3), socialNetworkRegister(Sn3, F, "A", "V", Sn4).

4) Ejemplo correlativo: 3 cuentas registradas
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4).

*/

%//////////////////////////////////////////// socialNetworkLogin ///////////////////////////////////////////////
/*
Predicado socialNetworkLogin, debe permitir iniciar sesion a una cuenta ya registrada
Entrada: Sn1 (TDA SocialNetwork), Username (String), Password (String) y Sn2 (variable | TDA SocialNetwork)
Salida: Sn2 (TDA SocialNetwork luego de aplicar socialNetworkLogin)
*/
socialNetworkLogin(Sn1, Username, Password, Sn2) :- esSocialNetwork(Sn1), (var(Sn2);esSocialNetwork(Sn2)),
                                getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL == "", validarCredenciales(Username, Password, LC),
                                actualizarContenidoSN(Username, LC, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Pruebas: 10
 - Exitosas: 6
 - Fallidas: 4

Ejemplos de uso:

1) Login simple
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkLogin(Sn2, "A", "B", Sn3).

2) Mismo caso anterior, pero se toman los resultados de las variables para demostrar el retorno 'true.' cuando Sn2 no es variable.  
socialNetworkLogin(["InstaBook", [25, 6, 2021], ["", [["A", "B", [25, 6, 2021], [], []]], [], []]], "A", "B", ["InstaBook", [25, 6, 2021], ["A", [["A", "B", [25, 6, 2021], [], []]], [], []]]).

3) Error: Intento de registro de cuenta despues de iniciar sesion
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkLogin(Sn2, "A", "B", Sn3), socialNetworkRegister(Sn3, F, "C", "D", Sn4).

4) Error: Intento de inicio sesion con credenciales no registradas
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkLogin(Sn2, "A", "A", Sn3).

5) Error: Intento de inicio sesion con sesion iniciada
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkLogin(Sn2, "A", "B", Sn3), socialNetworkLogin(Sn3, "A", "B", Sn4).

6) Ejemplo correlativo: Inicio de sesion de A
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "A", "B", Sn5).

*/

%//////////////////////////////////////////// socialNetworkPost ///////////////////////////////////////////////
/*
Predicado socialNetworkPost, debe permitir a la cuenta logueada realizar una publicacion en la red social.
Entrada: Sn1 (TDA SocialNetwork), Fecha (TDA Fecha), Texto (String), ListaUsernamesDest (Lista) y Sn2 (variable | TDA SocialNetwork)
Salida: Sn2 (TDA SocialNetwork luego de aplicar socialNetworkPost)

Se uso predicado corte para abarcar los 2 casos de este predicado (Publicacion propia | dirigida a usuarios en contactos)
*/

%Fallo 1: Los datos de entrada son incorrectos respecto a la entrada
socialNetworkPost(Sn1, _, Texto, ListaUsernamesDest, Sn2) :- not(esSocialNetwork(Sn1)); not(var(Sn2);esSocialNetwork(Sn2)); not(esLista(ListaUsernamesDest)); not(string(Texto)), !, fail.

%Fallo 2: No hay usuario logueado
socialNetworkPost(Sn1, _, _, _, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), UL == "", !, fail.

%Fallo 3: Cierto destino no pertenece a la lista de contactos (seguidos) del usuario logueado
socialNetworkPost(Sn1, _, _, ListaUsernamesDest, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), not(validarDestinos(ListaUsernamesDest, UL, LC)), !, fail.

%Caso 1: No hay destinatarios, se realiza solo 1 publicacion, con destino el usuario logueado
socialNetworkPost(Sn1, Fecha, Texto, ListaUsernamesDest, Sn2) :- largo(ListaUsernamesDest, L), L == 0, 
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    largo(LP, LargoLP), Id is LargoLP + 1, crearPublicacion(Id, Fecha, Texto, UL, UL, NuevaP), agregarPublicacion(NuevaP, LP, LPAct),
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.

%Caso 2: Hay destinatarios, se realiza 1 publicacion por cada usuario destino
socialNetworkPost(Sn1, Fecha, Texto, ListaUsernamesDest, Sn2) :- largo(ListaUsernamesDest, L), L > 0,
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    generarPublicacionesADirigir(ListaUsernamesDest, Fecha, UL, Texto, LP, LPAct), 
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.


/*
Pruebas: 25
 - Exitosas: 10
 - Fallidas: 15

Ejemplos de uso:

1) Ejemplo de publicacion simple, sin destinatarios
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkLogin(Sn2, "A", "B", Sn3), socialNetworkPost(Sn3, F, "Estoy solooooo", [], Sn4).

2) Mismo caso anterior, pero se toman los resultados de las variables para demostrar el retorno 'true.' cuando Sn2 no es variable.
socialNetworkPost(["InstaBook", [25, 6, 2021], ["A", [["A", "B", [25, 6, 2021], [], []]], [], []]], [25, 6, 2021], "Hola hijoles.", [], ["InstaBook", [25, 6, 2021], ["", [["A", "B", [25, 6, 2021], [], []]], [[1, 0, [25, 6, 2021], "Texto", "Hola hijoles.", "A", "A", "", ""]], []]]).

3) Error: Publicacion con destino(s) que no esta(n) en los contactos de la cuenta logueada (i.e., la cuenta logueada no los sigue)
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkRegister(Sn2, F, "A", "B", Sn3), socialNetworkLogin(Sn3, "A", "B", Sn4), socialNetworkPost(Sn4, F, "Estoy solooooo", [C], Sn5).

4) Ejemplo correlativo: Post de F
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6).

¿Y el caso de publicacion con destinos?
socialNetworkFollow esta abajo de este predicado, por ende, se presentara ese caso en tal predicado como ejemplo correlativo pendiente.
*/

%//////////////////////////////////////////// socialNetworkFollow ///////////////////////////////////////////////
/*
Predicado socialNetworkFollow, debe realizar la actualizacion de seguimiento por parte de la cuenta logueada hacia la cuenta apuntada
Entrada: Sn1 (TDA SocialNetwork), Username (String) y Sn2 (variable | TDA SocialNetwork)
Salida: Sn2 (TDA SocialNetwork luego de aplicar socialNetworkFollow)
*/
socialNetworkFollow(Sn1, Username, Sn2) :- esSocialNetwork(Sn1), (var(Sn2);esSocialNetwork(Sn2)), string(Username),
                                getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL \== "", Username \== UL, sePuedeSeguir(Username, UL, LC), getCuentaXUsuario(LC, Username, CuentaUsername), getCuentaXUsuario(LC, UL, CuentaUL), getSeguidosC(CuentaUL, SeguidosUL), getSeguidoresC(CuentaUsername, SeguidoresUsername),
    							agregarSeguidor(UL, SeguidoresUsername, SeguidoresUsernameAct), agregarSeguimiento(Username, SeguidosUL, SeguidosULAct), actualizarSeguidosCuenta(CuentaUL, SeguidosULAct, CuentaULAct), actualizarSeguidoresCuenta(CuentaUsername, SeguidoresUsernameAct, CuentaUsernameAct), 
                                actualizarListaCuentas(LC, CuentaUsername, CuentaUsernameAct, LC2), actualizarListaCuentas(LC2, CuentaUL, CuentaULAct, LC3), actualizarContenidoSN("", LC3, LP, LR, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.
/*
Pruebas: 12
 - Exitosas: 7
 - Fallidas: 5

Ejemplos de uso:

1) Ejemplo de seguimiento simple
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkRegister(Sn2, F, "C", "D", Sn3), socialNetworkLogin(Sn3, "A", "B", Sn4), socialNetworkFollow(Sn4, "C", Sn5).

2) Mismo caso anterior, pero se toman los resultados de las variables para demostrar el retorno 'true.' cuando Sn2 no es variable.
socialNetworkFollow(["InstaBook", [25, 6, 2021], ["A", [["C", "D", [25, 6, 2021], [], []], ["A", "B", [25, 6, 2021], [], []]], [], []]], "C", ["InstaBook", [25, 6, 2021], ["", [["C", "D", [25, 6, 2021], [], ["A"]], ["A", "B", [25, 6, 2021], ["C"], []]], [], []]]).

3) Error: Cuenta a seguir no existe
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkLogin(Sn2, "A", "B", Sn3), socialNetworkFollow(Sn3, "C", Sn4).

4) Error: Cuenta a seguir ya esta seguida
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkRegister(Sn2, F, "C", "D", Sn3), socialNetworkLogin(Sn3, "A", "B", Sn4), socialNetworkFollow(Sn4, "C", Sn5), socialNetworkLogin(Sn5, "A", "B", Sn6), socialNetworkFollow(Sn6, "C", Sn7).

5) Error: Cuenta a seguir es cuenta logueada
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1), socialNetworkRegister(Sn1, F, "A", "B", Sn2), socialNetworkLogin(Sn2, "A", "B", Sn3), socialNetworkFollow(Sn3, "A", Sn4).

6) Correlativo pendiente: Realizar publicacion con destinos -> Se deben seguir las cuentas destino para que esten en contactos
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12).

7) Correlativo: Seguimiento mutuo entre A, C y E
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20).

*/

%//////////////////////////////////////////// socialNetworkShare ///////////////////////////////////////////////
/*
Predicado socialNetworkShare, debe compartir una publicacion, sea en espacio de la cuenta logueada o en contactos de esta
Entrada: Sn1 (TDA SocialNetwork), Fecha (TDA Fecha), PostId (integer), ListaUsernamesDest (Lista) y Sn2 (variable | TDA SocialNetwork)
Salida: Sn2 (TDA SocialNetwork luego de aplicar socialNetworkShare)

Se uso predicado corte para abarcar los 2 casos de este predicado (Compartir en espacio propio/De usuarios en contactos)
*/
socialNetworkShare(Sn1, _, PostId, ListaUsernamesDest, Sn2) :- not(esSocialNetwork(Sn1)); not(var(Sn2);esSocialNetwork(Sn2)); not(integer(PostId)); not(esLista(ListaUsernamesDest)), !, fail.
socialNetworkShare(Sn1, _, _, _, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), UL == "", !, fail.
socialNetworkShare(Sn1, _, _, ListaUsernamesDest, _) :- getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), not(validarDestinos(ListaUsernamesDest, UL, LC)), !, fail.

%Caso 1: No hay destinatarios, se comparte en el muro del usuario logueado
socialNetworkShare(Sn1, Fecha, PostId, ListaUsernamesDest, Sn2) :- largo(ListaUsernamesDest, L), L == 0,
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    largo(LP, LargoLP), Id is LargoLP + 1 , getPublicacionXId(Id, LP, P), getContenidoP(P, ContenidoP), getAutorP(P, AutorP), getMuroP(P, MuroP),
    crearPublicacionCompartida(Id, PostId, Fecha, ContenidoP, AutorP, MuroP, UL, UL, NuevaPComp), agregarPublicacion(NuevaPComp, LP, LPAct),
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.

%Caso 2: Hay destinatarios, se debe crear una publicacion compartida para cada uno
socialNetworkShare(Sn1, Fecha, PostId, ListaUsernamesDest, Sn2) :- largo(ListaUsernamesDest, L), L > 0, 
    getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
    generarPublicacionesACompartir(ListaUsernamesDest, PostId, Fecha, UL, LP, LPAct),
    actualizarContenidoSN("", LC, LPAct, LR, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn1Act = Sn2, !.
/*
Pruebas: 15
 - Exitosas: 8
 - Fallidas: 7

Ejemplos de uso:

1) Ejemplo simple de compartir publicacion
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "C", "D", Sn5),
socialNetworkFollow(Sn5, "E", Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkPost(Sn7, F, "HolaAa", [], Sn8),
socialNetworkLogin(Sn8, "C", "D", Sn9),
socialNetworkShare(Sn9, F, 1, ["E"], Sn10).

2) Mismo caso anterior, pero se toman los resultados de las variables para demostrar el retorno 'true.' cuando Sn2 no es variable.
socialNetworkShare(["InstaBook", [25, 6, 2021], ["C", [["E", "F", [25, 6, 2021], [], ["C"]], ["C", "D", [25, 6, 2021], ["E"], []], ["A", "B", [25, 6, 2021], [], []]], [[1, 0, [25, 6, 2021], "Texto", "HolaAa", "A", "A", "", ""]], []]], [25, 6, 2021], 1, ["E"], ["InstaBook", [25, 6, 2021], ["", [["E", "F", [25, 6, 2021], [], ["C"]], ["C", "D", [25, 6, 2021], ["E"], []], ["A", "B", [25, 6, 2021], [], []]], [[2, 1, [25, 6, 2021], "Texto", "HolaAa", "A", "A", "C", "E"], [1, 0, [25, 6, 2021], "Texto", "HolaAa", "A", "A", "", ""]], []]]).

3) Error: Publicacion con IdP = PostId no existe
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "C", "D", Sn5),
socialNetworkFollow(Sn5, "E", Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkPost(Sn7, F, "HolaAa", [], Sn8),
socialNetworkLogin(Sn8, "C", "D", Sn9),
socialNetworkShare(Sn9, F, 0, ["E"], Sn10).

4) Error: Destino(s) no es(son) contacto(s) de cuenta logueada
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "C", "D", Sn5),
socialNetworkFollow(Sn5, "E", Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkPost(Sn7, F, "HolaAa", [], Sn8),
socialNetworkLogin(Sn8, "C", "D", Sn9),
socialNetworkShare(Sn9, F, 1, ["A"], Sn10).

5) Ejemplo correlativo: Compartir la publicacion que hizo A dirigido a C, estando logueado en C, a G e I (Nuevas cuentas, se deben seguir antes)
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28).

*/

%//////////////////////////////////////////// socialNetworkToString ///////////////////////////////////////////////
/*
Predicado socialNetworkToString, debe convertir el contenido de la red social a un gran string
Entrada: Sn1 (TDA SocialNetwork) y StrOut (Variable)
Salida: StrOut (String que contiene la informacion de Sn1)
*/

socialNetworkToString(Sn1, StrOut) :- esSocialNetwork(Sn1), var(StrOut),
    getNombreSN(Sn1, NombreSN), getFechaRegistroSN(Sn1, FechaSN), getContenidoSN(Sn1, ContSN),
    fechaAString(FechaSN, StringFechaSN), string_concat("\n\n########### RED SOCIAL: ", NombreSN, TempNombreSN), string_concat(TempNombreSN, " ##########\n", NombreSNFinal),
    string_concat("Fecha registro red social: ", StringFechaSN, StringFechaSNFinal), string_concat(NombreSNFinal, StringFechaSNFinal, StringInfoRedSocial), contenidoSNAString(ContSN, StringContSN),
    string_concat(StringInfoRedSocial, StringContSN, StringPreFinal), string_concat(StringPreFinal, "\n\n### FIN INFORMACION RED SOCIAL ###", StringFinal), StrOut = StringFinal.

/*
Pruebas: 10
 - Exitosas: 5
 - Fallidas: 5

Ejemplos de uso:

No hay actualizacion de Sn1 en este predicado, por lo que no seguira la estructura presentada anteriormente en los ejemplos de uso.

1) Ejemplo correlativo 1 (No canon): Muestra de informacion red social sin usuario logueado
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkToString(Sn28, StrInstabook),
write(StrInstabook).

2) Ejemplo correlativo 2 (No canon): Muestra de informacion red social con usuario logueado
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "A", "B", Sn29),
socialNetworkToString(Sn29, StrInstabook), 
write(StrInstabook).

3) Error: StrOut no es una variable
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkToString(Sn28, "Red social").

*/

% OPTATIVOS:

%//////////////////////////////////////////// socialNetworkComment ///////////////////////////////////////////////
/*
Predicado socialNetworkComment, debe permitir a la cuenta logueada comentar una publicacion ya realizada
Entrada: Sn1 (TDA SocialNetwork), Fecha (TDA Fecha), PostId (integer), CommentId (integer), TextoComentario (String) y Sn2 (variable | TDA SocialNetwork)
Salida: Sn2 (TDA SocialNetwork luego de aplicar socialNetworkComment)

Casos:

a) Publicacion original -> IdOriginalP == 0 -> Autor publicacion debe estar en contactos de cuenta logueada (i.e., cuenta logueada debe seguir a cuenta creadora de la publicacion)
a.1) Se comenta una publicacion original -> CommentId == 0
a.2) Se responde un comentario dentro de una publicacion original -> PostId y CommentId deben coincidir con la reaccion a encontrar -> CommentId > 0

b) Publicacion compartida -> IdOriginalP =\= 0 -> Cuenta que comparte debe estar en contactos de cuenta logueada (i.e., cuenta logueada debe seguir a cuenta que comparte publicacion)
b.3) Se comenta una publicacion compartida -> CommentId == 0
b.4) Se responde un comentario dentro de una publicacion compartida -> PostId y CommentId deben coincidir con la reaccion a encontrar -> CommentId > 0
*/

%a.1)
socialNetworkComment(Sn1, Fecha, PostId, CommentId, TextoComentario, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), string(TextoComentario), (var(Sn2);esSocialNetwork(Sn2)),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR), UL \== "",
                        CommentId == 0, getPublicacionXId(PostId, LP, Publicacion), getIdOriginalP(Publicacion, IdOriginalP), IdOriginalP == 0, getAutorP(Publicacion, AutorP), (validarDestinos([AutorP], UL, LC);AutorP == UL),
                        largo(LR, LargoLR), IdR is LargoLR+1, crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Comentario", TextoComentario, Reaccion), agregarReaccion(Reaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn2 = Sn1Act.

%b.3)
socialNetworkComment(Sn1, Fecha, PostId, CommentId, TextoComentario, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), string(TextoComentario), (var(Sn2);esSocialNetwork(Sn2)),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR), UL \== "",
                        CommentId == 0, getPublicacionXId(PostId, LP, Publicacion), getIdOriginalP(Publicacion, IdOriginalP), IdOriginalP > 0, getComparteP(Publicacion, ComparteP), (validarDestinos([ComparteP], UL, LC); ComparteP == UL),
                        largo(LR, LargoLR), IdR is LargoLR+1, crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Comentario", TextoComentario, Reaccion), agregarReaccion(Reaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn2 = Sn1Act.

%a.2)
socialNetworkComment(Sn1, Fecha, PostId, CommentId, TextoComentario, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), string(TextoComentario), (var(Sn2);esSocialNetwork(Sn2)),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR), UL \== "",
                        CommentId > 0, getReaccionXIdR(CommentId, LR, Reaccion), getTipoR(Reaccion, TipoR), getIdR(Reaccion, IdR), getIdPR(Reaccion, IdPR), IdR == CommentId, IdPR == PostId, TipoR == "Comentario", 
                        getPublicacionXId(PostId, LP, Publicacion), getIdOriginalP(Publicacion, IdOriginalP), IdOriginalP == 0, getAutorP(Publicacion, AutorP), (validarDestinos([AutorP], UL, LC);AutorP == UL),
                        largo(LR, LargoLR), IdNuevaR is LargoLR+1, crearReaccion(IdNuevaR, PostId, CommentId, Fecha, UL, "Comentario", TextoComentario, NuevaReaccion), agregarReaccion(NuevaReaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn2 = Sn1Act.

%b.4)
socialNetworkComment(Sn1, Fecha, PostId, CommentId, TextoComentario, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), string(TextoComentario), (var(Sn2);esSocialNetwork(Sn2)),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR), UL \== "",
                        CommentId > 0, getReaccionXIdR(CommentId, LR, Reaccion), getTipoR(Reaccion, TipoR), getIdR(Reaccion, IdR), getIdPR(Reaccion, IdPR), IdR == CommentId, IdPR == PostId, TipoR == "Comentario", 
                        getPublicacionXId(PostId, LP, Publicacion), getIdOriginalP(Publicacion, IdOriginalP), IdOriginalP > 0, getComparteP(Publicacion, ComparteP), (validarDestinos([ComparteP], UL, LC); ComparteP == UL),
                        largo(LR, LargoLR), IdNuevaR is LargoLR+1, crearReaccion(IdNuevaR, PostId, CommentId, Fecha, UL, "Comentario", TextoComentario, NuevaReaccion), agregarReaccion(NuevaReaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSNAct), actualizarSocialNetwork(Sn1, ContSNAct, Sn1Act), Sn2 = Sn1Act.


/*
Pruebas: 38
 - Exitosas: 13
 - Fallidas: 25

Ejemplos de uso:

1) Ejemplo simple de comentario a publicacion
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkLogin(Sn2, "A", "B", Sn3),
socialNetworkPost(Sn3, F, ":)", [], Sn4),
socialNetworkLogin(Sn4, "A", "B", Sn5),
socialNetworkComment(Sn5, F, 1, 0, ":(", Sn6).

2) Mismo caso anterior, pero se toman los resultados de las variables para demostrar el retorno 'true.' cuando Sn2 no es variable.
socialNetworkComment(["InstaBook", [25, 6, 2021], ["A", [["A", "B", [25, 6, 2021], [], []]], [[1, 0, [25, 6, 2021], "Texto", ":)", "A", "A", "", ""]], []]], [25, 6, 2021], 1, 0, ":(",  ["InstaBook", [25, 6, 2021], ["", [["A", "B", [25, 6, 2021], [], []]], [[1, 0, [25, 6, 2021], "Texto", ":)", "A", "A", "", ""]], [[1, 1, 0, [25, 6, 2021], "A", "Comentario", ":("]]]]).

3) Error: Publicacion con IdPost no existe
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkLogin(Sn2, "A", "B", Sn3),
socialNetworkPost(Sn3, F, ":)", [], Sn4),
socialNetworkLogin(Sn4, "A", "B", Sn5),
socialNetworkComment(Sn5, F, 2, 0, ":(", Sn6).

4) Error: Reaccion con CommentId no existe
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkLogin(Sn2, "A", "B", Sn3),
socialNetworkPost(Sn3, F, ":)", [], Sn4),
socialNetworkLogin(Sn4, "A", "B", Sn5),
socialNetworkComment(Sn5, F, 1, 1, ":(", Sn6).

5) Error: Se intenta comentar un Like (A presentar en siguiente predicado)

Casos presentados en inicio de predicado:

a.1)

fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30).

b.3)

fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34).

a.2)

fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36).

b.4)

fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38).

*/

%//////////////////////////////////////////// socialNetworkLike ///////////////////////////////////////////////
/*
Predicado socialNetworkLike, debe permitir a la cuenta logueada realizar un like, ya sea en una publicacion o comentario
Entrada: Sn1 (TDA SocialNetwork), Fecha (TDA Fecha), PostId (integer), CommentId (integer) y Sn2 (variable | TDA SocialNetwork)
Salida: Sn2 (TDA SocialNetwork luego de aplicar socialNetworkLike)
*/
socialNetworkLike(Sn1, Fecha, PostId, CommentId, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), (var(Sn2);esSocialNetwork(Sn2)),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        UL \== "", CommentId == 0, getPublicacionXId(PostId, LP, Publicacion), getIdP(Publicacion, IdP), IdP == PostId,
    					largo(LR, LargoLR), IdR is LargoLR+1, crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Like", "", NuevaReaccion), agregarReaccion(NuevaReaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.

socialNetworkLike(Sn1, Fecha, PostId, CommentId, Sn2) :- esSocialNetwork(Sn1), esFecha(Fecha), integer(PostId), integer(CommentId), (var(Sn2);esSocialNetwork(Sn2)),
                        getContenidoSN(Sn1, ContSN), getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                        UL \== "", CommentId > 0,  getPublicacionXId(PostId, LP, Publicacion), getIdP(Publicacion, IdP), IdP == PostId,
    					getReaccionXIdR(CommentId, LR, Reaccion), getIdR(Reaccion, IdReaccion), getIdPR(Reaccion, IdPR), getTipoR(Reaccion, TipoR), IdReaccion = CommentId, IdPR == PostId, TipoR == "Comentario",
    					largo(LR, LargoLR), IdR is LargoLR+1, crearReaccion(IdR, PostId, CommentId, Fecha, UL, "Like", "", NuevaReaccion), agregarReaccion(NuevaReaccion, LR, LRAct), 
                        actualizarContenidoSN("", LC, LP, LRAct, ContSN2), actualizarSocialNetwork(Sn1, ContSN2, Sn1Act), Sn2 = Sn1Act.

/*
Pruebas: 20
 - Exitosas: 12
 - Fallidas: 8

Ejemplos de uso:

1) Ejemplo simple de like:
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkLogin(Sn2, "A", "B", Sn3),
socialNetworkPost(Sn3, F, ":)", [], Sn4),
socialNetworkLogin(Sn4, "A", "B", Sn5),
socialNetworkLike(Sn5, F, 1, 0, Sn6).

2) Mismo caso anterior, pero se toman los resultados de las variables para demostrar el retorno 'true.' cuando Sn2 no es variable.
socialNetworkLike(["InstaBook", [25, 6, 2021], ["A", [["A", "B", [25, 6, 2021], [], []]], [[1, 0, [25, 6, 2021], "Texto", ":)", "A", "A", "", ""]], []]], [25, 6, 2021], 1, 0, ["InstaBook", [25, 6, 2021], ["", [["A", "B", [25, 6, 2021], [], []]], [[1, 0, [25, 6, 2021], "Texto", ":)", "A", "A", "", ""]], [[1, 1, 0, [25, 6, 2021], "A", "Like", ""]]]]).

3) Error 1: Publicacion con PostId no existe.
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, -1, 0, Sn40).

4) Error 2: Reaccion con CommentId no existe.
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, 4, 0, Sn40),
socialNetworkLogin(Sn40, "G", "H", Sn41),
socialNetworkLike(Sn41, F, 4, -1, Sn42).

5) Error 3: Like de cuenta es repetido

5.1) A publicacion
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, 4, 0, Sn40),
socialNetworkLogin(Sn40, "G", "H", Sn41),
socialNetworkLike(Sn41, F, 4, 0, Sn42).

5.2) A comentario
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, 4, 0, Sn40),
socialNetworkLogin(Sn40, "G", "H", Sn41),
socialNetworkLike(Sn41, F, 4, 4, Sn42),
socialNetworkLogin(Sn42, "G", "H", Sn43),
socialNetworkLike(Sn43, F, 4, 4, Sn44).

6) Error 4: Se intenta comentar un Like (Pendiente de comentario anterior)
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkLogin(Sn2, "A", "B", Sn3),
socialNetworkPost(Sn3, F, ":)", [], Sn4),
socialNetworkLogin(Sn4, "A", "B", Sn5),
socialNetworkLike(Sn5, F, 1, 0, Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkComment(Sn7, F, 1, 1, ":(", Sn8).

7) Correlativo 1: Like a publicacion
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, 4, 0, Sn40).

8) Correlativo 2: Like a comentario
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, 4, 0, Sn40),
socialNetworkLogin(Sn40, "G", "H", Sn41),
socialNetworkLike(Sn41, F, 4, 4, Sn42).


Correlativo final: 
Nadie se fijo en E y su publicacion. 
A se dio cuenta de esto, por ende, ira a comentar su publicacion,
para luego visualizar toda la red social.

Final original: Sin login de A
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, 4, 0, Sn40),
socialNetworkLogin(Sn40, "G", "H", Sn41),
socialNetworkLike(Sn41, F, 4, 4, Sn42),
socialNetworkLogin(Sn42, "A", "B", Sn43),
socialNetworkComment(Sn43, F, 1, 0, "Al fin se logro echar a andar esto! *O*", Sn44),
socialNetworkToString(Sn44, StrFinal),
write(StrFinal).

Final alternativo: Con login de A
fecha(25,6,2021, F), socialNetworkVacio("InstaBook", F, Sn1),
socialNetworkRegister(Sn1, F, "A", "B", Sn2),
socialNetworkRegister(Sn2, F, "C", "D", Sn3),
socialNetworkRegister(Sn3, F, "E", "F", Sn4),
socialNetworkLogin(Sn4, "E", "F", Sn5),
socialNetworkPost(Sn5, F, "¿Que sucede?", [], Sn6),
socialNetworkLogin(Sn6, "A", "B", Sn7),
socialNetworkFollow(Sn7, "C", Sn8),
socialNetworkLogin(Sn8, "A", "B", Sn9),
socialNetworkFollow(Sn9, "E", Sn10),
socialNetworkLogin(Sn10, "A", "B", Sn11),
socialNetworkPost(Sn11, F, "Hola a mis amigos! :D", ["C", "E"], Sn12),
socialNetworkLogin(Sn12, "C", "D", Sn13),
socialNetworkFollow(Sn13, "A", Sn14),
socialNetworkLogin(Sn14, "E", "F", Sn15),
socialNetworkFollow(Sn15, "A", Sn16),
socialNetworkLogin(Sn16, "C", "D", Sn17),
socialNetworkFollow(Sn17, "E", Sn18),
socialNetworkLogin(Sn18, "E", "F", Sn19),
socialNetworkFollow(Sn19, "C", Sn20),
socialNetworkRegister(Sn20, F, "G", "H", Sn21),
socialNetworkRegister(Sn21, F, "I", "J", Sn22),
socialNetworkLogin(Sn22, "C", "D", Sn23),
socialNetworkFollow(Sn23, "G", Sn24),
socialNetworkLogin(Sn24, "C", "D", Sn25),
socialNetworkFollow(Sn25, "I", Sn26),
socialNetworkLogin(Sn26, "C", "D", Sn27),
socialNetworkShare(Sn27, F, 1, ["G", "I"], Sn28),
socialNetworkLogin(Sn28, "C", "D", Sn29),
socialNetworkComment(Sn29, F, 1, 0, "Hola pibe", Sn30),
socialNetworkLogin(Sn30, "G", "H", Sn31),
socialNetworkFollow(Sn31, "C", Sn32),
socialNetworkLogin(Sn32, "G", "H", Sn33),
socialNetworkComment(Sn33, F, 4, 0, "¿?", Sn34),
socialNetworkLogin(Sn34, "A", "B", Sn35),
socialNetworkComment(Sn35, F, 1, 1, "No descuides el lab, esa cosa es interminable D:", Sn36),
socialNetworkLogin(Sn36, "C", "D", Sn37),
socialNetworkComment(Sn37, F, 4, 2, "Es por el lab man", Sn38),
socialNetworkLogin(Sn38, "G", "H", Sn39),
socialNetworkLike(Sn39, F, 4, 0, Sn40),
socialNetworkLogin(Sn40, "G", "H", Sn41),
socialNetworkLike(Sn41, F, 4, 4, Sn42),
socialNetworkLogin(Sn42, "A", "B", Sn43),
socialNetworkComment(Sn43, F, 1, 0, "Al fin se logro echar a andar esto! *O*", Sn44),
socialNetworkLogin(Sn44, "A", "B", Sn45),
socialNetworkToString(Sn45, StrFinal),
write(StrFinal).

Por alguna razon, se corta la informacion de los ejemplos que usan socialNetworkToString en el interprete, aun ingresando el comando w.
Percance no se pudo solucionar.
socialNetworkViral y socialNetworkSearch no implementados.

Conteo final estimado pruebas laboratorio 2:

Total: 140
Acertadas: 68
Fallidas: 72

*/
%//////////////////////////////////////////// Fin archivo ///////////////////////////////////////////////
