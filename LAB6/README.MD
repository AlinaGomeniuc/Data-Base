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

```SQL
CREATE TABLE profesori_new
(Id_Profesor int NOT NULL
 ,Nume_Profesor char(255)
 ,Prenume_Profesor char(255)
 ,Localitate char (60) DEFAULT ('mun. Chisinau')
 ,Adresa_1 char (60)
 ,Adresa_2 char (60),
  CONSTRAINT [PK_profesori_new] PRIMARY KEY CLUSTERED 
(	Id_Profesor )) ON [PRIMARY]

INSERT INTO profesori_new (Id_Profesor,Nume_Profesor, Prenume_Profesor, Localitate,Adresa_1, Adresa_2)
(SELECT Id_Profesor, Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor
from profesori)

UPDATE profesori_new
SET Localitate = case when CHARINDEX(', s.',Localitate) >0
				 then case when CHARINDEX (', str.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX (', str.',Localitate)-1)
					        when CHARINDEX (', bd.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX (', bd.',Localitate)-1)
				      end
				  when  CHARINDEX(', or.',Localitate) >0
				 then case when CHARINDEX (', str.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX ('str.',Localitate)-3)
					        when CHARINDEX (', bd.',Localitate) > 0
							then SUBSTRING (Localitate,1, CHARINDEX ('bd.',Localitate)-3)
					  end
				when CHARINDEX('nau',Localitate) >0
				then SUBSTRING(Localitate, 1, CHARINDEX('nau',Localitate)+2)
				end
UPDATE profesori_new
SET Adresa_1 = case when CHARINDEX('str.', Adresa_1)>0
					then SUBSTRING(Adresa_1,CHARINDEX('str',Adresa_1), PATINDEX('%, [0-9]%',Adresa_1)- CHARINDEX('str.',Adresa_1))
			        when CHARINDEX('bd.',Adresa_1)>0
					then SUBSTRING(Adresa_1,CHARINDEX('bd',Adresa_1), PATINDEX('%, [0-9]%',Adresa_1) -  CHARINDEX('bd.',Adresa_1))
			   end

UPDATE profesori_new
SET Adresa_2 = case when PATINDEX('%, [0-9]%',Adresa_2)>0
					then SUBSTRING(Adresa_2, PATINDEX('%, [0-9]%',Adresa_2)+1,len(Adresa_2) - PATINDEX('%, [0-9]%',Adresa_2)+1)
				end
				
select * from profesori_new

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_21_02_01.png)

### Task 6
Să se insereze datele in tabelul orarul pentru Grupa= 'CIBJ 71' (Id_ Grupa= 1) pentru ziua de luni. Toate lectiile vor avea loc în blocul de studii 'B'. Mai jos, sunt prezentate detaliile de inserare:

(ld_Disciplina = 107, Id_Profesor= 101, Ora ='08:00', Auditoriu = 202);

(Id_Disciplina = 108, Id_Profesor= 101, Ora ='11:30', Auditoriu = 501);

(ld_Disciplina = 119, Id_Profesor= 117, Ora ='13:00', Auditoriu = 501);

```SQL
create table orarul ( Id_Disciplina int,
					  Id_Profesor int,
					  Id_Grupa smallint default(1),
					  Zi char(2),
					  Ora Time,
					  Auditoriu int,
					  Bloc char(1) default('B'),
					  PRIMARY KEY (Id_Grupa, Zi, Ora, Auditoriu)
					  )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 107, 101, 'Lu','08:00', 202 )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 108, 101, 'Lu','11:30', 501 )
Insert orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 109, 117, 'Lu','13:00', 501 )

	   select * from orarul
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_00_55_05.png)

### Task 7
Sa se scrie expresiile T-SQL necesare pentru a popula tabelul orarul pentru grupa INF171 , ziua de luni.
Datele necesare pentru inserare trebuie sa fie colectate cu ajutorul instructiunii/instructiunilor SELECT si introduse in tabelul-destinatie, stiind ca: <br/>lectie #1 (Ora ='08:00', Disciplina = 'Structuri de date si algoritmi', Profesor ='Bivol Ion')<br/> lectie #2 (Ora ='11 :30', Disciplina = 'Programe aplicative', Profesor ='Mircea Sorin')<br/> lectie #3 (Ora ='13:00', Disciplina ='Baze de date', Profesor = 'Micu Elena')

```SQL
INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Structuri de date si algoritmi'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Bivol' and Prenume_Profesor = 'Ion'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '08:00')

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Programe aplicative'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Mircea' and Prenume_Profesor = 'Sorin'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '11:30')

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Baze de date'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Micu' and Prenume_Profesor = 'Elena'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '13:00')

		select * from orarul
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_01_15_27.png)

### Task 8
Sa se scrie interogarile de creare a indecsilor asupra tabelelor din baza de date universitatea pentru a asigura o performanta sporita la executarea interogarilor SELECT din Lucrarea practica 4. Rezultatele optimizarii sa fie analizate in baza planurilor de executie, pana la si dupa crearea indecsilor. Indecsii nou-creati sa fie plasati fizic in grupul de fisiere userdatafgroupl (Crearea si intrefinerea bazei de date - sectiunea 2.2.2)

### Example 1:
```SQL
SELECT *
INTO studenti_reusita_test
FROM studenti_reusita
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_21_26_32.png)


```SQL
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
```

Before adding index :
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_21_13_27.png)

After adding index:
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_21_18_38.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_23_07_21.png)

### Example 2:
Before indexing:
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_22_13_08.png)
 
 With NONCLUSTERED INDEX

```SQL
create NONCLUSTERED INDEX [IX_Test]
     ON orarul_test (Id_Disciplina, Id_Profesor, Id_Grupa)
	 on userdatafgroup01
Insert orarul_test (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 107, 101, 'Lu','08:00', 202 )
Insert orarul_test (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 108, 101, 'Lu','11:30', 501 )
Insert orarul_test (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 109, 117, 'Lu','13:00', 501 )

INSERT INTO orarul_test (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Structuri de date si algoritmi'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Bivol' and Prenume_Profesor = 'Ion'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '08:00')

INSERT INTO orarul_test(Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Programe aplicative'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Mircea' and Prenume_Profesor = 'Sorin'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '11:30')

INSERT INTO orarul_test (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Baze de date'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Micu' and Prenume_Profesor = 'Elena'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '13:00')
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_22_28_27.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_22_32_02.png)

With Columnstore index :
```SQL
create NONCLUSTERED COLUMNSTORE INDEX [IX_Test_2]
     ON orarul_test (Id_Disciplina, Id_Profesor, Id_Grupa)
	 on userdatafgroup01

Insert orarul_test (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 107, 101, 'Lu','08:00', 202 )
Insert orarul_test (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 108, 101, 'Lu','11:30', 501 )
Insert orarul_test (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
       values ( 109, 117, 'Lu','13:00', 501 )

INSERT INTO orarul_test (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Structuri de date si algoritmi'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Bivol' and Prenume_Profesor = 'Ion'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '08:00')

INSERT INTO orarul_test(Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Programe aplicative'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Mircea' and Prenume_Profesor = 'Sorin'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '11:30')

INSERT INTO orarul_test (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values ((select Id_Disciplina from discipline where Disciplina = 'Baze de date'),
		(select Id_Profesor from profesori where Nume_Profesor = 'Micu' and Prenume_Profesor = 'Elena'),
		(select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 'Lu', '13:00')	 
		
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_07_11_2018_22_34_34.png)
