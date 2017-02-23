
CREATE PROCEDURE SPSOFIA_AjusteComisiones (
    @solicitudid INT, 
    @sucursalid smallint,
	@comision  smallmoney)
  AS
  	update Solicitud set SucursalId=@sucursalid, PorcComVta=@comision
	where SolicitudKey=@solicitudid;
    
  GO


 