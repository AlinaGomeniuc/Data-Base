DROP PROCEDURE IF EXISTS Lab9_ex5
GO

CREATE PROCEDURE Lab9_ex5
@disciplina VARCHAR(50)
AS
DECLARE @stud_list TABLE (Id_Student int, Media float)
INSERT INTO @stud_list
	SELECT TOP (3) reusitaS.Id_Student, AVG(cast (Nota as float)) as Media
	FROM reusitaS, disciplineS
	WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
	AND Disciplina = @disciplina
	GROUP BY reusitaS.Id_Student
	ORDER BY Media desc		

SELECT cod_grupa, studentiS.Id_Student, CONCAT(nume_student, ' ', Prenume_Student) as Nume, Disciplina, nota AS Nota_Veche, iif(nota > 9, 10, nota + 1) AS Nota_Noua 
    FROM reusitaS, disciplineS, grupe, studentiS
	WHERE disciplineS.id_disciplina = reusitaS.id_disciplina
	AND grupe.Id_Grupa = reusitaS.Id_Grupa
	AND  studentiS.Id_Student = reusitaS.Id_Student
	AND studentiS.Id_Student in (select Id_Student from @stud_list)
	AND Disciplina = @disciplina
	AND Tip_Evaluare = 'Examen'

DECLARE @id_dis SMALLINT =
(SELECT  Id_Disciplina  FROM disciplineS
WHERE   Disciplina = @disciplina)

UPDATE reusitaS
SET reusitaS.Nota = (CASE WHEN nota >= 9 THEN 10 ELSE nota + 1 END)
WHERE Tip_Evaluare = 'Examen'
AND Id_Disciplina = @id_dis
AND Id_Student in (select Id_Student from @stud_list)

go
execute Lab9_ex5 @disciplina = 'Programarea WEB'

