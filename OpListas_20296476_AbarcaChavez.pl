% ESTE ARCHIVO NO ES UN TDA, SOLO GUARDARA UN CONJUNTO DE PREDICADOS
% NECESARIOS PARA EL TRABAJO CON LISTAS A REALIZAR EN ESTE LABORATORIO.

%Largo de la lista
largo([], Cont):-
    Cont is 0.
largo([_|Y], Cont):-
    largo(Y, L),
    Cont is L + 1.

%Comprueba si el elemento ingresado corresponde a una lista
esLista([]).
esLista([_|_]).

/*
Predicado modificador que agrega un elemento al final de una lista
[X|D]: Lista entrada
B: Elemento a ingresar
[X|E]: Lista con elemento ingresado al final de la lista*/
concatenar([],B,B).
concatenar([X|D],B,[X|E]):-concatenar(D,B,E).

/* Predicado que genera el siguiente reemplazo:
 * [X|List] : Lista original
 * X : Elemento original (A reemplazar)
 * Y : Elemento modificado (Reemplazo)
 * [Y|List] : Lista modificada
*/

reemplazar([X|List], X, Y, [Y|List]).
reemplazar([Xf|XList], X, Y, [Xf|YList]) :-
    reemplazar(XList, X, Y, YList).

%Manipula elemento de la lista:
%manipular(2, [1,2,3], X). -> elimina 2
%manipular(2, X, [1,2,3]). -> agrega 2 al inicio
manipular(Elemento,[Elemento|Tail1],Tail1).
manipular(Elemento,[Head|Tail1],[Head|Tail2]) :-
        manipular(Elemento,Tail1,Tail2).

%SUJETO A MODIFICACIONES

