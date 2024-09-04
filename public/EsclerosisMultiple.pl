% Hechos: Síntomas de la esclerosis múltiple 
sintoma('Espasmos'). 
sintoma('Espasmos'). 
sintoma('Entumecimiento'). 
sintoma('Debilidad Muscular'). 
sintoma('Dificultad de coordinacion'). 
sintoma('Habla arrastrada'). 
sintoma('Incontinencia urinaria'). 
sintoma('Vision Borrosa'). 
sintoma('Vision doble'). 
sintoma('Perdida de vision'). 
sintoma('Fatiga persistente'). 
 
% Pruebas 
prueba(resonancia_magnetica, positivo). % detecta lesiones en el sistema nervioso central, como placas o áreas de inflamación.
prueba(puncion_lumbar, positivo). % indica bandas oligoclonales, que pueden indicar la presencia de la esclerosis múltiple
prueba(electromiografia, negativo). % evalúa la actividad eléctrica de los músculos y los nervios que los controlan.

% Medicamentos 
medicamento(leve, 'Copaxone'). %puede retrasar la progresión de la enfermedad
medicamento(leve, 'Esteroides').%reduce inflamación en el sistema nervioso central
medicamento(moderada,'Fingolimod').%reduce migración de ciertas células del sistema inmunológico desde los ganglios linfáticos hacia el sistema nervioso central
medicamento(severa, 'Interferones'). %regula la respuesta inmunológica y reduce inflamación en el sistema nervioso central

%Tratamientos
tratamiento(leve, 'Terapia de rehabilitación cognitiva').
tratamiento(leve, 'Nutrición y suplementos como antioxidantes, ácidos grasos omega-3 y vitamina D').
tratamiento(moderada, 'Estimulación cognitiva y actividades mentales').
tratamiento(moderada, 'Terapia de rehabilitación en el agua').
tratamiento(severa, 'Psicoterapia y grupos de apoyo').

% Reglas de Gravedad (esclerosis_leve, esclerosis_moderada, esclerosis_severa)
gravedad(leve, "Esclerosis Multiple Remitente-Recurrente (EMRR)").
gravedad(leve, "Esclerosis Multiple Recurrente-Remitente (EMRR) sin lesiones en RM cerebral"). 
gravedad(moderada, "Esclerosis Multiple Primaria Progresiva (EMPP)"). 
gravedad(severa, "Esclerosis Multiple Secundaria Progresiva (EMSP)"). 
  
sintomas_graves(Sintomas) :-
    member('Incontinencia urinaria', Sintomas),
    member('Perdida de vision', Sintomas),
    member('Habla arrastrada', Sintomas).

sintomas_leves(Sintomas) :-
    member('Entumecimiento', Sintomas),
    member('Debilidad Muscular', Sintomas),
    member('Fatiga persistente', Sintomas).

sintomas_moderados(Sintomas) :-
    member('Espasmos', Sintomas),
    member('Vision doble', Sintomas),
    member('Dificultad de coordinacion', Sintomas).

% Regla para verificar si un paciente tiene esclerosis múltiple 
diagnostico_esclerosis_multiple(Paciente, Sintomas, ResultadosExamenes) :- 
    findall(X, sintoma(X), Lista_Sintomas),
    verifica_sintomas(Sintomas, Lista_Sintomas),
    verifica_puncion_lumbar(ResultadosExamenes),
    length(Sintomas, NumSintomas), 
    NumSintomas >= 3,
    write('El paciente '), write(Paciente), write(' tiene un diagnostico de esclerosis multiple. '), nl ,
    tipo_esclerosis(Sintomas, ResultadosExamenes, Tipo),
    write('Tipo de Esclerosis Multiple: '), write(Tipo), nl,
    evaluar_gravedad(Tipo, Gravedad),
    write('Gravedad: '), write(Gravedad), nl ,
    tratamiento_medicamento(Gravedad, Tratamiento, Medicamento),
    write('Tratamiento recomendado: '), write(Tratamiento), nl ,
    write('Medicamento recomendado: '), write(Medicamento).

