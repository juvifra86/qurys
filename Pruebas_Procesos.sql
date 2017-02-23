	
 
 select * from PLD_PersonasMorales
 select * from PLD_PersonasFisicas
select * from Persona
select * from PersonaFisica 
select * from PersonaMoral
select * from Cuenta
select * from PLD_Pagos
select * from Pago

select * from ListasNegras 

select * from PersonaFisicaMoral
select * from PersonaListasNegras

select * from DetallePagoCuenta
select distinct ComportamientoPagoCreditoId from Cuenta
select distinct CreditosActivosId from PersonaFisica
select distinct CreditosActivosId from PersonaMoral
select distinct TipoOperacionId from Persona
select distinct CoincidenciaListasNegrasId from Persona
select distinct CoincidenciaPEPId from Persona



select * from ErroresPreCargaDatos

select * from ErroresPreCargaPagos





select * from DetalleEvaluacionPersona
select * from Alerta

select * from ucAlerta

update Alerta set ReportarAlerta=1 where AlertaKey in(select top 500 Alertakey from Alerta)

