USE [DBSOFIA20150422]
GO
/****** Object:  StoredProcedure [dbo].[SPSOFIA_rptCarteraCastigada]    Script Date: 26/05/2015 10:41:19 a.m. ******/
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
  
Sintaxis:                  
 [SPSOFIA_rptCarteraVencida]     2,0,0,0,'07/09/2011',1,4,10   ,1             
 [SPSOFIA_rptCarteraVencida]     2,1,1,0,'06/06/2011',1,1,99 ,1               
 [SPSOFIA_rptCarteraVencida]     0,0,0,0,'10/10/2011',1,4,99,1                
 [SPSOFIA_rptCarteraCastigada]     '22/04/2015' 
 [SPSOFIA_rptCarteraVencida]     2,0,0,0,'22/04/2015',0,4,3,1        

   select * from carteracte where fechaCorte = '06/06/2011'                
  
*/                  
  
Create Procedure [dbo].[SPSOFIA_rptCarteraCAstigada]                            
       @Finicio date         
as                  
                    
begin     
  
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
 end