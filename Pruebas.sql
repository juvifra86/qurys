select EA.RazonSocial,P.PaisDsc,P.CatBuro 
	from vwEmpleoActor EA
		inner join CP cp on cp.CP=EA.CP
		inner join EdoPais Ep on Ep.EdoPAisKey=cp.EdoPaisId
		inner join Pais P on P.PaisKey=Ep.PaisId

select * from sys.Objects where name like '%Cambia%'

select * from CP 

select * from EdoPais

select * from Pais 
where finish is null
order by PaisDsc


select * from vwCuenta where CuentaCteKey= 13684

select * from vwSolicitud where Solicitudkey=54831

select * from Amortizacion where CuentaCteId=13854


select max(UltimaFechaPago) from CarteraCte where CuentaCteId=13854

select max(SaldoCapital) from CarteraCte where CuentaCteId=13854 order by SaldoCapital desc

select * from CarteraCte where CuentaCteId=13854 and BoletasVencidas=0

select importe,FechaPago from PagoCaja where CuentaCteId=15195 and FechaPago=(select max(FechaPago) from PagoCaja where CuentaCteId=15195)

select * from EstadoPO
	select top 1 * from vwCuenta

	select top 100 * from CuentaCte where CuentaCteKey=11466
	FNSOFIA_GetPeriodoPlazo

select top 1 * from vwSolicitud
select top 100 * from vwPersonaActor
select top 1 * from PersonaActor
select top 1 * from Solicitud
select top 1 * from Cliente
select * from DatosActor


select * from ResultadosBuroCredito where --cast(init as date)='29/07/2016'
	--and 
	PeriodoId=2

	select *
	 --   'primer string'
		--+ '12'+ cast(len([12_Origen del Domicilio])as varchar(2))--+len([12_Origen del Domicilio]+ cast([12_Origen del Domicilio] as varchar(2))
		--+ 'segundo string'
		from ResultadosBuroCredito where cast(init as date)='29/07/2016'
	and PeriodoId=5 and EmpresaId=1 and [00_Materno] like ''


	select * from Empresa

		select * from ResultadosBuroCreditoPM 
			where cast(init as date)='29/07/2016'
				order by init desc

	select * from EmpresaActor order by ActorId

	select * from Accionista
		where ActorId=19356

		

	select * from PersonaActor where TipoPersonaId=15

	select * from TipoPersona

	select * from CuentaCte

	
	
	select PA.RFC,PA.Nombre,PA.Nombre2,PA.ApPaterno,PA.ApMaterno,A.PorcentajeParticipacion,TA.Descripcion
	    from SolicitudPersona Sp
		inner join PersonaActor PA on PA.PersonaActorkey=Sp.PersonaActorId
		inner join Accionista A on A.AccionistaKey=Sp.PersonaActorId
		inner join TipoClienteBC TA on TA.TipoClienteBCKey=A.TipoClienteBCId
		where Sp.SolicitudId=54308 and Sp.TipoPersonaId=15
    

	select * from vwCuenta where CuentaCtekey=914
	select * from vwSolicitud where Cuenta=15061
	select * from solicitudpersona where tipopersonaid=6 and SolicitudId=59740
	select * from Accionista where ActorId in(265376,265377)
	select * from PersonaActor where ActorId in(265376,265377)
	select * from DireccionActor
	select * from Aval
	se
	select * from TipoPersona

	Select * from ucCiudadEstado
	select * from CP
	select * from EdoPais
	select * from AbrevEstadoBC

		select * from ResultadosBuroCreditoPM
			where cast(init as date)='20160729' 
			and 
			PeriodoId=5
			and finish is null
			
   select 
       --[14_DteUltPago],[45_Monto del último pago],[15_DteCompra],
	   --[43_Fecha de Primer Incumplimiento],
       * from ResultadosBuroCredito
			where cast(init as date)='20160729' 
			and 
			PeriodoId=5 
			and EmpresaId=2
			--and [14_DteUltPago] is not null 
			--and [45_Monto del último pago]=0
			--and [02_Nombre]='Carolina'
			and [05_RFC] in('DUPJ830620F57',
'MEGR771029RE5',
'GORA551009S7A',
'FUOA910327',
'ROOM920617',
'DERL7506277E8',
'SEMN700201KL1',
'LOSO620712CS3',
'HEMA580504V91',
'HECV670501315',
'NAXJ720120I87',
'RORC700611',
'LOCD710712'
)
			and finish is null 
			--order by 1

			select * from vwCuenta where Cuentactekey in(287,290)

SPSOFIA_getdatosPM_Excel


select * from vwCuenta 
	where CuentaCtekey=15067

declare @h as int=1257
select convert(varchar(3),@h)
select stuff('juan------',5,4,'.') 

select 1257/365
select [18_Origen de la Razón Social]
 from ResultadosBuroCredito
	where CuentaCtekey=13570 and cast(init as date)='20160729' 


	select * from vwCuenta where CuentaCtekey=11486

	select * from PersonaActor
		where Nombre='Francisco' and ApPaterno='Serrato'

		select * from TipoPersona


		select * from CarteraCte where CuentaCteId=13748
			order by FechaCorte desc
		 
	select * from PagoCaja 
		where CuentaCteId=15067  2016-06-24
		 --and BoletasVencidas=0

		 select * from Amortizacion 
		 where CuentaCteId=12668 and conceptoContableId=46 and EstadoPOId in(22)
		 and FechaLiquida is null

		 select * from EstadoPO

select * from fnsofia_getcargosypagosperiodoedoctainterno(11486,'20160729','20160729') 
   --order by 
	where Desglose='C' --and Saldo>0
	--order by FechaVencimiento


select top 1 fechavencimiento  
from amortizacion where CuentaCteId=10475 and conceptocontableid = 46 and estadopoid in (20,22) order by boleta


select * from ConceptoContable 

select max(FechaPago) from PagoCaja where CuentaCteId=11486 and TipoOperacionId not in(4)

select Importe,FechaPago from PagoCaja where CuentaCteId=11486 
	and cast(FechaPago as date)='2016-06-08 00:00:00' and TipoOperacionId not in(4)

select * from PagoCaja where CuentaCteId=11486 order by ConceptoContableId

select FechaPago,Importe,ImporteUsado,* from PagoCaja where CuentaCteId=11486
order by 1 desc

select * from CarteraCte where CuentaCteId=11486 and 

vwEmpleoActor

select * from RelacionEmpleo

select * from ConceptoContable

select * from TipoOperacion


select * from EmpleoActor where ActorId=28553

--CuentaCtekey in (4833,4928,5112,3315,4765,4833,4850)

select * from vwcuenta where Cuentactekey in(2628,
2647,
7429,
7887,
2526,
9061,
4928,
3315,
4765,
9937,
4833,
4850,
7950,
5112)

