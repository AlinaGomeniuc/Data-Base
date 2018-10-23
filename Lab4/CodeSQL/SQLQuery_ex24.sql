select Disciplina, COUNT(distinct profesori.Id_Profesor) as Nr_profesori
from discipline, studenti_reusita,profesori
where discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and studenti_reusita.Id_Profesor = profesori.Id_Profesor
group by Disciplina
having count(distinct profesori.Id_Profesor) > 1