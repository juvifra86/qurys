select * from Ctasofiasofia CSS
inner join BancoCargoCuenta CB
on CSS.CuentaCteNewId= CB.CuentaCteId
where CSS.Notraspaso=3
and CB.CicloCorteId=1
and cast(init as date)='20151118'
union
select * from Ctasofiasofia CSS
inner join BancoCargoCuenta CB
on CSS.CuentaCteNewId= CB.CuentaCteId
where CSS.Notraspaso=3
and CB.CicloCorteId=2
and cast(init as date)='20151118'
union
select * from Ctasofiasofia CSS
inner join BancoCargoCuenta CB
on CSS.CuentaCteNewId= CB.CuentaCteId
where CSS.Notraspaso=3
and CB.CicloCorteId=3
and cast(init as date)='20151118'