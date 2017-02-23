//*
Select Top 50 ntas.Nota_id
From 
SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas with (nolock)
WHERE 
ntas.FechaCaptura >= '2011/07/11 00:00:00'
and right (ntas.nota_id, 2) = 12
and ntas.Nota_id NOT IN
(SELECT Nota_id FROM NOTAS with (nolock)
where fechacaptura >= '2011/07/11 00:00:00'
and right (nota_id, 2) = 12)
Order by ntas.Nota_id asc
*//

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
      WHERE ntas.Nota_id in (Select Top 50 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas with (nolock)
								WHERE 
								ntas.FechaCaptura >= '2011/07/11 00:00:00'
								and right (ntas.nota_id, 2) = 12
								and ntas.Nota_id NOT IN
								(SELECT Nota_id FROM NOTAS with (nolock)
								where fechacaptura >= '2011/07/11 00:00:00'
								and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)
								

INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].NV_NotasClasificacion
SELECT Nota_id,Clasificacion_id,rowguid FROM  SRVMSPUEBLA.DBMSCOF012.[dbo].NV_NotasClasificacion as CIM
WHERE CIM.Nota_id in (Select Top 10 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].NV_NotasClasificacion as ntas with (nolock)
								WHERE 
								ntas.Nota_id NOT IN
								(SELECT Nota_id FROM NV_NotasClasificacion with (nolock)
								Where Nota_id>=201107110000000000
								and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)
								
								
-- execute sp_InsertaImagenesReplicaACentralPuebla @nota_id								

      INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].Imagenes_notas
      Select Nota_id,Imagen_id,rowguid from  SRVMSPUEBLA.DBMSCOF012.[dbo].Imagenes_notas  as Ino
      WHERE Ino.Nota_id in (Select Top 50 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].Imagenes_notas as ntas with (nolock)
								WHERE 
								right (ntas.nota_id, 2) = 12
								and ntas.Nota_id NOT IN
								(SELECT Nota_id FROM Imagenes_notas with (nolock) Where
								Nota_id>=201107110000000000
								and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)
								

	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].VM_NotasPublicidad
	Select Nota_id,Campana,Ancho,Alto,Color,Costo,Franja,rowguid
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].VM_NotasPublicidad
	Where nota_id in (Select Top 50 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].VM_NotasPublicidad as ntas with (nolock)
								WHERE 
								right (ntas.nota_id, 2) = 12
								and ntas.Nota_id NOT IN
								(SELECT Nota_id FROM VM_NotasPublicidad with (nolock)
								where Nota_id>=201107110000000000 and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)
								
	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].VM_NotasPlantillas
	Select Nota_id,VMPlantilla_id,VMCampoExtra_id,Valor,rowguid
    from  SRVMSPUEBLA.DBMSCOF012.[dbo].VM_NotasPlantillas
	Where nota_id in (Select Top 50 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas with (nolock)
								WHERE 
								ntas.FechaCaptura >= '2011/07/11 00:00:00'
								and right (ntas.nota_id, 2) = 12
								and ntas.Nota_id NOT IN
								(SELECT Nota_id FROM NOTAS with (nolock)
								where fechacaptura >= '2011/07/11 00:00:00'
								and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)

	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].VM_NotasPublicidadGMS
	Select Nota_id,TipoGMS_id,ID,rowguid
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].VM_NotasPublicidadGMS
	Where nota_id in (Select Top 50 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas with (nolock)
								WHERE 
								ntas.FechaCaptura >= '2011/07/11 00:00:00'
								and right (ntas.nota_id, 2) = 12
								and ntas.Nota_id NOT IN
								(SELECT Nota_id FROM NOTAS with (nolock)
								where fechacaptura >= '2011/07/11 00:00:00'
								and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)

	-- Notas Extras ---
	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].NotasExtras
	Select Nota_id,NotaExtra_id,Valor
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].NotasExtras
	Where nota_id in (Select Top 50 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas with (nolock)
								WHERE 
								ntas.FechaCaptura >= '2011/07/11 00:00:00'
								and right (ntas.nota_id, 2) = 12
								and ntas.Nota_id NOT IN
								(SELECT Nota_id FROM NOTAS with (nolock)
								where fechacaptura >= '2011/07/11 00:00:00'
								and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)

	INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].RecortesNotas
	Select Imagen_id,Nota_id,NombreArchivo,rowguid
	from  SRVMSPUEBLA.DBMSCOF012.[dbo].RecortesNotas
	Where nota_id in (Select Top 50 ntas.Nota_id
								From 
								SRVMSPUEBLA.DBMSCOF012.[dbo].NOTAS as ntas with (nolock)
								WHERE 
								ntas.FechaCaptura >= '2011/07/11 00:00:00'
								and right (ntas.nota_id, 2) = 12
								and ntas.Nota_id NOT IN
								(SELECT Nota_id FROM NOTAS with (nolock)
								where fechacaptura >= '2011/07/11 00:00:00'
								and right (nota_id, 2) = 12)
								Order by ntas.Nota_id asc)
								
								
