%TDA ContenidoSN
%Composicion: [UsuarioLogueado, ListaCuentas, ListaPublicaciones, ListaReacciones]
%             -> [string, TDA ListaCuentas,
%             TDA ListaPublicaciones, TDA ListaReacciones]

%Constructores
%Actividad previa
contenidoSNCustom(CSNC) :- crearListaCuentas(LC), crearListaPublicaciones(LP), crearListaReacciones(LR),
    CSNC = ["", LC, LP, LR].

%Vacio
contenidoSNVacio(CSNV) :- CSNV = ["",[],[],[]].

%Selectores
getUsuarioLogueado(CSN, UsuarioLogueado) :-       [UsuarioLogueado|_] = CSN.
getListaCuentas(CSN, ListaCuentas) :-             [_|[ListaCuentas|_]] = CSN.
getListaPublicaciones(CSN, ListaPublicaciones) :- [_|[_|[ListaPublicaciones|_]]] = CSN.
getListaReacciones(CSN, ListaReacciones) :-       [_|[_|[_|[ListaReacciones|_]]]] = CSN.

%Pertenencia
esContenidoSN(CSN) :- not(esLista(CSN)), !, fail.
esContenidoSN(CSN) :- largo(CSN, L), L \== 4, !, fail.
esContenidoSN(CSN) :- getUsuarioLogueado(CSN, UsuarioLogueado), not(string(UsuarioLogueado)), !, fail.
esContenidoSN(CSN) :- getListaCuentas(CSN, ListaCuentas), not(esListaCuentas(ListaCuentas)), !, fail.
esContenidoSN(CSN) :- getListaPublicaciones(CSN, ListaPublicaciones), not(esListaPublicaciones(ListaPublicaciones)), !, fail.
esContenidoSN(CSN) :- getListaReacciones(CSN, ListaReacciones), not(esListaReacciones(ListaReacciones)), !, fail.

%Modificadores
actualizarContenidoSN(UsuarioLogueado, ListaCuentas, ListaPublicaciones, ListaReacciones, ContenidoSNAct) :-
    ContenidoSNAct = [UsuarioLogueado, ListaCuentas, ListaPublicaciones, ListaReacciones].

%Otros