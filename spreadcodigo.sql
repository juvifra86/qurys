USE [DBSOFIA20150422]
GO
/****** Object:  StoredProcedure [dbo].[SPSOFIA_CodigoSeguroUnidadRead]    Script Date: 06/05/2015 12:59:53 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
Creación : 01-08-2012    
        Por : Gabriel Contreras Alanis   
Descripcion : Este procedimiento leer la tabla de CodigoSeguroUnidad.   
 Paremetros :
			  @UnidadId = EL ID DE LA UNIDAD 			
   Sintaxis :         
              EXEC SPSOFIA_CodigoSeguroUnidadRead 1
Modificado por: Juan Vicente Franco MArtinez
Descripción: Se añadieron los campos COD_MODELO_MAPFRE,TipoMapfre y COD_MARCA_MAPFRE para usarlos en el formulario de unidades.
Fecha: 06/05/2015
*/
                 
ALTER PROCEDURE [dbo].[SPSOFIA_CodigoSeguroUnidadRead]    
    @UnidadKey int    
AS    
     
Select CSU.UnidadKey, U.UnidadDsc, A.AseguradoraKey, A.AseguradoraDsc, CSU.Codigo
,isnull(CSU.COD_MARCA_MAPFRE,0) as COD_MARCA_MAPFRE,isnull(CSU.COD_MODELO_MAPFRE,0)as COD_MODELO_MAPFRE,isnull(CSU.TipoMapfre,0)as TipoMapfre
From CodigoSeguroUnidad CSU
INNER JOIN Unidad U 
on U.UnidadKey = CSU.UnidadKey  
INNER JOIN Aseguradora A 
on A.AseguradoraKey = CSU.AseguradoraKey 
Where U.UnidadKey = @UnidadKey and CSU.Status = 0 and CSU.Finish IS NULL