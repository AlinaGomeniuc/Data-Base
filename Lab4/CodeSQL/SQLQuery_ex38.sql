
select Disciplina, AVG(cast(Nota as float)) as Media
from discipline, studenti_reusita
where discipline.Id_Disciplina = studenti_reusita.Id_Disciplina 
group by Disciplina
having AVG(cast(Nota as float))<(
                  select AVG(cast(Nota as float))
				  from discipline, studenti_reusita
				  where Disciplina = 'Baze de date'
				  group by Disciplina )

