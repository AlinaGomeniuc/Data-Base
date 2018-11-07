CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS;
DBCC FREESYSTEMCACHE('ALL');
GO


SET STATISTICS IO ON;
UPDATE studenti_reusita
set Nota = Nota + 1
where Id_Student = ANY (select Sef_grupa from grupe)
and Nota != 10

select  Sef_grupa, Nota, Tip_Evaluare , Id_Disciplina
from grupe	,	studenti_reusita
where grupe.Id_Grupa = studenti_reusita.Id_Grupa
SET STATISTICS IO OFF;
