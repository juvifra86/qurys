USE [DBSOFIA20150624]
GO
/****** Object:  StoredProcedure [dbo].[SPSOFIA_RptDatosHeader]    Script Date: 16/07/2015 01:11:28 p.m. ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/*                                                                                                                                            
--  DHA 19-07-2010                                                                                                                                                    
--  Obtiene datos para el contrato                                                                                                                                                    
--  CuentaCte se le pasa para poder buscar los datos del actor segun su cuenta                                                                                                                                              
                                                                  
Modifico:Mauricio Rojas V                                                                  
fecha : 15-02-2011                                                                  
Desc :Se agregaron los campos finish y empresaID                                                                  
                                                                
Modifico:Mauricio Rojas V                                                                  
fecha : 15-02-2011                                                                  
Desc :Se agregaron la fecha de Cierre de credito.                                                                                  
                                                                                 
                 select * from cuentacte where cuentactekey=319                                                                                                                   
                                                              
Modifico:GACP                                                              
fecha : 26-04-2011                                                                  
Desc :Se modifica para usar with (nolock) en las consultas                                                         
                                                        
MODIFICO : DAHA                                                        
FECHA : 2011-06-08                                                        
DESC: Se modifica para que se pueda leer los datos de un cliente por la referencia                                                        
                                                      
MODIFICO : DAHA                                                        
FECHA : 2011-08-08                                                        
DESC: Se modifica para que lea el campo de observacion de CuentaCte para los casos de creditos sedidos siempre y cuando su estado sea 39                                                      
                                            
MODIF: IRZE                                            
FECHA: 04/10/2012                                            
DESC: SE MODIFICA LA LECTURA DEL PLAZO CON EL PRODUCTO, AHORA SE LE LA DURACION DE LA CUENTA CTE CON LA DURACION DE LA TABLA DE PLAZO.                                            
                                            
MODIF: LFA                                            
FECHA: 08/01/2013                                            
DESC: Se modifica Numsedido a que entregue siempre un cero                                            
                                            
MODF GACP: 7/10/13 SE OBTIENE LA TASA MORATORIA AHORA DE LA CUENTA                              
                              
MODF: GACP 05/08/13 SE AGREGA LA COLUMNA DE BURSATILIZADO                              
                    
MODF: GACP 6/01/14                        
SE AGREGA SI VIENE DE OTRA CUENTA (860) LA CUENTA ACTUAL                      
                  
MODF GACP 24/02/14 SE SE OBTIENE EL VALOR DEL CAT DE LA CUENTA Y NO DEL PRODUCTO                  
              
MODF EZM 20/05/2014 se agrego el RFC del cliente              
        
MODF: GACP 6/04/14        
SE AGREGA REGISTRO DE CUENTAS TRASPASADAS DE SOFIA A SOFIA                                        
  
MODF: GACP 03/11/14  
SE CAMBIA LA ETIQUETA DE BURSATILIZACION PARA INDICAR QUE NUMERO DE BURSATILIZACION ES  

MODF: JVFM 16/07/2015
Se corrigio la validacion de domiciliacion de cuenta.

Sintaxis:                 
    EXEC [SPSOFIA_RptDatosHeader] 2351                 
                                                            
    EXEC [SPSOFIA_RptDatosHeader] '02700000268'                                                        
    SELECT * FROM Cuentacte                                                 
                                              
    exec [SPSOFIA_RptDatosHeader] 83              
    Exec SPSOFIA_RptDatosHeader 50001
                
*/                                                                                                                
ALTER PROCEDURE [dbo].[SPSOFIA_RptDatosHeader]                             
--DECLARE             
@CuentaCte VARCHAR(15)=  5157          
AS                                                                                                                                     
DECLARE   @Aval AS int,                                                                            
    @Aval2 AS int,                                                                         
    @Aval3 AS int,                               
    @Aval4 AS int,                                                                          
    @actorid AS int  ,                                                                    
    @SaldoSeguroAuto AS MONEY ,                                      
    @SegurosVidaDes AS MONEY ,                                                                      
    @Montoafinanciar AS MONEY ,                                                                         
    @ImportePagare AS MONEY,                                                     
    @MontosSegPagare AS MONEY,                                                                        
    @MontoTotal AS MONEY,                                                                        
    @PrimeraBoleta AS SMALLDATETIME ,                                                                        
