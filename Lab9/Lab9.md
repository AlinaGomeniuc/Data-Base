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

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_25_11_2018_18_34_04.png)

### Ex.2
Sa se creeze o procedura stocata, care nu are niciun parametru de intrare si poseda un parametru de iesire. 
Parametrul de ie~ire trebuie sa returneze numarul de studenti, care nu au sustinut eel putin o forma de evaluare 
(nota mai mica de 5 sau valoare NULL).

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_25_11_2018_20_05_50.png)

### Ex.3
Sa se creeze o procedura stocata, care ar insera in baza de date informatii despre un student nou. In calitate de 
parametri de intrare sa serveasca datele personale ale studentului nou si Cod_Grupa. Sa se genereze toate intrarile-cheie 
necesare in tabelul studenti_reusita. Notele de evaluare sa fie inserate ca NULL.

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_25_11_2018_22_06_28.png)

### Ex.4
Fie ca un profesor se elibereaza din functie la mijlocul semestrului. Sa se creeze o procedura stocata care ar 
reatribui inregistrarile din tabelul studenti_reusita unui alt profesor. Parametri de intrare: numele si prenumele 
profesorului vechi, numele si prenumele profesorului nou, disciplina. in cazul in care datele inserate sunt incorecte 
sau incomplete, sa se afi~eze un mesaj de avertizare.


![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_21_56_59.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_00_37_14.png)
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

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_20_28_23.png)

-ex.13
```SQL

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_20_30_54.png)

### Ex.7
Sa se scrie functia care ar calcula varsta studentului. 
Sa se defineasca urmatorul format al functiei: <nume_functie>(<Data_Nastere_Student>).

```SQL

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_21_56_47.png)

### Ex.8
Sa se creeze o functie definita de utilizator, care ar returna datele referitoare la reusita unui student. Se defineste 
urmatorul format al functiei : < nume_functie > (<Nume_Prenume_Student>). Sa fie afisat tabelul cu urmatoarele 
campuri: Nume_Prenume_Student, Disticplina, Nota, Data_Evaluare.

```SQL

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_26_11_2018_23_58_37.png)

### Ex.9
Se cere realizarea unei functii definite de utilizator, care ar gasi cel mai sarguincios sau cel mai slab student 
dintr-o grupa. Se defineste urmatorul format al functiei: <nume_functie> (<Cod_Grupa>, <is_good>). 
Parametrul <is_good> poate accepta valorile "sarguincios" sau "slab", respectiv.
Functia sa returneze un tabel cu urmatoarele campuri Grupa, Nume_Prenume_Student, Nota Medie , is_good. 
Nota Medie sa fie cu precizie de 2 zecimale.

```SQL

```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_19_25_50.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_19_25_09.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab9/images/VirtualBox_Alina_27_11_2018_19_21_17.png)
