
With ex38_cte (Nota) AS
(Select AVG(cast(reusitaS.Nota as float)) as Medie
from reusitaS, disciplineS
where Disciplina = 'Baze de date')


select Disciplina, AVG(cast(reusitaS.Nota as float)) as Media
from disciplineS, reusitaS , ex38_cte
where disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
group by Disciplina
having AVG(cast(reusitaS.Nota as float))< AVG(cast(ex38_cte.Nota as float))


