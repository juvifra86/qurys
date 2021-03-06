USE [DBSOFIA20150422]
GO
/****** Object:  StoredProcedure [dbo].[SPSOFIA_RptAplicacionPagos]    Script Date: 22/05/2015 02:07:58 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                        
Creado : Mauricio Rojas V                          
fecha  : 22-12-2010                          
Descripcion proceso para obtener el reporte de aplicacion de pagos por fecha y /o Periodo                          
      
Modificacion : Mauricio Rojas V                          
fecha  : 09-01-2012                          
Descripcion: para el campo de otros gastos de incluyeron los conceptos 109,110,119 (Iva Comision, comision y Enganche)              
      
Modifico: Gabriel Contreras      
fecha : 2013-08-19          
Desc: Se agrega un parámetro para identificar a los clientes bursatilizados        
   @Bursatilsp       
      
Parametros :@FechaPagoInisp = fecha de la que se requiere informacion                           
     @Periodosp = si la bandera se activa se devuelve todos los pagos del mes                           
      a que corresponde la fecha solicitada de otra manera solo se                           
    regresa informacion de la fecha en cuestion                          
 @IdEmpresasp    = Id del catalogo de empresas, 0=Todas la empresas existentes, 1=Sucrea, 2=Auto Ahorro                          
 @Bonificacionessp = 0: pagos Caja 1: Bonificaciones 2: Bancos 3: Domi-TC-Amex 4: Todos los Pagos         
 @Bursatilsp = 1 todos los clientes, 2 Los clientes no bursatilizados o 3 Los clientes bursatilizados          
      
Modifico: Julio Peña      
fecha : 2013-10-04          
Desc: Se agrega el parámetro para identificar a los clientes que se les aplico la bonificacion por     
      sustitucion de unidad donde el parametro corresponde a la FormaPagoId 19 =Bon. x Sust.Unidad    
        
Mod: EZM  
se agrego el concepto de Anualidad en la columna OTROS GASTOS    
  
Mod: Erick  
se agrego el campo Nobursatilizacion para su filtrado por dicho campo      
       
MODF: GACP 5/02/15
SE MODIFICA LAS CONSULTAS PARA AGREGAR LOS with(nolock)    
    
Sintaxis :                 
           SPSOFIA_RptAplicacionPagos '20141119', 0, 0, 0, 1      
                           
*/                          
      
ALTER Procedure [dbo].[SPSOFIA_RptAplicacionPagos]                 
@FechaPagoIni Date,
@FechaPagoFinal Date,                 
@Periodo Tinyint,                 
@IdEmpresa Tinyint ,                 
@Bonificaciones Tinyint=0,      
@Bursatil Tinyint=0       
      
As                           
Begin      
declare  @FechaPagoFin Date                          
    ,@Ejercicio    Int                           
    ,@NoMora       Tinyint=2                          
    ,@cMes         varchar(2)                  
    ,@TipoBonifica     Tinyint=11                      
    ,@Titulo varchar(50)      
    ,@TipoCliente varchar(30)   
 ,@FechaPagoInisp Date ,                 
 @Periodosp Tinyint,                 
 @IdEmpresasp Tinyint,                 
 @Bonificacionessp Tinyint,      
 @Bursatilsp Tinyint   
   
 set @FechaPagoInisp =@FechaPagoIni  
 set @Periodosp = @Periodo  
 set @IdEmpresasp  = @IdEmpresa  
 set @Bonificacionessp = @Bonificaciones  
 set @Bursatilsp = @Bursatil     
         
      
 declare @datosCompletos table([No.Cuenta]integer,NombreCompleto varchar(100),FechaPago varchar(12),FechaCaptura varchar(12),FechaProceso varchar(10),                      
        PagoCajaId integer,Ejercicio integer,Periodo integer,Empresa varchar(20),OtrosGastos money,InteresMora money,IvaMora money,InteresOrd money,                      
        IvaOrd money,SegAuto money,SegDesem money,SegVida money,Capital money,Total money,PagoXapli money,ImporteXAplicarPago money,Importe money,      
  Titulo varchar(50),BursatilDsc varchar(30),SubTitulo varchar(30),FormaPagoDsc varchar(30),Folio integer,CtaBanco VarChar(4),NoBurzatilizacion int)                           
      
                          
      
If @Bursatilsp = 1 Set @Titulo = 'TODOS LOS CLIENTES'      
IF @Bursatilsp = 2 Set @Titulo = 'CLIENTES NO BURSATILIZADOS'      
IF @Bursatilsp = 3 Set @Titulo = 'CLIENTES BURSATILIZADOS'      
      
if @Periodosp =1    --Saca la fecha del primer dia del mes seleccionado                      
 Begin                       
   Set @Ejercicio = Year(@FechaPagoInisp)                          
   Set @Periodosp   = Month(@FechaPagoInisp)                         
   Set @cMes      = REPLICATE('0', 2 - LEN(@Periodosp)) + CAST(@Periodosp AS VARCHAR)                          
   Set @FechaPagoInisp = Cast((CAST(@Ejercicio as Char(4))+ @cMes + '01') as date)                         
      
  --Obtiene el ultimo dia del mes                       
      
   Set @FechaPagoFin = DateAdd(d,-1,(DateAdd(MM,1,@FechaPagoInisp)))                           
 End                          
Else                          
 --Set @FechaPagoFin = @FechaPagoInisp                          
   Set @FechaPagoFin =@FechaPagoFinal   
