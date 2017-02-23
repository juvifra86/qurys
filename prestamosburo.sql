insert into ResultadosBuroCredito(CuentaCtekey,HD,PN_Paterno,[00_Materno],[02_Nombre],[03_SegundoN],[04_fdn],[05_RFC],[11_EdoCivil],[12_Sexo],[20_f_def],
[21_Ind_Def],[PA_Calle],[00_Calle2],[01_Colonia],[02_Municipio],[03_Ciudad],[04_Estado],[05_Cp],[07_TelDom],[TL_cuentas],[01_Otorgante],[02_NomOtorga],
[04_Cuenta],[05_Resposabilidad],[06_TipoCta],[07_TipoContrato],[08_Moneda],[10_NumPagos],[11_FrecPagos],[12_monto],[13_DteApertura],[14_DteUltPago],
[15_DteCompra],[16_DteCierre],[17_DteReporte],[21_CredMaximo],[22_SdoActual],[23_LimCredito],[24_Saldovencido],[25_vencidas],[26_MOP],[30_Observacion],
[99_fin],EmpresaID,init,finish,status,PeriodoId,CargaSiop)
select CuentaCtekey,HD,PN_Paterno,[00_Materno],[02_Nombre],[03_SegundoN],[04_fdn],[05_RFC],[11_EdoCivil],[12_Sexo],[20_f_def],
[21_Ind_Def],[PA_Calle],[00_Calle2],[01_Colonia],[02_Municipio],[03_Ciudad],[04_Estado],[05_Cp],[07_TelDom],[TL_cuentas],[01_Otorgante],[02_NomOtorga],
[04_Cuenta],[05_Resposabilidad],[06_TipoCta],[07_TipoContrato],[08_Moneda],[10_NumPagos],[11_FrecPagos],[12_monto],[13_DteApertura],'2016-12-05',
[15_DteCompra],[16_DteCierre],
'20170131',[21_CredMaximo],1495702,[23_LimCredito],0,0,'01',[30_Observacion],
[99_fin],EmpresaID,'20170131',finish,status,PeriodoId,CargaSiop 
 from ResultadosBuroCredito
	where cast(init as date)='20161130'
		and CargaSiop=1 and PeriodoId=5 and CuentaCtekey =632
		


		


select * from ResultadosBuroCredito --set [17_DteReporte]='20161230',init='20161230'
	where cast(init as date)='20170131'
		--and finish is null  
		and CuentaCtekey in(621,635,636,637,641,643,632) and CargaSiop=1
		order by 1 asc

--		select * from vwCuenta where CuentaCtekey in(6851,10276,7236,7237,7238)

select * from ResultadosBuroCredito
	where CuentaCtekey in(select CuentaCteNewId from CtaSofiaSofia where NoTraspaso=6) 
	and cast(init as date)='20161031'

	

Select * from 

   --update 
   ResultadosBuroCreditoPM 
   --set UltimaFechaPago='20161219',DteLiquida='20161219',CantidadDE1=0,SaldoTotalBoleta=0,init='20161230'
	where --CuentaCteId = 633 and 
	cast(init as date)='20161230'

--	Select * from ResultadosBuroCreditoPM 
--	where CuentaCteId in(10276,7236,7237,7238)
--		--and finish is null and 
--		--and cast(init as date)='20161031'
--	order by init desc