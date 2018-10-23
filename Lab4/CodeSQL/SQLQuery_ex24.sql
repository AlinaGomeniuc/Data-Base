select Disciplina, COUNT(distinct studenti_reusita.Id_Profesor) as Nr_profesori
from discipline, studenti_reusita
where discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
group by Disciplina
having count(distinct studenti_reusita.Id_Profesor) > 1