if @IdEmpresasp >=1 and @Bonificacionessp = 1 -- Bonificaciones                   
begin      
  insert into @datosCompletos       
  Select  CuentaCteId [No.Cuenta]      
   ,left(NombreCompleto,50) NombreCompleto      
   ,convert(varchar(12),[FechaPago],105)[FechaPago]      
   ,convert(varchar(12),[Fecha Captura],105)[Fecha Captura]      
   ,convert(varchar(12),[Fecha Proceso],105)[Fecha Proceso]      
   ,[PagoCajaId]      
   ,[Ejercicio]      
   ,[Periodo]      
   ,[Empresa]      
   ,Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End) OtrosGastos      
   ,Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora]      
   ,Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora]      
   ,Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd]      
   ,Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd]      
   ,Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto]      
   ,Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem]      
   ,Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida]      
   ,Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital]      
   ,sum(ImportePagado)[Total]      
   ,LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
   FROM Liquidacion LI   with(nolock)   
    JOIN PagoCaja PC with(nolock)ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoId in (11,14,19,24) --'se agrego FormaPagoId 19,24'     
   WHERE LI.EstadoPOId=30 And LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso] AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli]      
   ,0      
   ,Importe      
   ,@Titulo Titulo      
   ,BursatilDsc      
   ,'BONIFICACIONES'      
   ,''      
   ,0      
   ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco ,NoBursatilizacion ----- -tipo de burzatilizacion     
  From (      
   select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
     L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo],      
     Year(pc.FechaPago)[Ejercicio], @NoMora TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
  ,@Titulo Titulo      
  ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
  ,pc.CuentaBancaria    
  ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l  with(nolock)    
   inner join Amortizacion A with(nolock)on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref       
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId  and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid in (11,14,19,24) --'se agrego FormaPagoId 19,24'      
   Inner join vwNombreCte DC on Dc.CuentaCtekey=L.CuentaCteId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
  union all      
  select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
   L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,      
   Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
   ,@Titulo Titulo      
   ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,pc.CuentaBancaria    
   ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l  with(nolock)
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid in (11,14,19,24) --'se agrego FormaPagoId 19,24'       
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   left Join vwConceptoMora CM on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo= 'N' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
   ) as LiquidacionCreada      
  Group by CuentaCteId,NombreCompleto,FechaPago,[Fecha Captura],[Fecha Proceso],[PagoCajaId],[Ejercicio],[Periodo],      
   [Empresa],[Importe],BursatilDsc,CuentaBancaria ,NoBursatilizacion -----------tipo de burzatilizacion     
  order by [Empresa] desc, [No.Cuenta], PagoCajaId      
      
end                           
      
if @IdEmpresasp >=1 and @Bonificacionessp = 0 -- Caja      
begin      
      
  insert into @datosCompletos       
  Select  CuentaCteId [No.Cuenta]      
   ,left(NombreCompleto,50) NombreCompleto      
   ,convert(varchar(12),[FechaPago],105)[FechaPago]      
   ,convert(varchar(12),[Fecha Captura],105)[Fecha Captura]      
   ,convert(varchar(12),[Fecha Proceso],105)[Fecha Proceso]      
   ,[PagoCajaId]      
   ,[Ejercicio]      
   ,[Periodo]      
   ,[Empresa]      
   ,Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End) OtrosGastos      
   ,Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora]      
   ,Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora]      
   ,Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd]      
   ,Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd]      
   ,Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto]      
   ,Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem]      
   ,Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida]      
   ,Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital]      
   ,sum(ImportePagado)[Total]      
   ,LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
   FROM Liquidacion LI  with(nolock)    
    JOIN PagoCaja PC with(nolock)ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoId not in (6,7,8,11,14,19,24) and pc.Folio > 0   --'se agrego FormaPagoId 19,24'    
   WHERE LI.EstadoPOId=30 And LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso] AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli]      
   ,0      
   ,Importe      
   ,@Titulo Titulo      
   ,BursatilDsc      
   ,'CAJA'      
   ,''      
   ,0      
   ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco ,NoBursatilizacion ----- -tipo de burzatilizacion     
  From (      
select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
     L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo],      
     Year(pc.FechaPago)[Ejercicio], @NoMora TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
  ,@Titulo Titulo      
  ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
  ,pc.CuentaBancaria    
  ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l  with(nolock)    
   inner join Amortizacion A with(nolock)on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref       
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId  and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (6,7,8,11,14,19,24) and pc.Folio > 0   --'se agrego FormaPagoId 19,24'    
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
  union all      
  select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
   L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,      
   Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
   ,@Titulo Titulo      
   ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,pc.CuentaBancaria      
   ,B.NoBursatilizacion -------------tipo de burzatilizacion  
  from Liquidacion l    with(nolock)  
   inner join Notacargo A with(nolock) on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (6,7,8,11,14,19,24) and pc.Folio > 0   --'Se agrego FormaPagoid 19,24'    
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId     
   left Join vwConceptoMora CM on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo= 'N' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
   ) as LiquidacionCreada      
  Group by CuentaCteId,NombreCompleto,FechaPago,[Fecha Captura],[Fecha Proceso],[PagoCajaId],[Ejercicio],[Periodo],      
   [Empresa],[Importe],BursatilDsc,CuentaBancaria,NoBursatilizacion -----------tipo de burzatilizacion     
  order by [Empresa] desc, [No.Cuenta], PagoCajaId      
      
