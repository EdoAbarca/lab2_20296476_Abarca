% TDA Fecha
% Composicion: [Dia, Mes, Anio] -> [integer, integer, integer]

/*
%Dominio
Dia: Entero positivo, dia para TDA Fecha
Mes: Entero positivo, mes para TDA Fecha
Anio: Entero positivo, anio para TDA Fecha
Fecha: TDA, lista de 3 elementos que representa una fecha en formato [dd, mm, yyyy]
StringF: Version en string del TDA Fecha, formato dd/mm/yyyy
DiaString: Version en string de Dia
MesString: Version en string de Mes
AnioString: Version en string de Fecha

%Predicados
fecha(Dia, Mes, Anio, Fecha)
obtenerDia(Fecha, Dia)
obtenerMes(Fecha, Mes)
obtenerAnio(Fecha, Anio)
esFecha(Fecha)
fechaAString(Fecha, StringF)

%Metas
% Principales
fecha
esFecha
fechaAString

% Secundarias
obtenerDia
obtenerMes
obtenerAnio

%Clausulas
%Reglas y hechos
*/

%Constructor
fecha(Dia, Mes, Anio, Fecha) :- Fecha = [Dia, Mes, Anio].

%Selectores
obtenerDia(Fecha, Dia) :-   [Dia|_] = Fecha.
obtenerMes(Fecha, Mes) :-   [_|[Mes|_]] = Fecha.
obtenerAnio(Fecha, Anio) :- [_|[_|[Anio|_]]] = Fecha.

%Pertenencia
%Pasos para verificar validez TDA Fecha:
%1) Debe ser una lista con 3 elementos
esFecha(Fecha) :- not(esLista(Fecha)), !, fail.
esFecha(Fecha) :- largo(Fecha, L), L =\= 3, !, fail.
%2) Los elementos dentro de la lista deben ser enteros
esFecha(Fecha) :- obtenerDia(Fecha, Dia), not(integer(Dia)), !, fail.
esFecha(Fecha) :- obtenerMes(Fecha, Mes), not(integer(Mes)), !, fail.
esFecha(Fecha) :- obtenerAnio(Fecha, Anio), not(integer(Anio)), !, fail.
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
esFecha(Fecha) :- obtenerDia(Fecha, Dia), (Dia > 31 ; Dia < 1), !, fail.
esFecha(Fecha) :- obtenerMes(Fecha, Mes), (Mes > 12 ; Mes < 1), !, fail.
esFecha(Fecha) :- obtenerAnio(Fecha, Anio), (Anio > 2021 ; Anio < 1972), !, fail.
%Fecha limite para fecha actual, sujeta a entrega de esta implementacion
esFecha(Fecha) :- obtenerDia(Fecha, Dia), obtenerMes(Fecha, Mes), obtenerAnio(Fecha, Anio), (Mes >= 7), (Anio >= 2021), (Dia > 12), !, fail.
%Casos por mes
%Febrero
esFecha(Fecha) :- obtenerDia(Fecha, Dia), obtenerMes(Fecha, Mes), obtenerAnio(Fecha, Anio), Mes == 2, Bisiesto is mod(Anio, 4), Bisiesto =\= 0, Dia > 28, !, fail.
esFecha(Fecha) :- obtenerDia(Fecha, Dia), obtenerMes(Fecha, Mes), obtenerAnio(Fecha, Anio), Mes == 2, Bisiesto is mod(Anio, 4), Bisiesto == 0, Dia > 29, !, fail.
%Meses con 30 dias
esFecha(Fecha) :- obtenerDia(Fecha, Dia), obtenerMes(Fecha, Mes),
    (Mes == 4; Mes == 6; Mes == 9; Mes == 11), Dia > 30, !, fail.
% Meses con 31 dias esta cubierto por la sentencia del predicado que verifica el dominio de esta, por lo que no sera implementado.
% Todos los dominios verificados, el elemento ingresado es un TDA Fecha. ¿Es necesario el '!'?
esFecha(_) :- !, true.

%Modificadores
%Sin modificadores.

%Otros
% Convertir TDA Fecha a string
fechaAString(Fecha, StringF) :- obtenerDia(Fecha, Dia), number_string(Dia, DiaString), obtenerMes(Fecha, Mes), number_string(Mes, MesString), obtenerAnio(Fecha, Anio), number_string(Anio, AnioString),
                string_concat(DiaString, "/", Parte1S), string_concat(MesString, "/", Parte2S), string_concat(Parte1S, Parte2S, StringDiaYMes), string_concat(StringDiaYMes, AnioString, StringFecha), StringF = StringFecha.
