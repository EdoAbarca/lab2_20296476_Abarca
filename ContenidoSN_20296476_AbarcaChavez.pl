%TDA ContenidoSN
%Composicion: [UsuarioLogueado, ListaUsuarios, ListaCuentas, ListaPublicaciones, ListaReacciones]
%             -> [string, TDA ListaUsuarios, TDA ListaCuentas,
%             TDA ListaPublicaciones, TDA ListaReacciones]

%Constructores
%Actividad previa
contenidoSNCustom(CSNC) :- crearListaUsuarios(LU), crearListaCuentas(LC), crearListaPublicaciones(LP), crearListaReacciones(LR),
    CSNC = ["", LU, LC, LP, LR].

%Vacio
contenidoSNVacio(CSNV) :- CSNV = ["",[],[],[],[]].

%Selectores
getUsuarioLogueado(CSN, UsuarioLogueado) :-       [UsuarioLogueado|_] = CSN.
getListaUsuarios(CSN, ListaUsuarios) :-           [_|[ListaUsuarios|_]] = CSN.
getListaCuentas(CSN, ListaCuentas) :-             [_|[_|[ListaCuentas|_]]] = CSN.
getListaPublicaciones(CSN, ListaPublicaciones) :- [_|[_|[_|[ListaPublicaciones|_]]]] = CSN.
getListaReacciones(CSN, ListaReacciones) :-       [_|[_|[_|[_|[ListaReacciones|_]]]]] = CSN.

%Pertenencia
esContenidoSN(CSN) :- not(esLista(CSN)), !, fail.
esContenidoSN(CSN) :- largo(CSN, L), L \== 5, !, fail.
esContenidoSN(CSN) :- getUsuarioLogueado(CSN, UsuarioLogueado), not(string(UsuarioLogueado)), !, fail.
esContenidoSN(CSN) :- getListaUsuarios(CSN, ListaUsuarios), not(esListaUsuarios(ListaUsuarios)), !, fail.
esContenidoSN(CSN) :- getListaCuentas(CSN, ListaCuentas), not(esListaCuentas(ListaCuentas)), !, fail.
esContenidoSN(CSN) :- getListaPublicaciones(CSN, ListaPublicaciones), not(esListaPublicaciones(ListaPublicaciones)), !, fail.
esContenidoSN(CSN) :- getListaReacciones(CSN, ListaReacciones), not(esListaReacciones(ListaReacciones)), !, fail.

%Modificadores
actualizarContenidoSN(UsuarioLogueado, ListaUsuarios, ListaCuentas, ListaPublicaciones, ListaReacciones, ContenidoSNAct) :-
    ContenidoSNAct = [UsuarioLogueado, ListaUsuarios, ListaCuentas, ListaPublicaciones, ListaReacciones].

%Otros