@MontoInicial AS MONEY,                                                                        
    @DifPago    AS MONEY,                                                        
    @Referencia AS VARCHAR(15)                                                        
                                                            
                                                        
IF LEN(@CuentaCte) > 6                                                        
BEGIN                                              
SET @Referencia = CAST(@CuentaCte AS VARCHAR(15))                                                        
SELECT @CuentaCte = CuentaCteKey FROM CuentaCte with(nolock) WHERE NumReferencia = @Referencia                                                        
END                                                                                                                                                               
SELECT @PrimeraBoleta=FechaVencimiento                                                                                             
FROM Amortizacion   with(nolock)                                                                                            
WHERE CuentaCteId=@CuentaCte                                                         
AND Boleta=1                                                                                             
AND ConceptoContableId=46                                                          
                                                                                            
select @SaldoSeguroAuto=SUM(PrimaTotal)                                                                                     
from vwPolizaCte with(nolock)                                                                                       
where CuentaCteid=@CuentaCte                                                                                     
                                                                                                 
                                                                                                                  
select @MontosSegPagare = ISNULL(@SaldoSeguroAuto/NumPagos,0)                                                                       
   ,@actorid = CC.ClienteId                                                                                            
   --,@DifPago = Case when CC.Importe-CC.Enganche < CC.LimCredito THEN 0                                                                 
   --                  ELSE cast((CC.Importe-CC.Enganche -CC.LimCredito) as decimal(10,2)) End                                 
   ,@DifPago =CC.DifPago                              
   ,@Montoafinanciar=CC.Saldo                                                                                 
from vwCuenta   CC  with(nolock)                           
--INNER JOIN Cliente CL   with(nolock)                              
--        ON CL.ClienteKey=CC.ClienteId                                                                                           
where  CuentaCtekey=@CuentaCte                 
                                                                                  
                                                                                                             
--select @Montoafinanciar=SUM(SaldoEmision)                                                                                                                     
--from Amortizacion   with(nolock)                                                                              
--where CuentaCteId=@CuentaCte                                                                                   
--and ConceptoContableId in (46,47,48)                                                                          
                                                                                                  
select  @SegurosVidaDes=ISNULL(SUM(SaldoEmision),0)                                                      
from NotaCargo      with(nolock)                                                    
where CuentaCteId=@CuentaCte                                                                                                      
and ConceptoContableId in (85,73)                                                         
                                                                                                   
set @ImportePagare = @Montoafinanciar + ISNULL(@SegurosVidaDes,0)                                                                                                    
set @MontoTotal = @ImportePagare + ISNULL(@SaldoSeguroAuto,0)                                         
                                                                                            
                                                                                                                    
                                                         
SELECT TOP 1 CC.CuentaCteKey,                                                                        
 CASE WHEN EM.EmpresaKey = 1 THEN                                                     
       CASE WHEN CAST(CC.FechaInicio AS DATE) < = '20110605' THEN 'SU CRÉDITO Y AHORRO S.A. DE C.V., SOCIEDAD FINANCIERA POPULAR(FINANCIERA PLANFIA)'                                                     
       ELSE 'FINANCIERA PLANFIA S.A. DE C.V., SOCIEDAD FINANCIERA POPULAR' END                                                     
 ELSE UPPER(EM.EmpresaDsc)END[EmpresaDsc], --EM .EmpresaDsc,                                                                                                                         
                                                                         
  PA.TipoFiscal,                                                    
  CC.Contrato,                                                                                                                  
  CC.NumReferencia [Cuenta],CC.SolicitudID                                                                 
  ,SOL.SolicitanteId                                                                
  ,(SELECT dbo.FNSOFIA_SiguienteFechaPago(CC.CuentaCteKey))[FechaSigPago]                                                                
  ,@PrimeraBoleta [FechaImpContrato]                                                                                                                     
  ,CAST(CC.FechaFin AS SMALLDATETIME)[FechaFin]                                                                                                                   
  ,UPPER(EM.Responsable) [FirmaAutorizadora]              
  ,CAST (CC.FechaInicio AS SMALLDATETIME)[FechaIni]                                                                 
  ,isnull(EP.EstadoDsc,'Activo')StatusDsc                                                                
  ,CC.Situacion                                                                
  ,isnull(Email.EmailNormal,'Sin registrar')[Email],                                          
  ISNULL(PU.Poliza,'0')Poliza,                                                         
                                                                      
