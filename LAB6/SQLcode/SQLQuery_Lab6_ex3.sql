ALTER TABLE grupe
ADD Sef_grupa int;
   -- Prof_Indrumator int;
   select * from grupe
DECLARE @nr_grupe int = (select count(Id_Grupa)
						 from grupe)
DECLARE @index int = 1;

while (@index <= @nr_grupe)
begin
	UPDATE grupe
	set Sef_grupa = (select  x.Id_Student
					  from (select Id_Student , avg(cast(Nota as float)) as Media
							from studenti_reusita
							where Id_Grupa = @index
							group by  Id_Student
							having avg(cast(Nota as float)) >= all(select avg(cast(Nota as float))
																	from studenti_reusita
																	where Id_Grupa = @index
																	group by Id_Student)  
																	  ) as x)
																	  
		where Id_Grupa = @index
		 set @index = @index +1;
					end
				