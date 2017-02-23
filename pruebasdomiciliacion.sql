select * from RequisicionesIndividuales

delete from RequisicionesIndividuales where CuentaCte=11388

select BancoActorId from CuentaCte mc where mc.CuentaCtekey=2115

select top 10 * from CuentaCte where BancoActorId=0



select * from BancoCargoCuenta bc where bc.CuentaCteId=5566

select Count(*) from BancoCargoCuenta where CuentaCteId=5088 and Status=0 and Finish is null

select top 10 * from BancoCargoCuenta where  status=0 and Finish is null

select distinct * from MasterCollection where Contrato in(11457,7673,1569,5566,11498,5088) and FechaCarga>'20150615'

EXEC [SPSOFIA_RptDatosHeader] 11457 

EXEC [SPSOFIA_RptDatosHeader]7673

EXEC [SPSOFIA_RptDatosHeader]1569

EXEC [SPSOFIA_RptDatosHeader]5566

EXEC [SPSOFIA_RptDatosHeader]11498

EXEC [SPSOFIA_RptDatosHeader]5088