end                           
      
if @IdEmpresasp >=1 and @Bonificacionessp = 2 -- Bancos      
begin      
      
  insert into @datosCompletos       
  Select  CuentaCteId [No.Cuenta]      
   ,left(NombreCompleto,50) NombreCompleto      
   ,convert(varchar(12),[FechaPago],105)[FechaPago]      
   ,convert(varchar(12),[Fecha Captura],105)[Fecha Captura]      
   ,convert(varchar(12),[Fecha Proceso],105)[Fecha Proceso]      
   ,[PagoCajaId]      
   ,[Ejercicio]      
   ,[Periodo]      
   ,[Empresa]      
   ,Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End) OtrosGastos      
   ,Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora]      
   ,Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora]      
   ,Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd]      
   ,Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd]      
   ,Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto]      
   ,Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem]      
   ,Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida]      
   ,Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital]      
   ,sum(ImportePagado)[Total]      
   ,LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
   FROM Liquidacion LI with(nolock)     
    JOIN PagoCaja PC with(nolock)ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoId not in (11,14,8,7,6,19,24) and pc.Folio is null  --'Se agrego FormaPagoId 19,24'    
   WHERE LI.EstadoPOId=30 And LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso] AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli]      
   ,0      
   ,Importe      
   ,@Titulo Titulo      
   ,BursatilDsc      
   ,'BANCOS'      
   ,''      
   ,0      
   ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco,NoBursatilizacion ----- -tipo de burzatilizacion       
  From (      
   select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura],CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
     L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo],      
     Year(pc.FechaPago)[Ejercicio], @NoMora TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
  ,@Titulo Titulo      
  ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
  ,pc.CuentaBancaria   
  ,B.NoBursatilizacion -------------tipo de burzatilizacion      
  from Liquidacion l with(nolock)     
   inner join Amortizacion A with(nolock)on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref       
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId  and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (11,14,8,7,6,19,24) and pc.Folio is null  --'se agrego FormaPagoId 19,24'    
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId    
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion    
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
  union all      
  select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
   L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,      
   Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
   ,@Titulo Titulo      
   ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,pc.CuentaBancaria      
   ,B.NoBursatilizacion -------------tipo de burzatilizacion  
  from Liquidacion l   with(nolock)   
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (11,14,8,7,6,19,24) and pc.Folio is null  --'se agrego FormaPagoId 19,24'     
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId   
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo= 'N' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
   ) as LiquidacionCreada      
  Group by CuentaCteId,NombreCompleto,FechaPago,[Fecha Captura],[Fecha Proceso],[PagoCajaId],[Ejercicio],[Periodo],      
   [Empresa],[Importe],BursatilDsc,CuentaBancaria ,NoBursatilizacion -----------tipo de burzatilizacion     
  order by [Empresa] desc, [No.Cuenta], PagoCajaId      
      
end                           
      
if @IdEmpresasp >=1 and @Bonificacionessp = 3 -- Domic-TC-Amex      
begin      
      
  insert into @datosCompletos       
  Select  CuentaCteId [No.Cuenta]      
   ,left(NombreCompleto,50) NombreCompleto      
   ,convert(varchar(12),[FechaPago],105)[FechaPago]      
   ,convert(varchar(12),[Fecha Captura],105)[Fecha Captura]      
   ,convert(varchar(12),[Fecha Proceso],105)[Fecha Proceso]      
   ,[PagoCajaId]      
   ,[Ejercicio]      
   ,[Periodo]      
   ,[Empresa]      
   ,Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End) OtrosGastos      
   ,Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora]      
   ,Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora]      
   ,Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd]      
   ,Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd]      
   ,Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto]      
   ,Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem]      
   ,Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida]      
   ,Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital]      
   ,sum(ImportePagado)[Total]      
   ,LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
   FROM Liquidacion LI  with(nolock)    
    JOIN PagoCaja PC with(nolock)ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoId in (8,7,6)       
   WHERE LI.EstadoPOId=30 And LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso] AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli]      
   ,0      
   ,Importe      
   ,@Titulo Titulo      
   ,BursatilDsc      
   ,'DOMICILIACION-CARGOS TC Y AMEX'      
   ,(Case FormaPagoid when 6 then 'Cargo American Express'       
      when 7 then 'Cargo Tarjeta Credito'       
      when 8 then 'Domiciliación' end) FormaPagoDsc      
   ,0      
   ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco ,NoBursatilizacion -----------tipo de burzatilizacion     
  From (      
   select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
     L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo],      
     Year(pc.FechaPago)[Ejercicio], @NoMora TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
  ,@Titulo Titulo      
  ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
  ,pc.FormaPagoId      
  ,pc.CuentaBancaria       
  ,B.NoBursatilizacion -------------tipo de burzatilizacion  
  from Liquidacion l   with(nolock)   
   inner join Amortizacion A with(nolock)on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref       
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId  and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid in (8,7,6)       
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId   
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion     
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
  union all      
  select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
   L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,      
   Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
  ,@Titulo Titulo      
   ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,FormaPagoid      
   ,pc.CuentaBancaria      
   ,B.NoBursatilizacion -------------tipo de burzatilizacion  
  from Liquidacion l   with(nolock)   
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid in (8,7,6)       
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo= 'N' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
   ) as LiquidacionCreada      
  Group by CuentaCteId,NombreCompleto,FechaPago,[Fecha Captura],[Fecha Proceso],[PagoCajaId],[Ejercicio],[Periodo],      
   [Empresa],[Importe],BursatilDsc,FormaPagoid,CuentaBancaria ,NoBursatilizacion -----------tipo de burzatilizacion     
  order by [Empresa] desc, [No.Cuenta], PagoCajaId      
      
