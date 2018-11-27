DROP PROCEDURE IF EXISTS Lab9_ex2;
GO

CREATE PROCEDURE Lab9_ex2
   @nr_de_studenti SMALLINT = NULL OUTPUT
AS
  
SELECT @nr_de_studenti =  COUNT(DISTINCT Id_student) 
FROM reusitaS
WHERE Nota < 5 or Nota = NULL
  
 


