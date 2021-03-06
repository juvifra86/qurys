USE [DBSOFIA20150422]
GO
/****** Object:  StoredProcedure [dbo].[SPSOFIA_rptCarteraVencida]    Script Date: 25/05/2015 02:29:50 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
                  
  
/*                  
  
Creo : Elias Zuñiga                  
  
Descripcion : proceso que alimenta al reporte de cartera vencida                  
Modificacion : 31-12-2010                  
Por : Mauricio Rojas V   

Modificacion : 20-08-2013                  
Por : Jose R. Castillo Guevara  
se agrego  filtro bursatilizados    

Modificacion : 26-05-2015                  
Por : Juan Vicente Franco Martinez  
Se agrego reporte de cuentas castigadas                 
  
Sintaxis:                  
 [SPSOFIA_rptCarteraVencida]     2,0,0,0,'07/09/2011',1,4,10   ,1             
 [SPSOFIA_rptCarteraVencida]     2,1,1,0,'06/06/2011',1,1,99 ,1               
 [SPSOFIA_rptCarteraVencida]     0,0,0,0,'10/10/2011',1,4,99,1                
 [SPSOFIA_rptCarteraVencida]     2,0,0,0,'13/10/2011',0,4,99,1  
 [SPSOFIA_rptCarteraVencida]     2,0,0,0,'22/04/2015',0,4,3,1        

   select * from carteracte where fechaCorte = '06/06/2011'                
  
*/                  
  
ALTER Procedure [dbo].[SPSOFIA_rptCarteraVencida]                  
       @empresa Tinyint,                  
       @sucursal Smallint,                  
       @Plan  Tinyint,                  
       @producto Smallint,                  
       @Finicio date,                  
       @Todos  int,                  
       @TipoCorte integer,                
       @Despacho integer   --trae el tipo despacho     
       ,@Bursatilizado as tinyint=1  --Filtro de bursatilizacion                        
  

as                  
 
	 
declare   @Consulta        varchar(max)                  
  , @where           varchar(max)                  
  , @Strsucursal     varchar(5)                  
  , @StrPlan         varchar(2)                  
  , @Strproducto     varchar(3)                  
  , @strEmpresa      varchar(2)                  
  , @StrFinicio      varchar(12)                  
  , @StrTipoCorte    varchar(2)                  
  , @CadenaTipoCorte varchar(50)                
  , @TipoDespacho    varchar (500)                
