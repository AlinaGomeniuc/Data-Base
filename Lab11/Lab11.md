# Laboratorul nr.11
## Recuperarea bazei de date
### Sarcini

### 1. Sa se creeze un dosar Backup_labll. Sa se execute un backup complet al bazei de date universitatea in acest dosar. Fisierul copiei de rezerva sa se numeasca exercitiull.bak. Sa se scrie instructiunea SQL respectiva.
```SQL
EXEC sp_addumpdevice 'DISK', 'device1', 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\device1_exercitiul1.bak'
GO
BACKUP DATABASE universitatea
TO device1 
WITH FORMAT,
NAME = N'universitatea- Full Database Backup'
GO
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab11/screenshots/VirtualBox_Alina_10_12_2018_17_36_14.png)

### 2. Sa se scrie instructiunea unui backup diferentiat al bazei de date universitatea. Fisierul copiei de rezerva sa se numeasca exercitiul2.bak.
```SQL
EXEC sp_addumpdevice 'DISK', 'device2', 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\device1_exercitiul2.bak'
GO
BACKUP DATABASE universitatea
TO device2 
WITH FORMAT,
NAME = N'universitatea- Differential Database Backup'
GO
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab11/screenshots/VirtualBox_Alina_10_12_2018_17_49_58.png)


### 3. Sa se scrie instructiunea unui backup al jurnalului de tranzactii al bazei de date universitatea. Fisierul copiei de rezerva sa se numeasca exercitiul3.bak
```SQL
EXEC sp_addumpdevice 'DISK','backup_Log', 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\exercitiul3.bak'
GO
BACKUP LOG universitatea
TO backup_Log
GO
```
![alt text](https://github.com/AlinaGomeniuc/Data-Base/blob/master/Lab11/screenshots/VirtualBox_Alina_10_12_2018_17_55_16.png)

### 4. Sa se execute restaurarea consecutiva a tuturor copiilor de rezerva create. Recuperarea trebuie sa fie realizata intr-o baza de date noua universitatea_labll. Fisierele bazei de date noise afla in dosarul BD_labll. Sa se scrie instructiunile SQL respective
```SQL

```
![alt text]()
![alt text]()
