begin tran commit tran
    update ResultadosBuroCredito set [16_DteCierre]='1900-01-01',[30_Observacion]=''
	where cast(init as date)='20161230'
	and CuentaCtekey in(13945,10487,10959,11935,10255,13839,15190,15024,15180,14637,10808,13805,15141,
	13856,13880,13930,10296,15192,11553,13863,14618,14608,11754,12759,10472,12738,13887,11319,11323,12705,
	13788,12442,15040,11208,15177,11757,14630,11486,12608) and EmpresaID=2

update ResultadosBuroCredito set [16_DteCierre]='1900-01-01',[30_Observacion]=''
	where cast(init as date)='20161230'
	and CuentaCtekey in(10375) and EmpresaID=2
	
select * from ResultadosBuroCredito
	where cast(init as date)='20161230'
	and CuentaCtekey in(13945,10487,10959,11935,10255,13839,15190,15024,15180,14637,10808,13805,15141,
	13856,13880,13930,10296,15192,11553,13863,14618,14608,11754,12759,10472,12738,13887,11319,11323,12705,
	13788,12442,15040,11208,15177,11757,14630,11486,12608,10375) and EmpresaID=2


select * from ResultadosBuroCreditoPM
	where cast(init as date)='20161230'

