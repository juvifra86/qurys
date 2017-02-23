 /*                                
  **************************MENSUAL*******************************                              
 [SPSOFIA_GetReporteBuro_insert]                                          
 [SPSOFIA_GetReporteBuro_insert] 11,2013,1,5                                            
 [SPSOFIA_GetReporteBuro_insert0501] 12,2016,2,5                                  
 se agrego si la información generada es mensual o no (semanal)                                     
 */                                            
ALTER procedure [SPSOFIA_GetReporteBuro_insert0501]                                            
@mes AS integer,                                            
@anio as integer,                                            
@empresa AS SMALLINT,                              
@periodo as integer -- 5 Mensual por defecto  (info de la tabla periodo)                                            
      --2 para semanal                              
as                                            
begin                                            
--Variables para calcular la fecha siempre indicando el ultimo dia del mes-------------------                                                                                                  
declare @fechaCorte as date                                                                                                  
declare @UltimaFecha as varchar(20)                                            
DECLARE @EMPRESA1 AS VARCHAR(20) = 'FINANC_PLANFIA'                                            
DECLARE @EMPRESA2 AS VARCHAR(20) = 'PLANFIA'                                                  
set @fechaCorte =                               
--Si es Mensual toma la ultima fecha de la tabla CarteraCte                              
case when @periodo = 5 then                              
 (select MAX(FechaCorte)                                                       
  from CarteraCte with(nolock) where Ejercicio = @anio and Periodo = @mes)                              
 ---Si es semanal toma la ultima fecha de la tabla CarteraCteFinaliza                              
else                               
 (select MAX(FechaCorte)                                                       
 from CarteraCteFinaliza with(nolock) where Ejercicio = @anio and Periodo = @mes )                              
end                              
set @UltimaFecha = replace(convert(varchar(10),CAST(@fechaCorte as DATE),103),'/','')                            
----------------------------------Se agregan las cuentas con contratos nuevos a la tabla cartera Cte para que tambien se manden                
--if @periodo = 5              
--begin                            
-- exec SpSofia_InsertaClientesCartera @fechaCorte,@empresa     --------------ESTE PROCEDIMIENTO TAMBIEN ESTA EN [SPSOFIA_getdatosPM_Insert]                    
--end                             
----------------------TABLA DONDE SE ALMACENAN LOS DATOS GENERADOS-----------                                      
----Valida que no exista la informacion en la tabla, de existir se eliminan los datos anteriores para insertar los nuevos                      
--if cast(@fechaCorte as date) in (select distinct cast([init] as DATE) from ResultadosBuroCredito where EmpresaID = @empresa and PeriodoId = @periodo and CargaSiop=0)                                    
--begin                                            
--update	ResultadosBuroCredito set finish = dbo.SOFIAGETDATE(), status = 1 where cast([init] as date) =  cast(@fechaCorte as date)                 
--and EmpresaID = @empresa and periodoId = @periodo and status = 0 and CargaSiop = 0 and finish is null                
--end                                            
if @periodo = 5  --MENSUAL                              
begin                                            
insert into ResultadosBuroCredito                               
SELECT distinct CC.CuentaCtekey,                                                                                                  
'MI31820001' HD,   --HD                                                                 
 -------------------------------------------SEGMENTO DE NOMBRE----------------------------------------------------------------                                                                                                       
case when replace(dbo.TRIM(PA.ApPaterno),'.','') = '' then dbo.TRIM(PA.ApMaterno) else replace(dbo.TRIM(PA.ApPaterno),'.','') end  ApPaterno,--Apellido Paterno                                            
case when replace(dbo.TRIM(PA.ApPaterno),'.','') = '' then 'NO PROPORCIONADO' else dbo.TRIM(PA.ApMaterno) end ApMaterno,--Apellido Materno                                                                                                  
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
-------------------------------------------CRÉDITO--SEGMENTO DE CUENTAS----------------------------------------------------------------                                                                             
 'TL' TlCuentas, --Etiqueta del Segmento                                            
 'MI31820001' ClaveBC,--Clave del otorgante                                     
 'FINANC_PLANFIA' NombreUsuario,--Nombre del Usuario   EMPRESA                                            
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
 --*******************   --Fecha ultimo Pago ********************--                                                                                                    
 case when CT.UltimaFechaPago = '01/01/1900'                                              
 then                                             
 cast(PR.FechaAlta As date)                                            
 else                                             
cast(CT.UltimaFechaPago as date)                                            
 end   FechaUltimoPago,                                                             
 case when exists (select CuentaCteId from CtaSiopSofia with(nolock)where CuentaCteID = CC.CuentaCtekey) then                                              
cast(CC.FechaImpContrato AS date)                                            
else                                                                  
 cast(PR.FechaAlta as date)                                            
 end FechaCompra,          
