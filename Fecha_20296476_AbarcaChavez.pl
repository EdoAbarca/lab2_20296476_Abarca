% TDA Fecha
% Composicion: [Dia, Mes, Anio] -> [integer, integer, integer]

%Constructores
fecha(Dia, Mes, Anio, F) :- F = [Dia, Mes, Anio].
%Selectores
obtenerDia(F, Dia) :- [Dia|_] = F.
obtenerMes(F, Mes) :- [_|[Mes|_]] = F.
obtenerAnio(F, Anio) :- [_|[_|[Anio|_]]] = F.

%Pertenencia
%Pasos para verificar validez TDA Fecha:
%1) Debe ser una lista con 3 elementos
esFecha(F) :- not(esLista(F)), !, fail.
esFecha(F) :- largo(F, L), L =\= 3, !, fail.
%2) Los elementos dentro de la lista deben ser enteros
esFecha(F) :- obtenerDia(F, Dia), not(integer(Dia)), !, fail.
esFecha(F) :- obtenerMes(F, Mes), not(integer(Mes)), !, fail.
esFecha(F) :- obtenerAnio(F, Anio), not(integer(Anio)), !, fail.
%3) Se debe verificar el dominio de cada elemento
/*
 * Dominios a considerar:
 * Dias: 1 a 31 (dominio total, limite superior sujeto al mes apuntado)
 * Meses: 1 a 12
 * Anios: 1972 a 2021
 * Fecha limite sujeta a la fecha de entrega de este laboratorio (2/7/2021)
 * Dominio de dias x mes seleccionado:
 *	- 2: 1-28 dias (29 si es anio bisiesto -> anio mod 4 == 0)
 *  - 1,3,5,7,8,10,12: 1-31 dias
 *  - 4,6,9,11: 1-30 dias
*/
esFecha(F) :- obtenerDia(F, Dia), (Dia > 31 ; Dia < 1), !, fail.
esFecha(F) :- obtenerMes(F, Mes), (Mes > 12 ; Mes < 1), !, fail.
esFecha(F) :- obtenerAnio(F, Anio), (Anio > 2021 ; Anio < 1972), !, fail.
%Fecha limite para fecha actual, sujeta a entrega de esta implementacion
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes), obtenerAnio(F, Anio), (Mes >= 7), (Anio >= 2021), (Dia > 2), !, fail.
%Casos por mes
%Febrero
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes), obtenerAnio(F, Anio), Mes == 2, Bisiesto is mod(Anio, 4), Bisiesto \== 0, Dia > 28, !, fail.
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes), obtenerAnio(F, Anio), Mes == 2, Bisiesto is mod(Anio, 4), Bisiesto == 0, Dia > 29, !, fail.
%Meses con 30 dias
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes),
    (Mes == 4; Mes == 6; Mes == 9; Mes == 11), Dia > 30, !, fail.
% Meses con 31 dias esta cubierto por la sentencia del predicado que verifica el dominio de esta, por lo que no sera implementado.
% Todos los dominios verificados, el elemento ingresado es un TDA Fecha. ¿Es necesario el '!'?
esFecha(_) :- !, true.

%Modificadores

%Otros