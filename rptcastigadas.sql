USE [DBSOFIA20150422]
GO
/****** Object:  StoredProcedure [dbo].[SPSOFIA_RptCastigadas]    Script Date: 22/05/2015 04:38:33 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                        
Creado : JVFM                         
fecha  : 22-05-2015                          
Descripcion proceso para obtener el reporte de aplicacion de pagos de cuentas castigadas por fecha y /o Periodo                           
    
Sintaxis :                 
           SPSOFIA_RptCastigadas '20141119','20141119', 1     
                           
*/                          
      ---agregar campos para llenar plantilla segun usuario
Alter Procedure [dbo].[SPSOFIA_RptCastigadas] (                
@FechaPagoIni Date,
@FechaPagoFin Date,                                 
@IdEmpresa Tinyint )           
      
As          
               
 select CuentaCtekey,NombreCte,Prod,NoPago,FechaPago,DiasMora,IntereseMora,IvaintMora,IntOrd,IvaIntOrd,SubTotalint,SegAuto,SegVida,SegDesempleo,Capital,SubTotSeg,Total 
 from rtpcastigo where FechaPago between @FechaPagoIni and @FechaPagoFin
      
go                       
      
                          
