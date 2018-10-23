SELECT distinct Nume_Student , Prenume_Student 
FROM studenti, studenti_reusita, discipline
Where studenti.Id_Student = studenti_reusita.Id_Student
and discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and Tip_Evaluare = 'examen' 
and year(Data_Evaluare) = 2018 
and Disciplina = 'Baze de date'
and Nota between  4 and 8