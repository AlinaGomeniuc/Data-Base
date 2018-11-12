SELECT DISTINCT disciplineS.Disciplina 
FROM disciplineS, reusitaS, studentiS
WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
AND reusitaS.Id_Student = studentiS.Id_Student
AND  studentiS.Nume_Student = 'Florea' 
AND   studentiS.Prenume_Student = 'Ioan'