DECLARE @CuentaCte bigint = 13689      
  ,@EmpresaId smallint =0      
  ,@AseguradoraId tinyint =0     
  ,@TipoPago tinyint=1      
  ,@FechaIni datetime='20150801'      
  ,@fechaFin datetime='20151113'      
  ,@Migrados bit =0     
  ,@TipoSeguro bit  =0 
  ,@FiltroEmpresa bit=0  
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
     WHERE
	  CAST(CQ.FechaEmision AS DATE) BETWEEN CAST(@FechaIni AS DATE) AND CAST(@FechaFin AS DATE)  
     AND CQ.CuentaCteId = CASE WHEN @CuentaCte = 0 THEN CQ.CuentaCteId ELSE @CuentaCte END      
      AND VC.EmpresaId = CASE WHEN @EmpresaId = 0 THEN VC.EmpresaId ELSE @EmpresaId END      
      AND A.AseguradoraKey = CASE WHEN @AseguradoraId = 0 THEN A.AseguradoraKey ELSE @AseguradoraId END      
      AND PS.Status = 0     
   AND CAST(PS.FechaPolizaINI AS DATE) >= @FechaLiberacion  
   AND CAST(CQ.FechaEmision AS DATE) >= @FechaLiberacion  
   
   AND VC.Situacion NOT IN (14)  
  
    UNION      
  
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
     WHERE 
	 NC.ConceptoContableId = @NotaSeguro      
      AND NC.EstadoPOId NOT IN (@Cancelado)   ------- ???????     
   AND NC.ImporteEmitido > 0  
      AND CAST(NC.FechaVencimiento AS DATE) BETWEEN CAST(@FechaIni AS DATE) AND CAST(@FechaFin AS DATE)      
     AND NC.CuentaCteId = CASE WHEN @CuentaCte = 0 THEN NC.CuentaCteId ELSE @CuentaCte END      
   --   AND VC.EmpresaId = CASE WHEN @EmpresaId = 0 THEN VC.EmpresaId ELSE @EmpresaId END    
   --AND A.AseguradoraKey = CASE WHEN @AseguradoraId = 0 THEN A.AseguradoraKey ELSE @AseguradoraId END      
   --   AND PS.Status = 0      
   --   AND @Migrados = 1    
   --AND CAST(NC.FechaVencimiento AS DATE) >= @FechaLiberacion  
   --AND VC.TipoProdId = 5  
  
   --AND VC.Situacion IN(12,72)   
        
    ORDER BY  fecha     