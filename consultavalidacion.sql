/****** Script para el comando SelectTopNRows de SSMS  ******/
SELECT TOP 1000 [TipoVentaKey]
      ,[TipoVentaDsc]
      ,[init]
      ,[finish]
      ,[status]
  FROM [DBSOFIA20150422].[dbo].[TipoVenta]

  exec SPSOFIA_ReadTbl3 'vwsolicitud','status not in (select EstadoPOKey from vwEstatusFinalNoEjercidoSolicitud) and Solicitudkey',42370

  select * from vwSolicitud 
  where status not in (select EstadoPOKey from vwEstatusFinalNoEjercidoSolicitud) and solicitudkey=42074
