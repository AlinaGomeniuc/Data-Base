select disciplineS.Disciplina, COUNT(distinct reusitaS.Id_Profesor) as Nr_profesori
from disciplineS, reusitaS
where disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
group by disciplineS.Disciplina
having count(distinct reusitaS.Id_Profesor) > 1