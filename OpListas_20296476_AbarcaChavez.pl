%ESTE ARCHIVO NO ES UN TDA, SOLO GUARDARA UN CONJUNTO DE REGLAS NECESARIAS PARA EL TRABAJO CON LISTAS A REALIZAR EN EL LABORATORIO.

%Largo de la lista
largo([], Cont):-
    Cont is 0.
largo([_|Y], Cont):-
    largo(Y, L),
    Cont is L + 1.

%Comprueba si el elemento ingresado corresponde a una lista
esLista([]).
esLista([_|_]).

%Predicado modificador que agrega un elemento a una lista
agregarAStack([],B,B).
agregarAStack([X|D],B,[X|E]):-agregarAStack(D,B,E).

%Predicado que revisa si el elemento ingresado existe en la lista
estaEnStack(R, [R|_]).
estaEnStack(R,[_|S]) :- estaEnStack(R,S).

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

