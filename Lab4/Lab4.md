# Laboratory work nr.4
## The chosen queries:

### Nr.10
Gasiti studentii (numele, prenumele), care au obtinut la disciplina Baze de date (examen), în anul 2018, vreo nota mai mica de 8 si mai mare ca 4.

```SQL
SELECT distinct Nume_Student , Prenume_Student 
FROM studenti, studenti_reusita, discipline
Where studenti.Id_Student = studenti_reusita.Id_Student
and discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
and Tip_Evaluare = 'examen' 
and year(Data_Evaluare) = 2018 
and Disciplina = 'Baze de date'
and Nota between  4 and 8
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab4/imageLab4/VirtualBox_Alina_23_10_2018_19_11_11.png)

### Nr.13
Aflati cursurile urmate de catre studentul Florea loan.

```SQL
SELECT DISTINCT Disciplina 
FROM discipline
INNER JOIN studenti_reusita
ON discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
INNER JOIN studenti
ON studenti_reusita.Id_Student = studenti.Id_Student
WHERE Nume_Student = 'Florea' 
AND   Prenume_Student = 'Ioan'
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab4/imageLab4/VirtualBox_Alina_03_10_2018_18_54_44.png)

### Nr. 24
Sa se afiseze lista disciplinelor(Disciplina) predate de cel putin doi profesori.

```SQL
select Disciplina, COUNT(distinct studenti_reusita.Id_Profesor) as Nr_profesori
from discipline, studenti_reusita
where discipline.Id_Disciplina = studenti_reusita.Id_Disciplina
group by Disciplina
having count(distinct studenti_reusita.Id_Profesor) > 1
```

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab4/imageLab4/VirtualBox_Alina_23_10_2018_20_48_38.png)

### Nr. 38
Furnizati denumirile disciplinelor cu o medie mai mica decat media notelor de la disciplina Baze de date.

```SQL
select Disciplina, AVG(cast(Nota as float)) as Media
from discipline, studenti_reusita
where discipline.Id_Disciplina = studenti_reusita.Id_Disciplina 
group by Disciplina
having AVG(cast(Nota as float))<(
                  select AVG(cast(Nota as float))
				          from discipline, studenti_reusita
				          where Disciplina = 'Baze de date'
				          group by Disciplina )
```   

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab4/imageLab4/VirtualBox_Alina_23_10_2018_19_58_37.png)
