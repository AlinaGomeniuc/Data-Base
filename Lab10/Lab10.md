### Crearea si utilizarea declansatoarelor

## Sarcini:
### 1. Sa se modifice declansatorul inregistrare_noua,in asa fel,incat in cazul actualizarii auditoriului sa apara mesajul de informare, care, in afara de disciplina si ora, va afisa codul grupei afectate, ziua, blocul, auditoriul vechi si auditoriul nou.

```SQL
DROP TRIGGER IF EXISTS inregistrare_noua 
GO
CREATE TRIGGER inregistrare_noua ON plan_studii.orarul
AFTER UPDATE
AS SET NOCOUNT ON
IF UPDATE(Auditoriu)
SELECT 'Lectia la disciplina ' + UPPER(disciplineS.Disciplina)+ ', a grupei ' + grupe.Cod_Grupa +
		', ziua de ' + CAST(inserted.Zi as VARCHAR(5)) + ', de la ora ' + CAST(inserted.Ora as VARCHAR(5))
		+ ', a fost transferata in aula ' + CAST(inserted.Auditoriu as VARCHAR(5)) + ', Blocul '+
		CAST(inserted.Bloc as VARCHAR(5)) + '. Auditoriul vechi: ' + CAST(deleted.Auditoriu as VARCHAR(5))+
		', Auditoriul nou: ' + CAST(inserted.Auditoriu as VARCHAR(5))
FROM inserted,deleted, disciplineS, grupe
WHERE deleted.Id_Disciplina = disciplineS.Id_Disciplina
AND inserted.Id_Grupa = grupe.Id_Grupa
GO
```
PANA LA MODIFICARI <br>
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_04_12_2018_18_08_37.png)

![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_04_12_2018_18_09_31.png)

DUPA<br>
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_04_12_2018_18_10_02.png)

### 2. Sa se creeze declansatorul, care ar asigura popularea corecta (consecutiva) a tabelelor studenti si studenti_reusita,si ar permite evitarea erorilor la nivelul cheilor externe.

```SQL
CREATE TRIGGER Lab10_ex2 ON studenti.studenti_reusita
INSTEAD OF INSERT
AS SET NOCOUNT ON
   
  INSERT INTO studenti.studenti_reusita 
  SELECT * FROM inserted
  WHERE Id_Student in (SELECT Id_Student FROM studenti.studenti)
  GO

  INSERT INTO reusitaS values (200, 101, 101, 1, 'Examen', null, null)

 -- INSERT INTO studentiS values (200,'AAA', 'BBB', '1999-11-18', null)

 -- delete from studentiS where Id_Student = 200
  select * from studentiS where Id_Student= 200
  select * from reusitaS where Id_Student = 200
  ```
  ![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_05_12_2018_00_09_32.png)

### 3. Sa se creeze un declansator, care ar interzice micsorarea notelor in tabelul studenti_reusita si modificarea valorilor campului Data_Evaluare, unde valorile acestui camp sunt nenule. Declansatorul trebuie sa se lanseze, numai daca sunt afectate datele studentilor din grupa ,,CIB 171 ". Se va afisa un mesaj de avertizare in cazul tentativei de a incalca constrangerea.

```SQL
IF OBJECT_ID('Lab10_ex3', 'TR') is not null
   DROP TRIGGER Lab10_ex3
   GO
CREATE TRIGGER Lab10_ex3 ON studenti.studenti_reusita
AFTER UPDATE
AS
SET NOCOUNT ON
IF UPDATE (Nota)
DECLARE @ID_GRUPA INT = (SELECT Id_Grupa  FROM grupe WHERE Cod_Grupa = 'CIB171')
DECLARE @count int = (SELECT count(*) FROM deleted , inserted 
			where deleted.Id_Disciplina = inserted.Id_Disciplina and deleted.Id_Grupa = inserted.Id_Grupa 
			and deleted.Id_Profesor = inserted.Id_Profesor and deleted.Tip_Evaluare = inserted.Tip_Evaluare 
			and deleted.Id_Student = inserted.Id_Student
			and inserted.Nota < deleted.Nota 
			and inserted.Id_Grupa = @ID_GRUPA)
	
BEGIN
IF (@count > 0 )
PRINT ('Nu se perminte micsorarea notelor pentru grupa CIB 171')
ROLLBACK TRANSACTION
end

IF UPDATE(Data_evaluare)
		SET @count = (SELECT count(*) FROM deleted WHERE Data_Evaluare is not null and Id_Grupa = @ID_GRUPA)
		IF @count > 0
		BEGIN
			PRINT ('Nu se permite modificarea campului Tip_Evaluare')
			ROLLBACK TRANSACTION
		END
GO
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_05_12_2018_01_10_48.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_05_12_2018_01_26_05.png)

### 4. Sa se creeze un declansator DDL care ar interzice modificarea coloanei ld_Disciplina in tabelele bazei de date universitatea cu afisarea mesajului respectiv.

### 5. Sa se creeze un declansator DDL care ar interzice modificarea schemei bazei de date in afara orelor de lucru.

### 6. Sa se creeze un declansator DDL care, la modificarea proprietatilor coloanei ld_Profesor dintr-un tabel, ar face schimbari asemanatoare in mod automat in restul tabelelor.
