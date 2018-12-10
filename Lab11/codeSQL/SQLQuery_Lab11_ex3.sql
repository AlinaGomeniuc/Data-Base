EXEC sp_addumpdevice 'DISK','backup_Log', 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\exercitiul3.bak'
GO
BACKUP LOG universitatea
TO backup_Log
GO