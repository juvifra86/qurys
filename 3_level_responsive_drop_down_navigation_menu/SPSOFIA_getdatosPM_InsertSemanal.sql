/*                      
creo: ezm                      
inserta datos en la tabla de ResultadosBuroCreditoPM                      
SPSOFIA_getdatosPM_InsertSemanal 1,'20130902'                      
exec SPSOFIA_getdatosPM_InsertSemanal 2,'20160408',2                      
select * from ResultadosBuroCreditoPM where empresaid = 1 order by 1                      
select * from ResultadosBuroCreditoPM where empresaid = 1 and cuentacteid = 6645                                           
delete from ResultadosBuroCreditoPM            
exec SPSOFIA_getdatosPM_Insert  2,'20160822',2             
*/                      
ALTER procedure SPSOFIA_getdatosPM_InsertSemanal                      
@EmpresaID integer,                          
@Periodo Date, ---Fecha    
@catPeriodo integer --2.- semanal,  5.- Mensual                         
as                      
begin                       
Declare @Fecha Char(8)                                                  
Declare @NumPeriodo Char(6)                                                  
Declare @mes Int                                                   
Declare @año Int                                                  
Declare @UltimaFecha Date                                                  
Set @Fecha=REPLACE(CONVERT(Varchar,@Periodo,103),'/','')                                                  
Set @NumPeriodo=SUBSTRING(@Fecha,3,6)                                                  
Set @mes=DATEPART(MONTH,@Periodo)                                                   
Set @año=DATEPART(YEAR ,@Periodo)                                                   
-------------------------------------------ULTIMA FECHA    
set @UltimaFecha =                     
 ---Si es Mensual toma la ultima fecha de la tabla CarteraCte                    
 case when @catPeriodo = 5 then                    
  (select MAX(FechaCorte)                                             
 from CarteraCte with(nolock) where Ejercicio = @año and Periodo = @mes)                    
 ---Si es semanal toma la ultima fecha de la tabla CarteraCteFinaliza                    
 else                     
 (select MAX(FechaCorte)                                             
 from CarteraCteFinaliza with(nolock) where Ejercicio = @año and Periodo = @mes )                    
 end        
