select * from ResultadosBuroCredito
	where cast(init as date)='20160930'
		--and CargaSiop=1 and 
		and PeriodoId=5 --and CuentaCtekey BETWEEN 600 AND 700
		order by 1
		
		begin tran
insert into ResultadosBuroCreditoPM(CuentacteId,SegmentoEMEM,RFC_EM,Curp,NumBC,RazonSocial,Nombre1,Nombre2,Apaterno,Amaterno,Nacionalidad,
Calif,Banxico1,Banxico2,Banxico3,Domicilio,Domicilio2,Colonia,Delegacion,Ciudad,Estado,CP,Telefono,Ext,Fax,tipoCliente,EdoExt,PaisDom,fillerEm,
SegmentoCRCR,RFC_CR,NoExp,NoContrato,ContAnt,FechaApert,Plazo,TipoCred,SaldoIni,Moneda,NumPagos,FrecPag,ImportePago,UltimaFechaPago,DteReestructura,
pagoEfec,DteLiquida,montoQuita,montoDacion,montoQuebranto,ClaveObs,Especial,FillerCR,BoletaxVencer,Vencido,SegmentoDE1,RFC_DE1,NoContratoDE1,
VencidoDE1,CantidadDE1,FillDE1,SegmentoDE2,RFC_DE2,NoContratoDE2,VencidoDE2,CantidadDE2,FillDE2,SumaSaldoVencido,TEmpresas,BoletasXVencer,
SaldoTotalBoleta,MopBuro,EmpresaID,init,finish,status,PeriodoId,CargaSiop)
select CuentacteId,SegmentoEMEM,RFC_EM,Curp,NumBC,RazonSocial,Nombre1,Nombre2,Apaterno,Amaterno,Nacionalidad,Calif,Banxico1,Banxico2,Banxico3,
Domicilio,Domicilio2,Colonia,Delegacion,Ciudad,Estado,CP,Telefono,Ext,Fax,tipoCliente,EdoExt,PaisDom,fillerEm,SegmentoCRCR,RFC_CR,NoExp,
NoContrato,ContAnt,FechaApert,Plazo,TipoCred,SaldoIni,Moneda,NumPagos,FrecPag,ImportePago,UltimaFechaPago,DteReestructura,pagoEfec,DteLiquida,
montoQuita,montoDacion,montoQuebranto,ClaveObs,Especial,FillerCR,BoletaxVencer,Vencido,SegmentoDE1,RFC_DE1,NoContratoDE1,VencidoDE1,CantidadDE1,
FillDE1,SegmentoDE2,RFC_DE2,NoContratoDE2,VencidoDE2,CantidadDE2,FillDE2,SumaSaldoVencido,TEmpresas,BoletasXVencer,SaldoTotalBoleta,MopBuro,
EmpresaID,'2016-09-30',finish,status,PeriodoId,CargaSiop from ResultadosBuroCreditoPM
	where cast(init as date)='20160831'
		and PeriodoId=5 and CuentacteId=633
		--order by 1

insert into ResultadosBuroCredito(CuentaCtekey,HD,PN_Paterno,[00_Materno],[02_Nombre],[03_SegundoN],[04_fdn],[05_RFC],[11_EdoCivil],[12_Sexo],[20_f_def],
[21_Ind_Def],[PA_Calle],[00_Calle2],[01_Colonia],[02_Municipio],[03_Ciudad],[04_Estado],[05_Cp],[07_TelDom],[TL_cuentas],[01_Otorgante],[02_NomOtorga],
[04_Cuenta],[05_Resposabilidad],[06_TipoCta],[07_TipoContrato],[08_Moneda],[10_NumPagos],[11_FrecPagos],[12_monto],[13_DteApertura],[14_DteUltPago],
[15_DteCompra],[16_DteCierre],[17_DteReporte],[21_CredMaximo],[22_SdoActual],[23_LimCredito],[24_Saldovencido],[25_vencidas],[26_MOP],[30_Observacion],
[99_fin],EmpresaID,init,finish,status,PeriodoId,CargaSiop)
select CuentaCtekey,HD,PN_Paterno,[00_Materno],[02_Nombre],[03_SegundoN],[04_fdn],[05_RFC],[11_EdoCivil],[12_Sexo],[20_f_def],
[21_Ind_Def],[PA_Calle],[00_Calle2],[01_Colonia],[02_Municipio],[03_Ciudad],[04_Estado],[05_Cp],[07_TelDom],[TL_cuentas],[01_Otorgante],[02_NomOtorga],
[04_Cuenta],[05_Resposabilidad],[06_TipoCta],[07_TipoContrato],[08_Moneda],[10_NumPagos],[11_FrecPagos],[12_monto],[13_DteApertura],'2016-09-01',
[15_DteCompra],[16_DteCierre],'20160930',[21_CredMaximo],1527148,[23_LimCredito],[24_Saldovencido],[25_vencidas],[26_MOP],[30_Observacion],
[99_fin],EmpresaID,'20160930',finish,status,PeriodoId,CargaSiop 
 from ResultadosBuroCredito
	where cast(init as date)='20160831'
		and CargaSiop=1 and PeriodoId=5 and CuentaCtekey =632

commit tran





select * from ResultadosBuroCreditoPM
	where cast(init as date)='20160930'
	  and PeriodoId=5 --and CuentacteId=633


--begin tran

--update ResultadosBuroCreditoPM set UltimaFechaPago='',CantidadDE1=107175,SaldoTotalBoleta=107175
--	where cast(init as date)='20160831'
--	  and PeriodoId=5 and CuentacteId=633

--update ResultadosBuroCredito set [26_MOP]='01'
--	where cast(init as date)='20160831'
--		and CargaSiop=1 and PeriodoId=5 and CuentaCtekey between 620 and 650

--update ResultadosBuroCredito set [26_MOP]='05'
--	where cast(init as date)='20160831'
--		and CargaSiop=1 and PeriodoId=5 and CuentaCtekey=621

--update ResultadosBuroCreditoPM set Estado='HGO'
--	where cast(init as date)='20160831'
--	  and PeriodoId=5 and CuentacteId=633

--commit tran
--rollback tran

--select * from ResultadosBuroCredito
--	where cast(init as date)='20160831'
--		and CargaSiop=1 and PeriodoId=5 and CuentaCtekey between 620 and 650
--		order by 1

