/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Suscriptor_id]
      ,[Servicio_Id]
  FROM [MSCENTRALDB].[dbo].[Servicios]
 where Suscriptor_id=961

--delete from Servicios where Suscriptor_id=925 and Servicio_Id=42

SELECT TOP 1000 [Servicio_Id]
      ,[Nombre]
      ,[Descripción]
  FROM [MSCENTRALDB].[dbo].[Cat_Servicios] order by servicio_id
  
    select * from nv_usuarios_suscriptor where usuario like '%clipping%'
    select * from nv_usuarios_suscriptor where Suscriptor_id=1922
 -- insert into Servicios values(2078,15)
 -- agregar herramienta a portal
 select * from NV_Temas where Tema_id=11765
 
 insert into Cat_Servicios values(46,'Minuto a minuto Ppal','Politicas Publicas y Asesoria legislativa')