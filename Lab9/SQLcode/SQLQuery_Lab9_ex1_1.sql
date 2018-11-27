DROP PROCEDURE IF EXISTS Lab9_ex1;
GO

CREATE PROCEDURE Lab9_ex1
		@evaluare VARCHAR(20) = 'examen',
		@data SMALLINT = 2018,
		@disciplina VARCHAR(20) = 'Baze de date',
		@nota1 SMALLINT = 4,
		@nota2 SMALLINT = 8
AS

SELECT studentiS.Nume_Student, studentiS.Prenume_Student
FROM studentiS JOIN reusitaS ON studentiS.Id_Student = reusitaS.Id_Student
			   JOIN disciplineS ON reusitaS.Id_Disciplina = disciplineS.Id_Disciplina
WHERE Tip_Evaluare = @evaluare
AND   YEAR(Data_Evaluare) = @data
AND   Disciplina = @disciplina
AND   Nota BETWEEN @nota1 and @nota2;

