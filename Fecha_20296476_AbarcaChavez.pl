% TDA Fecha
% Composicion: [Dia, Mes, Anio] -> [integer, integer, integer]

%Constructores
fecha(Dia, Mes, Anio, F) :- F = [Dia, Mes, Anio].
%Selectores
obtenerDia(F, Dia) :- [Dia|_] = F.
obtenerMes(F, Mes) :- [_|[Mes|_]] = F.
obtenerAnio(F, Anio) :- [_|[_|[Anio|_]]] = F.

%Pertenencia
esFecha(F) :- not(esLista(F)), !, fail.
esFecha(F) :- largo(F, L), L \== 3, !, fail.
%Los predicados de pertenencia siguientes deben llamar a los elementos del TDA Fecha y comprobar sus dominios (en proceso...)
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes), obtenerAnio(F, Anio), not(integer(Dia), integer(Mes), integer(Anio)), !, fail.
/*
 * Dominios a considerar:
 * Dias: 1 a 31 (dominio total, limite superior sujeto al mes apuntado)
 * Meses: 1 a 12
 * Anios: 1972 a 2021
 * Fecha limite sujeta a la fecha de entrega de este laboratorio (17/06/2021)
 * Dominio de dias x mes seleccionado:
 *	- 2: 1-28 dias (29 si es anio bisiesto -> anio%4 == 0)
 *  - 1,3,5,7,8,10,12: 1-31 dias
 *  - 4,6,9,11: 1-30 dias
*/
esFecha(F) :- obtenerDia(F, Dia), Dia > 31 ; Dia < 1, !, fail.
esFecha(F) :- obtenerMes(F, Mes), Mes > 12 ; Mes < 1, !, fail.
esFecha(F) :- obtenerAnio(F, Anio), Anio > 2021 ; Anio < 1972, !, fail.
%Fecha de entrega
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes), obtenerAnio(F, Anio), (Dia > 17),(Mes > 6; Mes == 6),(Anio > 2021; Anio == 2021), !, fail .
%Casos x mes
%Febrero
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes), obtenerAnio(F, Anio), Mes == 2, 0 is mod(Anio, 4), not(Dia < 29), !, fail.
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes), obtenerAnio(F, Anio), Mes == 2, not(0 is mod(Anio, 4)), not(Dia < 30), !, fail.
%Meses con 30 dias
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes),
    (Mes == 4; Mes == 6; Mes == 9; Mes == 11), not(Dia < 31), !, fail.
% Meses con 31 dias (Probablemente se elimine, pues el rango de dias
% posibles para este caso esta cubierto por la primera sentencia)
esFecha(F) :- obtenerDia(F, Dia), obtenerMes(F, Mes),
    (Mes == 1; Mes == 3; Mes == 5; Mes == 7; Mes == 8; Mes == 10; Mes == 12), not(Dia < 32), !, fail.

%Modificadores

%Otros
