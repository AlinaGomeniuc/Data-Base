ALTER VIEW View_ex1_Lab8 WITH SCHEMABINDING AS
SELECT distinct studentiS.Nume_Student , studentiS.Prenume_Student 
FROM studentiS, disciplineS , reusitaS
Where studentiS.Id_Student = reusitaS.Id_Student
and disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
and reusitaS.Tip_Evaluare = 'examen' 
and year(reusitaS.Data_Evaluare) = 2018 
and disciplineS.Disciplina = 'Baze de date'
and reusitaS.Nota between  4 and 8
WITH CHECK OPTION;
