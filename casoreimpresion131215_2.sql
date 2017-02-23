/*      
 Creado: Erick Torres      
      
 Descripcion: Recupera las polizas para generar las requisiciones   
   
 Modificado: Juan franco  
   
 Descripción: Se agregaron mas campos a la consulta y el filtro de empresa para obtener sumatoria de importe por aseguradora y empresa y fecha.     


MODF: GACP 8/10/15  
SE HACE CORRECCION CUANDO SE HACE UNA DESBURSATILZACION EL REGISTRO DE BURSA NO DEBE CONSIDERARSE  

      
 EXEC SPSOFIA_RequisicionSegurosIndividual 0,0,0,0,'20150216','20150228',0 , 1,0 --caso entresemana no MIGRADOS  
 Exec SPSOFIA_RequisicionSegurosIndividual 0,0,0,1,'20141001','20141031',0 , 1,0 --caso viernes no MIGRADOS  
 EXEC SPSOFIA_RequisicionSegurosIndividual 0,2,0,1,'20150201','20150215',1 , 1,0 --caso entresemana con MIGRADOS  
 Exec SPSOFIA_RequisicionSegurosIndividual 0,1,0,1,'20150201','20150215',1 , 1,0 --caso sabado con MIGRADOS  
 Exec SPSOFIA_RequisicionSegurosIndividual 0,0,0,1,'20141001','20141031',1 , 1,0 --caso viernes con MIGRADOS   
   
 Exec SPSOFIA_RequisicionSegurosIndividual 0,0,0,0,'20150601','20150630',1, 0,0-- no migrados  
 Exec SPSOFIA_RequisicionSegurosIndividual 0,1,0,0,'20150517','20150617',0, 0,0 --migrados  
 Exec SPSOFIA_RequisicionSegurosIndividual131115 11993,0,0,1,'20150801','20151113',0 , 0,0 --caso seguro auto  
*/      
      
alter PROCEDURE SPSOFIA_RequisicionSegurosIndividual131115    
 (      
  @CuentaCte bigint = 0      
  ,@EmpresaId smallint       
  ,@AseguradoraId tinyint      
  ,@TipoPago tinyint      
  ,@FechaIni datetime      
  ,@fechaFin datetime      
  ,@Migrados bit      
  ,@TipoSeguro bit   
  ,@FiltroEmpresa bit   
 )      
AS      
BEGIN      
 --if @Migrados=1  
  --set @Migrados=5  
 DECLARE @NotaSeguro INT = 61      
   ,@Emitido int = 25      
   ,@SaldoporCobrar int = 27     
   ,@Cancelado int = 28   
   ,@Ace int = 100      
   ,@Patrimonial int = 101  
   ,@nd int       
   ,@nd1 int  
   ,@FechaLiberacion date = '20150526'  
   ,@iva float=0.16  
Declare  @factorsegurodevida float   
 ,@porcentajesegurodevidapago float    
   
