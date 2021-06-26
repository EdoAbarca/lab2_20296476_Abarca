% TDA SocialNetwork
% Composicion: [NombreRedSocial, FechaRegistro, ContenidoSN]
%              -> [string, TDA Fecha, TDA ContenidoSN]

%Constructores
socialNetworkVacio(Nombre, Fecha, SN) :- contenidoSNVacio(CSNV), SN = [Nombre, Fecha, CSNV].
%socialNetwork(Nombre, Fecha, SN) :- contenidoSNCustom(CSNC), SN = [Nombre, Fecha, CSNC].

%Selectores
getNombreSN(SN, NombreSN) :- [NombreSN|_] = SN.
getFechaRegistroSN(SN, FechaSN) :- [_|[FechaSN|_]] = SN.
getContenidoSN(SN, ContenidoSN) :- [_|[_|[ContenidoSN|_]]] = SN.

%Pertenencia
esSocialNetwork(SN) :- not(esLista(SN)), !, fail.
esSocialNetwork(SN) :- largo(SN, L), L\== 3, !, fail.
esSocialNetwork(SN) :- getNombreSN(SN, NombreSN), not(string(NombreSN)), !, fail.
esSocialNetwork(SN) :- getFechaRegistroSN(SN, FechaSN), not(esFecha(FechaSN)), !, fail.
esSocialNetwork(SN) :- getContenidoSN(SN, ContenidoSN), not(esContenidoSN(ContenidoSN)), !, fail.

%Modificadores
actualizarSocialNetwork(SN, ContenidoSNAct, SNAct) :- getNombreSN(SN, NombreSN), getFechaRegistroSN(SN, FechaSN),
    			SNAct = [NombreSN, FechaSN, ContenidoSNAct].

%Otros