end                           
      
if @IdEmpresasp >=1 and @Bonificacionessp = 4 -- Todos los Pagos      
begin      
      
  insert into @datosCompletos       
  Select  CuentaCteId [No.Cuenta]      
   ,left(NombreCompleto,50) NombreCompleto      
   ,convert(varchar(12),[FechaPago],105)[FechaPago]      
   ,convert(varchar(12),[Fecha Captura],105)[Fecha Captura]      
   ,convert(varchar(12),[Fecha Proceso],105)[Fecha Proceso]      
   ,[PagoCajaId]      
   ,[Ejercicio]      
   ,[Periodo]      
   ,[Empresa]      
   ,Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End) OtrosGastos      
   ,Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora]      
   ,Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora]      
   ,Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd]      
   ,Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd]      
   ,Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto]      
   ,Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem]      
   ,Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida]      
   ,Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital]      
   ,sum(ImportePagado)[Total]      
   ,LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
   FROM Liquidacion LI  with(nolock)    
    JOIN PagoCaja PC with(nolock)ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoId not in (11,14,19,24) --'se agrego FormaPagoId 19,24'      
   WHERE LI.EstadoPOId=30 And LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso] AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli]      
   ,0      
   ,Importe      
   ,@Titulo Titulo      
   ,BursatilDsc      
   ,'TODOS LOS PAGOS'      
   ,(Case  when FormaPagoid = 6 then 'Cargo American Express'       
      when FormaPagoid = 7 then 'Cargo Tarjeta Credito'       
      when FormaPagoid = 8 then 'Domiciliación'       
      when FormaPagoid not in (6,7,8) and Folio is null Then 'Bancos'      
      when FormaPagoid not in (6,7,8) and Folio > 0 Then 'Caja'      
      end) FormaPagoDsc      
  ,Folio      
  ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco,NoBursatilizacion ----- -tipo de burzatilizacion   
  From (      
   select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE)[Fecha Proceso],      
     L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo],      
     Year(pc.FechaPago)[Ejercicio], @NoMora TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
  ,@Titulo Titulo      
  ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc   
  ,pc.FormaPagoId,pc.Folio,pc.CuentaBancaria      
  ,B.NoBursatilizacion -------------tipo de burzatilizacion  
  from Liquidacion l  with(nolock)    
   inner join Amortizacion A with(nolock)on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref       
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId  and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (11,14,19,24) --'se agrego FormaPagoId 19,24'       
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId    
  LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
  union all      
  select  l.CuentaCteId, left(DC.NombreCompleto,50)NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso],      
   L.ImportePagado, l.PagoCajaId, A.FechaVencimiento, a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,      
   Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora, pc.Importe - pc.ImporteUsado [PagoXapli], pc.Importe      
  ,@Titulo Titulo      
   ,(Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc   
   ,FormaPagoid,pc.Folio,pc.CuentaBancaria    
  ,B.NoBursatilizacion -------------tipo de burzatilizacion  
  from Liquidacion l  with(nolock)    
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (11,14,19,24)   --'se agrego FormaPagoId 19,24'    
   Inner join vwNombreCte DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId     
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo= 'N' and l.EstadoPOId=30 and cast(l.FechaLiquida as DATE) between @FechaPagoInisp and @FechaPagoFin and E.EmpresaKey=@IdEmpresasp      
   ) as LiquidacionCreada      
  Group by CuentaCteId,NombreCompleto,FechaPago,[Fecha Captura],[Fecha Proceso],[PagoCajaId],[Ejercicio],[Periodo],      
   [Empresa],[Importe],BursatilDsc,FormaPagoid,Folio,CuentaBancaria,NoBursatilizacion -----------tipo de burzatilizacion  
  order by [Empresa] desc, [No.Cuenta], PagoCajaId      
      
end                           
      
   ---------------------------------------------------------------------------------------------------------                      
      
