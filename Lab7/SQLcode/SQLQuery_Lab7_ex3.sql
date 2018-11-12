
create table orarul ( Id_Disciplina int NOT NULL,
					  Id_Profesor int NOT NULL,
					  Id_Grupa smallint default(1),
					  Zi char(2),
					  Ora Time,
					  Auditoriu int,
					  Bloc char(1) default('B') NOT NULL,
					  PRIMARY KEY (Id_Grupa, Zi, Ora, Auditoriu)
					  )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 107, 101, 'Lu','08:00', 202 )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 108, 101, 'Lu','11:30', 501 )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 109, 117, 'Lu','13:00', 501 )

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora, Auditoriu)
values ((select Id_Disciplina from discipline where Disciplina = 'Structuri de date si algoritmi'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Bivol' and Prenume_Profesor = 'Ion'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '08:00', 222)

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora, Auditoriu)
values ((select Id_Disciplina from discipline where Disciplina = 'Programe aplicative'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Mircea' and Prenume_Profesor = 'Sorin'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '11:30', 500)

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora, Auditoriu)
values ((select Id_Disciplina from discipline where Disciplina = 'Baze de date'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Micu' and Prenume_Profesor = 'Elena'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '13:00', 111)