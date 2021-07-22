%TDA ContenidoSN
%Composicion: [UL, LC, LP, LR]
%             -> [string, TDA ListaCuentas, TDA ListaPublicaciones, TDA ListaReacciones]

/*
%Dominio
ContenidoSNV: TDA ContenidoSN, materializacion sin actividad
ContenidoSN: TDA ContenidoSN, materializacion con o sin actividad
UL: String, usuario con sesion iniciada ("" si no hay)
LC: TDA ListaCuentas, listado de cuentas registradas en la red social
LP: TDA ListaPublicaciones, listado de publicaciones realizadas en la red social
LR: TDA ListaReacciones, listado de reacciones ocurridas en la red social
ContenidoSNAct: TDA ContenidoSN, con actividad actualizada dependiendo del predicado llamado
ContenidoSNString: String, conversion de la informacion en el TDA ContenidoSN a un gran string, este dependiendo del campo UL

%Predicados
contenidoSNVacio(ContenidoSNV)
getUsuarioLogueado(ContenidoSN, UL)
getListaCuentas(ContenidoSN, LC)
getListaPublicaciones(ContenidoSN, LP) 
getListaReacciones(ContenidoSN, LR)
esContenidoSN(ContenidoSN)
actualizarContenidoSN(UL, LC, LP, LR, ContenidoSNAct)
contenidoSNAString(ContenidoSN, ContenidoSNString)

%Metas
%Principales
contenidoSNVacio
esContenidoSN
actualizarContenidoSN
contenidoSNAString

%Secundarias
getUsuarioLogueado
getListaCuentas
getListaPublicaciones
getListaReacciones

%Clausulas
%Hechos y reglas
*/

%Constructores

%Vacio
contenidoSNVacio(ContenidoSNV) :- tdaLCVacio(LC), tdaLPVacio(LP), tdaLRVacio(LR), ContenidoSNV = ["", LC, LP, LR].

%Selectores
getUsuarioLogueado(ContenidoSN, UL) :-      [UL|_] = ContenidoSN.
getListaCuentas(ContenidoSN, LC) :-         [_|[LC|_]] = ContenidoSN.
getListaPublicaciones(ContenidoSN, LP) :-   [_|[_|[LP|_]]] = ContenidoSN.
getListaReacciones(ContenidoSN, LR) :-      [_|[_|[_|[LR|_]]]] = ContenidoSN.

%Pertenencia
esContenidoSN(ContenidoSN) :- not(esLista(ContenidoSN)), !, fail.
esContenidoSN(ContenidoSN) :- largo(ContenidoSN, L), L =\= 4, !, fail.
esContenidoSN(ContenidoSN) :- getUsuarioLogueado(ContenidoSN, UL), not(string(UL)), !, fail.
esContenidoSN(ContenidoSN) :- getListaCuentas(ContenidoSN, LC), not(esListaCuentas(LC)), !, fail.
esContenidoSN(ContenidoSN) :- getListaPublicaciones(ContenidoSN, LP), not(esListaPublicaciones(LP)), !, fail.
esContenidoSN(ContenidoSN) :- getListaReacciones(ContenidoSN, LR), not(esListaReacciones(LR)), !, fail.
esContenidoSN(_) :- !, true.

%Modificadores
actualizarContenidoSN(UL, LC, LP, LR, ContenidoSNAct) :-
    ContenidoSNAct = [UL, LC, LP, LR].

%Otros

% Pasar de TDA ListaReacciones a string
listaReaccionesAString([], _, StringAux, StringLR) :- string_concat(StringAux, "Fin reacciones.\n\n", StringFinal), StringLR = StringFinal.
listaReaccionesAString([LRH|LRT], PostId, StringAux, StringLR) :- getIdPR(LRH, IdPR), PostId == IdPR, reaccionAString(LRH, StringReaccion), string_concat(StringAux, StringReaccion, StringTemp), listaReaccionesAString(LRT, PostId, StringTemp, StringLR).
listaReaccionesAString([_|LRT], PostId, StringAux, StringLR) :- listaReaccionesAString(LRT, PostId, StringAux, StringLR).

