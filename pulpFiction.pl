%pareja(Persona, Persona)
pareja(marsellus,mia).
pareja(pumkin,honeyBunny).
%trabajaPara(Empleador, Empleado)
trabajaPara(marsellus,vincent).
trabajaPara(marsellus,jules).
trabajaPara(marsellus,winston).

%saleCon/2: relaciona dos personas que están saliendo porque son pareja, independientemente de cómo esté definido en el predicado pareja/2.
saleCon(Persona,OtraPersona):-
	pareja(Persona,OtraPersona).
saleCon(Persona,OtraPersona):-
	pareja(OtraPersona,Persona).

 
