--USE [ReplicacionPuebla]
-- GO
/****** Object:  StoredProcedure [dbo].[sp_InsertaImagenesReplicaACentral]    Script Date: 07/09/2011 07:54:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_InsertaImagenesReplicaACentralPuebla] (@Nota_id as bigint)
as
Set nocount on
/*
Drop sp_InsertaImagenesADF
sp_InsertaImagenesADF
*/

Declare  @Existe int
-- Declare @Nota_id as bisgint
Declare @Imagen_id as bigint
-- Set @Nota_id = 201001210513120510
DECLARE ImagenesNotas CURSOR FOR

Select imagen_id from SRVMSPUEBLA.DBMSCOF012.[dbo].Imagenes_Notas Where Nota_id = @Nota_id

OPEN ImagenesNotas
FETCH NEXT FROM ImagenesNotas INTO @Imagen_id
WHILE @@FETCH_STATUS = 0
BEGIN

	-- Select @Imagen_id
    Set @Existe = (Select count(Imagen_id) from  SRVMSDBVIR.MSCENTRALDB.[dbo].Cat_Imagenes_Medios Where Imagen_id = @Imagen_id)
	-- Select @Existe

	if @Existe = 0 
	Begin

		INSERT INTO  SRVMSDBVIR.MSCENTRALDB.[dbo].Cat_Imagenes_medios
        Select Imagen_id,Medio_id,Seccion_id,Pagina,FechaPublicacion,Nombre,usuario_id,Publicidad,Duracion,rowguid
		from SRVMSPUEBLA.DBMSCOF012.[dbo].Cat_Imagenes_medios
        WHERE Imagen_id = @Imagen_id
		
	End

      FETCH NEXT FROM ImagenesNotas
      INTO @Imagen_id
END
CLOSE ImagenesNotas
DEALLOCATE ImagenesNotas