Set nocount on                  
begin     
	
	if @Despacho=3
		Select distinct                  
      CC.CuentaCteId,                   
      DA.NombreCompleto,                  
      CC.SaldoInsolutoConActual as SaldoGlobal,                    
       CC.SegCV1 Saldo30Dias,                  
       CC.SegCV2 Saldo60Dias,                  
       CC.SegCV3 Saldo90Dias,                  
       CC.SegCV4 Saldo120Dias,                  
       CC.SegCV5 Saldo150Dias,                  
       CC.SegCV6 Saldo180Dias,                  
       CC.SegCV7 Saldo210Dias,                  
       CC.SegCV8 SaldoMas210Dias,                    
        (InteresMora + IvaMora ) as SaldosMoratorios,                    
        (cc.seguroAuto + CC.SeguroUdi   )as SaldoSeguroAuto,                  
        (CC.SeguroVida + CC.seguroDesem )as SaldoOtrosCargos,                  
         dc.SucursalDsc,                  
         Dc.PlanDsc ,                  
         dc.Empresa [EmpresaDsc],                  
        (isnull(CC.ReservaCapital,0) + isnull(CC.ReservaInteres,0)) [ImporteReserva],                
         isnull(CC.DespachoId,1)  DespachoId,            
  99 [DespachoTodos],  
    D.DespachoDsc as [DespachoDsc],      
    TD.TipoDespachoDsc  
  ,'TODOS LOS CLIENTES' Titulo  
 , (case  ISNULL(cuc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' ELSE 'BURSATILIZADOS' END)  TipoCliente                                   
     from CarteraCte CC                  
     inner join CuentaCte C                  
       on C.cuentactekey=CC.cuentacteid                  
     inner join vwDatosActor DA                   
       on CC.CuentaCteId = DA.CuentaCtekey                  
     inner join vwDatosCredito DC                   
       on dc.cuentaCteKey = CC.CuentaCteId   and DC.PlanKey <> 4 --PLAN ESPECIAL no vale               
     Inner Join SegmentoCartera SC                  
       on SC.SegmentoCarteraKey = CC.SegmentoCVId              
     inner join CuentasCastigadas Ctc
	   on ctc.CuentaCteId=CC.CuentaCteId                
        ---              
    inner join Despacho D               
  on D.DespachoKey = isnull(CC.DespachoId,1)              
               
 inner join TipoDespacho TD              
  on TD.TipoDespachoKey = D.TipoDespachoId              
     ---       
 inner join CuentaCte cuc   
 on cuc.CuentaCtekey = CC.CuentaCteId        
             where CC.DiasAtraso > 0 and CC.FechaCorte = @Finicio and DC.EmpresaId = 2 and C.CicloCorteId <> 100  order by CC.CuentaCteId                  
else
 
--bursatilizacion  
declare @Titulo      varchar(30)=''  
If @Bursatilizado = 1 Set @Titulo ='TODOS LOS CLIENTES'  
ELSE IF @Bursatilizado = 2 Set @Titulo ='CLIENTES NO BURSATILIZADOS'  
ELSE iF @Bursatilizado = 3 Set @Titulo ='CLIENTES BURSATILIZADOS'  
  
--Asignacion de valores a Variables                  
Set @Strsucursal   = @sucursal                  
Set @StrPlan       = @Plan                  
Set @Strproducto   = @producto                  
Set @StrFinicio    = @Finicio                  
Set @strEmpresa    = @empresa                  
Set @StrTipoCorte  = @TipoCorte                  
Set @CadenaTipoCorte = Case When @TipoCorte = 4 then ' and C.CicloCorteId <> 100 '                  
                              else ' and C.CicloCorteId = ' + @StrTipoCorte End                  
  
---Cuando el Despacho que se manda sea TODOS                
set @TipoDespacho = case when @Despacho = 99 then '' else ' and TD.TipoDespachoKey = ' + CAST(@despacho as varchar(5)) end                 
  --set @TipoDespacho = case when @Despacho = 99 then ''       
  --else ' and TD.TipoDespachoKey = ' + CAST(@despacho as varchar(5)) end                 
------------------Todos los registros                   
  
If @Todos = 1                   
 Begin  --Comienza el If de TODOS                  
  if @Despacho = 99                
  begin  --99 son todos los despachos                
    Set @consulta = 'select distinct CC.CuentaCteId,                   
   DA.NombreCompleto,                  
   CC.SaldoInsolutoConActual as SaldoGlobal,                   
   CC.SegCV1  Saldo30Dias,                  
   CC.SegCV2 Saldo60Dias,                  
   CC.SegCV3 Saldo90Dias,                  
   CC.SegCV4 Saldo120Dias,                  
   CC.SegCV5 Saldo150Dias,                  
   CC.SegCV6 Saldo180Dias,                  
   CC.SegCV7 Saldo210Dias,                  
   CC.SegCV8 SaldoMas210Dias,                   
    (InteresMora + IvaMora) as SaldosMoratorios,                    
    (cc.seguroAuto + CC.SeguroUdi   )as SaldoSeguroAuto,                  
    (CC.SeguroVida + CC.seguroDesem )as SaldoOtrosCargos,                  
     dc.SucursalDsc,                  
     Dc.PlanDsc ,                  
     dc.Empresa [EmpresaDsc],                  
    (isnull(CC.ReservaCapital,0) + isnull(CC.ReservaInteres,0)) [ImporteReserva],                
    isnull(TD.TipoDespachoKey,1)  DespachoId,                
    '+cast(@Despacho as varchar(30))+' [DespachoTodos],   
    D.DespachoDsc as [DespachoDsc],      
    TD.TipoDespachoDsc  
     ,'''+@Titulo+''' Titulo  
 , (case  ISNULL(cuc.Bursatil,0) when 0 then ''NO BURSATILIZADOS'' ELSE ''BURSATILIZADOS'' END)  TipoCliente                
   from CarteraCte CC                  
   inner join vwDatosActor DA                   
     on CC.CuentaCteId = DA.CuentaCtekey         
   inner join vwDatosCredito dc                   
     on dc.cuentaCteKey = CC.CuentaCteId and DC.PlanKey <> 4' --PLAN ESPECIAL no vale       
Set @consulta =   @consulta+' Inner Join  SegmentoCartera SC                  
     on  SC.SegmentoCarteraKey=CC.SegmentoCVId'                
     ---              
Set @consulta =   @consulta+' inner join Despacho D               
  on D.DespachoKey = isnull(CC.DespachoId,1)              
               
 inner join TipoDespacho TD              
  on TD.TipoDespachoKey = D.TipoDespachoId'              
     ---     
Set @consulta =   @consulta+' inner join CuentaCte cuc   
 on cuc.CuentaCtekey = CC.CuentaCteId  
                
   where CC.FechaCorte = ''' + @StrFinicio + '''               
     and CC.DiasAtraso > 0'                     
 end                 
  
 else ---------------------------------Separa por tipo de despacho                
 begin                
   Set @consulta = ' select distinct CC.CuentaCteId,                   
   DA.NombreCompleto,                  
   CC.SaldoInsolutoConActual as SaldoGlobal,                   
   CC.SegCV1  Saldo30Dias,                  
   CC.SegCV2 Saldo60Dias,                  
   CC.SegCV3 Saldo90Dias,                  
   CC.SegCV4 Saldo120Dias,                  
   CC.SegCV5 Saldo150Dias,                  
   CC.SegCV6 Saldo180Dias,                  
   CC.SegCV7 Saldo210Dias,                  
   CC.SegCV8 SaldoMas210Dias,                   
    (InteresMora + IvaMora) as SaldosMoratorios,                    
    (cc.seguroAuto + CC.SeguroUdi   )as SaldoSeguroAuto,                  
    (CC.SeguroVida + CC.seguroDesem )as SaldoOtrosCargos,                  
     dc.SucursalDsc,                  
     Dc.PlanDsc ,                  
     dc.Empresa [EmpresaDsc],                  
    (isnull(CC.ReservaCapital,0) + isnull(CC.ReservaInteres,0)) [ImporteReserva],                
     isnull(TD.TipoDespachoKey,1)  DespachoId,            
       '+cast(@Despacho as varchar(30))+' [DespachoTodos] ,  
       D.DespachoDsc as [DespachoDsc],      
    TD.TipoDespachoDsc  
      ,'''+@Titulo+''' Titulo  
 , (case  ISNULL(cuc.Bursatil,0) when 0 then ''NO BURSATILIZADOS'' ELSE ''BURSATILIZADOS'' END)  TipoCliente                
   from CarteraCte CC                  
   inner join vwDatosActor DA                   
     on CC.CuentaCteId = DA.CuentaCtekey                  
   inner join vwDatosCredito dc                   
     on dc.cuentaCteKey = CC.CuentaCteId and DC.PlanKey <> 4' --PLAN ESPECIAL no vale                 
Set @consulta =   @consulta+' Inner Join  SegmentoCartera SC                  
     on  SC.SegmentoCarteraKey=CC.SegmentoCVId'                
     ---              
Set @consulta =   @consulta+' inner join Despacho D               
  on D.DespachoKey = isnull(CC.DespachoId,1)              
               
 inner join TipoDespacho TD              
  on TD.TipoDespachoKey = D.TipoDespachoId'              
     ---     
 Set @consulta =   @consulta+' inner join CuentaCte cuc   
 on cuc.CuentaCtekey = CC.CuentaCteId                
   where CC.FechaCorte = ''' + @StrFinicio + '''                
     and CC.DiasAtraso > 0'                 
     --and isnull (CC.DespachoId,1) = @Despacho                 
Set @consulta =   @consulta+' and  TD.TipoDespachoKey  = '+cast(@Despacho as varchar(30))   
   --order by CC.CuentaCteId                 
 end                                                                                         
  -- [SPSOFIA_rptCarteraVencida]     2,0,0,0,'06/06/2011',1,4,99                
 end   ---Termina el if De TODOS                  
 -----------------------------------------------------------------------                  
else  -- Aplica Filtros                  
 Begin                  
                    
 Set @consulta = ' Select distinct                  
      CC.CuentaCteId,                   
      DA.NombreCompleto,                  
      CC.SaldoInsolutoConActual as SaldoGlobal,                    
       CC.SegCV1 Saldo30Dias,                  
       CC.SegCV2 Saldo60Dias,                  
       CC.SegCV3 Saldo90Dias,                  
       CC.SegCV4 Saldo120Dias,                  
       CC.SegCV5 Saldo150Dias,                  
       CC.SegCV6 Saldo180Dias,                  
       CC.SegCV7 Saldo210Dias,                  
       CC.SegCV8 SaldoMas210Dias,                    
        (InteresMora + IvaMora ) as SaldosMoratorios,                    
        (cc.seguroAuto + CC.SeguroUdi   )as SaldoSeguroAuto,                  
        (CC.SeguroVida + CC.seguroDesem )as SaldoOtrosCargos,                  
         dc.SucursalDsc,                  
         Dc.PlanDsc ,                  
         dc.Empresa [EmpresaDsc],                  
        (isnull(CC.ReservaCapital,0) + isnull(CC.ReservaInteres,0)) [ImporteReserva],                
         isnull(CC.DespachoId,1)  DespachoId,            
  ' + cast(@Despacho as varchar(30)) + ' [DespachoTodos],  
    D.DespachoDsc as [DespachoDsc],      
    TD.TipoDespachoDsc  
  ,'''+@Titulo+''' Titulo  
 , (case  ISNULL(cuc.Bursatil,0) when 0 then ''NO BURSATILIZADOS'' ELSE ''BURSATILIZADOS'' END)  TipoCliente                                   
     from CarteraCte CC                  
     inner join CuentaCte C                  
       on C.cuentactekey=CC.cuentacteid                  
     inner join vwDatosActor DA                   
       on CC.CuentaCteId = DA.CuentaCtekey                  
     inner join vwDatosCredito DC                   
       on dc.cuentaCteKey = CC.CuentaCteId   and DC.PlanKey <> 4 --PLAN ESPECIAL no vale               
     Inner Join SegmentoCartera SC                  
       on SC.SegmentoCarteraKey = CC.SegmentoCVId              
                     
        ---              
    inner join Despacho D               
  on D.DespachoKey = isnull(CC.DespachoId,1)              
               
 inner join TipoDespacho TD              
  on TD.TipoDespachoKey = D.TipoDespachoId              
     ---       
 inner join CuentaCte cuc   
 on cuc.CuentaCtekey = CC.CuentaCteId                 
     where CC.DiasAtraso > 0 and CC.FechaCorte = ''' + @StrFinicio + ''''                   
                       
    If  @empresa <>0                    
    Begin                    
     Set @where = ' and DC.EmpresaId = ' + @strEmpresa                     
     If @Plan <> 0                  
       Set @where = @where  + ' and dc.PlanKey = ' + @StrPlan                  
                         
     If @sucursal <> 0                  
       Set @where = @where  + ' and C.SucursalId = ' + @Strsucursal                  
                         
     If @producto <> 0          
       Set @where = @where  + ' and C.ProductoId = ' + @Strproducto                     
                       
    End                  
    Else--@empresa =0                  
		Begin                  
		If @Plan <> 0                  
			Set @where = @where  + ' and DC.PlanKey = ' + @StrPlan                  
	                             
			 If @sucursal <> 0                  
			Set @where = @where  + ' and C.SucursalId = ' + @Strsucursal              
	                          
		  If @producto <> 0                       
		   Set @where = @where  + ' and C.ProductoId  = ' + @Strproducto                  
		End                  
                    
   Set @consulta = @consulta + @where                  
   Set @Consulta = @consulta + @CadenaTipoCorte                  
   Set @Consulta = @Consulta + @TipoDespacho --+ ' Order by CC.CuentaCteId'                  
  -- Exec(@consulta)                   
                  
 end -- termina If @Todos = 1   
   
 If @Bursatilizado = 1 Set @consulta =@consulta  
 --ELSE IF @Bursatilizado = 2 Set @consulta =@consulta+' AND (cuc.Bursatil =  0 OR cuc.Bursatil Is Null) '  
 ELSE IF @Bursatilizado = 2 Set @consulta =@consulta+' AND (isnull(cuc.Bursatil,0) = 0) '  
 ELSE iF @Bursatilizado = 3 Set @consulta =@consulta +' AND cuc.Bursatil = 1 '                  
 Set @consulta =@consulta + ' order by CC.CuentaCteId'                   
 Exec(@consulta)                
 --print @consulta  
end -- Fin proceso 