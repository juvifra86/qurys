SET NOCOUNT ON
Declare  @FechaIni datetime
Select  @FechaIni = cast (convert (char (10), getdate ()- 2, 101)  as datetime)
Declare  @Sucursal char(2)
Select @Sucursal = '12'
Declare @Nota_id as bigint

-- USE REPLICACIONPUEBLA

 DECLARE Notas CURSOR FOR

      Select Top 1 Nota_id
	  From 
	  	 SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas with (nolock)
      WHERE 
		  ntas.FechaCaptura >= @FechaIni
		  and right (ntas.nota_id, 2) = @Sucursal
		  and ntas.Nota_id NOT IN
		  (SELECT Nota_id FROM NOTAS with (nolock)
		  where fechacaptura >= @FechaIni
		  and right (nota_id, 2) = @Sucursal)
		  and nota_id = 201107110526416312
		  Order by ntas.Nota_id desc

OPEN Notas
FETCH NEXT FROM Notas INTO @Nota_id
WHILE @@FETCH_STATUS = 0
BEGIN

Select @Nota_id

      INSERT INTO SRVMSDBVIR.MSCENTRALDB.[dbo].NOTAS ([Nota_id]
              ,[Usuario_Id]
              ,[Agencia_Id]
              ,[Medio_Id]
              ,[TipoNota_Id]
              ,[Titulo]
              ,[Nota]
              ,[Balazo1]
              ,[Balazo2]
              ,[Balazo3]
              ,[Balazo4]
              ,[FechaCaptura]
              ,[FechaPublicacion]
              ,[FechaVencimiento]
              ,[Seccion_id]
              ,[Display]
      --      ,[MSSearch]
              ,[autor1]
              ,[autor2]
              ,[autor3]
              ,[Status]
              ,[Costo]
              ,[tipoCarga]
              ,[opcionales]
              ,[kiker]
              ,[FechaHoy]
              ,[URL]
              ,[DescCosto]
              ,[Programa_Id]
              ,[FechaHora],
              ROWGUID)
      SELECT [Nota_id]
              ,[Usuario_Id]
              ,[Agencia_Id]
              ,[Medio_Id]
              ,[TipoNota_Id]
              ,[Titulo]
              ,[Nota]
              ,[Balazo1]
              ,[Balazo2]
              ,[Balazo3]
              ,[Balazo4]
              ,[FechaCaptura]
              ,[FechaPublicacion]
              ,[FechaVencimiento]
              ,[Seccion_id]
              ,[Display]
      --      ,[MSSearch]
              ,[autor1]
              ,[autor2]
              ,[autor3]
              ,[Status]
              ,[Costo]
              ,[tipoCarga]
              ,[opcionales]
              ,[kiker]
              ,[FechaHoy]
              ,[URL]
              ,[DescCosto]
              ,[Programa_Id]
              ,[FechaHora]
              ,NEWID()
      FROM  SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas
      WHERE ntas.Nota_id = @Nota_id


      INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].NV_NotasClasificacion
      SELECT Nota_id,Clasificacion_id,rowguid FROM  SRVMSPUEBLA.DBMSCOF012.[dbo].NV_NotasClasificacion as CIM
      WHERE CIM.Nota_id = @Nota_id

/* -------------------- */

 -- Inserta en Cat_Imagenes_Medios
--      Print '-- Cat_Imagenes_Medios --'
     execute sp_InsertaImagenesReplicaACentralPuebla @nota_id
 -- Inserta en ImagenesNotas de la nota

--      Print '--- Imagenes_notas ---'	  	  
      INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].Imagenes_notas
      Select Nota_id,Imagen_id,rowguid from  SRVMSPUEBLA.DBMSCOF012.[dbo].Imagenes_notas  as Ino
      WHERE Ino.Nota_id = @Nota_id 

-- Inserta publicidad
	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].VM_NotasPublicidad
	Select Nota_id,Campana,Ancho,Alto,Color,Costo,Franja,rowguid
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].VM_NotasPublicidad
	Where nota_id = @Nota_id 

	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].VM_NotasPlantillas
	Select Nota_id,VMPlantilla_id,VMCampoExtra_id,Valor,rowguid
    from  SRVMSPUEBLA.DBMSCOF012.[dbo].VM_NotasPlantillas
	Where nota_id = @Nota_id 

	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].VM_NotasPublicidadGMS
	Select Nota_id,TipoGMS_id,ID,rowguid
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].VM_NotasPublicidadGMS
	Where nota_id = @Nota_id

	-- Notas Extras ---
	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].NotasExtras
	Select Nota_id,NotaExtra_id,Valor
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].NotasExtras
	Where nota_id = @Nota_id

	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].RecortesNotas
	Select Imagen_id,Nota_id,NombreArchivo,rowguid
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].RecortesNotas
	Where nota_id = @Nota_id

      FETCH NEXT FROM Notas
      INTO @Nota_id
END
CLOSE Notas
DEALLOCATE Notas

