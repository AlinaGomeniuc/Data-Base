-- Inserarea unui nou student in viziune (Nume, Prenume)
ALTER VIEW View_ex1_Lab8  AS
	SELECT  studentiS.Id_Student, studentiS.Nume_Student , studentiS.Prenume_Student
FROM studentiS, disciplineS , reusitaS
Where studentiS.Id_Student = reusitaS.Id_Student
and disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
and reusitaS.Tip_Evaluare = 'examen' 
and year(reusitaS.Data_Evaluare) = 2018 
and disciplineS.Disciplina = 'Baze de date'
and reusitaS.Nota between  4 and 8
GO
INSERT INTO View_ex1_Lab8 
values (99,'STUDENT', 'NOU')
GO

create view ex as 
select nume_student , Prenume_Student from studentiS
go

SELECT * FROM View_ex1_Lab8
SELECT * FROM ex

select * from studentiS

-- Modificarea unui student in viziune
UPDATE dbo.View_ex1_Lab8 
SET Prenume_Student = 'AAA'
WHERE Prenume_Student = 'Teodora'
SELECT * FROM dbo.View_ex1_Lab8

-- Stergerea unui student din viziune
delete from ex where Nume_Student = 'STUDENT'

select * from ex 
