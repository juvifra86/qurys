--select TieneCuenta,TipoVenta,EngancheCompletado,status,EstadoDsc from vwsolicitud where solicitudKey=42074

select top 5 TieneCuenta,status,EstadoDsc,* from vwsolicitud 
where TieneCuenta=1

select top 5 TieneCuenta,status,EstadoDsc,* from vwsolicitud 
where TieneCuenta=0  and TipoVenta=1 and status in(11,211)

select top 5 TieneCuenta,status,EstadoDsc,* from vwsolicitud 
where TieneCuenta=0  and status not in(11,211)

select SucursalId,PorcComVta,SucursalDsc,* from vwSolicitud where Solicitudkey=42328
select SucursalId,PorcComVta,SucursalDsc,* from vwSolicitud where Solicitudkey=42335
select SucursalId,PorcComVta,SucursalDsc,* from vwSolicitud where Solicitudkey=42338
select SucursalId,PorcComVta,SucursalDsc,* from vwSolicitud where Solicitudkey=42352
select SucursalId,PorcComVta,SucursalDsc,* from vwSolicitud where Solicitudkey=42358

--update Solicitud set status=11 where SolicitudKey=43866

--select * from vwEstatusFinalNoEjercidoSolicitud
select * from vwEstatusFinalEjercidoSolicitud
select TieneCuenta,status,EstadoDsc,* from vwsolicitud order by SolicitudKey desc
