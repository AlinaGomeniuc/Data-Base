
RESTORE DATABASE universitatea_lab11
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\device1_exercitiul1.bak'
WITH MOVE 'universitatea' TO 'C:\MyDocuments\Data\universitatea_lab11',
MOVE 'universitatea_File2' TO 'C:\MyDocuments\Data\universitatea_lab11_File2',
MOVE 'universitatea_File3' TO 'C:\MyDocuments\Data\universitatea_lab11_File3',
MOVE 'universitatea_log' TO 'C:\MyDocuments\SQL-logs\universitatea_lab11_log.ldf',
NORECOVERY
GO

RESTORE DATABASE universitate_lab11
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\device1_exercitiul2.bak'
WITH NORECOVERY
GO

RESTORE LOG universitatea_lab11
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\Backup\Backup_lab1\exercitiul3.bak'
WITH NORECOVERY