if @IdEmpresasp = 0 and @Bonificacionessp = 1  -- Bonificaciones                                      
begin                      
      
  insert into @datosCompletos      
  Select  CuentaCteId [No.Cuenta],      
  NombreCompleto,      
  FechaPago,      
  [Fecha Captura],      
  convert(varchar(10),[Fecha Proceso],110)[Fecha Proceso],      
  [PagoCajaId],      
  [Ejercicio],      
  [Periodo],      
  [Empresa],      
  Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End)  'OtrosGastos',      
  Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora],      
  Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora],      
  Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd],      
  Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd],      
  Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto],      
  Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem],      
  Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida],      
  Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital],      
  sum(ImportePagado)[Total],      
  LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
  FROM Liquidacion LI with(nolock)     
  JOIN PagoCaja PC   with(nolock)     
    ON PC.PagoCajaKey = LI.PagoCajaId      
    and PC.FormaPagoid in (11,14,19,24) --'se agrego FormaPagoId 19,24'       
  WHERE LI.EstadoPOId=30      
  And  LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso]      
  AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli],      
  0,      
  Importe,      
  @Titulo,      
  LiquidacionCreada.BursatilDsc,      
  'BONIFICACIONES',      
  ''      
  ,0      
  ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco ,NoBursatilizacion -----------tipo de burzatilizacion     
  From (      
 select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura],CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo], Year(pc.FechaPago)[Ejercicio], @NoMora TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,      
   @Titulo Titulo,      
   (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,pc.CuentaBancaria  ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l   with(nolock)   
   inner join Amortizacion A with(nolock)  on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref      
   Inner join vwDatosCredito DC with(nolock)  on Dc.CuentaCtekey=L.CuentaCteId      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and Pc.FormaPagoid  in (11,14,19,24) --'se agrego FormaPagoId 19,24'      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId   
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion     
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
 union all      
  select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura],CAST(L.FechaLiquida AS DATE)[Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,  Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,       
   @Titulo Titulo,      
    (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
 ,pc.CuentaBancaria  ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l  with(nolock)    
   Inner join vwDatosCredito DC on Dc.CuentaCtekey=L.CuentaCteId      
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and Pc.FormaPagoid in (11,14,19,24)  --'se agrego FormaPagoId 19,24'       
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId   
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion     
  where l.TipoCargo='N' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
   )  as LiquidacionCreada       
   Group by CuentaCteId, NombreCompleto, FechaPago, [Fecha Captura],[Fecha Proceso],      
      [Periodo],[Ejercicio],[Empresa]  ,[PagoXapli]  ,[PagoCajaId],LiquidacionCreada.Importe,BursatilDsc,CuentaBancaria ,NoBursatilizacion -----------tipo de burzatilizacion     
  order by [Empresa] desc, [No.Cuenta]      
      
end                          
      
if @IdEmpresasp = 0 and @Bonificacionessp = 0 -- Caja                                      
begin                      
      
  insert into @datosCompletos      
  Select  CuentaCteId [No.Cuenta],      
  NombreCompleto,      
  FechaPago,      
  [Fecha Captura],      
  convert(varchar(10),[Fecha Proceso],110)[Fecha Proceso],      
  [PagoCajaId],      
  [Ejercicio],      
  [Periodo],      
  [Empresa],      
  Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End)  'OtrosGastos',      
  Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora],      
  Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora],      
  Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd],      
  Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd],      
  Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto],      
  Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem],      
  Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida],      
  Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital],      
  sum(ImportePagado)[Total],      
  LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
  FROM Liquidacion LI   with(nolock)   
  JOIN PagoCaja PC with(nolock)     
    ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoid not in (8,7,6,11,14,19,24) and pc.Folio > 0  --'se agrego FormaPagoId 19,24'    
  WHERE LI.EstadoPOId=30      
  And  LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso]      
  AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli],      
  0,      
  Importe,      
  @Titulo,      
  LiquidacionCreada.BursatilDsc,      
  'CAJA',      
  ''      
  ,0      
  ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco,NoBursatilizacion -----------tipo de burzatilizacion      
  From (      
 select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura],CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo], Year(pc.FechaPago)[Ejercicio], @NoMora TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,      
   @Titulo Titulo,      
   (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,pc.CuentaBancaria ,B.NoBursatilizacion -------------tipo de burzatilizacion      
  from Liquidacion l with(nolock)     
   inner join Amortizacion A with(nolock) on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref      
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (8,7,6,11,14,19,24) and pc.Folio > 0   --'se agrego FormaPagoId 19,24'    
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId     
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion   
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
 union all      
  select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,  Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,       
   @Titulo Titulo,      
    (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
 ,pc.CuentaBancaria  ,B.NoBursatilizacion -------------tipo de burzatilizacion     
  from Liquidacion l with(nolock)     
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (8,7,6,11,14,19,24) and pc.Folio > 0   --'se agrego FormaPagoId 19,24'    
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo='N' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
   )  as LiquidacionCreada       
   Group by CuentaCteId, NombreCompleto, FechaPago, [Fecha Captura],[Fecha Proceso],      
      [Periodo],[Ejercicio],[Empresa]  ,[PagoXapli]  ,[PagoCajaId],LiquidacionCreada.Importe,BursatilDsc,CuentaBancaria,NoBursatilizacion -----------tipo de burzatilizacion      
  order by [Empresa] desc, [No.Cuenta]      
      
end                          
      
if @IdEmpresasp = 0 and @Bonificacionessp = 2 -- Bancos                                     
begin                      
      
  insert into @datosCompletos      
  Select  CuentaCteId [No.Cuenta],      
  NombreCompleto,      
  FechaPago,      
  [Fecha Captura],      
  convert(varchar(10),[Fecha Proceso],110)[Fecha Proceso],      
  [PagoCajaId],      
  [Ejercicio],      
  [Periodo],      
  [Empresa],      
  Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End)  'OtrosGastos',      
  Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora],      
  Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora],      
  Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd],      
  Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd],      
  Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto],      
  Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem],      
  Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida],      
  Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital],      
  sum(ImportePagado)[Total],      
  LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
  FROM Liquidacion LI with(nolock)     
  JOIN PagoCaja PC with(nolock)     
    ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoid not in (8,7,6,11,14,19,24) and pc.Folio is null  --'se agrego FormaPagoId 19,24'    
  WHERE LI.EstadoPOId=30      
  And  LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso]      
  AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli],      
  0,      
  Importe,      
  @Titulo,      
  LiquidacionCreada.BursatilDsc,      
  'BANCOS',      
  ''      
  ,0      
  ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco ,NoBursatilizacion -----------tipo de burzatilizacion    
  From (      
 select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura],CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo], Year(pc.FechaPago)[Ejercicio], @NoMora TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,      
   @Titulo Titulo,      
   (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,pc.CuentaBancaria   ,B.NoBursatilizacion -------------tipo de burzatilizacion   
  from Liquidacion l with(nolock)     
   inner join Amortizacion A with(nolock) on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref      
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (8,7,6,11,14,19,24) and pc.Folio is null  --'se agrego FormaPagoId 19,24'    
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=DC.EmpresaId    
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion    
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
 union all      
  select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,  Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,       
   @Titulo Titulo,      
    (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
 ,pc.CuentaBancaria  ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l with(nolock)     
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (8,7,6,11,14,19,24) and pc.Folio is null  --'se agrego FormaPagoId 19,24'    
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId     
   LEFT JOIN Bursatilizado B with(nolock) ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion   
  where l.TipoCargo='N' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
   )  as LiquidacionCreada       
   Group by CuentaCteId, NombreCompleto, FechaPago, [Fecha Captura],[Fecha Proceso],      
      [Periodo],[Ejercicio],[Empresa]  ,[PagoXapli]  ,[PagoCajaId],LiquidacionCreada.Importe,BursatilDsc,CuentaBancaria ,NoBursatilizacion -----------tipo de burzatilizacion      
  order by [Empresa] desc, [No.Cuenta]      
      
end                          
      
if @IdEmpresasp = 0 and @Bonificacionessp = 3 -- Domi-TC-Amex                                     
begin                      
      
  insert into @datosCompletos      
  Select  CuentaCteId [No.Cuenta],      
  NombreCompleto,      
  FechaPago,      
  [Fecha Captura],      
  convert(varchar(10),[Fecha Proceso],110)[Fecha Proceso],      
  [PagoCajaId],      
  [Ejercicio],      
  [Periodo],      
  [Empresa],      
  Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End)  'OtrosGastos',      
  Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora],      
  Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora],      
  Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd],      
  Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd],      
  Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto],      
  Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem],      
  Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida],      
  Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital],      
  sum(ImportePagado)[Total],      
  LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
  FROM Liquidacion LI with(nolock)      
  JOIN PagoCaja PC with(nolock)     
    ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoid in (8,7,6)       
  WHERE LI.EstadoPOId=30      
  And  LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso]      
  AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli],      
  0,      
  Importe,      
  @Titulo,      
  LiquidacionCreada.BursatilDsc,      
  'DOMICILIACION-CARGOS TC Y AMEX'      
 ,(Case FormaPagoid when 6 then 'Cargo American Express'       
      when 7 then 'Cargo Tarjeta Credito'       
      when 8 then 'Domiciliación' end) FormaPagoDsc      
 ,0      
 ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco,NoBursatilizacion -----------tipo de burzatilizacion      
  From (      
 select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE)[Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo], Year(pc.FechaPago)[Ejercicio], @NoMora TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,      
   @Titulo Titulo,      
   (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
    ,pc.FormaPagoId      
 ,pc.CuentaBancaria  ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l with(nolock)     
   inner join Amortizacion A with(nolock)on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref      
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid in (8,7,6)       
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId      
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion  
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
 union all      
  select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura],CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,  Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,       
   @Titulo Titulo,      
    (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
   ,FormaPagoid       
   ,pc.CuentaBancaria  ,B.NoBursatilizacion -------------tipo de burzatilizacion    
  from Liquidacion l with(nolock)     
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid in (8,7,6)      
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=DC.EmpresaId    
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion    
  where l.TipoCargo='N' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
   )  as LiquidacionCreada       
   Group by CuentaCteId, NombreCompleto, FechaPago, [Fecha Captura],[Fecha Proceso],      
      [Periodo],[Ejercicio],[Empresa]  ,[PagoXapli]  ,[PagoCajaId],LiquidacionCreada.Importe,BursatilDsc,FormaPagoId,CuentaBancaria ,NoBursatilizacion -----------tipo de burzatilizacion     
  order by [Empresa] desc, [No.Cuenta]      
      
