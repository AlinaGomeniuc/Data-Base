EXEC sp_addumpdevice 'DISK', 'device2', 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\device1_exercitiul2.bak'
GO
BACKUP DATABASE universitatea
TO device2 
WITH FORMAT,
NAME = N'universitatea- Differential Database Backup'
GO
