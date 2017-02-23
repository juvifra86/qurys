/*
 Creado por JVFM 06/07/2015
 Descripcion:
	Store que recibe como parametros fecha inicial y fecha final y devuelve la consulta de los stores
	SPSOFIA_rptSeguroAuto,SPSOFIA_RptSeguroAutoSem y SPSOFIA_rptEmisionNotasSeguroPagoContado
 Sintaxis:
	exec SP_SEGUROAUTOSTOTAL '20150501','20150502'

 */
Alter procedure SP_SEGUROAUTOSTOTAL
	@fechaini date,
	@fechafin date
as
	-- tabla temporal primer store
	declare @Notasseguro as table(
	 CuentaCtekey bigint,Plann varchar(50),PlazoDsc varchar(40),NumAgente bigint,Poliza varchar(80),
	 PrimaTotal money,FrecuenciaPagoId int,PeriodoDsc varchar(30),PrimaNeta money,FechaPolizaINI date,FechaPolizaFin date,
	 FechaEmision date,EmpresaDsc varchar(100),AseguradoraDsc varchar(50),PlazoId int,TipoPago varchar(30),DiasAtraso int,
	 Estatus varchar(80),FechaEntrega date,ImporteUdis money,SucursalDsc varchar(100)
	)
	-- tabla temporal segundo store
	declare @rptsegurosem as table(
	Consecutivo int,NoCuenta BIGINT,Nombre varchar(100),SucursalDsc varchar(100),PolizaUnidadkey bigint,productoid int,
	fechacorte date,Poliza varchar(80),PrimaPeriodo money,PeriodoDsc varchar(60),FechaInicio date,FechaVencimiento date,
	PNetaRecibo money,Recibo varchar(50),EmpresaDsc varchar(100),AseguradoraDsc varchar(100),fecha1 date,fecha2 date
	)
	--tabla temporal tercer store
	 declare @rptSeguro as table(
	 AseguradoraDsc varchar(100),CuentaCteKey bigint,SucursalDsc varchar(100),Contrato bigint,Nombre varchar(100),
	 PlanDsc varchar(50),Plazo varchar(50),Duracion int,NumAgente int,Poliza varchar(80),PrimaTotal money,MontoPrimaPeriodo money,
	 PrimaMensual money,FrecuenciaPagoId int,PeriodoDsc varchar(50),FechaInicioVigencia date,FechaFinVigencia date,PrimaNeta money,
	 PagosVencidos int,MontoSaldoConAccesorios money,CicloCorteDsc varchar(50),Empresa varchar(100),DomicilioEmpresa varchar(200),
	 Telefono varchar(50),AseguradorDsc varchar(100),EstadoCuenta varchar(50),PN money,PNReal money,Grupo bigint,Integrante bigint
	 )
    --tabla temporal cuarto store
	 declare @rptsegurovida as table(
	 Cuentactekey bigint,Unidadid int,Nombre varchar(100),Contrato int,TipFiscal varchar(5),Fnacimiento date,Sexo varchar(5),Saldoinsoluto money,
	 MontoMensualidad money,MontomensualidadSeguro money,Mensualidadesatrasadas int,SaldoVencidoconAccesorios money,IniPoli date,FinPoli date,
	 Sucursaldsc varchar(200),SumaSaldoInsoluto money,factorsegurovida varchar(50),porcentajesegurodevida varchar(50),porcentajesegurodevidapago varchar(50),
	 Primaseguro money,Porcentajeprimaseguro varchar(50),pagoaseguradora money,fecharequisicion date,Pagoseguroletra varchar(50),empresa varchar(200),
	 domicilio varchar(200),rfc varchar(40),Responsable varchar(100),tel varchar(50)
	 )
	--tabla temporal quinto store
	declare @rptsegurodesempleo as table(
	CuentaCtekey bigint,Unidadid bigint,Nombre varchar(200),contrato bigint,nomunidad varchar(100),preciounidad money,saldoinsoluto money,fechaliqpriamortizacion date,
	primasegauto money,fechaini date,fechafin date,montomensualidad money,frecuenciaseguro varchar(50),pagosatrasados int,saldovencconaccesorios money,
	sucursal varchar(200),sumasaldoinsoluto money,factordesempleo float,porcentajemonto float,porcentajepagoaseguradora float,empresa varchar(200),domicilio varchar(300),
	rfc varchar(50),responsable varchar(100),tel varchar(40)
	)
	-- tabla temporal final
	declare @total as table(
	 cuenta bigint,
	 sucursal varchar(100),
	 plazo varchar(40),
	 poliza varchar(50),
	 primatotal money,
	 forma_pago varchar(50),
	 vigenciaini date,
	 vigenciafin date,
	 primaneta money,
	 empresadsc varchar(100),
	 aseguradoradsc varchar(100),
	 TipoRep varchar(100),
	 Tiposeguro varchar(100)
 	)