end                          
      
if @IdEmpresasp = 0 and @Bonificacionessp = 4 -- Todos los Pagos                                     
begin                      
      
  insert into @datosCompletos      
  Select  CuentaCteId [No.Cuenta],      
  NombreCompleto,      
  FechaPago,      
  [Fecha Captura],      
  convert(varchar(10),[Fecha Proceso],110)[Fecha Proceso],      
  [PagoCajaId],      
  [Ejercicio],      
  [Periodo],      
  [Empresa],      
  Sum(Case  when ConceptoContableId in (109,110,119,154) then ImportePagado else 0 End)  'OtrosGastos',      
  Sum(Case LiquidacionCreada.TMora when 0 then ImportePagado else 0 End )[InteresMora],      
  Sum(Case LiquidacionCreada.TMora when 1 then ImportePagado else 0 End )[IvaMora],      
  Sum(Case ConceptoContableId when 47 then ImportePagado else 0 End) [InteresOrd],      
  Sum(Case ConceptoContableId when 48 then ImportePagado else 0 End) [IvaOrd],      
  Sum(Case  when ConceptoContableId in (61,62) then ImportePagado else 0 End) [SegAuto],      
  Sum(Case ConceptoContableId when 73 then ImportePagado else 0 End )[SegDesem],      
  Sum(Case ConceptoContableId when 85 then ImportePagado else 0 End )[Segvida],      
  Sum(Case ConceptoContableId when 46 then ImportePagado else 0 End )[Capital],      
  sum(ImportePagado)[Total],      
  LiquidacionCreada.Importe-SUM(LiquidacionCreada.ImportePagado)-ISNULL((SELECT SUM(ImportePagado)      
  FROM Liquidacion LI with(nolock)     
  JOIN PagoCaja PC with(nolock)     
    ON PC.PagoCajaKey = LI.PagoCajaId and pc.FormaPagoid not in (11,14,19,24) --'se agrego FormaPagoId 19 y 24'      
  WHERE LI.EstadoPOId=30      
  And  LI.FechaLiquida < LiquidacionCreada.[Fecha Proceso]      
  AND PC.PagoCajaKey = LiquidacionCreada.PagoCajaId),0)[PagoXapli],      
  0,      
  Importe,      
  @Titulo,      
  LiquidacionCreada.BursatilDsc,      
  'TODOS LOS PAGOS'      
 ,(Case  when FormaPagoid = 6 then 'Cargo American Express'       
      when FormaPagoid = 7 then 'Cargo Tarjeta Credito'       
      when FormaPagoid = 8 then 'Domiciliación'       
      when FormaPagoid not in (6,7,8) and Folio is null Then 'Bancos'      
      when FormaPagoid not in (6,7,8) and Folio > 0 Then 'Caja'      
      end) FormaPagoDsc      
  ,Folio      
  ,Case when CuentaBancaria is null Then '' Else SUBSTRING(CuentaBancaria,Len(CuentaBancaria)-3,Len(CuentaBancaria)) end CtaBanco,NoBursatilizacion -----------tipo de burzatilizacion    
  From (      
 select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura],CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)[Periodo], Year(pc.FechaPago)[Ejercicio], @NoMora TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,      
   @Titulo Titulo,      
   (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
    ,pc.FormaPagoId,pc.Folio,pc.CuentaBancaria,B.NoBursatilizacion -------------tipo de burzatilizacion      
  from Liquidacion l with(nolock)     
   inner join Amortizacion A with(nolock)on A.CuentaCteId=l.CuentaCteId and AmortizacionKey=l.cargoref      
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (11,14,19,24) --'se agrego FormaPagoId 19 y 24'       
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=cc.EmpresaId    
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion    
  where l.TipoCargo='A' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
 union all      
  select  l.CuentaCteId, DC.NombreCompleto, pc.FechaPago, pc.FechaCarga [Fecha Captura], CAST(L.FechaLiquida AS DATE) [Fecha Proceso], L.ImportePagado, l.PagoCajaId, A.FechaVencimiento,      
   a.ImporteEmitido, A.ConceptoContableId, E.NombreComercial [Empresa], MONTH(pc.FechaPago)Periodo,  Year(pc.FechaPago)Ejercicio, ISNULL(Biva,@NoMora)TMora,      
   pc.Importe - pc.ImporteUsado [PagoXapli], pc.importe,       
   @Titulo Titulo,      
    (Case isnull(cc.Bursatil,0) when 0 then 'NO BURSATILIZADOS' else 'BURSATILIZADOS' end) BursatilDsc      
  ,FormaPagoid,pc.Folio,pc.CuentaBancaria ,B.NoBursatilizacion -------------tipo de burzatilizacion     
  from Liquidacion l  with(nolock)    
   Inner join vwDatosCredito DC with(nolock)on Dc.CuentaCtekey=L.CuentaCteId      
   inner join Notacargo A with(nolock)on A.CuentaCteId=l.CuentaCteId and NotacargoKey=l.cargoref      
   inner join PagoCaja pc with(nolock)on pc.PagoCajaKey=l.PagoCajaId and pc.CuentaCteId=l.CuentaCteId and pc.FormaPagoid not in (11,14,19,24) --'se agrego FormaPagoId 19 y 24'      
   left Join vwConceptoMora CM with(nolock)on CM.conceptoContablekey = A.ConceptoContableId      
   inner join CuentaCte cc with(nolock)on cc.CuentaCtekey = l.CuentaCteId      
   Inner join Empresa E with(nolock)on E.EmpresaKey=DC.EmpresaId     
   LEFT JOIN Bursatilizado B with(nolock)ON l.CuentaCteId =  B.CuentaCteId ----------------------tipo de burzatilizacion   
  where l.TipoCargo='N' and l.EstadoPOId=30 and cast(l.FechaLiquida as date) between @FechaPagoInisp and @FechaPagoFin      
   )  as LiquidacionCreada       
   Group by CuentaCteId, NombreCompleto, FechaPago, [Fecha Captura],[Fecha Proceso],      
      [Periodo],[Ejercicio],[Empresa]  ,[PagoXapli]  ,[PagoCajaId],LiquidacionCreada.Importe,BursatilDsc,FormaPagoId,Folio,CuentaBancaria,NoBursatilizacion -----------tipo de burzatilizacion      
  order by [Empresa] desc, [No.Cuenta]      
      
