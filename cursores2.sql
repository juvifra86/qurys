use MSCENTRALDB
SET NOCOUNT ON
Declare @Tema_id as int
CREATE TABLE #TablaRecor(Tema_id int,Tema varchar(30))

DECLARE Temass CURSOR LOCAL STATIC FOR
      Select Tema_id from AdminRecortesTemas Where Proyecto_id = 1
OPEN Temass
FETCH NEXT FROM Temass INTO @Tema_id
WHILE @@FETCH_STATUS = 0
BEGIN
    --Select @Tema_id 
    Insert into #TablaRecor
       Select nvnt.Tema_id,nt.Nombre as Tema
       from NV_NotasTemas as nvnt 
       inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id 
       Where(nvnt.Display >= 0)
       and nvnt.Tema_id = @Tema_id   
       and nvnt.Tema_id in (Select Tema_id From AdminRecortesTemasMedios Where tipoie=1 AND Proyecto_id=1)
       and nvnt.Tema_id not in (Select Tema_id From AdminRecortesTemasMedios Where tipoie=0 AND Proyecto_id=1)

FETCH NEXT FROM Temass
    INTO @Tema_id
END
CLOSE Temass
DEALLOCATE Temass
Select * from #TablaRecor 
Drop Table #TablaRecor

