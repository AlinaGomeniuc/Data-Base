
DROP PROCEDURE IF EXISTS Lab9_ex4
GO
CREATE PROCEDURE Lab9_ex4
@nume_prof_vechi VARCHAR(60),
@prenume_prof_vechi VARCHAR(60),
@nume_prof_nou VARCHAR(60),
@prenume_prof_nou VARCHAR(60),
@disciplina VARCHAR(20)

AS


IF(( SELECT disciplineS.Id_Disciplina FROM disciplineS WHERE Disciplina = @disciplina)
     IN (SELECT DISTINCT reusitaS.Id_Disciplina FROM reusitaS WHERE Id_Profesor =
	     (SELECT cadre_didactice.profesori.Id_Profesor FROM cadre_didactice.profesori WHERE Nume_Profesor = @nume_prof_vechi 
																				      AND Prenume_Profesor = @prenume_prof_vechi)))
BEGIN

UPDATE reusitaS
SET Id_Profesor =  (SELECT Id_Profesor
			      FROM cadre_didactice.profesori
				  WHERE Nume_Profesor = @nume_prof_nou
				  AND   Prenume_Profesor = @prenume_prof_nou)

WHERE Id_Profesor = (SELECT Id_profesor
					 FROM cadre_didactice.profesori
     			     WHERE Nume_Profesor = @nume_prof_vechi
					 AND Prenume_Profesor = @prenume_prof_vechi)

END
ELSE
BEGIN
  PRINT 'Something went wrong, check the input parameters'
END






				



