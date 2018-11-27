DROP FUNCTION IF EXISTS Lab9_ex6_2
GO
CREATE FUNCTION Lab9_ex6_2 (@nume VARCHAR(20), @prenume VARCHAR(20))
RETURNS TABLE
AS
RETURN
(SELECT DISTINCT disciplineS.Disciplina
FROM disciplineS JOIN reusitaS ON disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
				 JOIN studentiS ON reusitaS.Id_Student = studentiS.Id_Student
WHERE Nume_Student = @nume	
AND   Prenume_Student = @prenume	)