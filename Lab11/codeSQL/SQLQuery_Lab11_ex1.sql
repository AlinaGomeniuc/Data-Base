EXEC sp_addumpdevice 'DISK', 'device1', 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\device1_exercitiul1.bak'
GO
BACKUP DATABASE universitatea
TO device1 
WITH FORMAT,
NAME = N'universitatea- Full Database Backup'
GO
