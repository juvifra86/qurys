 DECLARE @CuentaCte bigint = 11894      
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



  --select * FROM NotaCargo NC WITH(NOLOCK)       
  --    INNER JOIN vwCuenta VC WITH(NOLOCK)       
  --     ON NC.CuentaCteId = VC.CuentaCtekey    
  --   INNER JOIN vwPolizaCte VP with(nolock)  
  --  on vp.CuentaCteId=vc.CuentaCtekey    
  --    INNER JOIN UnidadCuentaCte UCC  WITH(NOLOCK)      
  --     ON NC.CuentaCteId = UCC.CuentaCteId      
  --    INNER JOIN PolizaSeguroUnidad PS WITH(NOLOCK)       
  --     ON UCC.UnidadCuentaCtekey = PS.UnidadCuentaCteId      
  --    INNER JOIN Aseguradora A WITH(NOLOCK)       
  --     ON PS.AseguradoraId = A.AseguradoraKey    
  --  inner JOIN Periodo Per with(nolock)                                             
  --on PS.FrecuenciaPagoId = Per.PeriodoKey    
  --   INNER JOIN vwCuentaPlazo CP WITH(NOLOCK)       
  --     ON NC.CuentaCteId = CP.CuentaCtekey  
  --   INNER JOIN Plazo PL      
  --  ON PL.PlazoKey = CP.PlazoId      
  --   WHERE NC.ConceptoContableId = @NotaSeguro  and    
  --     NC.EstadoPOId NOT IN (@Cancelado)   ------- ???????     
  -- AND NC.ImporteEmitido > 0  
  --    --AND CAST(NC.FechaVencimiento AS DATE) BETWEEN CAST(@FechaIni AS DATE) AND CAST(@FechaFin AS DATE)      
  --    and NC.CuentaCteId = CASE WHEN @CuentaCte = 0 THEN NC.CuentaCteId ELSE @CuentaCte END      
  --    AND VC.EmpresaId = CASE WHEN @EmpresaId = 0 THEN VC.EmpresaId ELSE @EmpresaId END    
  -- AND A.AseguradoraKey = CASE WHEN @AseguradoraId = 0 THEN A.AseguradoraKey ELSE @AseguradoraId END      
  --    AND PS.Status = 0      
  --   -- AND @Migrados = 1    
  --    --AND CAST(NC.FechaVencimiento AS DATE) >= @FechaLiberacion  
  -- --AND VC.TipoProdId = 5  
  
  -- AND VC.Situacion IN(12,72) 


  -- select * from CtaSofiaSofia where CuentaCteNewId =13689

  -- select * from CobranzaCartera where CuentaCteId =11894

  -- select * from CtaSofiaSofia  where CuentaCteNewId =11894

  -- select * from TipoSeguro
  -- select TipoSeguroId ,* from vwcuenta where CuentaCtekey =11894

  -- select * from Notacargo n where n.CuentaCteId=13689 and ConceptoContableId=61 order by n.FechaVencimiento
  -- select * from Notacargo n where n.CuentaCteId=11894 and ConceptoContableId=61 order by n.FechaVencimiento


 select * FROM ChequeCuenta CQ  WITH(NOLOCK)    
      INNER JOIN vwCuenta VC   WITH(NOLOCK)     
       ON CQ.CuentaCteId = VC.CuentaCtekey      
   INNER JOIN vwPolizaCte VP with(nolock)  
    on vp.CuentaCteId=vc.CuentaCtekey  
	where CQ.CuentaCteId=@CuentaCte
  --    INNER JOIN UnidadCuentaCte UCC  WITH(NOLOCK)      
  --     ON CQ.CuentaCteId = UCC.CuentaCteId      
  --    INNER JOIN PolizaSeguroUnidad PS  WITH(NOLOCK)      
  --     ON UCC.UnidadCuentaCtekey = PS.UnidadCuentaCteId      
  --    INNER JOIN Aseguradora A   WITH(NOLOCK)     
  --     ON PS.AseguradoraId = A.AseguradoraKey     
  -- inner JOIN Periodo Per with(nolock)                                             
  --on PS.FrecuenciaPagoId = Per.PeriodoKey        
  --    INNER JOIN vwCuentaPlazo CP  WITH(NOLOCK)      
  --     ON CQ.CuentaCteId = CP.CuentaCtekey      
  --  INNER JOIN Plazo PL       
  --  ON PL.PlazoKey = CP.PlazoId  
  --   WHERE CAST(CQ.FechaEmision AS DATE) BETWEEN CAST(@FechaIni AS DATE) AND CAST(@FechaFin AS DATE)  
  --    and CQ.CuentaCteId = CASE WHEN @CuentaCte = 0 THEN CQ.CuentaCteId ELSE @CuentaCte END      
   --   AND VC.EmpresaId = CASE WHEN @EmpresaId = 0 THEN VC.EmpresaId ELSE @EmpresaId END      
   --   AND A.AseguradoraKey = CASE WHEN @AseguradoraId = 0 THEN A.AseguradoraKey ELSE @AseguradoraId END      
   --   AND PS.Status = 0     
   --AND CAST(PS.FechaPolizaINI AS DATE) >= @FechaLiberacion  
   --AND CAST(CQ.FechaEmision AS DATE) >= @FechaLiberacion  
   
   --AND VC.Situacion NOT IN (14)  
  
  select * from vwPolizaCte where CuentaCteId =11894
  select * from vwPolizaCte where CuentaCteId =13689