 /*                          

 **************************SEMANAL*******************************            
 [SPSOFIA_GetReporteBuro_insertSemanal]            
 [SPSOFIA_GetReporteBuro_insertSemanal] 03,2013,1                          
 [SPSOFIA_GetReporteBuro_insertSemanal] 07,2016,1,2    
 se agrego si la información generada es mensual o no (semanal)                   
--Este store se manda llamar del store original SPSOFIA_GetReporteBuro_insert            
es para obtener los clientes finalizados semanalmente            
SOLO CAMBIA EL JOIN CON LA TABLA Carteracte Y SE USA EL CarteraCteFinaliza            
 */                          

ALTER procedure [SPSOFIA_GetReporteBuro_insertSemanal]                          
@mes AS integer,                          
@anio as integer,                          
@empresa AS SMALLINT,            
@periodo as integer
as                          
begin                          

--Variables para calcular la fecha siempre indicando el ultimo dia del mes-------------------                                                                                

declare @fechaCorte as date                                                                                
declare @UltimaFecha as varchar(20)                          
DECLARE @EMPRESA1 AS VARCHAR(20) = 'FINANC_PLANFIA'                          
DECLARE @EMPRESA2 AS VARCHAR(20) = 'PLANFIA'                                
set @fechaCorte =             
 ---Si es Mensual toma la ultima fecha de la tabla CarteraCte            
case when @periodo = 5 then            
 (select MAX(FechaCorte)                                     
 from CarteraCte with(nolock) where Ejercicio = @anio and Periodo = @mes)            
 else             
 (select MAX(FechaCorte)                                     
 from CarteraCteFinaliza with(nolock) where Ejercicio = @anio and Periodo = @mes )            
 end            
set @UltimaFecha = replace(convert(varchar(10),CAST(@fechaCorte as DATE),103),'/','')                                     

----------------------TABLA DONDE SE ALMACENAN LOS DATOS GENERADOS-----------                                  


----Valida que no exista la informacion en la tabla, de existir se eliminan los datos anteriores para insertar los nuevos                                


if cast(@fechaCorte as date) in (select distinct cast([init] as DATE) from ResultadosBuroCredito where EmpresaID = @empresa and PeriodoId = @periodo)                                         


begin                                        

update ResultadosBuroCredito set finish = dbo.SOFIAGETDATE(), status = 1 where cast([init] as date) =  cast(@fechaCorte as date)                                        

and EmpresaID = @empresa and periodoId = @periodo and status = 0 and finish is null                                      

end                                        

-------------Inserta los nuevos datos                                                 

insert into ResultadosBuroCredito (CuentaCtekey,[HD],[PN_Paterno],[00_Materno],[02_Nombre],[03_SegundoN],[04_fdn],[05_RFC],[11_EdoCivil],[12_Sexo],
[20_f_def],[21_Ind_Def],[PA_Calle],[00_Calle2],[01_Colonia],[02_Municipio],[03_Ciudad],[04_Estado],[05_Cp],[07_TelDom],[12_Origen del Domicilio],
[PE_Nombre o Razón Social del Empleador],[18_Origen de la Razón Social],[TL_cuentas],[01_Otorgante],[02_NomOtorga],[04_Cuenta],[05_Resposabilidad],
[06_TipoCta],[07_TipoContrato],[08_Moneda],[10_NumPagos],[11_FrecPagos],[12_monto],[13_DteApertura],[14_DteUltPago],[15_DteCompra],
[16_DteCierre],[17_DteReporte],[21_CredMaximo],[22_SdoActual],[23_LimCredito],[24_Saldovencido],[25_vencidas],[26_MOP],
[30_Observacion],[43_Fecha de Primer Incumplimiento],[44_Saldo Insoluto de Capital],[45_Monto del último pago],[46_Fecha de Ingreso a Cartera Vencida],
[47_Monto correspondiente a intereses],[48_Forma de Pago actual (MOP de los intereses)],[49_Días de Vencido],[50_Plazo en Meses],
[51_Monto del Crédito de Originación],[52_Correo Electrónico],[99_fin],[EmpresaID],[init],[finish],[status],[PeriodoId],[CargaSiop])                          

