DECLARE @nr_de_studenti SMALLINT
EXEC Lab9_ex2 @nr_de_studenti OUTPUT
PRINT 'Nr de studenti ce nu au sustinut cel putin o forma de evaluare = ' + cast(@nr_de_studenti as VARCHAR(3))