end      
    
    
      
declare @fechasMaximas as table([noCuenta] integer, fecha VARCHAR(10))                  
      
declare @PcajaMax as table([noCuenta] integer, PagoidMax VARCHAR(10))                      
      
insert into @fechasMaximas                      
select [No.Cuenta],MAX(FechaProceso)[fechamaxima]                       
from @datosCompletos                       
group by [No.Cuenta]                        
    
insert into @PcajaMax                      
select [No.Cuenta],MAX(PagoCajaid)                       
from @datosCompletos                       
group by [No.Cuenta]                        
      
UPDATE @datosCompletos                       
SET ImporteXAplicarPago = 0                      
      
UPDATE @datosCompletos                       
SET ImporteXAplicarPago = isnull((SELECT SUM(PC.Importe-Pc.ImporteUsado)                      
         FROM PagoCaja PC with(nolock)                     
         WHERE PC.CuentaCteId = [No.Cuenta]                       
         and PC.EstadoPOId not in (16,18)),0)                       
         where FechaProceso =(SELECT Fecha                      
           FROM @fechasMaximas                      
               WHERE noCuenta = [No.Cuenta])                      
                and PagoCajaId =(SELECT PagoidMax                       
                  FROM @PcajaMax                       
                  WHERE noCuenta = [No.Cuenta])                      
      
