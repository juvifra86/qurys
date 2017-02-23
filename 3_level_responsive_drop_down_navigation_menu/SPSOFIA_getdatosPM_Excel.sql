/*                                  
Creo : EZM    
Descripcion : proceso que obtiene la informacion a reportar de personas morales para excel    
Sintaxis:              
Exec [SPSOFIA_getdatosPM_Excel] 1,'20130905'           
Exec [SPSOFIA_getdatosPM_Excel] 1,'20160729',5              
select * from ResultadosBuroCreditoPM    
*/                                  
 ALTER Procedure [dbo].[SPSOFIA_getdatosPM_Excel]                  
      @EmpresaID integer,                 
     @Periodo Date, 
     @CatPeriodoId integer               
As         
Declare @Fecha char(8)                                  
Declare @NumPeriodo char(6)                                  
Declare @mes  int                                   
Declare @año int                                  
Declare @UltimaFecha date                                  
        Set @Fecha=REPLACE(CONVERT(varchar,@Periodo,103),'/','')                                  
        Set @NumPeriodo=SUBSTRING(@Fecha,3,6)                                  
        Set @mes=DATEPART(MONTH,@Periodo)                                   
        Set @año=DATEPART(YEAR ,@Periodo)                                   
-------------------CALCULA FECHA SEMANAL
  declare @today  date        
  ,  @diasem  tinyint        
  ,  @fechaini   date         
  ,  @fechafin   date         
  ,  @DteCorte   date         
Set @diasem= DATEPART(dw,@Periodo)        
Set nocount on        
----- DETERMINAMOS LA FECHAS DE PERIODO ANTERIOR        
if @diasem=1        
begin        
  Set @fechaini = DATEADD(wk,-1,@Periodo)        
  Set @fechafin = DATEADD(dd,4,@fechaini)        
 End        
else        
begin        
 Set @diasem = @diasem-1        
 Set @today = DATEADD(dd,@diasem*-1,@Periodo)        
 Set @fechaini = DATEADD(wk,-1,@today)        
 Set @fechafin = DATEADD(dd,4,@fechaini)        
 End   
if @CatPeriodoId = 5
begin
     Set @UltimaFecha=(Select Top 1 FechaCorte From CarteraCte with(nolock) Where Ejercicio =@año and Periodo = @mes Order By FechaCorte Desc)                                  
end
else
begin
   Set @UltimaFecha= @fechafin
