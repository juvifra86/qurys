

--capital a bonificacion
select sum(saldo) from FNSOFIA_GetCargosyPagosPeriodoEdoCtaInterno(10241,'20190116','20190116') where ConceptoContable=46

select distinct FechaEmision,FechaLiquida from Amortizacion where CuentaCteId=8666 and ConceptoContableId=46

SELECT top 20 * from PagoCaja where PagoCaja.CuentaCteId=2

delete from PagoCaja where PagoCaja.CuentaCteId=10241 and Importe=21568.68
--parametro fecha
select max(FechaVencimiento) from Amortizacion where CuentaCteId=10241 and ConceptoContableId=46

select * from Amortizacion where CuentaCteId=10241 and ConceptoContableId=46 
select DiasAtraso,ConceptoContableId,* from Amortizacion where CuentaCteId=653 and ConceptoContableId=46

select distinct ConceptoContableId from NotaCargo where CuentaCteId=8666 

select * from ConceptoContable where ConceptoContableKey in (46)

select Situacion from CuentaCte where CuentaCte.CuentaCtekey =9287
update CuentaCte set Situacion=73 where CuentaCte.CuentaCtekey=10241

select * from RespaldoAmortizacion  --delete from RespaldoAmortizacion where CuentaCteId=653
select * from CuentasCastigadas --delete from CuentasCastigadas where CuentaCteId=10241
select * from RespaldoNotaCargo  --delete from RespaldoNotaCargo where CuentaCteId=653

-- respalda amortizaciones
insert into RespaldoAmortizacion select ImporteEmitido, EstadoPOId from Amortizacion where CuentaCteId=1832 and EstadoPOId<>46

insert into RespaldoNotaCargo select ImporteEmitido, EstadoPOId from NotaCargo where CuentaCteId=1832


delete from RespaldoNotaCargo where CuentaCteId=1368

select situacion,contrato,* from CuentaCte where CuentaCtekey in(1594,1615,1622,1632,1637,1641,1646,1654,1660)
select situacion,contrato,* from CuentaCte where CuentaCtekey in(1662,1673,1683,1687,1688,1699,1701,1707,1708)
select situacion,* from CuentaCte where CuentaCtekey in(1713,1721,1737,1739)
select situacion,* from CuentaCte where CuentaCtekey =9897

select * from CuentaCte where situacion=73

--fecha para capital
select max(FechaVencimiento) from Amortizacion where CuentaCteId=9171 and ConceptoContableId=46
--capital
select sum(saldo) from FNSOFIA_GetCargosyPagosPeriodoEdoCtaInterno(9171,'2019-08-16','2019-08-16') where ConceptoContable=46
select  ConceptoContable, saldo, diasatraso FROM FNSOFIA_GetCargosyPagosPeriodoEdoCtaInterno(8652,'20190816','20190816') where ConceptoContable=46

--datos que cambia
select situacion,* from CuentaCte where CuentaCtekey in(8833,8931,9156)
select * from Amortizacion where CuentaCteId=8444
 select * from NotaCargo where CuentaCteId=8444          
select * from CuentasCastigadas where CuentaCteId=8444
select * from Liquidacion where CuentaCteId=10241     
delete from    Liquidacion where CuentaCteId=10241 
select  ImporteEmitido,EstadoPOId from NotaCargo WHERE ConceptoContableId <> 46 And CuentaCteId =8444              
select ImporteEmitido,EstadoPOId from Amortizacion WHERE ConceptoContableId <> 46 and CuentaCteId = 8444

select * from PagoCaja where CuentaCteId = 10241


select * from FNSOFIA_GetCargosyPagosPeriodoEdoCtaInterno (653,'20150422','20150422')