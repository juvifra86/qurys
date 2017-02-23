select * from ResultadosBuroCredito
where CuentaCtekey in (13945,10487,10959,11935,10255,13839,15190,15024,15180,14637,10808,13805,15141,
	13856,13880,13930,10296,15192,11553,13863,14618,14608,11754,12759,10472,12738,13887,11319,11323,12705,
	13788,12442,15040,11208,15177,11757,14630,11486,12608,10375)
	and cast(init as date)='20161230'
	and EmpresaID=2

update ResultadosBuroCredito set [30_Observacion]='CA'
 where CuentaCtekey = 10375 and cast(init as date)='20161230'
	and EmpresaID=2

select * from ResultadosBuroCredito 
where CuentaCteKey in (13953,14966)
--where [16_DteCierre]='2016-11-30' 
and cast(init as date)='20161230'

select * from CarteraCte 
where CuentaCteId in(14966)--,14966) 
--and cast(FechaCorte as date)='2016-12-30'
order by FechaCorte desc

select * from vwPagoCaja where CuentaCteId = 14966
order by FechaPago desc

select * from PagoCaja where PagoCajaKey in(490146,504599)

select * from Banco

update ResultadosBuroCredito set [16_DteCierre]='2016-12-27'
	where CuentaCteKey=14966 and cast(init as date)='20161230'


update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=10255
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	10296
update ResultadosBuroCredito set [26_MOP]=01 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	10375
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	10472
update ResultadosBuroCredito set [26_MOP]=05 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	10487
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	10808
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	10959
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11208
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11319
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11323
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11486
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11553
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11754
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11757
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	11935
update ResultadosBuroCredito set [26_MOP]=05 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	12442
update ResultadosBuroCredito set [26_MOP]=97 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	12608
update ResultadosBuroCredito set [26_MOP]=05 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	12705
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	12738
update ResultadosBuroCredito set [26_MOP]=05 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	12759
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13788
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13805
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13839
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13856
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13863
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13880
update ResultadosBuroCredito set [26_MOP]=04 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13887
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13930
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	13945
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	14608
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	14618
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	14630
update ResultadosBuroCredito set [26_MOP]=05 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	14637
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	15024
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	15040
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	15141
update ResultadosBuroCredito set [26_MOP]=05 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	15177
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	15180
update ResultadosBuroCredito set [26_MOP]=06 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	15190
update ResultadosBuroCredito set [26_MOP]=07 where cast(init as date)='20161230' and EmpresaID=1 and Cuentactekey=	15192