% Regla auxiliar: Verifica si los sintomas del paciente pertenecen a los sintomas declarados para la enfermedad
verifica_sintomas([], _). 
verifica_sintomas([X | Resto_Sintomas], Lista_Sintomas) :- 
    member(X, Lista_Sintomas), 
    verifica_sintomas(Resto_Sintomas, Lista_Sintomas). 

% Regla auxiliar: Verifica si la prueba puncion_lumbar fue positiva
verifica_puncion_lumbar([]):- false.
verifica_puncion_lumbar([puncion_lumbar(positivo)|_]) :- !.
verifica_puncion_lumbar([_|Resto]) :-
  verifica_puncion_lumbar(Resto).

% Regla para evaluar la gravedad según la cantidad de síntomas 
evaluar_gravedad(Tipo, Gravedad):-  
    gravedad(Gravedad, Tipo).

% Regla para clasificar el tipo de esclerosis múltiple 
% Basado en los resultados de los exámenes (RM cerebral y LCR). 
tipo_esclerosis(Sintomas, ResultadosExamenes, Tipo) :-
    verifica_resonancia_magnetica(ResultadosExamenes),
    (sintomas_leves(Sintomas),
    not(sintomas_graves(Sintomas)),
    length(Sintomas, NumSintomas), NumSintomas < 5), !,
    Tipo = "Esclerosis Multiple Remitente-Recurrente (EMRR)".

tipo_esclerosis(Sintomas, ResultadosExamenes, Tipo) :-
    ( cumple_pruebas(ResultadosExamenes),
    sintomas_moderados(Sintomas),
    not(sintomas_graves(Sintomas)) ), !,
    Tipo = "Esclerosis Multiple Primaria Progresiva (EMPP)".

tipo_esclerosis(Sintomas, ResultadosExamenes, Tipo) :-
    cumple_pruebas(ResultadosExamenes),
    sintomas_graves(Sintomas), !,
    Tipo = "Esclerosis Multiple Secundaria Progresiva (EMSP)".

tipo_esclerosis(_, _, Tipo) :-
   Tipo = "Esclerosis Multiple Recurrente-Remitente (EMRR) sin lesiones en RM cerebral".
 

% Regla para verificar si el resultado de las pruebas coincide con el tipo de esclerosis multiple a especificar
cumple_pruebas([]).
cumple_pruebas([Prueba|Resto]) :-
    Prueba =.. [Nombre, Resultado],
    (Nombre = electromiografia, prueba(Nombre, negativo)) ; prueba(Nombre, positivo),
    cumple_pruebas(Resto).

% Regla auxiliar: Verifica si la prueba resonancia_magnetica fue positiva
verifica_resonancia_magnetica([]):- false.
verifica_resonancia_magnetica([resonancia_magnetica(positivo)|_]) :- !.
verifica_resonancia_magnetica([_|Resto]) :-
  verifica_resonancia_magnetica(Resto).


% Regla para proporcionar medicamento y tratamiento 
tratamiento_medicamento(Gravedad, Tratamiento,  Medicamento) :-
    medicamento(Gravedad, Medicamento),
    tratamiento(Gravedad, Tratamiento).

pares([], []).
pares([X], []).
pares([X,Y|Resto], [Y|Respuesta]):- pares(Resto, Respuesta).

pertenece(X,[X|_]).
pertenece(X,[_|L]):-pertenece(X,L).

diferente(X, Y) :- \+(X = Y).

insertar(X, [], [X|[]]).
insertar(X, [X|R], [X|R]).
insertar(X, [Y|R], [Y|RR]):- diferente(X,Y),insertar(X,R,RR).

generar(E1,E2,[]):-
      E2=:=E1+1.
generar(E1,E2, [X|R]):-
X is E1+1,
X < E2,
generar(X,E2,R).
%generar(2,9,X). 


lista(L2):- bagof(X, sintoma(X), L2).
%consult('EsclerosisMultiple').
