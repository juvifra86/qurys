Declare  @FechaIni datetime
--Declare  @Existe int
Select  @FechaIni = cast (convert (char (10), getdate() - 8, 101)  as datetime)
Declare  @Sucursal char(2)
Select @Sucursal = '12'

Declare @Nota_id as bigint

DECLARE Notas CURSOR FOR

      Select Nota_id from 
      PCOPERACIONES22.ReplicacionPuebla.[dbo].NOTAS as ntas with (nolock)
      WHERE 
      tipoCarga = 1

OPEN Notas
FETCH NEXT FROM Notas INTO @Nota_id
WHILE @@FETCH_STATUS = 0
BEGIN

	  -- Select @Nota_id

	  exec sp_EliminaNota @Nota_id
      
	  Update SRVMSPUEBLA.DBMSCOF012.dbo.notas Set tipoCarga=0 Where Nota_id = @Nota_id

      FETCH NEXT FROM Notas
      INTO @Nota_id
END
CLOSE Notas
DEALLOCATE Notas

