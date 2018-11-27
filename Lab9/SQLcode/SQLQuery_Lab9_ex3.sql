DROP PROCEDURE IF EXISTS Lab9_ex3
GO

CREATE PROCEDURE Lab9_ex3 
@numeS VARCHAR(50),
@prenumeS VARCHAR(50),
@data DATE,
@adresa VARCHAR(500),
@cod_grupa CHAR(6)

AS
INSERT INTO studentiS 
VALUES (99, @numeS, @prenumeS, @data, @adresa)
INSERT INTO reusitaS
VALUES (99, 100, 100 , 
         (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = @cod_grupa), 'examen', NULL, '2018-11-25')

		