------Valida que no exista la informacion en la tabla, de existir se eliminan los datos anteriores para insertar los nuevos                                
if cast(@UltimaFecha as date) in (select distinct cast([init] as DATE) from ResultadosBuroCreditoPM where EmpresaID = @EmpresaID and PeriodoId = @catPeriodo and cargasiop = 0)                                         
begin                                        
update ResultadosBuroCreditoPM set finish = dbo.SOFIAGETDATE(), status = 1 where cast([init] as date) =  cast(@UltimaFecha as date)                                        
and EmpresaID = @EmpresaID and periodoId = @catPeriodo and status = 0 and finish is null   and cargasiop = 0                                     
end                                        
-- Segmento de Encabezado                             
Declare @header Char(100)                              
Declare @Identificador varchar(7)                          
Declare @Usuario varchar(6)                          
Declare @Institucion  varchar(4)                          
Declare @TipoInstitucion varchar(3)                          
Declare @Formato varchar(1)                          
Declare @FechaHD char(8)            
Declare @NoPeriodo char(6)                           
declare @FillerHD varchar(60)                          
Set @header='HDBNCPM0010820100000200503104' + @Fecha + '05' + @NumPeriodo + '06'+space(53)                             
set @Identificador='HDBNCPM'                           
set @Usuario='1082'                              
Set @Institucion='0000'                              
set @TipoInstitucion='005'                           
set @Formato='1'                           
set @FechaHD=@Fecha                           
set @NoPeriodo=@NumPeriodo                           
set @FillerHD=space(53)                           
insert into ResultadosBuroCreditoPM(
[CuentacteId],[SegmentoEMEM],[RFC_EM],[Curp],[NumBC],[RazonSocial],[Nombre1],[Nombre2],[Apaterno],[Amaterno],[Nacionalidad],[Calif],
[Banxico1],[Banxico2],[Banxico3],[Domicilio],[Domicilio2],[Colonia],[Delegacion],[Ciudad],[Estado],[CP],[Telefono],[Ext],[Fax],[tipoCliente],
[EdoExt],[PaisDom],[fillerEm]
,[Segmento AC]
,[Accionistas]
,[22_FillerAC]
,[SegmentoCRCR],[RFC_CR],[NoExp],[NoContrato],
[ContAnt],[FechaApert],[Plazo],[TipoCred],[SaldoIni],[Moneda],[NumPagos],[FrecPag],[ImportePago],[UltimaFechaPago],[DteReestructura],[pagoEfec],
[DteLiquida],[montoQuita],[montoDacion],[montoQuebranto],[ClaveObs],[Especial]
,[23_Crédito Máximo Autorizado]
,[FillerCR],[BoletaxVencer],[Vencido]
,[SegmentoDE1],[RFC_DE1],[NoContratoDE1],[VencidoDE1],[CantidadDE1],[FillDE1],[SegmentoDE2],[RFC_DE2],[NoContratoDE2],[VencidoDE2],[CantidadDE2],
[FillDE2]
,[Segmento AV]
,[Avales]
,[22_FillerAV]
,[SumaSaldoVencido],[TEmpresas],[BoletasXVencer],[SaldoTotalBoleta],[MopBuro],[EmpresaID],[init]
,[finish],[status],[PeriodoId],[CargaSiop])                       
Select                           
    C.cuentactekey,                      
  ---- [Segmento EM] ----------------------------------------------------------------------------                          
     'EMEM'[Segmento EM]                                
    ,(Case When replace(EA.RFC,'-','') Is Null Then                   
                             dbo.FNSOFIA_GetCadenaBC('C',upper(b.RFC),13)                                
                 Else                                                 dbo.FNSOFIA_GetCadenaBC('C',replace(upper(EA.RFC),'-',''),13)                                 
            End)[RFC]                                 
     ,space(18)[Curp]                                
     ,space(10)[NumBC]                          
     ,dbo.FNSOFIA_GetCadenaBC('C',SUBSTRING(b.RazonSocial,1,75),75)[RazonSocial]                           
     ,space(75)[Nombre1]                                   
     ,space(75)[Nombre2]                                
     ,space(25)[Apaterno]                                
     ,space(25)[Amaterno]                                
     ,'08MX'[Nacionalidad]                                
     ,'09B3'[Calif]                                                    
     ,dbo.FNSOFIA_GetCadenaBC('C','9999999',11)[Banxico1]                                                     
     ,REPLICATE('0', 11)[Banxico2]                                            
     ,REPLICATE('0', 11)[Banxico3]                                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',SUBSTRING(dbo.fn_CambiaCaracter(da.Calle) + ' ' + dbo.fn_CambiaCaracter(da.Numext)+ ' ' + dbo.fn_CambiaCaracter(da.NumInt),1,40),40)[Domicilio]                                
     ,space(40)[Domicilio2]                                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',dbo.fn_CambiaCaracter(da.colonia),60)[Colonia]                                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',dbo.fn_CambiaCaracter(da.DelMunicipio),40)[Delegacion]                                                    
     ,space(40)[Ciudad]                                                    
     ,dbo.FNSOFIA_GetCadenaBC('C',dbo.FNSOFIA_AbrevEstadoBC(Case When ISNUMERIC(da.estado) = 1 Then (Select Top 1 Estado From CP Where CP=da.cp Order By 1 Desc)                            
                                                                 When ISNUMERIC(da.estado) = 0 Then da.estado                      
                                                                 End),4)[estado]               
     , dbo.FNSOFIA_GetCadenaBC('C',da.CP ,10)[CP]                      
     ,space(11)[telefono]                          
     ,space(8)[Ext]                          
     ,space(11)[Fax]     
     ,'1'[tipoCliente]                          
     ,space(40)[EdoExt]                          
     ,'MX'[PaisDom]                          
     ,space(82)fillerEm 
	 ---Segmento Accionistas
	 ,'AC'[Segmento AC]--agregado
	,dbo.FNSOFIA_GETACCIONISTASBURO(C.cuentactekey) Accionistas--agregado  
	,space(30)FILLERAC --agregado                              
  ---- [Segmento CR] ----------------------------------------------------------------------------                          
     ,'CRCR'[Segmento CR]                            
     ,(Case When replace(upper(EA.RFC),'-','') Is Null Then dbo.FNSOFIA_GetCadenaBC('C',upper(b.RFC),13)                                 
            Else dbo.FNSOFIA_GetCadenaBC('C',replace(upper(EA.RFC),'-',''),13)                      
            End)[RFC_CR]                      
     ,space(6)[NoExp]                           ,dbo.FNSOFIA_GetCadenaBC('C',cast(c.cuentactekey as varchar(10)),25)[NoContrato]                          
     ,space(25)[ContAnt]    ---s.Contrato                          
     ,replace ((convert(varchar(10),c.fechainicio,103)), '/','')[FechaApert]                          
     ,dbo.FNSOFIA_GetCadenaBC('N', cast(datediff (d, c.fechainicio,c.FechaFin) as varchar(5)),5)[Plazo]                          
     ,'6270'[TipoCred]                          
     ,dbo.FNSOFIA_GetCadenaBC('N', cast( c.saldo as int) , 20)[SaldoIni]                          
     ,'001'[Moneda]                          
     ,dbo.FNSOFIA_GetCadenaBC('N', c.NumPagos,4)[NumPagos]                          
     ,dbo.FNSOFIA_GetCadenaBC('N', 30 ,3)[FrecPag]                          
     , (case when isnull(d.SaldoTotalBoleta,0) + isnull(d.SaldoTotalCapital,0) < = 0 then 0  ----------si no debe nada vencido y no tiene boletas x vencer se manda cero                  
       else dbo.FNSOFIA_GetCadenaBC('N', Case BoletasXVencer when 0 then 0 ---si tiene boletas por vencer se pone como vigente si no se manda cero          
           else  (cast(d.SaldoTotalCapital as Int)) End , 20)  ---Solo dejamos la deuda de puro capital futuro      
           end)+       
     (case when isnull(d.SaldoTotalBoleta,0) + isnull(d.SaldoTotalCapital,0) < = 0 then 0                     
  else (Case cast(d.SaldoTotalBoleta as Int) when 0 then 0 else cast( d.SaldoTotalBoleta as Int) End)  --[CantidadDE2]   ------solo manda lo vencido                       
   end)  ----------[IMPORTE PAGOS]----MANDA LO VIGENTE MAS LO VENCIDO      
    ,(Case When replace ((convert(varchar(10),d.UltimaFechaPago ,103)), '/','')='01011900' Then dbo.FNSOFIA_GetCadenaBC('N', 0,8)                                 
   Else replace ((convert(varchar(10),d.UltimaFechaPago ,103)), '/','')                 
   End)[UltimaFechaPago]                               
     ,dbo.FNSOFIA_GetCadenaBC('N','',8)[DteReestructura]                          
     ,dbo.FNSOFIA_GetCadenaBC('N','',20)[pagoEfec]                       
    , case when isnull(d.SaldoTotalBoleta,0) + isnull(d.SaldoTotalCapital,0) < = 0 then dbo.FNSOFIA_GetCadenaBC('N',replace ((convert(varchar(10),d.UltimaFechaPago ,103)), '/',''),8)                       
   else dbo.FNSOFIA_GetCadenaBC('N','',8) end --[DteLiquida]                        
    ,dbo.FNSOFIA_GetCadenaBC('N','',20)[montoQuita]                          
     ,dbo.FNSOFIA_GetCadenaBC('N','',20)[montoDacion]                          
     ,dbo.FNSOFIA_GetCadenaBC('N','',20)[montoQuebranto]                      
     , case when isnull(d.SaldoTotalBoleta,0) + isnull(d.SaldoTotalCapital,0) < = 0 then dbo.FNSOFIA_GetCadenaBC('C','CC',4)                       
                else ''                       
                     end--,space(4)[ClaveObs]                 
     ,space(1)[Especial]    
	 ,c.Importe '23_Crédito Máximo Autorizado'                       
     ,space(107)[FillerCR]                                
    , d.BoletasXVencer                            -- Total de Boletas por Vencer                                                 
     , cast(d.SaldoTotalBoleta as Int)[Vencido]    -- Campo Saldo Total de la Boleta                                                 
   ---- [Primer Segmento DE]  --------------------VIGENTE-------------------------------------------------------------                          
    ,'DEDE'[SegmentoDE1]                                      
     , (Case When replace(upper(EA.RFC),'-','') Is Null Then dbo.FNSOFIA_GetCadenaBC('C',upper(b.RFC),13)                      
            Else dbo.FNSOFIA_GetCadenaBC('C',replace(upper(EA.RFC),'-',''),13)                      
             End)[RFC_DE1]                      
    , dbo.FNSOFIA_GetCadenaBC('C',cast(c.cuentactekey as varchar(10)),25)[NoContratoDE1]                          
    , case when isnull(d.SaldoTotalBoleta,0) + isnull(d.SaldoTotalCapital,0) < = 0 then dbo.FNSOFIA_GetCadenaBC('N',0,3)                      
   else dbo.FNSOFIA_GetCadenaBC('N', 0,3) end ---DIAS DE VENCIMIENTO                          
     , case when isnull(d.SaldoTotalBoleta,0) + isnull(d.SaldoTotalCapital,0) < = 0 then dbo.FNSOFIA_GetCadenaBC('N',0,20)                      
       else dbo.FNSOFIA_GetCadenaBC('N', Case BoletasXVencer when 0 then 0 ---si tiene boletas por vencer se pone como vigente si no se manda cero          
   else  (cast(d.SaldoTotalCapital as Int)) End , 20)  ---Solo dejamos la deuda de puro capital futuro                     
   end  ---CANTIDAD                      
    , space(75)[FillDE1]                                                    
   ---- [Segundo Segmento DE]  --------------------VENCIDO---------------------------------------------------------                          
   ,'DEDE'[SegmentoDE2]                                
    , (Case When replace(upper(EA.RFC),'-','') Is Null Then dbo.FNSOFIA_GetCadenaBC('C',upper(b.RFC),13)                      
            Else dbo.FNSOFIA_GetCadenaBC('C',replace(upper(EA.RFC),'-',''),13)                      
            End)[RFC_DE2]                                                        
     , dbo.FNSOFIA_GetCadenaBC('C',cast(c.cuentactekey as varchar(10)),25)[NoContratoDE2]                          
	,dbo.FNSOFIA_GetCadenaBC('N', case when d.diasatraso > 999 then 999 else d.diasatraso end,3)        
 ,case when isnull(d.SaldoTotalBoleta,0) + isnull(d.SaldoTotalCapital,0) < = 0 then dbo.FNSOFIA_GetCadenaBC('N',0,20)                      
 else (Case cast(d.SaldoTotalBoleta as Int) when 0 then 0 else cast( d.SaldoTotalBoleta as Int) End)  --[CantidadDE2]   ------solo manda lo vencido                       
   end --CANTIDAD                      
  , space(75)[FillDE2]  
  ---Segmento Avales-----------------------
  ,'AV' [SegmentoAvales]    
  ,dbo.FNSOFIA_GETAVALESBURO(C.cuentactekey) Avales  
  ,space(94)[FillerAV]                                                
     ---------------------------------------------------------SumaSaldoVencido----------------------------------------------------------------------------------------------------------------------------              
    ,cast( d.SaldoTotalBoleta as Int)  ---------Solo se manda lo vencido        
