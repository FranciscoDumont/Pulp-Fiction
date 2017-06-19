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

% esFiel/1 Una persona es fiel cuando sale con una única persona.
esInfiel(Persona):- 
	saleCon(Persona,OtraPersona),
	saleCon(Persona,Amante),
	OtraPersona \= Amante.  

esFiel(Persona):- saleCon(Persona,_),not(esInfiel(Persona)).

%acataOrden/2 Alguien acata la orden de otra persona si trabaja para esa persona directa o indirectamente
acataOrden(Superior,Empleado):-
	trabajaPara(Superior,Empleado).
acataOrden(Superior,Empleado):-
	trabajaPara(Empleador,Empleado),
	acataOrden(Superior,Empleador).

%Entrega 2

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

%1) Personajes peligrosos
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

%2) San Cayetano
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

%3) Nivel de Respeto
nivelRespeto(Personaje,Nivel):-	
	personaje(Personaje,Ocupacion),
	nivelSegunOcupacion(Ocupacion,Nivel).
nivelRespeto(vincent,15).

nivelSegunOcupacion(mafioso(resuelveProblemas),10).
nivelSegunOcupacion(mafioso(capo),20).
nivelSegunOcupacion(actriz(ListaPeliculas),Nivel):-
	length(ListaPeliculas,Cantidad),
	Nivel is Cantidad/10.

%4) Personajes respetables
esRespetable(Personaje):-
	nivelRespeto(Personaje,Nivel),
	Nivel>9.

respetabilidad(Respetables , NoRespetables):-
	cantidadRespetables(Respetables),
	cantidadNoRespetables(NoRespetables).

cantidadRespetables(Respetables):-
	findall(Personaje,esRespetable(Personaje),PersonajesRespetables),
	length(PersonajesRespetables,Respetables).

cantidadNoRespetables(NoRespetables):-
	findall(Personaje,(personaje(Personaje,_),not(esRespetable(Personaje))),PersonajesNoRespetables),
	length(PersonajesNoRespetables,NoRespetables).

/*
5) Más atareado
cantidadEncargos(Personaje,CantidadEncargos):-
	encargo(_,Personaje,_),
	personaje(Personaje, _),
	findall(Encargo,encargo(_,Personaje,Encargo),ListaEncargos),
	length(ListaEncargos,CantidadEncargos).

esMasAtareadoQue(Personaje,OtroPersonaje):-
	cantidadEncargos(Personaje,CantidadPersonaje),
	cantidadEncargos(OtroPersonaje,CantidadOtroPersonaje),
	CantidadPersonaje>=CantidadOtroPersonaje.
	%Personaje\=OtroPersonaje.

masAtareado(Personaje):- %es el mas atareado si para todos los personajes él es el que tiene mas encargos
	personaje(Personaje,_),
	forall(personaje(OtroPersonaje,_),esMasAtareadoQue(Personaje,OtroPersonaje)).
	%muestra resultados repetidos
*/

%5) Más atareado
cantidadEncargos(Personaje,CantidadEncargos):-
	encargo(_,Personaje,_),
	findall(Encargo,encargo(_,Personaje,Encargo),ListaEncargos),
	length(ListaEncargos,CantidadEncargos).

esMasAtareadoQue(Personaje,OtroPersonaje):-
	cantidadEncargos(Personaje,CantidadPersonaje),
	cantidadEncargos(OtroPersonaje,CantidadOtroPersonaje),
	CantidadPersonaje>=CantidadOtroPersonaje.
	%Personaje\=OtroPersonaje.

masAtareado(Personaje):- %es el mas atareado si para todos los personajes él es el que tiene mas encargos
	encargo(_,Personaje,_),
	forall(encargo(_,OtroPersonaje,_),esMasAtareadoQue(Personaje,OtroPersonaje)).