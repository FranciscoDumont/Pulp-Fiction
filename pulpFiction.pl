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
 
%También tenemos información de los encargos que le hacen los jefes a sus empleados, codificada en la base de la siguiente forma: 
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
cantidadEncargos(Personaje,Cantidad):-findall(Personaje,encargo(Personaje,_,_),CantidadEncargos),length(CantidadEncargos,Cantidad).
masAtareado(Personaje):- forall	(personje(Personaje,_),			


*/