SELECT 
distinct CC.CuentaCtekey,                                                               

 dbo.trim(e.ClaveBC)HD,   --HD                                                             


 -------------------------------------------SEGMENTO DE NOMBRE----------------------------------------------------------------                                                                               


 dbo.TRIM(PA.ApPaterno)ApPaterno,--Apellido Paterno                                        



 dbo.TRIM(PA.ApMaterno)ApMaterno,--Apellido Materno                                                                  



 dbo.TRIM(PA.Nombre)Nombre, --Primer Nombre                                                                 



 CASE WHEN  PA.Nombre2 <>' ' THEN dbo.TRIM(PA.Nombre2) ELSE '' END Nombre2,--Segundo Nombre                                                                                              



 PA.FechaNacimiento,--Fecha de Naciminto                                                                                           



 dbo.Trim(PA.RFC)RFC, --Número de RFC                                                                                              



 CASE PA.EdoCivilId WHEN 1 THEN 'S'                                                                                                  



     WHEN 2 THEN 'M'                                                              



     WHEN 3 THEN 'F'                                        



     else 'D' END EdoCivilId, ---Estado Cicil                                        

 CASE PA.Sexo WHEN 'H' THEN 'M'                                                          

     WHEN 'M' THEN 'F' END Sexo,                                        

 ''Fecha_def,                                        

 ''Ind_Def,                                        

------------------------------------------SEGMENTO DE DIRECCION----------------------------------------------------------------------                                                                                                  

 dbo.trim(cast(dbo.TRIM(replace(replace(D1.Calle,'   ',' '),'  ',' '))+' '+                                                                                             

     CASE WHEN D1.Numext NOT LIKE '%MZ%'                                                                                                   

      THEN 'EXT '+ replace(DBO.fn_CambiaCaracter(ltrim(rtrim(D1.Numext))),'  ',' ')                                                                                       

      ELSE  rtrim(ltrim(DBO.fn_CambiaCaracter(replace(replace(D1.Numext,'   ',''),'  ',''))))                                        

                    END                                                   

     + CASE WHEN dbo.trim(D1.NumInt) = ' ' OR dbo.trim(D1.NumInt) IS NULL or dbo.trim(D1.NumInt) = '-'                                         

     THEN ''                                                        
                   ELSE                                                                 


       CASE WHEN dbo.trim(D1.NumInt) NOT LIKE 'LT%'                                             
      THEN ' INT ' + DBO.fn_CambiaCaracter(dbo.TRIM(D1.NumInt)) + ' '                                                                                              
       ELSE ' ' + DBO.fn_CambiaCaracter(dbo.TRIM(D1.NumInt))                                          
       END                                        
     END                                         
as varchar(40))) DireccionL1,  --maximo 40 caracteres                                        

 case when        

      len( dbo.trim(dbo.TRIM(replace(replace(D1.Calle,'   ',' '),'  ',' '))+' '+                                         

     CASE WHEN D1.Numext NOT LIKE '%MZ%'                                                                      

      THEN 'EXT '+ replace(DBO.fn_CambiaCaracter(ltrim(rtrim(D1.Numext))),'  ',' ')                                                        

      ELSE  rtrim(ltrim(DBO.fn_CambiaCaracter(replace(replace(D1.Numext,'   ',''),'  ',''))))                                   
  END                                                   
    + CASE WHEN dbo.trim(D1.NumInt) = ' ' OR dbo.trim(D1.NumInt) IS NULL or dbo.trim(D1.NumInt) = '-'                              

     THEN ''                                                        

ELSE                                                                                                                

       CASE WHEN dbo.trim(D1.NumInt) NOT LIKE 'LT%'                                                                                                   
      THEN ' INT '+ DBO.fn_CambiaCaracter(dbo.TRIM(D1.NumInt)) + ' '                                                                                              
      ELSE ' ' + DBO.fn_CambiaCaracter(dbo.TRIM(D1.NumInt))                                          
      END                                        
   END )) > 40                                         
     then   -----------SI ES MAYOR A 40                                                                       
       dbo.trim(substring(dbo.TRIM(replace(replace(D1.Calle,'   ',' '),'  ',' ')) + ' ' +                                                                                              
       CASE WHEN D1.Numext NOT LIKE '%MZ%'                                                                                                   
         THEN 'EXT '+ replace(DBO.fn_CambiaCaracter(ltrim(rtrim(D1.Numext))),'  ',' ')                                                                                                
        ELSE  rtrim(ltrim(DBO.fn_CambiaCaracter(replace(replace(D1.Numext,'   ',''),'  ',''))))                                        
       END +                                                                                                
       CASE WHEN D1.NumInt = ' ' OR D1.NumInt IS NULL or D1.NumInt = '-'                                                                                                    
       THEN ''                                        
        ELSE                                                                      
         CASE WHEN D1.NumInt NOT LIKE 'LT%'                                                                                                   
      THEN ' INT '+ dbo.TRIM(DBO.fn_CambiaCaracter(D1.NumInt))                                        
        ELSE ' '+ dbo.TRIM(DBO.fn_CambiaCaracter(D1.NumInt))                                        
        END                                                                                                  
       END,41,100))                                        
                   ELSE  ''   ------------------NO ES MAYOR A 40                                         
    end   Calle2,                                                   
 isnull(cast(replace(replace(dbo.TRIM(DBO.fn_CambiaCaracter(dbo.TRIM(D1.Colonia))),'(',''),')','') as varchar(40)),'')Colonia,--Colonia Población                                                         
 isnull(dbo.TRIM(DBO.fn_CambiaCaracter(cast(D1.DelMunicipio as varchar(40)))),'') Delegacion,--Delegacion Municipio                                                  
 '' Ciudad,                                          
 dbo.FNSOFIA_AbrevEstadoBC(D1.Estado)Estado,--Estado                                        
 dbo.fn_ChgFormatoNumero(D1.CP,5) CP,  ----Codigo Postal                                        
 '' telDomicilio,  
 'MX' OrigenDomi,--Origen de domicilio(agregado)   
