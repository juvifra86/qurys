/*
CREADO: JVFM 11/10/2016
DESCRIPCION: FUNCION QUE TRAE EL IMPORTE DEL ULTIMO PAGO DE UNA CUENTA
PARAMETROS:
	@cuentacte=id de la cuenta a consultar
SINTAXIS: SELECT * from dbo.FNSOFIA_TomarUltimoPago(11486)
*/
alter Function FNSOFIA_TomarUltimoPago(@cuentacte as integer)
returns @importe table(importe float,fecha date)
as 
begin
 declare @maxdate as date
 select @maxdate=(select max(FechaPago) from PagoCaja where CuentaCteId=@cuentacte and TipoOperacionId not in(4))
 insert into @importe 
	select top 1 importe,@maxdate from PagoCaja 
		where CuentaCteId=@cuentacte and cast(FechaPago as date)=@maxdate and TipoOperacionId not in(4)
			order by FechaPago desc
 
 return
end