--            <<<<<<<<<<<<<<<<<<<<<<<<<DATOS GENERALES CLIENTE>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                                                            
                                                                                                                                   
    case when PA.TipoFiscal ='F' then UPPER(PA.NombreCompleto) else UPPER(PA.RazonSocial) end [NombreCliente]                                   
    ,PA.RazonSocial                                                                
    ,DOC.DocumentoDsc                              
    ,PA.NumIdentificacion                                                                
    ,ISNULL(DA.Calle,DA2.Calle)[Calle]                                                            
    ,ISNULL(DA.Numext,DA2.Numext)[NumExt]                                      
    ,ISNULL(CASE WHEN DA.NumInt <>''THEN ' INT. '+DA.NumInt ELSE '' END,CASE WHEN DA2.NumInt <>''THEN ' INT. '+DA2.NumInt ELSE '' END)[NumInt]                       
                        
                           
                           
    ,ISNULL(DA.Colonia,DA2.Colonia)[Colonia]                                                            
    ,ISNULL(DA.DelMunicipio,DA2.DelMunicipio)[DelMunicipio]                                                            
    ,ISNULL(DA.CP,DA2.CP)[CP]                                                            
   ,ISNULL(DA.Estado,DA2.Estado)[Estado]                               
    ,ISNULL(CASE WHEN DA.TipoViviendaId=1 THEN 'X'ELSE '' END,CASE WHEN DA2.TipoViviendaId=1 THEN 'X'ELSE '' END) [TVivPropiaCliente]                                                                                                             
    ,ISNULL(CASE WHEN DA.TipoViviendaId=2 THEN 'X'ELSE '' END,CASE WHEN DA2.TipoViviendaId=2 THEN 'X'ELSE '' END) [TViviRentaCliente]                                                                                  
    --,ISNULL(DA.Telefono1,DA2.Telefono1)[Telefono1]                                                                                                                   
    ,isnull(case when not DA.Telefono1 is null and rtrim(ltrim(DA.Telefono1)) <> '0' and rtrim(ltrim(DA.Telefono1)) <> ''                                                     
   then ' Opc. 1: ' + cast(DA.Telefono1 as varchar) +                                                     
   case when not DA.Telefono2 IS null and rtrim(ltrim(DA.Telefono2)) <> '0' and rtrim(ltrim(DA.Telefono2)) <> ''                                                    
     then '   Opc 2 : ' + CAST(DA.Telefono2 AS varchar) else '' end                                                    
   else                                                     
    case when not DA.Telefono2 IS null and rtrim(ltrim(DA.Telefono2)) <> '0' and rtrim(ltrim(DA.Telefono2)) <> ''                                                    
    then ' Opc 1 : ' + cast(DA.Telefono2 as varchar)end                                                    
   end,'Sin Registrar')  [Telefono1]                                                                                                                   
                                  
                               --   EXEC [SPSOFIA_RptDatosHeader] 1152                                                                          
