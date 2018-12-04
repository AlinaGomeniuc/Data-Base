### Crearea si utilizarea declansatoarelor

## Sarcini:
### 1. Sa se modifice declansatorul inregistrare_noua,in asa fel,incat in cazul actualizarii auditoriului sa apara mesajul de 
informare, care, in afara de disciplina si ora, va afisa codul grupei afectate, ziua, blocul, auditoriul vechi si auditoriul nou.

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
PANA LA MODIFICARI
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_04_12_2018_18_08_37.png)
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_04_12_2018_18_09_31.png)

DUPA
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab10/images/VirtualBox_Alina_04_12_2018_18_10_02.png)

### 2. Sa se creeze declansatorul, care ar asigura popularea corecta (consecutiva) a tabelelor studenti si studenti_reusita,
si ar permite evitarea erorilor la nivelul cheilor externe.

### 3. Sa se creeze un declansator, care ar interzice micsorarea notelor in tabelul studenti_reusita si modificarea valorilor
campului Data_Evaluare, unde valorile acestui camp sunt nenule. Declansatorul trebuie sa se lanseze, numai daca sunt afectate 
datele studentilor din grupa ,,CIB 171 ". Se va afisa un mesaj de avertizare in cazul tentativei de a incalca constrangerea.

### 4. Sa se creeze un declansator DDL care ar interzice modificarea coloanei ld_Disciplina in tabelele bazei de date 
universitatea cu afisarea mesajului respectiv.