--------------------------------------si ya no debe nada pone la fecha de cierre                                              
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
--cuando el SALDOVENCIDO es mayor al saldo actual pone el vencido                                            
case when isnull(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT) ,0) >    --Saldo Vencido                                                                                            
 isnull(CAST( CT.SaldoCapital + CT.SaldoInteres + CT.SaldoTotalCapital AS INT),0)     ----------Saldo Actual                                        
 then                                     
 isnull(CAST(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT) AS VARCHAR(10)),0)                                         
 else                                            
 isnull(CAST(CAST( CT.SaldoCapital + CT.SaldoInteres + CT.SaldoTotalCapital AS INT) AS VARCHAR(10)),0)                                             
 end SaldoActual, --Saldo Actual                                            
'' LimiteCredito,                                                    
--******************* SALDO VENCIDO-------------                                                                                  
 -------solo lo que debe del periodo-------                                              
 isnull(CAST(CAST( CT.SaldoCapital + CT.SaldoInteres AS INT) AS VARCHAR(10)),0) SaldoVencido,                                                 
--******************* --Número de Pagos Vencidos *****************                                                                                                                                 
CASE WHEN isnull( CAST( CT.SaldoCapital + CT.SaldoInteres AS INT),0)>0   --SALDO VENCIDO                                            
  THEN   ---si las boletas vencida son 0 entonces pone 1 ya que el saldo vencido es mayor a 0, si las boletas vencidas son diferentes a 0 pone las boletas reales                                            
  case when  CAST(CT.BoletasVencidas AS VARCHAR(10)) < = 0 then 1 else  CAST(CT.BoletasVencidas AS VARCHAR(10)) end                                            
  ELSE '' END  BoletasVencidas,                                            
-------------------------Cuando no debe nada, se manda el mop en 01   ---else                                              
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
  end  MOP,                                            
----------------------------------------------------Clave de Observacion------------------------------------------------------------------------------------------------                                                                                     
-----------cuando el saldo total y el saldo vencido actual es < = 0 entonces si lo pone como finalizado                                              
+ case when isnull(CAST(CT.SaldoTotalCapital + CT.SaldoCapital + CT.SaldoInteres AS INT),0) <= 0                                         
  then --Clave de Observacion                              
  'CC'                                            
 else ''                                            
end Observacion,                                            
'99'Fin,                                            
 1	,                                            
 @fechaCorte init,                                            
 null finish,                              
 0 status,                              
 @periodo,
 0                               
from CuentaCte CC                                            
join vwcuenta vc on vc.CuentaCtekey =cc.CuentaCtekey                                          
join lgrActor A on A.actorKey = vc.ClienteId                                            
join PersonaActor PA on PA.ActorId = vc.ClienteId                                 
join Empresa e on e.empresakey = CC.empresaid                                   
------------SEGMENTO CUENTAS------                                            
join vwProducto PR on PR.CuentaCtekey = CC.CuentaCtekey                                            
join CarteraCte CT on CT.CuentaCteId = CC.CuentaCtekey and cast(CT.FechaCorte as date) =  cast(@fechaCorte as date)                                            
OUTER APPLY                            
(                                               
 SELECT TOP 1 *                                            
  FROM DireccionActor  WITH (nolock)                                                                                            
  WHERE ActorId = isnull(vc.ClienteId,0) and finish is null                                            
  AND AddressTypeId <> case when EXISTS (select 1 from DireccionActor with(nolock) where AddressTypeId=1 AND ActorId=vc.ClienteId AND finish is null)                                            
 then  10 ELSE  1 END                                       
 ORDER BY AddressTypeId asc)  D1                                              
where CC.EmpresaId = @empresa                                             
and PA.TipoFiscal = 'F'              
and isnull(CT.DiasAtraso,0) <= 2190 --solo los que tengan menos de estos días de atraso        
and CC.Cuentactekey not in (select CuentaCteId from CarteraCteFinaliza)                              
and CC.Cuentactekey not in (select CuentaCteID from CtaSiopSofia where NoTraspaso = 5)  
and CC.Cuentactekey in(13945,10487,10959,11935,10255,13839,15190,15024,15180,14637,10808,13805,15141,
	13856,13880,13930,10296,15192,11553,13863,14618,14608,11754,12759,10472,12738,13887,11319,11323,12705,
	13788,12442,15040,11208,15177,11757,14630,11486,12608,10375)
order by 1                                             
End ----------IF Inserta Datos                              
else                              
begin                              
exec [SPSOFIA_GetReporteBuro_insertSemanal] @mes,@anio,@Empresa,@periodo                              
end                              
-----------------------Revisa que no se hayan mandado como finalizados en el mes anterior, si es asi los elimina de los resultados                    
--update ResultadosBuroCredito set finish = dbo.sofiaGetDate(),status = 1                    
--where EmpresaID = @empresa                    
--and cast(init as date) = cast(@fechaCorte as date)                    
--and periodoId = @periodo and CargaSiop=0             
--and CuentaCtekey in                     
--(select CuentaCtekey from ResultadosBuroCredito where EmpresaID = @empresa                     
--              and  [30_Observacion] in('CC','CA','CV') ---terminado                    
-- and cast(init as date) < cast(@fechaCorte as date) ) --la fecha de corte sea menor a la fecha de corte actual                                
end                                             