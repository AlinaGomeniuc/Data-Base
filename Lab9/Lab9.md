# Laboratorul Nr. 9
## Crearea procedurilor stocate si a functiilor definite de utilizator
### Sarcini practice :

### Ex.1
Sa se creeze proceduri stocate in baza exercitiilor (2 exercitii) din capitolul 4. 
Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective.

-10
``` SQL
DROP PROCEDURE IF EXISTS Lab9_ex1;
GO

CREATE PROCEDURE Lab9_ex1
		@evaluare VARCHAR(20) = 'examen',
		@data SMALLINT = 2018,
		@disciplina VARCHAR(20) = 'Baze de date',
		@nota1 SMALLINT = 4,
		@nota2 SMALLINT = 8
AS

SELECT studentiS.Nume_Student, studentiS.Prenume_Student
FROM studentiS JOIN reusitaS ON studentiS.Id_Student = reusitaS.Id_Student
			   JOIN disciplineS ON reusitaS.Id_Disciplina = disciplineS.Id_Disciplina
WHERE Tip_Evaluare = @evaluare
AND   YEAR(Data_Evaluare) = @data
AND   Disciplina = @disciplina
AND   Nota BETWEEN @nota1 and @nota2;
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_25_11_2018_18_25_03.png)

-13
```SQL
DROP PROCEDURE IF EXISTS Lab9_ex1_2
GO

CREATE PROCEDURE Lab9_ex1_2
   @nume VARCHAR(10) = 'Florea', 
   @prenume VARCHAR(10) = 'Ioan' 
AS

SELECT DISTINCT disciplineS.Disciplina
FROM disciplineS JOIN reusitaS ON disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
				 JOIN studentiS ON reusitaS.Id_Student = studentiS.Id_Student
WHERE Nume_Student = @nume	
AND   Prenume_Student = @prenume
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_25_11_2018_18_34_04.png)

### Ex.2
Sa se creeze o procedura stocata, care nu are niciun parametru de intrare si poseda un parametru de iesire. 
Parametrul de ie~ire trebuie sa returneze numarul de studenti, care nu au sustinut eel putin o forma de evaluare 
(nota mai mica de 5 sau valoare NULL).
```SQL
DROP PROCEDURE IF EXISTS Lab9_ex2;
GO

CREATE PROCEDURE Lab9_ex2
   @nr_de_studenti SMALLINT = NULL OUTPUT
AS
  
SELECT @nr_de_studenti =  COUNT(DISTINCT Id_student) 
FROM reusitaS
WHERE Nota < 5 or Nota = NULL
```

Pentru executie:
```SQL
DECLARE @nr_de_studenti SMALLINT
EXEC Lab9_ex2 @nr_de_studenti OUTPUT
PRINT 'Nr de studenti ce nu au sustinut cel putin o forma de evaluare = ' + cast(@nr_de_studenti as VARCHAR(3))
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_25_11_2018_20_05_50.png)

### Ex.3
Sa se creeze o procedura stocata, care ar insera in baza de date informatii despre un student nou. In calitate de 
parametri de intrare sa serveasca datele personale ale studentului nou si Cod_Grupa. Sa se genereze toate intrarile-cheie 
necesare in tabelul studenti_reusita. Notele de evaluare sa fie inserate ca NULL.

```SQL

DROP PROCEDURE IF EXISTS Lab9_ex3
GO

CREATE PROCEDURE Lab9_ex3 
@numeS VARCHAR(50),
@prenumeS VARCHAR(50),
@data DATE,
@adresa VARCHAR(500),
@cod_grupa CHAR(6)

AS
INSERT INTO studentiS 
VALUES (99, @numeS, @prenumeS, @data, @adresa)
INSERT INTO reusitaS
VALUES (99, 100, 100 , 
         (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = @cod_grupa), 'examen', NULL, '2018-11-25')
```
Pentru executie:
```SQL
exec Lab9_ex3  'Gomeniuc', 'Alina', '1999-04-24',' mun.Chisinau', 'TI171'

