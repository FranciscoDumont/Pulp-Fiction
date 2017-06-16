%pareja(Persona, Persona)
pareja(marsellus,mia).
pareja(pumkin,honeyBunny).
pareja(bernardo,bianca).
pareja(bernardo,charo).
%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus,vincent).
trabajaPara(marsellus,jules).
trabajaPara(marsellus,winston).
trabajaPara(Empleador,bernardo):-
	trabajaPara(marsellus,Empleador),
	Empleador\=jules.
trabajaPara(Empleador,george):-
	saleCon(bernardo,Empleador).

% saleCon/2: relaciona dos personas que están saliendo porque son pareja, independientemente de cómo esté definido en el predicado pareja/2.
saleCon(Persona,OtraPersona):-
	pareja(Persona,OtraPersona).
saleCon(Persona,OtraPersona):-
	pareja(OtraPersona,Persona).

% ​esFiel/1 Una persona es fiel cuando sale con una única persona.
esFiel(Persona):-
	pareja(Persona,_),
	findall(OtraPersona,saleCon(Persona,OtraPersona),ListaDeParejas),
	length(ListaDeParejas,CantidadParejas),
	CantidadParejas=1.

%acataOrden/2 Alguien acata la orden de otra persona si trabaja para esa persona directa o indirectamente
acataOrden(Superior,Empleado):-
	trabajaPara(Superior,Empleado).
acataOrden(Superior,Empleado):-
	trabajaPara(Empleador,Empleado),
	acataOrden(Superior,Empleador).

% personaje(Nombre, Ocupacion)
personaje(pumkin,     ladron([estacionesDeServicio, licorerias])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).
personaje(bernardo,   mafioso(cerebro)).
personaje(bianca,     actriz([elPadrino1])).
personaje(elVendedor, vender([humo, iphone])).
personaje(jimmie,     vender([auto])).

% encargo(Solicitante, Encargado, Tarea). 
% las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).
encargo(bernardo, vincent, buscar(jules, fuerteApache)).
encargo(bernardo, winston, buscar(jules, sanMartin)).
encargo(bernardo, winston, buscar(jules, lugano)).
 
%Por último contamos con la información de quién es amigo de quién:
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

%esPeligroso/1. Nos dice si un personaje es peligroso. Eso ocurre cuando:
%realiza alguna actividad peligrosa: ser matón, o robar licorerías. 
%tiene un jefe peligroso

esPeligroso(Personaje):-
	haceActividadPeligrosa(Personaje).
esPeligroso(Personaje):-
	trabajaPara(Jefe,Personaje),
	esPeligroso(Jefe).

haceActividadPeligrosa(Personaje):-
	personaje(Personaje,mafioso(maton)).
haceActividadPeligrosa(Personaje):-
	personaje(Personaje,ladron(ListaRobos)),
	member(licorerias,ListaRobos).

/*sanCayetano/1 Se considera "San Cayetano" a​ ​ quien a todos los que tiene cerca les da algún encargo (y tiene al menos a alguien cerca)
Alguien tiene cerca a otro personaje si son amigos o uno trabaja para el otro*/

sonAmigos(Persona,OtraPersona):-
	amigo(Persona,OtraPersona).
sonAmigos(Persona,OtraPersona):-
	amigo(OtraPersona,Persona).

trabajanJuntos(Persona,OtraPersona):-
	trabajaPara(Persona,OtraPersona).
trabajanJuntos(Persona,OtraPersona):-
	trabajaPara(OtraPersona,Persona).

estanCerca(Persona,OtraPersona):-
	sonAmigos(Persona,OtraPersona).
estanCerca(Persona,OtraPersona):-
	trabajanJuntos(Persona,OtraPersona).

sanCayetano(Personaje):-
	estanCerca(Personaje,_),
	forall(estanCerca(Personaje,Alguien),encargo(Personaje,Alguien,_)).