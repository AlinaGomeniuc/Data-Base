# Laboratory work nr.7
## Diagrame, Scheme si Sinonime

### Sarcini practice:
### Task 1
Creați o diagramă a bazei de date, folosind forma de vizualizare standard, structura căreia este descrisă la începutul sarcinilor practice din capitolul 4.
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_20_56_27.png)

### Task 2
Să se adauge constrîngeri referențiale (legate cu tabelele studenti și profesori) necesare coloanelor Sef_grupa și Prof_Indrumator (sarcina3, capitolul 6) din tabelul grupe.

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_21_40_33.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_21_41_27.png)

The new database diagram
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_21_46_40.png)

### Task 3
La diagrama construită, să se adauge și tabelul orarul definit în capitolul 6 al acestei lucrari:tabelul orarul conține identificatorul disciplinei (ld_Disciplina), identificatorul profesorului(Id_Profesor) și blocul de studii (Bloc). Cheia tabelului este constituită din trei cîmpuri:identificatorul grupei (Id_ Grupa), ziua lectiei (Z1), ora de inceput a lectiei (Ora), sala unde are loc lectia (Auditoriu)

```SQL
create table orarul ( Id_Disciplina int NOT NULL,
					  Id_Profesor int NOT NULL,
					  Id_Grupa smallint default(1),
					  Zi char(2),
					  Ora Time,
					  Auditoriu int,
					  Bloc char(1) default('B') NOT NULL,
					  PRIMARY KEY (Id_Grupa, Zi, Ora, Auditoriu)
					  )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 107, 101, 'Lu','08:00', 202 )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 108, 101, 'Lu','11:30', 501 )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 109, 117, 'Lu','13:00', 501 )

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora, Auditoriu)
values ((select Id_Disciplina from discipline where Disciplina = 'Structuri de date si algoritmi'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Bivol' and Prenume_Profesor = 'Ion'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '08:00', 222)

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora, Auditoriu)
values ((select Id_Disciplina from discipline where Disciplina = 'Programe aplicative'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Mircea' and Prenume_Profesor = 'Sorin'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '11:30', 500)

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora, Auditoriu)
values ((select Id_Disciplina from discipline where Disciplina = 'Baze de date'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Micu' and Prenume_Profesor = 'Elena'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '13:00', 111)
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_22_22_37.png)

### Task 4
Tabelul orarul trebuie să conțină și 2 chei secundare: (Zi, Ora, Id_ Grupa, Id_ Profesor) și (Zi, Ora, ld_Grupa, ld_Disciplina).

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_23_46_47.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_23_54_12.png)

### Task 5
În diagrama, de asemenea, trebuie sa se defineasca constrangerile referentiale (FK-PK) ale atributelor ld_Disciplina, ld_Profesor, Id_ Grupa din tabelului orarul cu atributele tabelelor respective.

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_23_59_17.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_12_11_2018_23_11_24.png)

### Task 6
Creați, în baza de date universitatea, trei scheme noi: cadre_didactice, plan_studii și studenti. Transferați tabelul profesori din schema dbo in schema cadre didactice, ținînd cont de dependentele definite asupra tabelului menționat. În același mod să se trateze tabelele orarul,discipline care aparțin schemei plan_studii și tabelele studenți, studenti_reusita, care apartin schemei studenti. Se scrie instructiunile SQL respective.

```SQL
CREATE SCHEMA cadre_didactice
GO
ALTER SCHEMA cadre_didactice TRANSFER dbo.profesori

GO
CREATE SCHEMA plan_studii
GO
ALTER SCHEMA plan_studii TRANSFER dbo.orarul
ALTER SCHEMA plan_studii TRANSFER dbo.discipline

GO
CREATE SCHEMA studenti
GO
ALTER SCHEMA studenti TRANSFER dbo.studenti
ALTER SCHEMA studenti TRANSFER dbo.studenti_reusita
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_13_11_2018_00_13_34.png)

### Task 7
Modificati 2-3 interogari asupra bazei de date universitatea prezentate in capitolul 4 astfel ca numele tabelelor accesate sa fie descrise in mod explicit, ținînd cont de faptul ca tabelele au fost mutate in scheme noi.

ex.10
Gasiti studentii (numele, prenumele), care au obtinut la disciplina Baze de date (examen), în anul 2018, vreo nota mai mica de 8 si mai mare ca 4.

```SQL
SELECT distinct studenti.studenti.Nume_Student , studenti.studenti.Prenume_Student 
FROM studenti.studenti, plan_studii.discipline , studenti.studenti_reusita
Where studenti.studenti.Id_Student = studenti.studenti_reusita.Id_Student
and plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
and studenti.studenti_reusita.Tip_Evaluare = 'examen' 
and year(studenti.studenti_reusita.Data_Evaluare) = 2018 
and plan_studii.discipline.Disciplina = 'Baze de date'
and studenti.studenti_reusita.Nota between  4 and 8
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_13_11_2018_00_36_03.png)

ex.13
Aflati cursurile urmate de catre studentul Florea loan.

```SQL
SELECT DISTINCT plan_studii.discipline.Disciplina 
FROM plan_studii.discipline, studenti.studenti_reusita, studenti.studenti
WHERE plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
AND studenti.studenti_reusita.Id_Student = studenti.studenti.Id_Student
AND  studenti.studenti.Nume_Student = 'Florea' 
AND   studenti.studenti.Prenume_Student = 'Ioan'
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_13_11_2018_00_41_58.png)

ex.24
Sa se afiseze lista disciplinelor(Disciplina) predate de cel putin doi profesori.

```SQL
select plan_studii.discipline.Disciplina, COUNT(distinct studenti.studenti_reusita.Id_Profesor) as Nr_profesori
from plan_studii.discipline, studenti.studenti_reusita
where plan_studii.discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
group by plan_studii.discipline.Disciplina
having count(distinct studenti.studenti_reusita.Id_Profesor) > 1
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_13_11_2018_00_44_05.png)


### Task 8
Creați sinonimele respective pentru a simplifica interogările construite în exercițiul precedent și reformulați interogările, folosind sinonimele create.

ex.10
```SQL
CREATE SYNONYM studentiS FOR studenti.studenti
CREATE SYNONYM reusitaS FOR studenti.studenti_reusita
CREATE SYNONYM disciplineS FOR plan_studii.discipline

SELECT distinct studentiS.Nume_Student , studentiS.Prenume_Student 
FROM studentiS, disciplineS , reusitaS
Where studentiS.Id_Student = reusitaS.Id_Student
and disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
and reusitaS.Tip_Evaluare = 'examen' 
and year(reusitaS.Data_Evaluare) = 2018 
and disciplineS.Disciplina = 'Baze de date'
and reusitaS.Nota between  4 and 8
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_13_11_2018_00_36_03.png)

ex.13
```SQL
SELECT DISTINCT disciplineS.Disciplina 
FROM disciplineS, reusitaS, studentiS
WHERE disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
AND reusitaS.Id_Student = studentiS.Id_Student
AND  studentiS.Nume_Student = 'Florea' 
AND   studentiS.Prenume_Student = 'Ioan'
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_13_11_2018_00_41_58.png)

ex.24
```SQL
select disciplineS.Disciplina, COUNT(distinct reusitaS.Id_Profesor) as Nr_profesori
from disciplineS, reusitaS
where disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
group by disciplineS.Disciplina
having count(distinct reusitaS.Id_Profesor) > 1
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab7/images/VirtualBox_Alina_13_11_2018_00_44_05.png)