--            <<<<<<<<<<<<<<<<<<<<<<<<<<DATOS DE LA CUENTA>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                                               
          
       ,CC.Saldo       [MontoFinancia]                                                                                              
       ,@DifPago       [DiffPago]                                                                                      
       ,@ImportePagare [Saldo]                                                                                                           
       ,@MontoTotal    [MontoTotal]                                                                                                                    
       ,dbo.FnSofia_NumToText2(@ImportePagare)[SaldoLetra], --dbo.fn_Sofia_NumToText(@ImportePagare)[SaldoLetra],                                                                                                                                            
       DBO.fn_Sofia_NumToText(CAST(SUBSTRING(CAST(@ImportePagare AS VARCHAR(20)),                                                                                                           
       CHARINDEX ('.',CAST(@ImportePagare AS VARCHAR(20)),1)+1,4)AS INT))[PuntoS],                                                                                           
    CC.NumPagos,                                                                                                                          
       PL.PlazoDsc,                                                                                                    
       PR.Comision,                                                                                         
       PL.Duracion,                                                                            
       CC.TasaNeta                                                                
       ,dbo.fn_Sofia_NumToText(CC.TasaNeta)[LetraInteres],                                                                                                                                           
       DBO.fn_Sofia_NumToText(CAST(SUBSTRING(CAST(CC.TasaNeta AS VARCHAR(20)),                                                                                                         
       CHARINDEX ('.',CAST(CC.TasaNeta AS VARCHAR(20)),1)+1,4)AS INT))[PuntoI],                                                                                                                                            
       --PR.InteresM,                                                                                                  
       --dbo.fn_Sofia_NumToText(PR.InteresM)[InteresMLetra],                                                                                                                              
       --DBO.fn_Sofia_NumToText(CAST(SUBSTRING(CAST(PR.InteresM AS VARCHAR(20)),                                                                                                                                            
       --CHARINDEX ('.',CAST(PR.InteresM AS VARCHAR(20)),1)+1,4)AS INT))[PuntoM],                                        
       CC.TasaMoratorio InteresM,                                                                                                                               
       dbo.fn_Sofia_NumToText(CC.TasaMoratorio)[InteresMLetra],                                              
       DBO.fn_Sofia_NumToText(CAST(SUBSTRING(CAST(CC.TasaMoratorio AS VARCHAR(20)),                                                                                                                                            
       CHARINDEX ('.',CAST(CC.TasaMoratorio AS VARCHAR(20)),1)+1,4)AS INT))[PuntoM],                                                                                        
       CC.valorcat [CAT],                                                                                                          
       EM.CveRAP ,                                                                                                                       
       CC.Enganche,                       
       CC.ImportePago,                                                                                                                      
dbo.FnSofia_NumToText2(CC.ImportePago)[ImportePagoLetra],-- dbo.fn_Sofia_NumToText(CC.ImportePago)[ImportePagoLetra],                                                                                                                              
       DBO.fn_Sofia_NumToText(CAST(SUBSTRING(CAST(CC.ImportePago AS VARCHAR(20)),                                                                                                                                            
       CHARINDEX ('.',CAST(CC.ImportePago AS VARCHAR(20)),1)+1,4)AS INT))[PuntoIm],                                                                    
        dbo.FNSOFIA_GetNombreProducto(1,@CuentaCte) ProductoDsc,                                                                                    
                                                                                                                       
       dbo.FNSOFIA_ReferenciaHSBC(CC.Cuenta)[CuentaPagos],                                                                                            
       dbo.FNSOFIA_GetDiaPagoDoc(CC.CuentaCtekey) DiaVencimiento,                                                                                                                                       
       CASE WHEN (select Count(1) from BancoCargoCuenta with(nolock) where CuentaCteId=@CuentaCte and Status=0 and Finish is null)>0 THEN'' ELSE 'X' END[CuentasinDomi],                                                                     
       CASE WHEN CC.BancoActorId IS NOT NULL THEN  BA.NumCuenta ELSE '' END[CuentaDom],                                                                                                                                     
       CASE WHEN  (select Count(1) from BancoCargoCuenta with(nolock) where CuentaCteId=@CuentaCte and Status=0 and Finish is null)>0 THEN  'X' ELSE '' END[CuentaconDomi],                                                                                                                                 
                                                                                                                                                   
--            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<DATOS DE LA SUCURSAL>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                          
                                                                                                            
       UPPER(SU.SucursalDsc+', '+SU.Calle+' '+SU.Numext+', '+SU.Colonia+', C.P. '+', '+SU.Delmunicipio+', TEL.'+SU.TelSucursal)[Datos Sucursal],UPPER(su.SucursalDsc)[Sucursal],                                                                              
  
    
      
        
          
               
              
                
                  
                    
                      
                        
                                                                                                       