begin
	--primer store
	insert into @Notasseguro exec SPSOFIA_rptEmisionNotasSeguroPagoContado 0,0,@fechaini,@fechafin
	--segundo store
	insert into @rptsegurosem exec SPSOFIA_RptSeguroAutoSem 0,@fechaini,@fechafin
	--tercer store
	insert into @rptSeguro exec SPSOFIA_rptSeguroAuto 0,@fechaini,@fechafin
	--cuarto store
	insert into @rptsegurovida exec SPSOFIA_rptSegurodeVida @fechafin,1,0 
	insert into @rptsegurovida exec SPSOFIA_rptSegurodeVida @fechafin,2,0
	insert into @rptsegurovida exec SPSOFIA_rptSegurodeVida @fechafin,1,5 
	insert into @rptsegurovida exec SPSOFIA_rptSegurodeVida @fechafin,2,5
	--quinto store 
	insert into @rptsegurodesempleo exec SPSOFIA_rptSegurodeDesempleo @fechafin,1,0
	insert into @rptsegurodesempleo exec SPSOFIA_rptSegurodeDesempleo @fechafin,2,0
	insert into @rptsegurodesempleo exec SPSOFIA_rptSegurodeDesempleo @fechafin,1,5
	insert into @rptsegurodesempleo exec SPSOFIA_rptSegurodeDesempleo @fechafin,2,5

	--insert stores en tabla total
	insert into @total 
	select CuentaCtekey,SucursalDsc,PlazoDsc,Poliza,PrimaTotal,PeriodoDsc,FechaPolizaINI,FechaPolizaFin,PrimaNeta,EmpresaDsc,AseguradoraDsc,'Seguro Contado','SeguroUnidad Auto' from @Notasseguro
	union
	select NoCuenta,SucursalDsc,Recibo,Poliza,PrimaPeriodo,PeriodoDsc,FechaInicio,FechaVencimiento,PNetaRecibo,EmpresaDsc,AseguradoraDsc,'Seguro Semanal','SeguroUnidad Auto' from @rptsegurosem
	union
	select CuentaCteKey,SucursalDsc,Plazo,Poliza,PrimaTotal,PeriodoDsc,FechaInicioVigencia,FechaFinVigencia,PrimaNeta,Empresa,AseguradoraDsc,'Seguro Notas','SeguroUnidad Auto' from @rptSeguro
	union
	select Cuentactekey,Sucursaldsc,'plazo','poliza',(Saldoinsoluto*0.55),'periodo',IniPoli,FinPoli,Primaseguro,empresa,'ACE SEGUROS','Seguro De Vida','Seguro de vida' from @rptsegurovida
	union
	select CuentaCtekey,sucursal,'plazo','poliza',(saldoinsoluto*0.40),frecuenciaseguro,fechaini,fechafin,primasegauto,empresa,'','ASEGURADORA PATRIMONIAL VIDA S.A. DE C.V.','Seguro de Desempleo' from @rptsegurodesempleo
	
	-- select final
	select * from @total order by Tiposeguro
	
end
