% ESTE ARCHIVO NO ES UN TDA, SOLO GUARDARA UN CONJUNTO DE PREDICADOS NECESARIOS PARA EL TRABAJO CON LISTAS A REALIZAR EN ESTE LABORATORIO.
% Aun asi, se agregara su documentacion respectiva.

/*
%Dominio
Cont: Entero, contador de elementos en la lista
Lista: Lista, lista a la cual se le calculara la cantidad de elementos que almacena (primera capa)
A: Elemento a agregar en la lista, tipo de dato puede variar
Act: Elemento actual de listas entrada y salida, tipo de dato puede variar
D: Lista, resto lista entrada
E: Lista, resto lista salida
X: Elemento original lista entrada
Y: Elemento a reemplazar original, se agrega a lista salida, tipo de dato puede variar
List: Lista, resto de listas entrada y salida suponiendo son coincidentes
Xf: Elemento actual listas entrada y salida
XList: Lista, resto lista entrada
YList: Lista, resto lista salida

%Predicados

largo([], Cont)
largo([_|Lista], Cont)
esLista([])
esLista([_|_])
concatenar([],A,A)
concatenar([Act|D],A,[Act|E]):-concatenar(D,A,E)
reemplazar([X|List], X, Y, [Y|List]).
reemplazar([Xf|XList], X, Y, [Xf|YList])

%Metas
%Principales
largo
esLista
concatenar
reemplazar

%Reglas y hechos
*/

% Predicado que calcula el largo de la lista
largo([], Cont):-
    Cont is 0.
largo([_|Lista], Cont):-
    largo(Lista, L),
    Cont is L + 1.

% Predicado que comprueba si el elemento ingresado corresponde a una lista
esLista([]).
esLista([_|_]).

/*
Predicado modificador que agrega un elemento a una lista, puede tomar 2 rumbos:
1)
[X|D]: Lista original
B: Elemento a ingresar
[X|E]: Lista con elemento ingresado al final

2)
[X|D]: Elemento a ingresar
B: Lista original
[X|E]: Lista con elemento ingresado al inicio
*/
concatenar([],A,A).
concatenar([Act|D],A,[Act|E]):-concatenar(D,A,E).

/* Predicado que genera el siguiente reemplazo:
 * [X|List] : Lista original
 * X : Elemento original (A reemplazar)
 * Y : Elemento modificado (Reemplazo)
 * [Y|List] : Lista modificada
*/
reemplazar([X|List], X, Y, [Y|List]).
reemplazar([Xf|XList], X, Y, [Xf|YList]) :-
    reemplazar(XList, X, Y, YList).