Ea.RazonSocial,--Razon Social Empleador(agregado)
isnull(P.CatBuro,'MX')CatBuro,--Origen Razon Social(agregado)                                      
-------------------------------------------CRÉDITO--SEGMENTO DE CUENTAS----------------------------------------------------------------                                                                         
'TL' TlCuentas, --Etiqueta del Segmento                                        
 dbo.Trim(e.ClaveBC) ClaveBC,--Clave del otorgante                                 
dbo.TRIM(replace(e.NombreBC,' ','')) NombreUsuario,--Nombre del Usuario   EMPRESA                                        
case                                                       
    when  exists (select CuentaCteId from CtaSiopSofia with(nolock)where CuentaCteID = CC.CuentaCtekey)                                        
   then cast((select Grupo from CtaSiopSofia SS with(nolock) where SS.CuentaCteID = CC.CuentaCtekey)as varchar(5)) +                                         
  cast(replicate(0,3 - len((select integrante from CtaSiopSofia SS with(nolock) where SS.CuentaCteId = CC.CuentaCtekey)))AS varchar(3))                                        
 + cast((select integrante from CtaSiopSofia SS with(nolock) where SS.CuentaCteId = CC.CuentaCtekey)AS varchar(3))                                        
 else dbo.TRIM(CC.Cuenta) end  Cuenta,  ---Cuenta                                      
 dbo.TRIM('I') TipoesRponsabilidad,   --Indicador de Tipo de Responsabilidad                                        
 dbo.TRIM(PR.CBUP) TipoCuenta,       --Tipo de cuenta                                        
 PR.CBCDestino TipoContrato,    --Tipo Contrato                                        
 'MX' Moneda, --         --Clave de unidad monetaria                                        
CAST(PR.Duracion AS VARCHAR(3)) NumPagos,--Numero de Pagos                                        
 dbo.trim(PR.FrecuenciaBC)FrecuenciaPago,  -- Frecuencia de Pagos                                        
 -----------------MONTO A PAGAR-----------------                                          
 ---Modificado para que el monto de pago sea 0 si ya se liquido el credito                                                                    
