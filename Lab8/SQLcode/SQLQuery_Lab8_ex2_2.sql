-- Inserarea unui nou student in viziune (Nume, Prenume)
ALTER VIEW exercitiul1  AS
	SELECT  disciplineS.Id_Disciplina, disciplineS.Disciplina 
	FROM disciplineS, reusitaS, studentiS
	WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
	AND reusitaS.Id_Student = studentiS.Id_Student
	AND  studentiS.Nume_Student = 'Florea' 
	AND   studentiS.Prenume_Student = 'Ioan'
GO
	SELECT * FROM exercitiul1
GO
alter view exercitiul1_1 as 
SELECT  disciplineS.Id_Disciplina, disciplineS.Disciplina 
	FROM disciplineS
go

drop view exercitiul1_1
go
delete from disciplineS where Id_Disciplina=1
go
INSERT INTO exercitiul1 
values (1,'FIZICA')
GO
select * from exercitiul1_1


-- Modificarea unui student in viziune
UPDATE exercitiul1 
SET Disciplina = 'Noua Disciplina'
WHERE id_disciplina = 100
SELECT * FROM exercitiul1

-- Stergerea unui student din viziune
delete from exercitiul1_1 where Disciplina = 'Fizica' 

select * from exercitiul1_1