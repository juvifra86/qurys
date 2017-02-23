select * from EmpleoActor

select * from EmpresaActor

commit tran

update EmpleoActor set GiroId=342 where EmpleoActorKey in(
select ea.EmpleoActorKey
from vwCuenta vc with (nolock)
left join vwPersonaActor pa with (nolock) on vc.ClienteId =pa.PersonaActorkey 
left join empresaactor emp with (nolock) on pa.PersonaActorkey=emp.ActorId           
left join EmpleoActor ea with (nolock) on pa.PersonaActorkey=ea.ActorId   
left join DireccionActor dra with (nolock) on pa.PersonaActorkey=dra.ActorId and dra.AddressTypeId=2 and dra.Finish is null                          
left join cp cps with (nolock) on dra.CpId=cps.cpkey  
where CuentaCtekey in(select LlaveExternaId from DBSOFIA_PLD.DBO.PLD_PersonasFisicas) --and pa.EdoPaisId in(0)
)

update PersonaActor set EdoPaisId=9 
where PersonaActorkey in(
	select pa.PersonaActorkey
from vwCuenta vc with (nolock)
left join PersonaActor pa with (nolock) on vc.ClienteId =pa.PersonaActorkey 
where CuentaCtekey in(select LlaveExternaId from DBSOFIA_PLD.DBO.PLD_PersonasFisicas)
)

select LocalidadId,* 
from CuentaCte vc with (nolock)
where CuentaCtekey in(select LlaveExternaId from DBSOFIA_PLD.DBO.PLD_PersonasMorales)

commit tran
update CuentaCte set LocalidadId=6
where CuentaCtekey in(select LlaveExternaId from DBSOFIA_PLD.DBO.PLD_PersonasFisicas)


select * from ucGiroMercantil

select * from ucLocalidadCNVB

select * from ucEdoPais



select dra.*
from vwCuenta vc with (nolock)
left join vwPersonaActor pa with (nolock) on vc.ClienteId =pa.PersonaActorkey 
--left join empresaactor emp with (nolock) on pa.PersonaActorkey=emp.ActorId           
--left join EmpleoActor ea with (nolock) on pa.PersonaActorkey=ea.ActorId   
 inner join DireccionActor dra with (nolock) on pa.PersonaActorkey=dra.ActorId and dra.AddressTypeId=2 and dra.Finish is null                          
 left join cp cps with (nolock) on dra.CpId=cps.cpkey  
where CuentaCtekey in(select LlaveExternaId from DBSOFIA_PLD.DBO.PLD_PersonasMorales) --and pa.EdoPaisId in(0)
--)

select * from TipoVivienda