/****** Script para el comando SelectTopNRows de SSMS  ******/
SELECT TOP 1000 [Suscriptor_id]
      ,[Cliente_id]
      ,[Nombre]
      ,[Password]
      ,[Descripcion]
      ,[Fecha_Registro]
      ,[Status]
      ,[BusquedaAvanzada]
      ,[EdicionImpresa]
      ,[Reportes]
      ,[PDA]
      ,[Otros]
      ,[Comercial]
      ,[Display]
      ,[logo]
      ,[Producto]
      ,[Tema_id]
      ,[Formulario]
      ,[TopDefaultBloque]
      ,[Logo2]
  FROM [MSCENTRALDB].[dbo].[Suscriptores] where Suscriptor_id=2043
  
  
  --update Suscriptores set Descripcion='integralia12' where Suscriptor_id=1992