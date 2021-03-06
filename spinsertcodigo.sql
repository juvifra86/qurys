USE [DBSOFIA20150422]
GO
/****** Object:  StoredProcedure [dbo].[SPSOFIA_CodigoSeguroUnidadInsertUpdate]    Script Date: 05/05/2015 04:09:17 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*      
Creación : 01-08-2012    
        Por : Gabriel Contreras Alanis   
Descripcion : Este procedimiento Inserta los datos a la tabla de CodigoSeguroUnidad.   
 Paremetros :
			  @UnidadKey       = EL ID DE LA UNIDAD
			  @AseguradoraKey  = ES EL ID DE LA ASEGURADORA DE CONFORMIDAD CON AL CATALOGO DE ASEGURADORAS
			  @Codigo          = EL CODIGO ES EL IDENTIFICADOR QUE ASIGNA LA ASEGURADORA PARA SUS PROCESOS			
   Sintaxis :         
              EXEC SPSOFIA_CodigoSeguroUnidadInsert 12, 2, 221 
Modificado por: Juan Vicente Franco MArtinez
Descripción: Se añadieron los campos COD_MODELO_MAPFRE,TipoMapfre y COD_MARCA_MAPFRE para usarlos en el formulario de unidades.
Fecha: 06/05/2015
*/      
ALTER PROC [dbo].[SPSOFIA_CodigoSeguroUnidadInsertUpdate]          
  
  @UnidadKey      as int     
 ,@AseguradoraKey as Int
 ,@Codigo         as int	
 ,@marca		  as int
 ,@modelo		  as int
 ,@tipo		      as smallint
AS      

BEGIN

BEGIN TRY
If Exists (Select * from CodigoSeguroUnidad where UnidadKey = @UnidadKey and AseguradoraKey = @AseguradoraKey)
   BEGIN
       UPDATE CodigoSeguroUnidad  
       SET Codigo = @Codigo
           ,[STATUS]=0
 	       ,FINISH=null
		   ,COD_MARCA_MAPFRE=@marca
		   ,COD_MODELO_MAPFRE=@modelo
		   ,TipoMapfre=@tipo 	    
 	       WHERE UnidadKey=@UnidadKey and AseguradoraKey = @AseguradoraKey
   END       
Else
   BEGIN
     INSERT INTO CodigoSeguroUnidad(UnidadKey,AseguradoraKey,Codigo,[Init],[Status],COD_MARCA_MAPFRE,COD_MODELO_MAPFRE,TipoMapfre)        
            VALUES (@UnidadKey,@AseguradoraKey,@Codigo,dbo.SOFIAGETDATE(),0,@marca,@modelo,@tipo)      
   END   
   
END TRY
 BEGIN CATCH     
   
 DECLARE @ErrorMessage AS VARCHAR (4000)      
  DECLARE @ErrorSeverity INT;      
     DECLARE @ErrorState INT;      
           
  SET @ErrorMessage=ERROR_MESSAGE()         
     SET @ErrorSeverity = ERROR_SEVERITY()      
     SET  @ErrorState = ERROR_STATE()  
            
     RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState)      
     RETURN      
 END CATCH       
                                               
  RETURN                    
      
END


 