,Case When BoletasXVencer<>0 and cast(d.SaldoTotalBoleta as int)<>0                                    
              or BoletasXVencer<>0 and cast(d.SaldoTotalBoleta as int)=0                         
              or BoletasXVencer=0 and cast(d.SaldoTotalBoleta as int)<>0                                           
            Then                                         
              Case When EA.RFC Is Null Then dbo.FNSOFIA_GetCadenaBC('C',upper(b.RFC),13)                                 
                   Else dbo.FNSOFIA_GetCadenaBC('C',replace(upper(EA.RFC),'-',''),13)                               
                   End                        
                   else  -----------Se agregó este else para que a todos les ponga RFC (ahora tambien toma en cuenta los Terminados)                      
                   Case When EA.RFC Is Null Then dbo.FNSOFIA_GetCadenaBC('C',upper(b.RFC),13)                                 
                   Else dbo.FNSOFIA_GetCadenaBC('C',replace(upper(EA.RFC),'-',''),13)                               
                   End                                 
   End                                
,d.BoletasxVencer                      
,d.SaldoTotalBoleta                      
,d.MopBuro                     
,@EmpresaID                      
,d.FechaCorte  --init                      
,null --finish                      
,0 --Status                 
,@catPeriodo --Periodo id MENSUAL  o Semanal                  
,0 --CargaSiop                    
From  CuentaCte c                                               
Left Join personaactor b         On b.personaactorkey = c.ClienteId                                
Left Join EmpresaActor EA        On EA.ActorId = c.ClienteId                                
Inner Join CarteraCteFinaliza d  On c.CuentaCtekey = d.CuentaCteId                                
                                 And d.FechaCorte =cast(@UltimaFecha as date)    
Left Join ctasiopsofia s         On s.cuentacteID=c.cuentactekey                                
Left Join vwDatosActor da        On da.CuentaCtekey=c.CuentaCtekey                                
Where  b.TipoFiscal='M'                                                    
And c.EmpresaId = @EmpresaID    
and c.CuentaCtekey not in (select CuentaCteID from CtaSiopSofia where NoTraspaso = 5)       
Order By C.cuentactekey,[RazonSocial],d.DiasAtraso Desc              
end