Select @factorsegurodevida=dbo.[FNSOFIA_FactoresSeguroVida](1)                          
Select @porcentajesegurodevidapago=dbo.[FNSOFIA_FactoresSeguroVida](3)         
      
 DECLARE @SegurosTemp TABLE      
  (    
   impreso tinyint    
   ,cuentacte bigint      
   ,nombre varchar(max)      
   ,empresa varchar(max)  
   ,aseguradora varchar(max)   
   ,poliza varchar(20)      
   ,fecha varchar(10)      --fechaentregaunidad  
   ,Primatotal money  
   ,PrimaNeta money  
   ,UDI money  
   ,IVA money  
   ,Totaludi money      
   ,boleta smallint  
   ,Plans varchar(50)  
   ,Plazo varchar(50)  
   ,No_Agente int  
   ,vigencia1 date  
   ,vigencia2 date  
   ,fechaemision date  
   ,impudis money  
   ,migrado tinyint  
   ,sucursal varchar(max)  
   ,frecpago varchar(50)  
   --*/  
  )      
  
  DECLARE @TEMPVida TABLE  
 (  
  empresaid int  
  ,saldoinsoluto decimal  
 )  
  
 DECLARE @TEMPDesempleo TABLE  
 (  
  empresaid int  
  ,saldoinsoluto decimal  
 )  
  
  DECLARE @SALDOS TABLE  
 (  
  empresaid int  
  ,saldoinsoluto decimal  
 )  
       
 IF @TipoSeguro = 0      
  BEGIN      
   INSERT INTO @SegurosTemp     
    SELECT (select count(1) from RequisicionesIndividuales where CuentaCte=CQ.CuentaCteId) impreso  
 ,CQ.CuentaCteId cuentacte      
     ,VC.NombreCompleto nombre      
     ,CASE WHEN EXISTS(SELECT 1 FROM Bursatilizado B WHERE B.CuentaCteId = CQ.CuentaCteId  and B.finish is null     
           AND B.EmpresaAnteriorId IS NOT NULL AND B.EmpresaAnteriorId <> VC.EmpresaId)        
        THEN (SELECT E.EmpresaDsc FROM Empresa E WHERE E.EmpresaKey = (SELECT B1.EmpresaAnteriorId FROM Bursatilizado B1 WHERE B1.CuentaCteId = CQ.CuentaCteId  and B1.finish is null     
           AND B1.EmpresaAnteriorId IS NOT NULL AND B1.EmpresaAnteriorId <> VC.EmpresaId) )      
        ELSE VC.EmpresaDsc END empresa      
     ,A.RazonSocial aseguradora      
     ,PS.Poliza poliza      
     ,CAST((SELECT DBO.FNSOFIA_CalculaFechaPagoPoliza (A.AseguradoraKey,PS.FechaEmision)) AS varchar(10)) fecha      
     ,PS.PrimaTotal PrimaTotal      
     ,PS.PrimaNeta  
  ,ROUND(((PS.PrimaNeta * (SELECT TOP (1) (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey            AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100),2) udis  
  ,ROUND(((PS.PrimaNeta * (SELECT TOP (1) (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey  
         AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100 * @iva),2) iva  
  ,ROUND((((PS.PrimaNeta * (SELECT TOP (1) (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey  
         AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100) +  
    ((PS.PrimaNeta * (SELECT TOP (1)  (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey  
         AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100 * @iva)),2) totalUdis      
     ,0 boleta  
  --/*  
  ,vc.PlanDsc  
 ,(case when LEN(PL.PlazoDsc)=13 then substring(PL.PlazoDsc,1,8)           
      else           
      (case when LEN(PL.PlazoDsc)=12 then substring(PL.PlazoDsc,1,7)          
       else          
         PL.PlazoDsc           
       end)          
     end) as PlazoDsc    
  ,vp.numagente  
  , VP.FechaPolizaINI         
     ,VP.FechaPolizaFin  
  ,VP.FechaEmision       
     ,cast(round(VP.PrimaNeta * (Select Value from ParametroSofia where ParametroSofiaKey = 69),2) as money) ImporteUdis  
  ,0 migrado  
  ,vc.SucursalDsc  
  ,Per.PeriodoDsc  
    
     --*/  
  FROM ChequeCuenta CQ  WITH(NOLOCK)    
      INNER JOIN vwCuenta VC   WITH(NOLOCK)     
       ON CQ.CuentaCteId = VC.CuentaCtekey      
   INNER JOIN vwPolizaCte VP with(nolock)  
    on vp.CuentaCteId=vc.CuentaCtekey  
      INNER JOIN UnidadCuentaCte UCC  WITH(NOLOCK)      
       ON CQ.CuentaCteId = UCC.CuentaCteId      
      INNER JOIN PolizaSeguroUnidad PS  WITH(NOLOCK)      
       ON UCC.UnidadCuentaCtekey = PS.UnidadCuentaCteId      
      INNER JOIN Aseguradora A   WITH(NOLOCK)     
       ON PS.AseguradoraId = A.AseguradoraKey     
   inner JOIN Periodo Per with(nolock)                                             
  on PS.FrecuenciaPagoId = Per.PeriodoKey        
      INNER JOIN vwCuentaPlazo CP  WITH(NOLOCK)      
       ON CQ.CuentaCteId = CP.CuentaCtekey      
    INNER JOIN Plazo PL       
    ON PL.PlazoKey = CP.PlazoId  
     WHERE CAST(CQ.FechaEmision AS DATE) BETWEEN CAST(@FechaIni AS DATE) AND CAST(@FechaFin AS DATE)  
      AND CQ.CuentaCteId = CASE WHEN @CuentaCte = 0 THEN CQ.CuentaCteId ELSE @CuentaCte END      
      AND VC.EmpresaId = CASE WHEN @EmpresaId = 0 THEN VC.EmpresaId ELSE @EmpresaId END      
      AND A.AseguradoraKey = CASE WHEN @AseguradoraId = 0 THEN A.AseguradoraKey ELSE @AseguradoraId END      
      AND PS.Status = 0     
   AND CAST(PS.FechaPolizaINI AS DATE) >= @FechaLiberacion  
   AND CAST(CQ.FechaEmision AS DATE) >= @FechaLiberacion  
   
   AND VC.Situacion NOT IN (14)  
  
    --UNION      
  
    SELECT (select count(1) from RequisicionesIndividuales where CuentaCte=NC.CuentaCteId) impreso  
 ,NC.CuentaCteId cuentacte      
     ,VC.NombreCompleto nombre       
     ,CASE WHEN EXISTS(SELECT 1 FROM Bursatilizado B WHERE B.CuentaCteId = NC.CuentaCteId and B.finish is null
           AND B.EmpresaAnteriorId IS NOT NULL AND B.EmpresaAnteriorId <> VC.EmpresaId)        
        THEN (SELECT E.EmpresaDsc FROM Empresa E WHERE E.EmpresaKey = (SELECT B1.EmpresaAnteriorId FROM Bursatilizado B1 WHERE B1.CuentaCteId = NC.CuentaCteId  and B1.finish is null     
           AND B1.EmpresaAnteriorId IS NOT NULL AND B1.EmpresaAnteriorId <> VC.EmpresaId) )      
        ELSE VC.EmpresaDsc END empresa      
     ,A.RazonSocial aseguradora      
     , PS.Poliza poliza      
      ,(CASE WHEN A.RazonSocial IS NULL THEN NULL  
   ELSE CAST((SELECT DBO.FNSOFIA_CalculaFechaPagoPoliza (A.AseguradoraKey,NC.FechaVencimiento)) AS varchar(10)) END) fecha          
  ,NC.ImporteEmitido PrimaTotal      
     ,PS.PrimaNeta  
  ,ROUND(((PS.PrimaNeta * (SELECT TOP (1) (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey  
         AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100),2) udis  
  ,ROUND(((PS.PrimaNeta * (SELECT TOP (1) (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey  
         AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100 * @iva),2) iva  
  ,ROUND((((PS.PrimaNeta * (SELECT TOP (1) (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey  
         AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100) +  
    ((PS.PrimaNeta * (SELECT TOP (1)  (FP.Porciento) FROM FechaPagoAseguradora FP WHERE FP.AseguradoraId = A.AseguradoraKey  
         AND CAST(FP.Fecha AS DATE) <= CAST(GETDATE() AS DATE)))/100 * @iva)),2) totalUdis          
     ,nc.Boleta boleta    
  --/*  
  ,vc.PlanDsc  
 ,(case when LEN(PL.PlazoDsc)=13 then substring(PL.PlazoDsc,1,8)           
      else           
      (case when LEN(PL.PlazoDsc)=12 then substring(PL.PlazoDsc,1,7)          
       else          
         PL.PlazoDsc           
       end)          
     end) as PlazoDsc    
  ,vp.numagente  
  , VP.FechaPolizaINI         
     ,VP.FechaPolizaFin  
  ,VP.FechaEmision,   
  cast(round(VP.PrimaNeta * (Select Value from ParametroSofia where ParametroSofiaKey = 69),2) as money) ImporteUdis  
  ,@Migrados migrado  
  ,vc.SucursalDsc  
  ,per.PeriodoDsc  
  --*/  
     FROM NotaCargo NC WITH(NOLOCK)       
      INNER JOIN vwCuenta VC WITH(NOLOCK)       
       ON NC.CuentaCteId = VC.CuentaCtekey    
     INNER JOIN vwPolizaCte VP with(nolock)  
    on vp.CuentaCteId=vc.CuentaCtekey    
      INNER JOIN UnidadCuentaCte UCC  WITH(NOLOCK)      
       ON NC.CuentaCteId = UCC.CuentaCteId      
      INNER JOIN PolizaSeguroUnidad PS WITH(NOLOCK)       
       ON UCC.UnidadCuentaCtekey = PS.UnidadCuentaCteId      
      INNER JOIN Aseguradora A WITH(NOLOCK)       
       ON PS.AseguradoraId = A.AseguradoraKey    
    inner JOIN Periodo Per with(nolock)                                             
  on PS.FrecuenciaPagoId = Per.PeriodoKey    
     INNER JOIN vwCuentaPlazo CP WITH(NOLOCK)       
       ON NC.CuentaCteId = CP.CuentaCtekey  
     INNER JOIN Plazo PL       
    ON PL.PlazoKey = CP.PlazoId      
     WHERE NC.ConceptoContableId = @NotaSeguro      
      AND NC.EstadoPOId NOT IN (@Cancelado)   ------- ???????     
   AND NC.ImporteEmitido > 0  
      AND CAST(NC.FechaVencimiento AS DATE) BETWEEN CAST(@FechaIni AS DATE) AND CAST(@FechaFin AS DATE)      
      AND NC.CuentaCteId = CASE WHEN @CuentaCte = 0 THEN NC.CuentaCteId ELSE @CuentaCte END      
      AND VC.EmpresaId = CASE WHEN @EmpresaId = 0 THEN VC.EmpresaId ELSE @EmpresaId END    
   AND A.AseguradoraKey = CASE WHEN @AseguradoraId = 0 THEN A.AseguradoraKey ELSE @AseguradoraId END      
      AND PS.Status = 0      
      AND @Migrados = 1    
   AND CAST(NC.FechaVencimiento AS DATE) >= @FechaLiberacion  
   AND VC.TipoProdId = 5  
  
   AND VC.Situacion IN(12,72)   
        
    ORDER BY  fecha     
     
 --   select * from @SegurosTemp  
	--return
   IF @TipoPago = 0 -- TODO    
     BEGIN   
  if @Filtroempresa=1                       
     SELECT distinct st.empresa,st.aseguradora,st.fecha,sum(st.Primatotal)as importe,REPLACE(CAST(CAST(@FechaIni AS DATE) AS VARCHAR(8)),'-','') + CASE WHEN DATEPART(dd,@FechaIni) < 16 THEN '1' ELSE '2' END as periodo,(select AseguradoraKey from Asegurado

ra where RazonSocial=st.aseguradora) as ase_id,(SELECT EmpresaKey FROM Empresa WHERE EmpresaDsc = st.empresa)as emp_id  
     FROM @SegurosTemp ST where st.migrado=@Migrados group by st.empresa,st.aseguradora,st.fecha  
       else   
   SELECT st.impreso,st.cuentacte,st.Plans,st.nombre,isnull(st.sucursal,'NINGUNA'),st.Plazo,st.No_Agente,st.poliza,isnull(st.Primatotal,0) primatotal,st.frecpago,st.vigencia1,st.vigencia2,isnull(st.PrimaNeta,0),st.fecha,isnull(st.Totaludi,0),isnull(st.aseguradora,'NINGUNA'),isnull(st.empresa,'NINGUNA'),isnull(st.boleta,0) FROM @SegurosTemp ST  where st.migrado=@Migrados  and st.PrimaTotal>1        
    END      
      
   IF @TipoPago = 1 -- CONTADO      
    BEGIN    
  if @Filtroempresa=1     
     SELECT distinct st.empresa,st.aseguradora,st.fecha,sum(st.Primatotal)as importe,REPLACE(CAST(CAST(@FechaIni AS DATE) AS VARCHAR(8)),'-','') + CASE WHEN DATEPART(dd,@FechaIni) < 16 THEN '1' ELSE '2' END as periodo,(select AseguradoraKey from Aseguradora where RazonSocial=st.aseguradora) as ase_id,(SELECT EmpresaKey FROM Empresa WHERE EmpresaDsc = st.empresa)as emp_id  
      FROM @SegurosTemp ST   
     INNER JOIN vwCuentaPlazo CP  WITH(NOLOCK)      
   ON ST.cuentacte = CP.CuentaCtekey      
   WHERE CP.TipoSeguroID = 1 and st.migrado=@Migrados    
   group by st.empresa,st.aseguradora,st.fecha  
       else     
   SELECT st.impreso,st.cuentacte,st.Plans,st.nombre,isnull(st.sucursal,'NINGUNA'),st.Plazo,st.No_Agente,st.poliza,isnull(st.Primatotal,0),st.frecpago,st.vigencia1,st.vigencia2,isnull(st.PrimaNeta,0),st.fecha,isnull(st.Totaludi,0),isnull(st.aseguradora,'NINGUNA'),isnull(st.empresa,'NINGUNA'),isnull(st.boleta,0) FROM @SegurosTemp ST      
   INNER JOIN vwCuentaPlazo CP  WITH(NOLOCK)      
   ON ST.cuentacte = CP.CuentaCtekey      
   WHERE CP.TipoSeguroID = 1 and st.migrado=@Migrados       
    END      
      
   IF @TipoPago = 2 --MULTI      
    BEGIN    
 if @Filtroempresa=1     
     SELECT distinct st.empresa,st.aseguradora,st.fecha,sum(st.Primatotal)as importe,cast((REPLACE(CAST(CAST((select top 1 fecha from @SegurosTemp) AS DATE) AS VARCHAR(8)),'-','') + CASE WHEN DATEPART(dd,CAST((select top 1 fecha from @SegurosTemp) AS DATE

)) < 16 THEN '01' ELSE '16' END)as date) as fechapago,REPLACE(CAST(CAST(@FechaIni AS DATE) AS VARCHAR(8)),'-','') + CASE WHEN DATEPART(dd,@FechaIni) < 16 THEN '1' ELSE '2' END as periodo,(select AseguradoraKey from Aseguradora where RazonSocial=st.aseguradora) as ase_id,(SELECT EmpresaKey FROM Empresa WHERE EmpresaDsc = st.empresa)as emp_id  
      FROM @SegurosTemp ST   
     INNER JOIN vwCuentaPlazo CP WITH(NOLOCK)       
       ON ST.cuentacte = CP.CuentaCtekey      
      INNER JOIN PolizaSeguroUnidad PS WITH(NOLOCK)       
       ON ST.poliza = PS.Poliza      
      WHERE CP.TipoSeguroID <> 1      
       AND DATEDIFF(YEAR,PS.FechaPolizaINI,PS.FechaPolizaFin) > 1  
    and st.migrado=@Migrados    
     group by st.empresa,st.aseguradora,st.fecha  
       else    
     SELECT st.impreso,st.cuentacte,st.Plans,st.nombre,isnull(st.sucursal,'NINGUNA'),st.Plazo,st.No_Agente,st.poliza,isnull(st.Primatotal,0),st.frecpago,st.vigencia1,st.vigencia2,isnull(st.PrimaNeta,0),st.fecha,isnull(st.Totaludi,0),isnull(st.aseguradora,

'NINGUNA'),isnull(st.empresa,'NINGUNA'),isnull(st.boleta,0) FROM @SegurosTemp ST      
      INNER JOIN vwCuentaPlazo CP WITH(NOLOCK)       
       ON ST.cuentacte = CP.CuentaCtekey      
      INNER JOIN PolizaSeguroUnidad PS WITH(NOLOCK)       
       ON ST.poliza = PS.Poliza      
      WHERE CP.TipoSeguroID <> 1 and st.migrado=@Migrados       
       AND DATEDIFF(YEAR,PS.FechaPolizaINI,PS.FechaPolizaFin) > 1      
    END      
      
   IF @TipoPago = 3 --ANUAL      
    BEGIN   
 if @Filtroempresa=1     
     SELECT distinct st.empresa,st.aseguradora,st.fecha,sum(st.Primatotal)as importe,cast((REPLACE(CAST(CAST((select top 1 fecha from @SegurosTemp) AS DATE) AS VARCHAR(8)),'-','') + CASE WHEN DATEPART(dd,CAST((select top 1 fecha from @SegurosTemp) AS DATE

)) < 16 THEN '01' ELSE '16' END)as date) as fechapago,REPLACE(CAST(CAST(@FechaIni AS DATE) AS VARCHAR(8)),'-','') + CASE WHEN DATEPART(dd,@FechaIni) < 16 THEN '1' ELSE '2' END as periodo,(select AseguradoraKey from Aseguradora where RazonSocial=st.aseguradora) as ase_id,(SELECT EmpresaKey FROM Empresa WHERE EmpresaDsc = st.empresa)as emp_id  
      FROM @SegurosTemp ST INNER JOIN vwCuentaPlazo CP WITH(NOLOCK)       
       ON ST.cuentacte = CP.CuentaCtekey      
      INNER JOIN PolizaSeguroUnidad PS WITH(NOLOCK)       
       ON ST.poliza = PS.Poliza      
      WHERE CP.TipoSeguroID <> 1  and st.migrado=@Migrados      
       AND DATEDIFF(YEAR,PS.FechaPolizaINI,PS.FechaPolizaFin) > 1  
    group by st.empresa,st.aseguradora,st.fecha  
       else     
     SELECT st.impreso,st.cuentacte,st.Plans,st.nombre,isnull(st.sucursal,'NINGUNA'),st.Plazo,st.No_Agente,st.poliza,isnull(st.Primatotal,0),st.frecpago,st.vigencia1,st.vigencia2,isnull(st.PrimaNeta,0),st.fecha,isnull(st.Totaludi,0),isnull(st.aseguradora,

'NINGUNA'),isnull(st.empresa,'NINGUNA'),isnull(st.boleta,0) FROM @SegurosTemp ST     
      INNER JOIN vwCuentaPlazo CP  WITH(NOLOCK)      
       ON ST.cuentacte = CP.CuentaCtekey      
      INNER JOIN PolizaSeguroUnidad PS WITH(NOLOCK)       
       ON ST.poliza = PS.Poliza      
      WHERE CP.TipoSeguroID <> 1  and st.migrado=@Migrados      
       AND DATEDIFF(YEAR,PS.FechaPolizaINI,PS.FechaPolizaFin) = 1      
    END     
 --select top 1 fecha from @SegurosTemp  
  END    
  ELSE  
 begin  
  set @nd = (select DATEPART(dw,@fechaFin ))  
  if @nd  = 5  
   begin  
    set @nd1 = @nd -5  
    set @fechaFin = (select dateadd(dd,-@nd1,@fechaFin))   
   end  
  else -- caso no cae en viernes  
   begin  
    set @nd1 = @nd -5  
    if @nd1 > 0 --caso sabado y domingo  
     begin  
      set @fechaFin = (select dateadd(dd,-@nd1,@fechaFin))  
     end  
    else --caso entre semana  
     begin  
      set @nd1 = 7+@nd1  
      set @fechaFin = (select dateadd(dd,-@nd1,@fechaFin))  
     end  
   end    
      
  DECLARE @FECHA VARCHAR(10)   
  DECLARE @FECHA1 VARCHAR(10)  
  declare @Empresa2 nvarchar(100)   
  DECLARE @Control VARCHAR(10)  
  
  SET @Control = REPLACE(CAST(CAST(@FechaIni AS DATE) AS VARCHAR(8)),'-','') + CASE WHEN DATEPART(dd,@FechaIni) < 16 THEN '1' ELSE '2' END  
  
  SET @FECHA = (CAST((SELECT DBO.FNSOFIA_CalculaFechaPagoPoliza  (100,@FechaIni)) AS varchar(10))) --DESEMPLEO  
  SET @FECHA1 = (CAST((SELECT DBO.FNSOFIA_CalculaFechaPagoPoliza (101,@FechaIni)) AS varchar(10))) --VIDA  
  
  INSERT INTO @TEMPVida  
   SELECT C.EmpresaId  
     ,(Select Top 1 SaldoInsolutoConActual from CarteraCte WITH(NOLOCK)   
      where cuentacteid = c.CuentaCtekey   
      order by fechacorte desc) SaldoInsoluto    
    From cuentacte c    
      Inner join personaActor p on p.actorid = c.ClienteId and TipoPersonaId=4    
      Inner join UnidadCuentaCte ucc on ucc.CuentaCteId = c.CuentaCtekey    
      Inner join PolizaSeguroUnidad psu on psu.UnidadCuentaCteId = ucc.UnidadCuentaCtekey    
        and psu.FechaPolizaINI <= @fechaFin           
        and psu.FechaPolizaFin >= @fechaFin      
      Inner join Sucursal s on s.SucursalKey = c.SucursalId    
    Where p.tipoFiscal = 'F'   
     and c.CuentaCtekey not in (39,40)   
     And c.Situacion  not in (12,14)   
     and c.EmpresaId = CASE WHEN @EmpresaId = 0 THEN c.EmpresaId ELSE @EmpresaId END     
    Order by c.CuentaCtekey   
  
  INSERT INTO @TEMPVida  
    SELECT C.EmpresaId  
     ,(Select Top 1 SaldoInsolutoConActual from CarteraCte WITH(NOLOCK)   
      where cuentacteid = c.CuentaCtekey   
      order by fechacorte desc) SaldoInsoluto    
    From vwCuenta c    
      Inner join personaActor p on p.actorid = c.ClienteId and TipoPersonaId=4    
      Inner join UnidadCuentaCte ucc on ucc.CuentaCteId = c.CuentaCtekey    
      Inner join PolizaSeguroUnidad psu on psu.UnidadCuentaCteId = ucc.UnidadCuentaCtekey    
        --and psu.FechaPolizaINI <= @fechaFin           
    and psu.FechaPolizaFin >= @fechaFin      
      Inner join Sucursal s on s.SucursalKey = c.SucursalId    
    Where p.tipoFiscal = 'F'   
     and c.CuentaCtekey not in (39,40)   
     And c.Situacion in (72,73)  
     and c.EmpresaId = CASE WHEN @EmpresaId = 0 THEN c.EmpresaId ELSE @EmpresaId END    
     and c.TipoProdId = 5   
  
    --Order by c.CuentaCtekey   
  
  INSERT INTO @TEMPDesempleo  
   SELECT C.EmpresaId  
     ,(Select Top 1 SaldoInsolutoConActual from CarteraCte WITH(NOLOCK)   
      where cuentacteid = c.CuentaCtekey   
      order by fechacorte desc) SaldoInsoluto    
    From cuentacte c    
      Inner join personaActor p on p.actorid = c.ClienteId and TipoPersonaId=4    
      Inner join UnidadCuentaCte ucc on ucc.CuentaCteId = c.CuentaCtekey    
      Inner join PolizaSeguroUnidad psu on psu.UnidadCuentaCteId = ucc.UnidadCuentaCtekey    
        and psu.FechaPolizaINI <= @fechaFin           
        and psu.FechaPolizaFin >= @fechaFin      
      Inner join Sucursal s on s.SucursalKey = c.SucursalId    
    Where p.tipoFiscal = 'F'   
     and c.CuentaCtekey not in (39,40)   
     And c.Situacion in (72)   
     and c.EmpresaId = CASE WHEN @EmpresaId = 0 THEN c.EmpresaId ELSE @EmpresaId END     
    Order by c.CuentaCtekey   
  
  INSERT INTO @TEMPDesempleo  
    SELECT C.EmpresaId  
     ,(Select Top 1 SaldoInsolutoConActual from CarteraCte WITH(NOLOCK)   
      where cuentacteid = c.CuentaCtekey   
      order by fechacorte desc) SaldoInsoluto    
    From vwCuenta c    
      Inner join personaActor p on p.actorid = c.ClienteId and TipoPersonaId=4    
      Inner join UnidadCuentaCte ucc on ucc.CuentaCteId = c.CuentaCtekey    
      Inner join PolizaSeguroUnidad psu on psu.UnidadCuentaCteId = ucc.UnidadCuentaCtekey    
        --and psu.FechaPolizaINI <= @fechaFin           
        and psu.FechaPolizaFin >= @fechaFin      
      Inner join Sucursal s on s.SucursalKey = c.SucursalId    
    Where p.tipoFiscal = 'F'   
     and c.CuentaCtekey not in (39,40)   
     And c.Situacion in (72)  
     and c.EmpresaId = CASE WHEN @EmpresaId = 0 THEN c.EmpresaId ELSE @EmpresaId END    
     and c.TipoProdId = 5   
  
  
  SELECT E.EmpresaDsc  
   ,(SELECT RazonSocial FROM Aseguradora WITH(NOLOCK) WHERE AseguradoraKey = 11) --VIDA  
   , @FECHA1  
   , ROUND((ISNULL(SUM(T.saldoinsoluto),0)) * @factorsegurodevida,2)  
   ,@Control    
   FROM @TEMPVida T  
    INNER JOIN Empresa E  
     ON T.empresaid = E.EmpresaKey  
   GROUP BY E.EmpresaDsc   
  UNION  
  SELECT E.EmpresaDsc  
   ,(SELECT RazonSocial FROM Aseguradora WITH(NOLOCK) WHERE AseguradoraKey = 10) --DESEMPLEO  
   , @FECHA  
   , ROUND((ISNULL(SUM(T.saldoinsoluto),0)) * dbo.[FNSOFIA_FactoresSeguroDesempleo](1) ,2)  
   ,@Control    
   FROM @TEMPDesempleo T  
    INNER JOIN Empresa E  
     ON T.empresaid = E.EmpresaKey  
   GROUP BY E.EmpresaDsc   
  
    
  --select * from @TEMP  
        
 end    
END