If @Bursatilsp = 1       
Begin      
select dc.[No.Cuenta]      
      ,dc.NombreCompleto      
   ,tp.TipoProdDsc      
      ,dc.PagoCajaId      
   ,dc.CtaBanco      
   ,dc.FechaPago      
   ,dc.FechaCaptura      
   ,dc.FechaProceso      
   ,dc.InteresMora      
   ,dc.IvaMora      
   ,dc.InteresOrd      
   ,dc.IvaOrd      
   ,dc.OtrosGastos      
   ,dc.SegAuto      
   ,dc.SegVida      
   ,dc.SegDesem      
   ,dc.Capital      
   ,dc.Total      
   ,dc.Importe      
   ,dc.PagoXapli      
   ,dc.ImporteXAplicarPago      
   ,dc.Ejercicio      
   ,dc.Periodo      
   ,dc.Empresa         
   ,dc.Titulo      
   ,dc.BursatilDsc      
   ,dc.SubTitulo      
   ,dc.FormaPagoDsc      
   ,dc.Folio    
   ,dc.NoBurzatilizacion  
from @datosCompletos dc      
inner join vwCuenta c on c.CuentaCtekey= dc.[No.Cuenta]      
inner join TipoProd tp on tp.TipoProdKey = c.TipoProdId       
order by Empresa desc,BursatilDsc,NoBurzatilizacion, FormaPagoDsc,[No.Cuenta], PagoCajaId                       
End      
      
If @Bursatilsp = 2       
Begin      
select dc.[No.Cuenta]      
      ,dc.NombreCompleto      
   ,tp.TipoProdDsc      
      ,dc.PagoCajaId      
   ,dc.CtaBanco      
   ,dc.FechaPago      
   ,dc.FechaCaptura      
   ,dc.FechaProceso      
   ,dc.InteresMora      
   ,dc.IvaMora      
   ,dc.InteresOrd      
   ,dc.IvaOrd      
   ,dc.OtrosGastos      
   ,dc.SegAuto      
   ,dc.SegVida      
   ,dc.SegDesem      
   ,dc.Capital      
   ,dc.Total      
   ,dc.Importe      
   ,dc.PagoXapli      
   ,dc.ImporteXAplicarPago      
   ,dc.Ejercicio      
   ,dc.Periodo      
   ,dc.Empresa         
   ,dc.Titulo      
   ,dc.BursatilDsc      
   ,dc.SubTitulo      
   ,dc.FormaPagoDsc      
   ,dc.Folio      
   ,dc.NoBurzatilizacion  
from @datosCompletos dc      
inner join vwCuenta c on c.CuentaCtekey= dc.[No.Cuenta]      
inner join TipoProd tp on tp.TipoProdKey = c.TipoProdId       
where BursatilDsc = 'NO BURSATILIZADOS'       
order by Empresa desc,BursatilDsc,NoBurzatilizacion,FormaPagoDsc, [No.Cuenta], PagoCajaId      
End      
      
If @Bursatilsp = 3       
Begin      
select dc.[No.Cuenta]      
      ,dc.NombreCompleto      
   ,tp.TipoProdDsc      
      ,dc.PagoCajaId      
   ,dc.CtaBanco      
   ,dc.FechaPago      
   ,dc.FechaCaptura      
   ,dc.FechaProceso      
   ,dc.InteresMora      
   ,dc.IvaMora      
   ,dc.InteresOrd      
   ,dc.IvaOrd      
   ,dc.OtrosGastos      
   ,dc.SegAuto      
   ,dc.SegVida      
   ,dc.SegDesem      
   ,dc.Capital      
   ,dc.Total      
   ,dc.Importe      
   ,dc.PagoXapli      
   ,dc.ImporteXAplicarPago      
   ,dc.Ejercicio      
   ,dc.Periodo      
   ,dc.Empresa         
   ,dc.Titulo      
   ,dc.BursatilDsc      
   ,dc.SubTitulo      
   ,dc.FormaPagoDsc      
   ,dc.Folio   
   ,dc.NoBurzatilizacion     
from @datosCompletos dc      
inner join vwCuenta c on c.CuentaCtekey= dc.[No.Cuenta]      
inner join TipoProd tp on tp.TipoProdKey = c.TipoProdId       
where BursatilDsc = 'BURSATILIZADOS'       
order by Empresa desc,BursatilDsc, NoBurzatilizacion, FormaPagoDsc, [No.Cuenta], PagoCajaId      
End      
END