select * from studentiS
```


![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_25_11_2018_22_06_28.png)

### Ex.4
Fie ca un profesor se elibereaza din functie la mijlocul semestrului. Sa se creeze o procedura stocata care ar 
reatribui inregistrarile din tabelul studenti_reusita unui alt profesor. Parametri de intrare: numele si prenumele 
profesorului vechi, numele si prenumele profesorului nou, disciplina. in cazul in care datele inserate sunt incorecte 
sau incomplete, sa se afi~eze un mesaj de avertizare.
```SQL


DROP PROCEDURE IF EXISTS Lab9_ex4
GO
CREATE PROCEDURE Lab9_ex4
@nume_prof_vechi VARCHAR(60),
@prenume_prof_vechi VARCHAR(60),
@nume_prof_nou VARCHAR(60),
@prenume_prof_nou VARCHAR(60),
@disciplina VARCHAR(20)

AS


IF(( SELECT disciplineS.Id_Disciplina FROM disciplineS WHERE Disciplina = @disciplina)
     IN (SELECT DISTINCT reusitaS.Id_Disciplina FROM reusitaS WHERE Id_Profesor =
	   (SELECT cadre_didactice.profesori.Id_Profesor FROM cadre_didactice.profesori WHERE Nume_Profesor = @nume_prof_vechi 
							                        AND Prenume_Profesor = @prenume_prof_vechi)))
BEGIN

UPDATE reusitaS
SET Id_Profesor =  (SELECT Id_Profesor
		    FROM cadre_didactice.profesori
		    WHERE Nume_Profesor = @nume_prof_nou
	            AND   Prenume_Profesor = @prenume_prof_nou)

WHERE Id_Profesor = (SELECT Id_profesor
		     FROM cadre_didactice.profesori
     		     WHERE Nume_Profesor = @nume_prof_vechi
	             AND Prenume_Profesor = @prenume_prof_vechi)

END
ELSE
BEGIN
  PRINT 'Something went wrong, check the input parameters'
END

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_21_56_59.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_00_35_45.png)

### Ex.5
Sa se creeze o procedura stocata care ar forma o lista cu primii 3 cei mai buni studenti la o disciplina, si acestor 
studenti sa le fie marita nota la examenul final cu un punct (nota maximala posibila este 10). In calitate de parametru
de intrare, va servi denumirea disciplinei. Procedura sa returneze urmatoarele campuri: 
Cod_Grupa, Nume_Prenume_Student, Disciplina, Nota_ Veche, Nota_Noua.


### Ex. 6
Sa se creeze functii definite de utilizator in baza exercitiilor (2 exercitii) din capitolul 4. 
Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective.

-ex.10
```SQL
DROP FUNCTION IF EXISTS Lab9_ex6_1 
GO
CREATE FUNCTION Lab9_ex6_1 (@evaluare VARCHAR(10), @an SMALLINT, @disciplina VARCHAR(20),
							@nota1 SMALLINT, @nota2 SMALLINT)
RETURNS TABLE
AS
RETURN
(SELECT distinct studentiS.Nume_Student ,studentiS.Prenume_Student 
FROM studentiS, reusitaS, disciplineS
WHERE studentiS.Id_Student = reusitaS.Id_Student
and disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
and Tip_Evaluare = @evaluare
and year(Data_Evaluare) = @an 
and Disciplina = @disciplina
and Nota between  @nota1 and @nota2)
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_20_28_23.png)

-ex.13
```SQL
DROP FUNCTION IF EXISTS Lab9_ex6_2
GO
CREATE FUNCTION Lab9_ex6_2 (@nume VARCHAR(20), @prenume VARCHAR(20))
RETURNS TABLE
AS
RETURN
(SELECT DISTINCT disciplineS.Disciplina
FROM disciplineS JOIN reusitaS ON disciplineS.Id_Disciplina = reusitaS.Id_Disciplina
				 JOIN studentiS ON reusitaS.Id_Student = studentiS.Id_Student
WHERE Nume_Student = @nume	
AND   Prenume_Student = @prenume
)
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_20_30_54.png)

