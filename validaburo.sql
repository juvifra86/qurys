--Creado por JVFM 2015-05-27    
--Procedimiento validar claves de observacion buro              
--exec SPSOFIA_ValidaObsBuro 653,'ad'

alter procedure SPSOFIA_ValidaObsBuro(@CuentaCte bigint,@obs varchar(15))
as
begin
	declare @claves table(cla varchar(3))

	insert into @claves select ClaveObservacionDsc from claveobservacionburo where TipoFiscal=(
                    select TipoFiscal  from vwCuenta where CuentaCtekey=@CuentaCte)
	select count(*) from @claves where cla=@obs
	
end
go


