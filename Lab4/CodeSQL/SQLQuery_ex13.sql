SELECT DISTINCT Disciplina 
FROM discipline
INNER JOIN studenti_reusita
ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
INNER JOIN studenti
ON studenti_reusita.Id_Student = studenti.Id_Student
WHERE Nume_Student = 'Florea' 
AND   Prenume_Student = 'Ioan'