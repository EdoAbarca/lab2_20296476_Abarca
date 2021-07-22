% TDA SocialNetwork
% Composicion: [NombreRedSocial, FechaRegistro, ContenidoSN]
%              -> [string, TDA Fecha, TDA ContenidoSN]

/*
%Dominio
SN: TDA SocialNetwork
NombreSN: String, nombre asignado para el TDA SocialNetwork
FechaSN: TDA Fecha, fecha de registro asignada para el TDA SocialNetwork
ContenidoSN: TDA ContenidoSN, contenedor de los usuarios registrados, publicaciones realizadas y reacciones ocurridas.
ContenidoSNAct: TDA ContenidoSN, actualizado luego del procesamiento interno del predicado principal llamado.
SNAct: TDA SocialNetwork con TDA ContenidoSN actualizado

%Predicados
socialNetworkVacio(NombreSN, FechaSN, SN)
socialNetwork(NombreSN, FechaSN, SN)
getNombreSN(SN, NombreSN)
getFechaRegistroSN(SN, FechaSN)
getContenidoSN(SN, ContenidoSN)
esSocialNetwork(SN)
actualizarSocialNetwork(SN, ContenidoSNAct, SNAct)

%Metas
%Principales
socialNetworkVacio
socialNetwork
esSocialNetwork
actualizarSocialNetwork

%Secundarias
getNombreSN
getFechaRegistroSN
getContenidoSN

%Clausulas
%Hechos y reglas
*/

%Constructores
socialNetworkVacio(NombreSN, FechaSN, SN) :- contenidoSNVacio(CSNV), SN = [NombreSN, FechaSN, CSNV].
%socialNetwork(NombreSN, FechaSN, SN) :- contenidoSNCustom(CSNC), SN = [NombreSN, FechaSN, CSNC].

%Selectores
getNombreSN(SN, NombreSN) :- 		[NombreSN|_] = SN.
getFechaRegistroSN(SN, FechaSN) :- 	[_|[FechaSN|_]] = SN.
getContenidoSN(SN, ContenidoSN) :- 	[_|[_|[ContenidoSN|_]]] = SN.

%Pertenencia
esSocialNetwork(SN) :- not(esLista(SN)), !, fail.
esSocialNetwork(SN) :- largo(SN, L), L =\= 3, !, fail.
esSocialNetwork(SN) :- getNombreSN(SN, NombreSN), not(string(NombreSN)), !, fail.
esSocialNetwork(SN) :- getFechaRegistroSN(SN, FechaSN), not(esFecha(FechaSN)), !, fail.
esSocialNetwork(SN) :- getContenidoSN(SN, ContenidoSN), not(esContenidoSN(ContenidoSN)), !, fail.
esSocialNetwork(_) :- !, true.

%Modificadores
actualizarSocialNetwork(SN, ContenidoSNAct, SNAct) :- getNombreSN(SN, NombreSN), getFechaRegistroSN(SN, FechaSN), SNAct = [NombreSN, FechaSN, ContenidoSNAct].

%Otros