end
Select                         
   'EMEM' as EMEM               
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_EM,''),13)  as RFC-- RFC    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(curp,''),18) as Curp-- Curp             
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(NumBC,''),10) as NumBC-- NumBC    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(SUBSTRING(RazonSocial,1,75),''),75) as RazonSocial-- [RazonSocial]                  
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Nombre1,''),75) as Nombre1-- Nombre1                   
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Nombre2,''),75) as Nombre2-- Nombre2                
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Apaterno,''),25) as Apaterno-- Apaterno                
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Amaterno,''),25) as Amaterno-- Amaterno                
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('MX',''),2) as Nacionalidad-- Nacionalidad                
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('B3',''),2) as CalificacionCartera-- Calif                                   
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(banxico1,''),11) as Banxico1-- Banxico1    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(banxico2,''),11) as Banxico2-- Banxico2                                     
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(banxico3,''),11) as Banxico3-- Banxico3                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Domicilio,0),40) as Domicilio --[Domicilio]                
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('',''),40) as Domicilio2--[Domicilio2]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Colonia,''),60)  as Colonia-- [Colonia]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Delegacion,''),40) as Delegacion-- [Delegacion]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('',''),40) as Ciudad--[Ciudad]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Estado,''),4) as Estado-- Estado              
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(CP,'') ,10) as CP--CP                                 
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,11) as Telefono-- [telefono]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,8) as Extencion-- [Ext]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,11) as Fax --[Fax]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(tipoCliente,'') ,1) as TipoCliente--tipoCliente                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,40) as EstadoExtranjero--[Estado Extranjero]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(PaisDom,'') ,2) as PaisOrigenDomicilio--[Pais Origen Domicilio]                                    
     ,space(82) as filerEM --fillerEm   
	 --segmento accionistas----------------------
	 ,dbo.FNSOFIA_GetCadenaBC('C',isnull([Segmento AC],'') ,2) as [Segmento AC]--agregado
	 , Accionistas--agregado  
	 ,space(30)as FILLERAC --agregado                                  
    ,'CRCR' as  CR                 
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_CR,''),13) as RFC_Credito --RFC CREDITO    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,6)  as NumExpCrediticias --[Numero de Experiencias crediticia]        
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(NoContrato,''),25) as NoContrato --[NoContrato]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,25) as NoContratoanterior --No Contrato Anterior    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(FechaApert,'') ,8) as FechaApertura--[FechaApert]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(Plazo,0),5) as Pazo-- [Plazo]   
  ,dbo.FNSOFIA_GetCadenaBC('N',isnull(TipoCred,''),4) as TipoCredito --  [TipoCred]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(cast(saldoIni as int),0) , 20) as SaldoInicial --[SaldoIni]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(Moneda,0),3)  as Moneda           --[Moneda]    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(NumPagos,0),4) as NumPagos  --[NumPagos]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(FrecPag,0),3) as FrecuenciaPagos          --[Frecuencia de Pagos]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(cast(ImportePago as int),0),20) as ImportePagos --[ImportePago]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(UltimaFechaPago,''),8) as FechaUltimoPago--[FechaUltimoPago]                                 
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(DteReestructura,0),8) as FechaReestructura -- [DteReestructura]     
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(PagoEfec,0),20) as PagoEfectivo--[pagoEfec]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(DteLiquida,0),8) as FechaLiquida --[DteLiquida]                                       
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(montoQuita,0),20) as MontoQuita--[montoQuita]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(montoDacion,0),20) as MontoDacion--[montoDacion]                                      
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(montoQuebranto,0),20) as MontoQuebranto--[montoQuebranto]                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(ClaveObs,''),4) as ClaveObs--[ClaveObs]    
	 ,dbo.FNSOFIA_GetCadenaBC('C',isnull(Especial,''),1) as Especiales--[Especial]     
	 ,cast([23_Crédito Máximo Autorizado] as Int) as [23_Crédito Máximo Autorizado]  --agregado                               
     ,space(107) as FillerCR --[FillerCR]                
   ------------------------------VIGENTE------------------------------------                 
     --[Primer Segmento DE]                
     , 'DEDE' as DEDE1--SEGCR                
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_DE1,''),13) as RFC_DE1-- RFC  Detalle 1    
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(noContratoDE1,''),25) as NoContrato_DE1-- [NoContrato DE1]    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(VencidoDE1,0),3) as Vencido_DE1--[Vencido]         
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(CantidadDE1,0), 20)as Cantidad_DE1 --[Cantidad]          
     ,space(75) as FillerDE1--[FillDE]                                    
   ----------------------------VENCIDO--------------------------------------                 
     --[Segundo Segmento DE]                
     ,'DEDE' as DEDE2                
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_DE2,''),13)  as RFC_DE2-- RFC                              
     ,dbo.FNSOFIA_GetCadenaBC('C',isnull(NoContratoDE2,''),25) NoContrato_DE2-- [NoContratoDE]                                    
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(VencidoDE2,0),3) as Vencido_DE2--[Vencido]               
     ,dbo.FNSOFIA_GetCadenaBC('N',isnull(CantidadDE2,0),20)as Cantidad_DE2--[Cantidad]    
     ,space(75)  as FillerDE2--[FillDE]    
	 ---segmento avales-------------------------
      ,'AV' AS  [SegmentoAvales]    
	  ,Avales  
	  ,space(94) as [FillerAV]                                  
     ------------------------------------------------------------------                                  
     , BoletasXVencer  as  BoletasxVencer-- Total de Boletas por Vencer                                 
     , cast(SaldoTotalBoleta as Int) as Vencido--Campo Saldo Total de la Boleta    [VENCIDO]                             
     ,isnull(CantidadDE1,0) + isnull(CantidadDE2,0) as SumaSaldoVencido-- SumaSaldoVencido    
  ,Tempresas --TEmpresas -----------SE DEJA SI ES NULO    
     from ResultadosBuroCreditoPM with(nolock)   
     where empresaID =  @EmpresaID                                  
     and cast(init as date) =  cast(@UltimaFecha as date)    
     and finish is null    
     and status = 0    
     and periodoId = @CatPeriodoId
     Order By [RazonSocial] Desc--,d.DiasAtraso Desc        