% Pasar de TDA ListaPublicaciones a string
listaPublicacionesAString([], _, _, StringAux, StringLP) :- string_concat(StringAux, "Fin publicaciones.\n\n", StringFinal), StringLP = StringFinal.
listaPublicacionesAString([LPH|LPT], UsuarioLista, LR, StringAux, StringLP) :- getIdOriginalP(LPH, IdOriginalLPH), IdOriginalLPH == 0, getAutorP(LPH, AutorLPH), UsuarioLista == AutorLPH, getIdP(LPH, IdLPH), listaReaccionesAString(LR, IdLPH, "", StringLR),
                                                                            publicacionAString(LPH, StringPublicacion), string_concat("\n\nREACCIONES PUBLICACION:\n", StringLR, StringLROut), string_concat(StringPublicacion, StringLROut, StringPublicacionOut),
                                                                            string_concat(StringAux, StringPublicacionOut, StringTemp), listaPublicacionesAString(LPT, UsuarioLista, LR, StringTemp, StringLP).

listaPublicacionesAString([LPH|LPT], UsuarioLista, LR, StringAux, StringLP) :- getIdOriginalP(LPH, IdOriginalLPH), IdOriginalLPH =\= 0, getComparteP(LPH, ComparteLPH), UsuarioLista == ComparteLPH, getIdP(LPH, IdLPH), listaReaccionesAString(LR, IdLPH, "", StringLR),
                                                                            publicacionAString(LPH, StringPublicacion), string_concat("\n\nREACCIONES PUBLICACION:\n", StringLR, StringLROut), string_concat(StringPublicacion, StringLROut, StringPublicacionOut),
                                                                            string_concat(StringAux, StringPublicacionOut, StringTemp), listaPublicacionesAString(LPT, UsuarioLista, LR, StringTemp, StringLP).
listaPublicacionesAString([_|LPT], UsuarioLista, LR, StringAux, StringLP) :- listaPublicacionesAString(LPT, UsuarioLista, LR, StringAux, StringLP).

% Pasar de TDA ListaCuentas a string
listaCuentasAString([], _, _, StringAux, StringLC) :- string_concat(StringAux, "Fin cuentas.\n\n", StringFinal), StringLC = StringFinal.
listaCuentasAString([LCH|LCT], LP, LR, StringAux, StringLC) :- cuentaAString(LCH, StringCuenta), getUsuarioC(LCH, UsuarioLCH), listaPublicacionesAString(LP, UsuarioLCH, LR, "", StringPublicaciones), 
                                                               string_concat("\n\nPUBLICACIONES USUARIO:\n\n", StringPublicaciones, StringPublicacionesFinal), string_concat(StringCuenta, StringPublicacionesFinal, StringCuentaFinal),
                                                               string_concat(StringAux, StringCuentaFinal, StringTemp), listaCuentasAString(LCT, LP, LR, StringTemp, StringLC).


% Pasar de TDA ContenidoSN a string. El flujo debe depender si hay o no usuario logueado.
%1) Sin usuario logueado
contenidoSNAString(ContenidoSN, ContenidoSNString) :- getUsuarioLogueado(ContenidoSN, UL), getListaCuentas(ContenidoSN, LC), getListaPublicaciones(ContenidoSN, LP), getListaReacciones(ContenidoSN, LR),
                                UL == "", listaCuentasAString(LC, LP, LR, "", StringLC), string_concat("\nUSUARIOS REGISTRADOS:\n\n", StringLC, StringLCOut), ContenidoSNString = StringLCOut.

%2) Con usuario logueado

contenidoSNAString(ContenidoSN, ContenidoSNString) :- getUsuarioLogueado(ContenidoSN, UL), getListaCuentas(ContenidoSN, LC), getListaPublicaciones(ContenidoSN, LP), getListaReacciones(ContenidoSN, LR),
                                UL \== "", getCuentaXUsuario(LC, UL, CuentaUL), listaCuentasAString([CuentaUL], LP, LR, "", StringCuentaUL), string_concat("\nINFORMACION USUARIO LOGUEADO:\n\n", StringCuentaUL, StringCuentaULOut), ContenidoSNString = StringCuentaULOut.

% Conversion de listas a strings se movio aca por dependencia de TDA ListaCuentas con TDA ListaPublicaciones y TDA ListaReacciones.


