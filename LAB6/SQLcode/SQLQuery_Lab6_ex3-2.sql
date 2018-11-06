ALTER TABLE grupe
--ADD Sef_grupa int,
 add   Prof_Indrumator int;
   select * from grupe
DECLARE @nr_grupe int = (select count(Id_Grupa)
						 from grupe)
DECLARE @index int = 1;

while (@index <= @nr_grupe)
begin
	UPDATE grupe
	--set Sef_grupa = (select  x.Id_Student
					 -- from (select Id_Student , avg(cast(Nota as float)) as Media
						--	from studenti_reusita
							--where Id_Grupa = @index
							--group by  Id_Student
							--having avg(cast(Nota as float)) >= all(select avg(cast(Nota as float))
																	--from studenti_reusita
																	--where Id_Grupa = @index
																	--group by Id_Student)  
																	--  ) as x)
			
		set Prof_Indrumator = (select  y.Id_Profesor
					  from (select Id_Profesor , count(distinct Id_Disciplina) as Nr_de_discipline
							from studenti_reusita
							where Id_Grupa = @index
							group by  Id_Profesor
							having count(distinct Id_Disciplina) >= all(select count(distinct Id_Disciplina)
																	from studenti_reusita
																	where Id_Grupa = @index
																	group by Id_Profesor)  
																	 ) as y)	
			
																	  
		where Id_Grupa = @index
		 set @index = @index +1;
					end
				