case when                                         
 isnull(CAST( (CT.SaldoCapital + CT.SaldoInteres + CT.SaldoTotalCapital) AS INT),0)< = 0                                         
then                                                                  
 CAST(CAST(ROUND(0,0) AS INT) AS VARCHAR(10))                                        
 else                        
 CAST(CAST(ROUND(CC.ImportePago + dbo.fnsofia_getSeguroBuroMonto (CC.CuentaCtekey,@mes,@anio),0) AS INT) AS VARCHAR(10)) --Monto a Pagar                                       
end    MontoAPagar,                                                   
   --******************* Fecha de Apertura de la Cuenta                                                                   
case when exists (select CuentaCteId from CtaSiopSofia with(nolock)where CuentaCteID = CC.CuentaCtekey) then                                          
 cast(CC.FechaImpContrato AS date)                                        
else           
 cast(PR.FechaAlta as date)                                        
 end  FechaApertura,                                        
case when CT.UltimaFechaPago = '01/01/1900'                                          
 then                                         
cast(PR.FechaAlta As date)                                        
 else                                         
 cast(CT.UltimaFechaPago as date)                                        
 end   FechaUltimoPago,                                                         
    --******************* --Fecha ultima Compra DISPOSICION********************--     2013/12/09      ----Se cambio a la fecha de inicio del credito                                                                    
  case when exists (select CuentaCteId from CtaSiopSofia with(nolock)where CuentaCteID = CC.CuentaCtekey) then                                          
 cast(CC.FechaImpContrato AS date)                                        
 else                                                                                  
  cast(PR.FechaAlta as date)                                        
 end  FechaCompra,           
 case when isnull(CAST((CT.SaldoCapital + CT.SaldoInteres + CT.SaldoTotalCapital) AS INT),0) <= 0                                          
  then                                         
 CAST( CT.UltimaFechaPago as date)                                        
  else ''                                                                    
  end  FechaCierre,                                        
 --******************* Fecha de Reporte   ********************--                                                                                         
 cast(@fechaCorte as date) FechaReporte,                                        
--*******************   Credito Maximo  ********************--                                                                        
CAST(CAST(ROUND(CC.Saldo,0) AS INT) AS VARCHAR(10)) CreditoMaximo,                                        
--******************* SALDO ACTUAL-------------                                          
case when isnull(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT) ,0) >    --Saldo Vencido                                                                                        
 isnull(CAST( CT.SaldoCapital + CT.SaldoInteres + CT.SaldoTotalCapital AS INT),0)     ----------Saldo Actual                                    
 then                                 
 isnull(CAST(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT) AS VARCHAR(10)),0)                                     
 else                                        
 isnull(CAST(CAST( CT.SaldoCapital + CT.SaldoInteres + CT.SaldoTotalCapital AS INT) AS VARCHAR(10)),0)                                         
  end SaldoActual, --Saldo Actual                                        
'' LimiteCredito,                                                
--******************* SALDO VENCIDO-------------                                                                              
 isnull(CAST(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT) AS VARCHAR(10)),0) SaldoVencido,                                             
--******************* --Número de Pagos Vencidos *****************                                                                                                                             
CASE WHEN isnull( CAST( CT.SaldoCapital + CT.SaldoInteres AS INT),0)>0   --SALDO VENCIDO                                        
 THEN   ---si las boletas vencida son 0 entonces pone 1 ya que el saldo vencido es mayor a 0, si las boletas vencidas son diferentes a 0 pone las boletas reales                                        
 case when  CAST(CT.BoletasVencidas AS VARCHAR(10)) < = 0 then 1 else  CAST(CT.BoletasVencidas AS VARCHAR(10)) end                                        
 ELSE '' END  BoletasVencidas,                                        
case when                                         
 isnull(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT),0) > 0  --SALDO VENCIDO                                          
  then  dbo.TRIM(CT.MopBuro)                                          
  else             
  case when   CC.Cuentactekey in (select cuentactekey             
         from ClinetesAgregadosCarteracte             
         where cast(fechacorte as date) =  cast(@fechaCorte as date)             
          and tipoFiscal = 'F' and empresaid = @empresa )              
   then '00' else '01' end                                     
  end  MOP,                                        
