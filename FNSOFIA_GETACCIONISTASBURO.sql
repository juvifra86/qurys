/*
CREADO: JVFM 12/10/2016
DESCRIPCION: FUNCION QUE CONCATENA LOS ACCIONISTAS DE MAS DE 10 PORCIENTO PARA BURO DE CREDITO
PARAMETROS:
	@cuentacte=id de la cuenta a consultar
SINTAXIS: select dbo.FNSOFIA_GETACCIONISTASBURO(15061)
*/
ALTER FUNCTION FNSOFIA_GETACCIONISTASBURO(@cuentacte as integer)
	returns varchar(max)
	as
begin
	declare @solicitudkey as integer,@cont as int=1,@con as int
	declare @cadena as varchar(max)=''
		   ,@RazonSocial as varchar(152)
	       ,@rfc as varchar(15)
		   ,@Nombre1 as varchar(32)
		   ,@Nombre2 as varchar(32)
		   ,@ApPaterno as varchar(27)
		   ,@ApMaterno as varchar(27)
		   ,@Porcentaje as varchar(4)
		   ,@Tipo as varchar(3)
	declare @accionistas as table(id int identity(1,1),rfc varchar(13),Nombre1 varchar(100),Nombre2 varchar(100),ApPaterno varchar(100),
								ApMaterno varchar(100),Porcentaje int,Tipo varchar(1))
	select @solicitudkey=Solicitudkey,@RazonSocial='03'+NombreCompleto+replicate(' ',150-(len(NombreCompleto)+2)) 
	  from vwSolicitud
		where Cuenta=@cuentacte
	insert into @accionistas(rfc,Nombre1,Nombre2,ApPaterno,ApMaterno,Porcentaje,Tipo)
	select 
		PA.RFC
		,PA.Nombre
		,PA.Nombre2
		,PA.ApPaterno
		,PA.ApMaterno
		,A.PorcentajeParticipacion
		,A.TipoClienteBCId
	  from SolicitudPersona Sp
		inner join PersonaActor PA on PA.PersonaActorkey=Sp.PersonaActorId
		inner join Accionista A on A.AccionistaKey=Sp.PersonaActorId and A.PorcentajeParticipacion >= 10
		where Sp.SolicitudId=@solicitudkey and Sp.TipoPersonaId=15
	set @con=(select count(1) from @accionistas)
	while @cont < @con +1
	begin
		select
		    @rfc=case when len(rfc)>0 then '00'+rfc else '' end
		   ,@Nombre1='04'+Nombre1+replicate(' ',30-len(Nombre1))
		   ,@Nombre2='05'+Nombre2+replicate(' ',30-len(Nombre2))
		   ,@ApPaterno='06'+ApPaterno+replicate(' ',25-len(ApPaterno))
		   ,@ApMaterno='07'+ApMaterno+replicate(' ',25-len(ApMaterno))
		   ,@Porcentaje='08'+cast(Porcentaje as varchar(2))
		   ,@Tipo='19'+Tipo
		from @accionistas where id=@cont
		set @cadena=@cadena+@rfc+@RazonSocial+@Nombre1+@Nombre2+@ApPaterno+@ApMaterno+@Porcentaje+@Tipo
		set @cont=@cont+1
	end
	return @cadena
end

	