### Ex.7
Sa se scrie functia care ar calcula varsta studentului. 
Sa se defineasca urmatorul format al functiei: <nume_functie>(<Data_Nastere_Student>).

```SQL
DROP FUNCTION IF EXISTS Lab9_ex7
GO

CREATE FUNCTION Lab9_ex7 (@data_nasterii DATE )
RETURNS INT
 BEGIN
 DECLARE @varsta INT
 SELECT @varsta = (SELECT (YEAR(GETDATE()) - YEAR(@data_nasterii) - CASE 
 						WHEN (MONTH(@data_nasterii) > MONTH(GETDATE())) OR (MONTH(@data_nasterii) = MONTH(GETDATE()) AND  DAY(@data_nasterii)> DAY(GETDATE()))
						THEN  1
						ELSE  0
						END))
 RETURN @varsta
 END
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_21_56_47.png)

### Ex.8
Sa se creeze o functie definita de utilizator, care ar returna datele referitoare la reusita unui student. Se defineste 
urmatorul format al functiei : < nume_functie > (<Nume_Prenume_Student>). Sa fie afisat tabelul cu urmatoarele 
campuri: Nume_Prenume_Student, Disticplina, Nota, Data_Evaluare.

```SQL
DROP FUNCTION IF EXISTS Lab9_ex8
GO

CREATE FUNCTION Lab9_ex8 (@nume_prenume_s VARCHAR(50))
RETURNS TABLE 
AS
RETURN
(SELECT Nume_Student + ' ' + Prenume_Student as Student, Disciplina, Nota, Data_Evaluare
 FROM studentiS, disciplineS, reusitaS
 WHERE studentiS.Id_Student = reusitaS.Id_Student
 AND disciplineS.Id_Disciplina = reusitaS.Id_Disciplina 
 AND Nume_Student + ' ' + Prenume_Student = @nume_prenume_s )
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_23_58_37.png)

### Ex.9
Se cere realizarea unei functii definite de utilizator, care ar gasi cel mai sarguincios sau cel mai slab student 
dintr-o grupa. Se defineste urmatorul format al functiei: <nume_functie> (<Cod_Grupa>, <is_good>). 
Parametrul <is_good> poate accepta valorile "sarguincios" sau "slab", respectiv.
Functia sa returneze un tabel cu urmatoarele campuri Grupa, Nume_Prenume_Student, Nota Medie , is_good. 
Nota Medie sa fie cu precizie de 2 zecimale.

```SQL
DROP FUNCTION IF EXISTS Lab9_ex9
GO

CREATE FUNCTION Lab9_ex9 (@cod_grupa VARCHAR(10), @is_good VARCHAR(20))
RETURNS @Test Table (Cod_Grupa varchar(10), Student varchar (100), Media decimal(4,2), Reusita varchar(20))
AS
begin

if @is_good = 'sarguincios'
begin
insert into @Test

SELECT top (1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student as Student,
		 CAST(AVG( Nota * 1.0) as decimal (4,2)) as Media, @is_good
 FROM grupe,studentiS, reusitaS
 WHERE grupe.Id_Grupa = reusitaS.Id_Grupa
 AND studentiS.Id_Student = reusitaS.Id_Student
 AND Cod_Grupa = @cod_grupa
 GROUP BY Cod_Grupa, Nume_Student, Prenume_Student
 Order by Media desc
 end
 else

 begin 
 insert into @Test
SELECT top (1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student as Student,
		 CAST(AVG( Nota * 1.0) as decimal (4,2)) as Media, @is_good
 FROM grupe,studentiS, reusitaS
 WHERE grupe.Id_Grupa = reusitaS.Id_Grupa
 AND studentiS.Id_Student = reusitaS.Id_Student
 AND Cod_Grupa = @cod_grupa
 GROUP BY Cod_Grupa, Nume_Student, Prenume_Student
 Order by Media 
 
end


 RETURN 
 end
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_19_25_50.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_19_25_09.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_19_21_17.png)
