/*
CREADO: JVFM 12/10/2016
DESCRIPCION: FUNCION QUE CONCATENA LOS AVALES DE MAS DE 10 PORCIENTO PARA BURO DE CREDITO
PARAMETROS:
	@cuentacte=id de la cuenta a consultar
SINTAXIS: select dbo.FNSOFIA_GETAVALESBURO(12769)
*/
ALTER FUNCTION FNSOFIA_GETAVALESBURO(@cuentacte as integer)
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
	,@Direccion as varchar(42)
	,@Colonia as varchar(62)
	,@Delegacion as varchar(42)
	,@Estado as varchar(6)
	,@CP as varchar(12)
	,@Taval as varchar(3)
	,@POrigen as varchar(4)
	declare @avales as table(id int identity(1,1),rfc varchar(100),Nombre1 varchar(100),Nombre2 varchar(100),ApPaterno varchar(100),
							ApMaterno varchar(100),Direccion varchar(300),Colonia varchar(45),Delegacion varchar(45),Estado varchar(5),
							CP varchar(20),Taval varchar(30),POrigen varchar(2))

	select @solicitudkey=Solicitudkey,@RazonSocial='03'+NombreCompleto+replicate(' ',152-(len(NombreCompleto)+2)) 
	  from vwSolicitud
		where Cuenta=@cuentacte

	insert into @avales(rfc,Nombre1,Nombre2,ApPaterno,ApMaterno,Direccion,Colonia,Delegacion,Estado,
							CP,Taval,POrigen)
	select PA.RFC,PA.Nombre,PA.Nombre2,PA.ApPaterno,PA.ApMaterno,Da.Calle+Da.Numext,Da.Colonia,Da.DelMunicipio,ABC.Abrev,Da.CP,
		case PA.TipoFiscal when 'F' then 2 else 1 end TipoAval,'MX'
	    from SolicitudPersona Sp
		inner join PersonaActor PA on PA.PersonaActorkey=Sp.PersonaActorId
		inner join DireccionActor Da on Da.ActorId=Sp.PersonaActorId
		inner join AbrevEstadoBC ABC on ABC.Estado=Da.Estado
		where Sp.SolicitudId=@solicitudkey and Sp.TipoPersonaId=6
	set @con=(select count(1) from @avales)
	while @cont < @con +1
	begin
	 select
	 @rfc ='00'+rfc+replicate(' ',13-len(rfc))
	,@Nombre1 ='04'+Nombre1+replicate(' ',30-len(Nombre1))
	,@Nombre2 =case when len(Nombre2)>0 then '05'+Nombre2+replicate(' ',30-len(Nombre2)) else '' end
	,@ApPaterno='06'+ApPaterno+replicate(' ',25-len(ApPaterno))
	,@ApMaterno ='07'+ApMaterno+replicate(' ',25-len(ApMaterno))
	,@Direccion ='08'+Direccion+replicate(' ',40-len(Direccion))
	,@Colonia ='10'+Colonia+replicate(' ',60-len(Colonia))
	,@Delegacion ='11'+Delegacion+replicate(' ',40-len(Delegacion))
	,@Estado='13'+Estado+replicate(' ',4-len(Estado))
	,@CP ='14'+CP+replicate(' ',10-len(CP))
	,@Taval ='18'+Taval
	,@POrigen ='20'+POrigen
		from @avales where id=@cont
		set @cadena=@cadena+@rfc+@RazonSocial+@Nombre1+@Nombre2+@ApPaterno+@ApMaterno+@Direccion+@Colonia+@Delegacion+@Estado+@CP+@Taval+@POrigen
		set @cont=@cont+1
	end
	return @cadena
	--return @RazonSocial
end
	