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
  
  a)
  ```SQL
ALTER TABLE grupe 
ADD UNIQUE (Cod_Grupa)
ALTER TABLE grupe 
ALTER COLUMN Cod_Grupa char(6) NOT NULL;

select Cod_Grupa
from grupe
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/LAB6/images/VirtualBox_Alina_06_11_2018_18_48_06.png)