+ case when isnull(CAST(CT.SaldoTotalCapital + CT.SaldoCapital + CT.SaldoInteres AS INT),0) <= 0                                     
  then --Clave de Observacion                                                    
  'CC'                                        
 else ''                                        
end Observacion,  
case when isnull(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT),0) > 0                                             
	then  
		(select max(UltimaFechaPago) from CarteraCte where CuentaCteId=cc.CuentaCtekey and BoletasVencidas=0 )                                             
	else 
	'01/01/1900'
 end FechaIncumplimiento, --fecha de primer incumplimiento(agregado)      
 ct.SaldoCapital,--Saldo insoluto de capital(agregado)        
 0.0 UltimoPago,--isnull(dbo.FNSOFIA_GetUltimoPago(CC.CuentaCtekey),0) UltimoPago,--monto ultimo pago (agregado)      
 case when isnull(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT),0) > 0                                             
	then  
		(select max(UltimaFechaPago) from CarteraCte where CuentaCteId=cc.CuentaCtekey and BoletasVencidas=0 )                                             
	else 
	'01/01/1900'
 end FechaIngresoVencida,--fechaingresocartera(agregado)
 ct.SaldoInteres,--saldointeres(agregado)
 case when                                             
isnull(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT),0) > 0  --SALDO VENCIDO                                              
then  dbo.TRIM(CT.MopBuro)                                              
else                 
----------si es de los clientes agregados entonces pone mop 00                
case when   CC.Cuentactekey in (select cuentactekey                 
from ClinetesAgregadosCarteracte                 
 where cast(fechacorte as date) =  cast(@fechaCorte as date)                 
 and tipoFiscal = 'F' and empresaid = @empresa )                  
 then '00' else '01' end                                         
end  MOPIntereses,--mopintereses(agregado)  
ct.DiasAtraso,--diasatraso(agregado)
dbo.FNSOFIA_GetPeriodoPlazo (cc.NumPagos,cc.PeriodoPagoId,5) Plazo,--plazo(agregado)
cc.Importe MontoCredito,--monto(agregado)
 isnull(PA.EmailDomicialicion,'') email, --mail(agregado)                                      
 '99'Fin,                                        
 @empresa,                                        
 @fechaCorte init,                                        
 null finish,                                        
 0 status,                          
 @periodo,
 0                           
from CuentaCte CC  
inner join vwEmpleoActor Ea on Ea.CuentaCteKey=CC.CuentaCtekey 
inner join CP cp on cp.CP=EA.CP
inner join EdoPais Ep on Ep.EdoPAisKey=cp.EdoPaisId
inner join Pais P on P.PaisKey=Ep.PaisId                                        
join Cliente Cl on Cl.ClienteKey = CC.ClienteId                                        
join lgrActor A on A.actorKey = CL.ActorId                                        
join vwPersonaActor PA on PA.ActorId = CL.ActorId                             
join Empresa e on e.empresakey = CC.empresaid                         
join vwProducto PR on PR.CuentaCtekey = CC.CuentaCtekey                          
join CarteraCteFinaliza CT on CT.CuentaCteId = CC.CuentaCtekey and cast(CT.FechaCorte as date) =  cast(@fechaCorte as date)                          
OUTER APPLY                           
(                             
   SELECT TOP 1 *                          
          FROM DireccionActor  WITH (nolock)                                           
          WHERE ActorId = isnull(CL.ActorId,0) and finish is null                          
          AND AddressTypeId <> case when EXISTS (select 1 from DireccionActor with(nolock) where AddressTypeId=1 AND ActorId=CL.ActorId AND finish is null)                          
  then  10 ELSE  1 END                          
   ORDER BY AddressTypeId asc)  D1        
where CC.EmpresaId = @empresa                           
and PA.TipoFiscal = 'F'           
and isnull(CT.DiasAtraso,0) <= 2190 --solo los que tengan menos de estos días de atraso  
and CC.Cuentactekey not in (select CuentaCteID from CtaSiopSofia where NoTraspaso = 5)
order by 1                           

end                           



                           