--            <<<<<<<<<<<<<<<<<<<<<<<<<<<<<DATOS DE LA UNIDAD>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                                     
                                                                                                
       UPPER(MA.MarcaDsc)[Marca],                                
       UPPER(SEU.OrigenMotor)[OrigenMotor],                                                                                              
       ISNULL(UPPER(UN.UnidadDsc),'')[Unidad]                                                                
       ,SEU.SerieMotor,SEU.Color [Color]                                                           
      ,ISNULL(UPPER(AE.AseguradoraDsc),'')[Aseguradora],                                              
       UPPER(PER.PeriodoDsc)[FrecuenciaPag],                                                                                                               
       CASE WHEN PER.PeriodoKey = 2 THEN 'X' ELSE '' END[Semanal],                                                                                                                
       CASE WHEN PER.PeriodoKey = 5 THEN 'X' ELSE '' END[Mensual],                                                                                                               
       CASE WHEN PER.PeriodoKey = 2 THEN 'de cada semana' ELSE '' END[semana],                                                                                 
       @SaldoSeguroAuto SaldoSeguro  ,                                                                        
       dbo.FnSofia_NumToText2(@SaldoSeguroAuto)[SeguroLetra],-- dbo.fn_Sofia_NumToText(@SaldoSeguroAuto)[SeguroLetra],                                                                                                                             
       DBO.fn_Sofia_NumToText(CAST(SUBSTRING(CAST(@SaldoSeguroAuto AS VARCHAR(20)),                                                                                          
       CHARINDEX ('.',CAST(@SaldoSeguroAuto AS VARCHAR(20)),1)+1,4)AS INT))[PuntoSeg],                                                
       @MontosSegPagare[MontosPagoSeg],                                                                                                                  
       dbo.FnSofia_NumToText2(@MontosSegPagare)PagoSeguroLetra,--dbo.fn_Sofia_NumToText(@MontosSegPagare)[PagoSeguroLetra],                                                                                                                         
       DBO.fn_Sofia_NumToText(CAST(SUBSTRING(CAST(@MontosSegPagare AS VARCHAR(20))                                                                                                          
       ,CHARINDEX ('.',CAST(@MontosSegPagare AS VARCHAR(20)),1)+1,4)AS INT))[PuntoPagoSeg]                                                 
        ,cc.Finish [fechaCancel]                                                                    
        ,pr.EmpresaId                                                                
        ,Cast (cc.FechaCierre as DATE) [ FechaCierre ]                                                        
        --,ISNULL(CC.Observacion,'0')[NumSedido]   LFA                                                                                                                                         
  ,isnull((select cast(CuentaCteNewId as varchar)from CtaSofiaSofia  with(nolock) where CuentaCteOldId=CC.CuentaCtekey),'0')[NumSedido]        --LFA    
  ,case         
  when EXISTS(select 1 from Cuentas860SolCD with(nolock) where SolicitudId=CC.SolicitudID)then 'Proviene de la cuenta de 8/60:' + (select cast(CuentaCteID as varchar)from Cuentas860SolCD  with(nolock) where SolicitudId=CC.SolicitudID)        
  when EXISTS(select 1 from CtaSofiaSofia with(nolock) where CuentaCteNewId=CC.CuentaCtekey)then 'Venta de Cartera Cuenta Anterior:' + (select cast(CuentaCteOldId as varchar)from CtaSofiaSofia  with(nolock) where CuentaCteNewId=CC.CuentaCtekey)        
  when EXISTS(select 1 from CtaSofiaSofia with(nolock) where CuentaCteOldId=CC.CuentaCtekey)then 'Venta de Cartera Cuenta Nueva:' + (select cast(CuentaCteNewId as varchar)from CtaSofiaSofia  with(nolock) where CuentaCteOldId=CC.CuentaCtekey)        
  else ''         
  end NumSedido2     
  ,isnull(CC.Bursatil,0)   Bursatil                            
  ,case when isnull(CC.Bursatil,0) = 0 then 'NO BURSATILIZADO' 
	ELSE (select 'BURSATILIZADO NO.' + dbo.UPPERTRIM(str(Bur.NoBursatilizacion))from Bursatilizado Bur with(nolock) where Bur.CuentaCteId=CC.CuentaCtekey)
		+ case when cc.CuentaCtekey in (Select CuentaCteID from CtaSiopSofia where NoTraspaso = 5) then ' /TRANSFERIR A LEGAL' else '' end
	
	END Burzatilizado                      
      
  ,case         
  when EXISTS(select 1 from Cuentas860SolCD with(nolock) where SolicitudId=CC.SolicitudID)then 'Proviene de la cuenta de 8/60:' + (select cast(CuentaCteID as varchar)from Cuentas860SolCD  with(nolock) where SolicitudId=CC.SolicitudID)        
  when EXISTS(select 1 from CtaSofiaSofia with(nolock) where CuentaCteNewId=CC.CuentaCtekey)then 'Venta de Cartera Cuenta Anterior:' + (select cast(CuentaCteOldId as varchar)from CtaSofiaSofia  with(nolock) where CuentaCteNewId=CC.CuentaCtekey)        
  when EXISTS(select 1 from CtaSofiaSofia with(nolock) where CuentaCteOldId=CC.CuentaCtekey)then 'Venta de Cartera Cuenta Nueva:' + (select cast(CuentaCteNewId as varchar)from CtaSofiaSofia  with(nolock) where CuentaCteOldId=CC.CuentaCtekey)        
  else ''         
  end CuentaOrigen                   
  ,isnull(CCD.NIP,'') NIP--------------------------------------------------------------------------------------------------------                
  ,isnull(CCD.PersonaAutorizada,'') [PersonaAutorizada]--------------------------------------------------------------------------------------------------------                
                
  ,isnull(Pa.RFC,ea.RFC) RFC              
                       
