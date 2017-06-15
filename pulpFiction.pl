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
	
