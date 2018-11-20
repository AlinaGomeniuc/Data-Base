# Lucrare de laborator nr.8
## Administrarea viziunilor si a expresiilor-tabel
### Sarcini:

### Sarcina 1
Sa se creeze doua viziuni in baza interogarilor formulate in doua exercitii indicate din capitolul 4. 
Prima viziune sa fie construita in Editorul de interogari, iar a doua, utilizand View Designer.

a) Folosind Editorul de interogari

```SQL
CREATE VIEW exercitiul1 AS
	SELECT DISTINCT disciplineS.Disciplina 
	FROM disciplineS, reusitaS, studentiS
	WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
	AND reusitaS.Id_Student = studentiS.Id_Student
	AND  studentiS.Nume_Student = 'Florea' 
	AND   studentiS.Prenume_Student = 'Ioan'
GO
	SELECT * FROM exercitiul1
  ```
  
  ![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_19_11_2018_13_11_23.png)
  
  b) Folosind View Designer
  
  ![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_19_11_2018_12_59_13.png)
  ![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_22_19_36.png)
  ### Sarcina 2
  Sa se scrie cate un exemplu de instructiuni INSERT, UPDATE, DELETE asupra viziunilor create.
  Sa se adauge comentariile respective referitoare la rezultatele executarii acestor instructiuni.
  
  a) Pentru prima viziune
  ```SQL
  -- Inserarea unui nou student in viziune (Nume, Prenume)

INSERT INTO View_ex1_Lab8 
values (99,'STUDENT', 'NOU')
GO

CREATW VIEW ex AS 
SELECT Id_Student, Nume_student , Prenume_Student FROM studentiS
go

-- Modificarea unui student in viziune
UPDATE dbo.View_ex1_Lab8 
SET Prenume_Student = 'TEODORA'
WHERE Prenume_Student = 'Teodora'
SELECT * FROM dbo.View_ex1_Lab8

-- Stergerea unui student din viziune
DELETE FROM ex WHERE Nume_Student = 'STUDENT'

```
Inserarea in viziune nu a fost posibila, deoarece noul tuplu nu satisface conditia viziunii. Din aceasta cauza, tuplul a fost 
inserat doar in tabelul general. </br>
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_22_02_33.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_22_03_20.png)
</br> Ce avem in tabelul de baza : </br>
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_22_05_06.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_22_03_20.png) </br>
b)Pentru a doua viziune
```SQL
-- Inserarea unui nou student in viziune (Nume, Prenume)

CREATE VIEW exercitiul1_1 AS 
SELECT  disciplineS.Id_Disciplina, disciplineS.Disciplina 
	FROM disciplineS
GO

INSERT INTO exercitiul1 
values (1,'FIZICA')
GO

-- Modificarea unui student in viziune
UPDATE exercitiul1 
SET Disciplina = 'Noua Disciplina'
WHERE id_disciplina = 100

-- Stergerea unui student din viziune
DELETE FROM exercitiul1_1 WHERE Disciplina = 'Fizica'
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_21_12_18.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_21_09_08.png)

### Sarcina 3
Sa se scrie instructiunile SQL care ar modifica viziunile create (in exercitiul 1) in asa fel, incat sa nu fie posibila 
modificarea sau stergerea tabelelor pe care acestea sunt definite si viziunile sa nu accepte operatiuni DML, 
daca conditiile clauzei WHERE nu sunt satisfacute.

a)
```SQL
ALTER VIEW View_ex1_Lab8 WITH SCHEMABINDING AS
SELECT studenti.studenti.Id_Student, studenti.studenti.Nume_Student , studenti.studenti.Prenume_Student 
FROM studenti.studenti, plan_studii.discipline , studenti.studenti_reusita
Where studenti.studenti.Id_Student = studenti.studenti_reusita.Id_Student
and plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
and studenti.studenti_reusita.Tip_Evaluare = 'examen' 
and year(studenti.studenti_reusita.Data_Evaluare) = 2018 
and plan_studii.discipline.Disciplina = 'Baze de date'
and studenti.studenti_reusita.Nota between  4 and 8
WITH CHECK OPTION;
```

b) 
```SQL
ALTER VIEW exercitiul1 WITH SCHEMABINDING AS
SELECT  plan_studii.discipline.Id_Disciplina, plan_studii.discipline.Disciplina 
FROM plan_studii.discipline, studenti.studenti_reusita, studenti.studenti
WHERE plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
AND studenti.studenti_reusita.Id_Student = studenti.studenti.Id_Student
AND  studenti.studenti.Nume_Student = 'Florea' 
AND   studenti.studenti.Prenume_Student = 'Ioan'
WITH CHECK OPTION;
```

### Sarcina 4
Sa se scrie instructiunile de testare a proprietatilor noi definite.

a) 
1)
```SQL
ALTER TABLE studenti.studenti DROP COLUMN Nume_Student
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_19_11_2018_19_55_38.png)

