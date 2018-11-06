# Laboratory nr.6
## CREAREA TABELELOR ȘI INDECȘILOR
### Task 1
Sa se scrie o instructiune T-SQL, care ar popula coloana Adresa _ Postala _ Profesor din tabelul profesori cu valoarea 'mun. Chisinau',
unde adresa este necunoscută.

```SQL
UPDATE profesori set Adresa_Postala_Profesor = 'mun.Chisinau'
				 where Adresa_Postala_Profesor IS NULL;

SELECT Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor
FROM profesori
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_06_11_2018_18_10_39.png)

### Task 2
Sa se modifice schema tabelului grupe, ca sa corespunda urmatoarelor cerinte:<br/>
  a) Campul Cod_ Grupa sa accepte numai valorile unice și să nu accepte valori necunoscute. <br/>
  b) Să se țină cont că cheie primară, deja, este definită asupra coloanei Id_ Grupa. <br/>

  ```SQL
ALTER TABLE grupe 
ADD UNIQUE (Cod_Grupa)
ALTER TABLE grupe 
ALTER COLUMN Cod_Grupa char(6) NOT NULL;

select Cod_Grupa
from grupe
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_06_11_2018_18_48_06.png)

### Task 3
La tabelul grupe, să se adauge 2 coloane noi Sef_grupa și Prof_Indrumator, ambele de tip INT. Să se populeze câmpurile nou-create cu cele mai potrivite candidaturi în baza criteriilor de mai jos:

a) Șeful grupei trebuie să aibă cea mai bună reușită (medie) din grupă la toate formele de evaluare și la toate disciplinele. Un student nu poate fi șef de grupa la mai multe grupe.

b) Profesorul îndrumător trebuie să predea un număr maximal posibil de discipline la grupa data. Daca nu există o singură candidatură, care corespunde primei cerințe, atunci este ales din grupul de candidați acel cu identificatorul (Id_Profesor) minimal. Un profesor nu poate fi indrumător la mai multe grupe.

c) Să se scrie instructiunile ALTER, SELECT, UPDATE necesare pentru crearea coloanelor în tabelul grupe, pentru selectarea candidaților și înserarea datelor.

```SQL

ALTER TABLE grupe
--ADD Sef_grupa int,
 add   Prof_Indrumator int;
   select * from grupe
DECLARE @nr_grupe int = (select count(Id_Grupa)  from grupe)
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
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_06_11_2018_21_52_30.png)

### Task 4
Să se scrie o instrucțiune T-SQL, care ar mări toate notele de evaluare șefilor de grupe cu un punct. Nota maximală (10) nu poate fi mărită.

```SQL
UPDATE studenti_reusita
set Nota = Nota + 1
where Id_Student = ANY (select Sef_grupa
					  from grupe)
and Nota != 10


select  Sef_grupa, Nota, Tip_Evaluare , Id_Disciplina
from grupe	,	studenti_reusita
where grupe.Id_Grupa = studenti_reusita.Id_Grupa
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_06_11_2018_22_29_40.png)

### Task 5
Sa se creeze un tabel profesori_new, care include urmatoarele coloane: Id_Profesor,Nume _ Profesor, Prenume _ Profesor, Localitate, Adresa _ 1, Adresa _ 2.

a) Coloana Id_Profesor trebuie sa fie definita drept cheie primara și, în baza ei, sa fie construit un index CLUSTERED.

b) Cîmpul Localitate trebuie sa posede proprietatea DEFAULT= 'mun. Chisinau'.

c) Să se insereze toate datele din tabelul profesori în tabelul profesori_new. Să se scrie, cu acest scop, un număr potrivit de instrucțiuni T-SQL.

În coloana Localitate să fie inserata doar informatia despre denumirea localității din coloana-sursă Adresa_Postala_Profesor. În coloana Adresa_l, doar denumirea străzii. În coloana Adresa_2, să se păstreze numărul casei și (posibil) a apartamentului.

