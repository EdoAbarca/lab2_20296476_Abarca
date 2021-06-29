%TDA ContenidoSN
%Composicion: [UsuarioLogueado, ListaCuentas, ListaPublicaciones, ListaReacciones]
%             -> [string, TDA ListaCuentas,
%             TDA ListaPublicaciones, TDA ListaReacciones]

%Constructores
%Actividad previa
/*
contenidoSNCustom(CSNC) :- crearListaCuentas(LC), crearListaPublicaciones(LP), crearListaReacciones(LR),
    CSNC = ["", LC, LP, LR].
*/
%Vacio
contenidoSNVacio(CSNV) :- CSNV = ["",[],[],[]].

%Selectores
getUsuarioLogueado(CSN, UsuarioLogueado) :-       [UsuarioLogueado|_] = CSN.
getListaCuentas(CSN, ListaCuentas) :-             [_|[ListaCuentas|_]] = CSN.
getListaPublicaciones(CSN, ListaPublicaciones) :- [_|[_|[ListaPublicaciones|_]]] = CSN.
getListaReacciones(CSN, ListaReacciones) :-       [_|[_|[_|[ListaReacciones|_]]]] = CSN.

%Pertenencia
esContenidoSN(CSN) :- not(esLista(CSN)), !, fail.
esContenidoSN(CSN) :- largo(CSN, L), L =\= 4, !, fail.
esContenidoSN(CSN) :- getUsuarioLogueado(CSN, UsuarioLogueado), not(string(UsuarioLogueado)), !, fail.
esContenidoSN(CSN) :- getListaCuentas(CSN, ListaCuentas), not(esListaCuentas(ListaCuentas)), !, fail.
esContenidoSN(CSN) :- getListaPublicaciones(CSN, ListaPublicaciones), not(esListaPublicaciones(ListaPublicaciones)), !, fail.
esContenidoSN(CSN) :- getListaReacciones(CSN, ListaReacciones), not(esListaReacciones(ListaReacciones)), !, fail.
esContenidoSN(_) :- !, true.

%Modificadores
actualizarContenidoSN(UsuarioLogueado, ListaCuentas, ListaPublicaciones, ListaReacciones, ContenidoSNAct) :-
    ContenidoSNAct = [UsuarioLogueado, ListaCuentas, ListaPublicaciones, ListaReacciones].

%Otros
% Pasar de TDA ContenidoSN a string. El flujo debe depender si hay o no usuario logueado.
%1) Sin usuario logueado
contenidoSNAString(ContSN, ContSNString) :- getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL == "", listaCuentasAString(LC, StringLC), listaPublicacionesAString(LP, StringLP), listaReaccionesAString(LR, StringLR),
    							string_concat("\nUsuarios registrados:\n\n", StringLC, StringLCOut), string_concat("\nPublicaciones realizadas:\n\n", StringLP, StringLPOut),
    							string_concat("\nReacciones ocurridas:\n\n", StringLR, StringLROut), string_concat(StringLCOut, StringLPOut, Parte1S),
    							string_concat(Parte1S, StringLROut, StringFinal), ContSNString = StringFinal.

%2) Con usuario logueado
/*
contenidoSNAString(ContSN, ContSNString) :- getUsuarioLogueado(ContSN, UL), getListaCuentas(ContSN, LC), getListaPublicaciones(ContSN, LP), getListaReacciones(ContSN, LR),
                                UL \== "".
*/
