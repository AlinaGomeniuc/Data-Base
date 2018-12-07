CREATE TRIGGER Lab10_ex6
ON DATABASE
FOR ALTER_TABLE
AS
SET NOCOUNT ON
DECLARE @COMANDA varchar(500)
DECLARE @ID_PROFESOR varchar (20)
DECLARE @TABELUL varchar (50)
DECLARE @COMANDA_NOUA varchar(500)

SELECT @ID_PROFESOR = EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]', 'nvarchar(max)')
IF @ID_PROFESOR = 'Id_Profesor'
BEGIN
SELECT @COMANDA = EVENTDATA().value ('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'nvarchar(max)')
SELECT @TABELUL = EVENTDATA().value ('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)')

SELECT @COMANDA_NOUA = REPLACE(@ID_PROFESOR, @TABELUL, 'studenti.studenti_reusita');
EXECUTE (@COMANDA_NOUA)


SELECT @COMANDA_NOUA = REPLACE(@ID_PROFESOR, @TABELUL, 'cadre_didactice.profesori');
EXECUTE (@COMANDA_NOUA)


SELECT @COMANDA_NOUA = REPLACE(@ID_PROFESOR, @TABELUL, 'plan_studii.orarul');
EXECUTE (@COMANDA_NOUA)

PRINT 'Datele au fost modificate cu succes'
END

ALTER TABLE cadre_didactice.profesori ALTER COLUMN Id_Profesor SMALLINT