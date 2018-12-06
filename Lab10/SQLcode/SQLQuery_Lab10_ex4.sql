CREATE TRIGGER Lab10_ex4 on database
FOR Alter_Table
AS 
SET NOCOUNT ON
DECLARE @NUME_STUDENT varchar(50)
SELECT @NUME_STUDENT=EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]', 'nvarchar(100)') 
IF @NUME_STUDENT='Nume_Student'
BEGIN 
PRINT ('Nu poate fi modificata coloana Nume_Student')
rollback;
END

ALTER TABLE studenti.studenti ALTER COLUMN Nume_Student varchar(100)