2)
```SQL
INSERT INTO View_ex1_Lab8 
values (10, 'A','A',10)
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_19_11_2018_19_52_50.png)

b)
1)
```SQL
ALTER TABLE studenti.studenti DROP COLUMN Prenume_Student
```
![ALT TEXT](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_19_11_2018_20_13_17.png)

2)
```SQL
INSERT INTO exercitiul1
VALUES (1,'Baze de date')
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_19_11_2018_20_17_59.png)

### Sarcina 5
Sa se rescrie 2 interogari formulate in exercitiile din capitolul 4, in asa fel incat interogarile imbricate sa fie redate 
sub forma expresiilor CTE.

a) ex.38
Furnizati denumirile disciplinelor cu o medie mai mica decat media notelor de la disciplina Baze de date.
```SQL
With ex38_cte (Nota) AS
    (Select AVG(cast(reusitaS.Nota as float)) as Medie
     FROM reusitaS, disciplineS
     WHERE Disciplina = 'Baze de date')

SELECT Disciplina, AVG(cast(reusitaS.Nota as float)) as Media
FROM disciplineS, reusitaS , ex38_cte
WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
GROUP BY Disciplina
HAVING AVG(cast(reusitaS.Nota as float))< AVG(cast(ex38_cte.Nota as float))
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_17_07_14.png)

b) ex.13
```SQL
WITH ex13_CTE (Id_Student) AS
    (SELECT studentiS.Id_Student
     FROM studentiS
     WHERE Nume_Student = 'Florea'
     AND Prenume_Student = 'Ioan' )

SELECT distinct disciplineS.Disciplina
FROM disciplineS, ex13_CTE, reusitaS
WHERE reusitaS.Id_Student = ex13_CTE.Id_Student
AND disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_17_06_54.png)

### Sarcina 6
Se considera un graf orientat, si fie se doreste parcursa calea de la nodul id = 3 la nodul unde id = 0. 
Sa se faca reprezentarea grafului orientat in forma de expresie-tabel recursiv.

                         (4)
                          |
      (5)-> (0)<- (1)<-  (2)
                          ^
                          |
                         (3)
Sa se observe instructiunea de dupa UNION ALL a membrului recursiv, precum si partea de pana la UNION ALL reprezentata 
de membrul-ancora.

```SQL
CREATE TABLE graph (
		Id_nr int PRIMARY KEY,
		dependent_nr int
		);

INSERT INTO graph VALUES
(5,0), (4,2), (3,2), (1,0), (2,1), (0, null);

select * from graph

;WITH graph_cte AS (
		SELECT Id_nr , dependent_nr FROM graph
		WHERE Id_nr = 3 and dependent_nr = 2
		
		UNION ALL
		
		SELECT graph.Id_nr, graph.dependent_nr FROM graph
		INNER JOIN graph_cte
		ON graph.ID_nr = graph_cte.dependent_nr
		
		
	
		
)
SELECT * from graph_cte

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab8/images/VirtualBox_Alina_20_11_2018_20_06_45.png)
