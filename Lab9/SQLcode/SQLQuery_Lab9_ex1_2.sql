DROP PROCEDURE IF EXISTS Lab9_ex1_2
GO

CREATE PROCEDURE Lab9_ex1_2
   @nume VARCHAR(10) = 'Florea', 
   @prenume VARCHAR(10) = 'Ioan' 
AS

SELECT DISTINCT disciplineS.Disciplina
FROM disciplineS JOIN reusitaS ON disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
				 JOIN studentiS ON reusitaS.Id_Student = studentiS.Id_Student
WHERE Nume_Student = @nume	
AND   Prenume_Student = @prenume	
      	    