FROM CuentaCte CC                  with(nolock)                                                                                                                                                                                
  --LEFT JOIN Cliente CL             with(nolock) ON CL.ClienteKey=CC.ClienteId                                                  
  LEFT JOIN PersonaActor PA        with(nolock) ON PA.ActorId=CC.ClienteId            
  LEFT JOIN Documento DOC          with(nolock) ON DOC.DocumentoKEY=PA.DocumentoId                       
  LEFT JOIN DireccionActor DA      with(nolock) ON DA.ActorId=CC.ClienteId                                                            
  AND DA.DireccionActorKey = CC.DireccionActorId                                                                
  LEFT JOIN DireccionActor DA2     with(nolock) ON DA2.ActorId=CC.ClienteId                                                                                                                
  AND DA2.[Status] = 0                                                            
  AND DA2.AddressTypeId = 1                                                    
  LEFT JOIN Producto PR            with(nolock) ON PR.ProductoKey=CC.ProductoId                                                                                                                                          
  INNER JOIN Empresa EM         with(nolock) ON EM.EmpresaKey=CC.EmpresaId                                       
  LEFT JOIN BancoActor BA          with(nolock) ON BA.BancoActorKey=CC.BancoActorId                                                                                                                                              
  LEFT JOIN Plazo PL         with(nolock) ON pl.Duracion=CC.NumPagos--PL.PlazoKey=PR.PlazoId                                                                                                                                    
  LEFT JOIN Sucursal SU         with(nolock) ON SU.SucursalKey=CC.SucursalId                                                                                          
  LEFT JOIN UnidadCuentaCte SEU    with(nolock) ON SEU.CuentaCteId= CC.CuentaCtekey                                        
  LEFT JOIN PolizaSeguroUnidad PU  with(nolock) ON PU.UnidadCuentaCteId=SEU.UnidadCuentaCtekey                                                                                          
  LEFT JOIN Unidad UN              with(nolock) ON UN.UnidadKey=SEU.UnidadId                 
  LEFT JOIN TipoUnidad TU          with(nolock) ON TU.TipoUnidadKey=UN.TipoUnidadId                                                            
  LEFT JOIN Linea LN    with(nolock) ON LN.LineaKey=TU.Lineaid                                                                                                                                                
  LEFT JOIN Marca MA      with(nolock) ON MA.MarcaKey=LN.MarcaId                                                                                                                                                  
  LEFT JOIN Aseguradora AE     with(nolock) ON AE.AseguradoraKey=PU.AseguradoraId                                            
  LEFT JOIN Periodo PER      with(nolock) ON PER.PeriodoKey=PL.PeriodoId                                                                         
  LEFT JOIN EstadoPO EP      with(nolock) ON EP.EstadoPOKey = CC.Situacion                                                                                  
  LEFT JOIN vwPersonaActor Email    with(nolock) ON Email.actorId = CC.ClienteId                                                                            
  LEFT JOIN UnidadCuentaCte UCC    with(nolock) ON UCC.CuentaCteId = CC.ClienteId                                                           
  LEFT JOIN PolizaSeguroUnidad PS  with(nolock) ON PS.UnidadCuentaCteId = UCC.UnidadCuentaCtekey                                                                        
   AND PS.UDI = 0                                                                                  
   AND PS.[Status] = 0                                                                               
  LEFT JOIN ClienteSolicitante SOL with(nolock) ON SOL.Clienteid = CC.ClienteId            
  left join ComplementoCD CCD with(nolock) on CCD.CuentaCteId = CC.CuentaCtekey                
  left join EmpresaActor ea with(nolock) on ea.ActorId = cc.ClienteId                                                                             
WHERE CC.CuentaCtekey=@CuentaCte 