/*                                                                  
                                                              
 Creo  : EZM                                                               
 Fecha : 14/04/2012                                                    
 Desc  : Procedimiento para Obtenet la Domiciliacion de Pagos a una Fecha BANAMEX                                                    
                               
                               
 modif MMG 20121101                              
 se agrega la condicion de boletas no nulas a la seleccion de detalles donde borra las de importe cero   
                            
                    
----------------------------------------Cambio de Bursatilizacion                    
 MOD: 21/08/2014                    
  EZM ... se agrego el campo de bursatil.                    
        
 MOD: 12/01/2015                    
  EZM ... se cambio la funcion que obtiene el monto del cargo 

 MOD: 10/10/2015
  JVFM ...se modifico la consulta para generar archivos diferentes para cuentas sin bursatilizar, bursatilizado 1 y bursatilizado 2

 	                                                      
 MOD: 16/10/2015
  JVFM ...se agrego la funcion FNSOFIA_RutaServidorDomi para identificar las carpetas de generacion de archivos segun empresa,y bursatilizacion
                                                               
   Sintaxis                                                               
                                                              
		                             
	exec  [SPSOFIA_GetDomiciliacionBanamex]'20150820',3,2,'20150831',1,'DomiBanamexprueba.dom',01,1,0
	exec  [SPSOFIA_GetDomiciliacionBanamex]'20150827',3,2,'20150831',1,'DomiBanamexpruebabursa2.dom',01,1,2                             
                             

                                                                  
    */                                                                  
                                                                      
CREATE PROCEDURE [dbo].[SPSOFIA_GetDomiciliacionBanamex1811] (                                                              
@FechaDomiciliacion As date,                                                              
@CicloCorte as integer,                                                              
@empresa as integer,                                                              
@FechaGeneracion as date,                                                              
@TipoProd as integer,                                                    
----Encabezado----                                                    
@nombreArchivo varchar(300),                                                    
@NumeroSecuencia as varchar(2) ,                                              
                                              
@aplicaDescuento as bit,                    
@nobursatil as int = 0                                                            
)                                                                    
AS                                                                
                                                                                        
BEGIN                                                                  
SET DATEFORMAT DMY                                                              
Declare @FechaDomiciliacion1 as Date                                                              
declare @SigDiahabil as date     
declare @bursatil as bit=@nobursatil  
                
if @CicloCorte <> 3                         
begin                        
set @SigDiahabil = dbo.FnSofia_GetDiaHabil(@FechaDomiciliacion)                                                              
end                        
else-----------Cuenado es semanal se les deja la fecha calculada aunque sea inhabil                        
begin                        
set @SigDiahabil = @FechaDomiciliacion                        
end                        
                        
declare @rows as integer            
declare @detalles as integer                                                               
Set @FechaDomiciliacion1  =  cast(@SigDiahabil as date)                                  
                                
declare @Tipoprod2 as integer                       
declare @Tipoprod3 as integer                                  
declare @Tipoprod4 as integer       
    
declare @VariableRuta as varchar(500),    
@nombreArchivoSinEspacios varchar(8000) = replace(@nombreArchivo,' ','')                                  
              
set @TipoProd2 = 0                       
set @Tipoprod3 = 0                    
set @Tipoprod4 = 0              
                             
                                
if @TipoProd = 1 begin                                 
   set @Tipoprod2 = 6  ---Balloon                
   set @Tipoprod3 = 7   ----8/60                             
   set @Tipoprod4 = 8   ----Seminuevos                             
end                             
                                                              
---Fecha de transeferencia es un dia habil siguiente despues de la fecha de cargo                                                               
Declare @fechaTransferencia as date                                                              
set @fechaTransferencia = @FechaDomiciliacion                                        
set @fechaTransferencia = dbo.FnSofia_GetDiaHabil(@fechaTransferencia)                  
set @fechaTransferencia = cast(@fechaTransferencia as datetime) +1                                                          
set @fechaTransferencia  =  dbo.FnSofia_GetDiaHabil(@fechaTransferencia)                                                         
                          
Declare @LeyendaReferencia As varchar(40),                                                               
        @CuentaEmpresa Nvarchar(10),                                                        
        @NombreComercial Varchar(40),                                                              
        @RFC Varchar(18)                                                           
                                                              
Set @LeyendaReferencia = 'Domiciliacion Boleta'                                                              
                                                   
----------------------------Datos De la Empresa-------------------------------------------------------------------------                                                              
declare @numcliente varchar(25)
Declare @datosEmpresa Table  (CuentaCteId bigint,                                                              
        numCuenta varchar(20),                                                              
        nomComercial varchar(40),                                                              
        rfc varchar(20),                                                    
        NumCliente varchar(20))  
		--comentado por problemas con banamex
		--if @nobursatil=2
		--	begin
		--		select @numcliente=NumCliente from CuentaBanco where NumCuenta='70078425723'  --Numero de cliente de bursatilizados numero 2
		--	end    
		--else 
			begin
				--set @numcliente=(select NumCliente from FNSOFIA_GETDATOSEMPRESA(@empresa,4,@bursatil)) 
				set @numcliente=(select NumCliente from FNSOFIA_GETDATOSEMPRESA(@empresa,4,0))     
			end                                                        
                                                                  
--insert into @datosEmpresa                                           
                   
--Select BCC.CuentaCteId,                                                              
--(select numCuenta from FNSOFIA_GETDATOSEMPRESA(DC.EmpresaId,4,@bursatil)),    
--(select replace(replace(EmpresaDsc,'.',' '),',',' ') from FNSOFIA_GETDATOSEMPRESA(DC.EmpresaId,4,@bursatil)),                   
--(select rfc from FNSOFIA_GETDATOSEMPRESA(DC.EmpresaId,4,@bursatil)), 
--@numcliente 
----(select NumCliente from FNSOFIA_GETDATOSEMPRESA(DC.EmpresaId,4,@bursatil))                                                              
--from BancoCargoCuenta BCC                                                              
--join vwDatosCredito DC on DC.cuentaCteKey = BCC.CuentaCteId and DC.PlanKey <> 4                                                               
--join CuentaCte CC on CC.CuentaCtekey = BCC.CuentaCteId           
          
--------------------------------------Se agrego para saber si realmente es bursatilizado para tomar cuentas bursatilizadas          
--join vwCuentasBursaDomi cb on cb.CuentaCtekey = CC.CuentaCtekey          
                                                             
--join Producto P on P.ProductoKey = CC.ProductoId                                                    
--join TipoProd TP on TP.TipoProdKey = p.TipoProdId                                         
--where BCC.FormaPagoID = 8                     
-- and DC.EmpresaId = @empresa             
-- and TP.TipoProdKey in(@TipoProd, @Tipoprod2,@Tipoprod3,@Tipoprod4)                                
-- and BCC.Finish is null                     
-- and BCC.Status = 0                     
-- and BCC.CicloCorteId  = @CicloCorte                                  
-- and BCC.TipoProductoId <> 2  --AHORRO                                  
-- --and isnull(CC.Bursatil,0) = @bursatil                     
--  and cb.BursatilDomi = @bursatil           
-- --and CC.Situacion in(12,33,34,39,72,73,223)        
-- and CC.Situacion in(select estadopokey from vwEstatusCuentaDomicilaicion)                   
                                                 
--                                                      --------------------------------------------------------------------------------------------------                                                            
-----------------------------------------------ENCABEZADO-------------------------------------------                                                            
----------------------------------------------------------------------------------------------------                                                            
                                                    
-- declare @TblEncabezado TABLE (Encabezado  Varchar (max))                                                       
-- declare  @dia as integer                                                      
-- set @dia = DAY(@FechaGeneracion)                                                
                      
   
                                                            
                                                           
----------------------------------------------------------------------------------------------------                                                            
-----------------------------------------------DETALLES---------------------------------------------                                                            
----------------------------------------------------------------------------------------------------                                                              
                                                             
--    --   exec  [SPSOFIA_GetDomiciliacionBanamex]'20120402',1,1,'20120402',1,1                                                    
                                   
Declare @TblPrueba  Table  (CuentaCteId bigint,                                              
        Importe  Decimal(20,2),                                                              
        Iva  Decimal(20,2),                                                              
        FechaVencimiento Date,                                             
        Boleta integer)                                                      
                                         
				Insert Into @TblPrueba                                                         
				Select BCC.CuentaCteId,    
					  (select importe from dbo.[FnSofia_GetPagoDomi](BCC.CuentaCteId,@SigDiahabil,@FechaGeneracion,@aplicaDescuento)) [importe],                                                              
					  (select importe from dbo.[FnSofia_GetPagoDomi](BCC.CuentaCteId,@SigDiahabil,@FechaGeneracion,@aplicaDescuento)) * dbo.FNSofia_GetIva() [Iva],                                                              
					  (select @SigDiahabil)[FechaVencimiento],                                                    
					  (select boleta from dbo.[FnSofia_GetPagoDomi](BCC.CuentaCteId,@SigDiahabil,@FechaGeneracion,@aplicaDescuento)) [boleta]                                                    
				From BancoCargoCuenta BCC               
				join CuentaCte CC on CC.CuentaCtekey = BCC.CuentaCteId           
          
				------------------------------------Se agrego para saber si realmente es bursatilizado para tomar cuentas bursatilizadas          
				join vwCuentasBursaDomi cb on cb.CuentaCtekey = CC.CuentaCtekey          
                                      
				join Producto P on P.ProductoKey = CC.ProductoId                                                              
				join TipoProd TP on TP.TipoProdKey = P.TipoProdId                            
				where BCC.FormaPagoID = 8                     
				  and BCC.Finish is null                                                     
				  and BCC.Status = 0                     
				  and BCC.CicloCorteId = @CicloCorte                                                     
				  and TP.TipoProdKey in( @TipoProd,@tipoprod2,@Tipoprod3,@Tipoprod4)                     
				  and CC.EmpresaId = @empresa                                                      
				  --and CC.Situacion in(12,33,34,39,72,73,223)        
				  and CC.Situacion in(select estadopokey from vwEstatusCuentaDomicilaicion)                     
				  and BCC.TipoProductoId <> 2  --AHORRO                                  
				  and cb.Bursatil = @bursatil                    
				  --and cb.BursatilDomi = @bursatil
				  AND cb.NoBursatil=@nobursatil       
				  order by bcc.CuentaCteId           
			             
--select * from @TblPrueba                                                    
delete from @TblPrueba where Importe < = 0.1  or boleta is null           
select * from @TblPrueba                           
                                               
---Cuenta los clientes que se van a mandar                                                              
--set @rows = (select count (*) from @TblPrueba)                                                       
 
-- if @rows>0 
--	begin
--				Insert Into @TblEncabezado                                                        
--		Select '01' --Tipo de Registro                                                        
--			   + '0000001' --No Secuencia                                                
--			   + '30'  --Codigo Operacion                                                        
--			   + '002' --Banco Participante                                                        
--			   + 'E'   --Sentido                                                        
--			   + '2'   --Servicio                                                        
--			   + dbo.fn_ChgFormatoNumero(@dia,2)+ REPLICATE('0',5 - len(@NumeroSecuencia)) + cast(@NumeroSecuencia as varchar) ---Numero de Bloque                                                       
--			   + Convert(Varchar(8), @FechaGeneracion, 112)  --Fecha de Presentación                                            
--			   + '01' --Codigo Divisa                                                        
--			   + '00' --Causa Rechazo                                                    
--			   + replicate (char(32),25)  --Uso Futuro                                                    
--			   + ltrim(rtrim((select top 1 nomComercial from @datosEmpresa)))+ replicate (char(32),40 - len((select top 1 nomComercial from @datosEmpresa))) --Razon Social                                                        
--			   + ltrim(rtrim((select top 1 rfc from @datosEmpresa)))+replicate (char(32),18 - len((select top 1 rfc from @datosEmpresa)))  --RFC                                                        
--			   + replicate (char(32),182)  --Uso Futuro                                                    
--			   + replicate ('0',12 - len ((select top 1 NumCliente from @datosEmpresa))) + LTRIM(rtrim((select top 1 NumCliente from @datosEmpresa))) --Numero de Cliente                                 
--			   + @NumeroSecuencia --Secuencia del Archivo                                                    
--			   + REPLICATE(CHAR(32),86) --Uso Futuro                                                      
                                                
--	end
                                                              
------------------------------Tabla DETALLES----------------------------------------------------------------------------                                             
--Declare @TblCadenaDetalle  Table  (Detalles Varchar(MAX))                              
                                                              
                                                              
                                                
----where BCC.FormaPagoID = 8 and DC.EmpresaId = @empresa and TP.TipoProdKey = @TipoProd                                                   
----and BCC.Finish is null and BCC.Status = 0                                                              
                                                              
------------------------------Detalle-------------------------------------------------------------------------------------------                                                              
--Insert @TblCadenaDetalle                                                              
--   Select     '02' --Tipo de Registro                                  
--             + Replicate('0',7-LEN(LTRIM(CAST((ROW_NUMBER()OVER(order by CC.status desc))+ 1  AS NVARCHAR))))+LTRIM(CAST((ROW_NUMBER()OVER(order by CC.status desc))+ 1 AS NVARCHAR))---Número de Secuencia                                                   





 
--             +'30' --Código de Operación                                                              
--             +'01' --Código de Divisa                                                    
--             --+ Replace(Convert(Varchar(15), REPLICATE('0',15-LEN(LTRIM(CAST(TP.Importe AS NVARCHAR))))+LTRIM(CAST(TP.Importe  AS NVARCHAR)),6),'.','') --Importe de la Operacion ---Quita Punto decimal y Aumenta 0 a la Izquierda                           





 
    
      
         
--             + Replace( REPLICATE('0',15-LEN(LTRIM(CAST(replace(TP.Importe,'.','') AS NVARCHAR))))+LTRIM(CAST(TP.Importe  AS NVARCHAR)),'.','')--Importe de la Operacion ---Quita Punto decimal y Aumenta 0 a la Izquierda                                     





  
    
      
        
--             + Convert(Varchar(8), @FechaGeneracion, 112) --Fecha Liquidacion                                                             
--             + REPLICATE('0',6) --Contador Reintento                                                    
--             + REPLICATE (Char(32),18)--Uso Futuro                                                    
--             + '51' --Tipo de Operacion                                                     
--             + Convert(Varchar(8), @FechaGeneracion, 112) --Fecha de Vencimiento                                                    
--             + isnull((Select CveHSBC from Banco where BancoKey = BA.BancoId),'021') --'021' --BancoReceptor                                                    
--             + (select case BA.FormatoCuentaid              
--      when 1 then '01'  
--      when 2 then '03'                           
--      when 3 then '40'               
--      else '03' --Se manda por default que sea el numero de targeta ya que en ocasiones no se captura                                                                          
--             end)--Tipo Cuenta del Cliente Usuario                                                    
--             + Replicate('0',20-LEN(LTRIM(CAST(BCC.NumCuenta AS NVARCHAR))))+LTRIM(CAST(BCC.NumCuenta AS NVARCHAR))  ---Numero de Cuenta del Cliente Usuario (tarjeta de credito)                                                
                                                       
--             + UPPER(replace(replace(replace(replace(RTRIM(LTRIM(isnull(CAST(DBO.fn_CambiaCaracter(BA.Titular) AS VARCHAR(40)),CAST(DBO.fn_CambiaCaracter(PA.NombreCompleto) AS VARCHAR(40))))),'ñ','n'),'Ñ','N'),'.',''),'  ',' ')                           




 


              
--             + Replicate(CHAR(32),40 - LEN(ltrim(rtrim(replace(replace(replace(replace(RTRIM(LTRIM(isnull(ltrim(rtrim(CAST(DBO.fn_CambiaCaracter(BA.Titular) AS VARCHAR(40)))),CAST(DBO.fn_CambiaCaracter(PA.NombreCompleto) AS VARCHAR(40))))),'ñ','n'),'Ñ','N





--'),'.',''),'  ',' '))))))  --Nombredel ClienteUsuario                  
          
                          
--             + LTRIM(CAST(CC.CuentaCtekey AS VARCHAR)) + Replicate(CHAR(32),40-LEN(LTRIM(CAST(CC.CuentaCtekey AS VARCHAR))))--Referencia del servicio con el emisor(num de cuenta Referencia CuentaCte)                      

  
    
      
--             + replace(replace(replace(replace(rtrim(LTRIM(CAST(DBO.fn_CambiaCaracter(PA.NombreCompleto) AS VARCHAR(40)))),'ñ','n'),'Ñ','N'),'.',''),'  ',' ') + Replicate(CHAR(32),40- LEN(replace(replace(replace(replace(rtrim(LTRIM(CAST(DBO.fn_CambiaCaracter(PA.NombreCompleto) AS VARCHAR(40)))),'ñ','n'),'Ñ','N'),'.',''),'  ',' ')))--Nombre del titular del servicio        
--             + Replace( Replicate('0',15 -LEN(LTRIM(CAST(replace(TP.Iva ,'.','') AS NVARCHAR))))+LTRIM(CAST(TP.Iva AS NVARCHAR)),'.','') --Importe del IVA de la Operación                                                    
--             + REPLICATE ('0',7) --Referencia Numerica del Emisor                                                    
                                                                 
----Se agrega la boleta para saber a que amortizacion se le hizo el cargo                                                    
--             -------------------------------------------------------------------------                                                   
--             + LTRIM(CAST(@LeyendaReferencia AS VARCHAR)) + Replicate(CHAR(32),21 - LEN(LTRIM(CAST(@LeyendaReferencia AS VARCHAR))))   --Leyenda del Emisor                                                    
--             + cast(tp.Boleta as varchar) + REPLICATE(CHAR(32),18 - LEN(cast(tp.Boleta as varchar)))                                
--             + cast(@aplicaDescuento as varchar) + REPLICATE(char(32),1 - LEN(cast(@aplicaDescuento as varchar)))                                                   
--             -------------------------------------------------------------------------                                                    
                                                     
--             + '00'--Motivo Devolucion                                                    
--             + REPLICATE (Char(32),21)--Uso Futuro                                                    
--             + '00' --Digito Verificador                                                    
--             + '00' --Numero de corte                                                    
--             + '1' --Indicador de Pago                                                    
--             + REPLICATE('0',6) --Autorización del Banco                                                    
--             + Convert(Varchar(8), @FechaGeneracion, 112) --fecha de aplicacion                                 
--         + REPLICATE('0',2-LEN(LTRIM(CAST(@NumeroSecuencia AS NVARCHAR))))+LTRIM(CAST(@NumeroSecuencia AS NVARCHAR)) -- Secuencia Original                                            
--             + REPLICATE (Char(32),20)--Referencia 1                                                    
--             + REPLICATE (Char(32),20)--Referencia 2                                                    
--             + REPLICATE (Char(32),20)--Referencia 3                                                    
--             + REPLICATE (Char(32),19)--Uso Futuro                                                    
                                      
--          --   + '021' --BancoPresentador                                                              
                                                                      
--          --   + '01'-----Tipo de Cuenta Originador                                                               
--          --   + Replicate('0',20-LEN(LTRIM((DE.numCuenta))))+ LTRIM(DE.numCuenta)--numero de cuenta del originador                                                              
--          --   + LTRIM(CAST(DE.nomComercial AS VARCHAR(40))) + Replicate(CHAR(32),40-LEN(RTRIM(CAST(DE.nomComercial AS VARCHAR(40)))))--nombre del originador                                                              
--          --   + LTRIM(CAST(DE.rfc AS VARCHAR(18))) + Replicate(CHAR(32),18-LEN(LTRIM(CAST(DE.rfc AS VARCHAR(18))))) --rfc del originador                                                        
--          --   + LTRIM(CAST(BA.RFC AS VARCHAR(18))) + Replicate(CHAR(32),18-LEN(LTRIM(CAST(BA.RFC AS VARCHAR(18))))) --RFC del receptor                                                         
--          --   + Replicate('0',7-LEN(LTRIM(CAST(CC.Contrato AS NVARCHAR(7)))))+LTRIM(CAST(CC.Contrato AS NVARCHAR(7)))--referencia numerica                                                               
                                                                          
--          --   + Replicate(CHAR(32),30)--Clave de Rastreo                                                              
                                                                         
                                   
--          --+ Replicate(CHAR(32),12)--Uso Futuro Zona Banco                                                               
--          --   + LTRIM(CAST(CC.Cuenta AS VARCHAR(30))) + Replicate(CHAR(32),30-LEN(RTRIM(CAST(CC.Cuenta AS NVARCHAR(30)))))  --referencia del cliente                                                              
--          --   + Replicate(CHAR(32),30)  --descripcion de referencia de pago (opcional)                                                              
                                       
--         from BancoCargoCuenta BCC                                                              
--        join @TblPrueba tp  ON tp.CuentaCteId = BCC.CuentaCteId                                                            
--        join BancoActor BA on BA.BancoActorKey = BCC.BancoActoId                                                            
--        --join Cliente CL on CL.ClienteKey = BA.ActorId   
--                join CuentaCte CC on CC.CuentaCtekey = BCC.CuentaCteId     
--        join PersonaActor PA on PA.ActorId = cc.ClienteId
--        join Producto P on P.ProductoKey = CC.ProductoId                               
--  join TipoProd TPR on TPR.TipoProdKey = P.TipoProdId                                                                
-- where BCC.FormaPagoID = 8                   
-- and BCC.CicloCorteId = @CicloCorte                   
-- and TPR.TipoProdKey in(@TipoProd,@Tipoprod2,@Tipoprod3,@Tipoprod4)                              
-- and BCC.Finish is null and BCC.Status = 0        
        
--  ORDER by BCC.CuentaCteId                  
--  ---and isnull(CC.Bursatil,0) = @bursatil                    
                                                    
--   --select * from @TblCadenaDetalle                                           
                     
                                                 
--  --Cuenta el total de registros DETALLES                                                    
--  set @detalles = (select COUNT(*) from @TblCadenaDetalle)                                                             
                                                       
----------------------------------------------------------------------------------------------------                                                            
-----------------------------------------------SUMARIO---------------------------------------------                                                            
----------------------------------------------------------------------------------------------------                                             
                                                     
-- DECLARE @TblSumario TABLE (Sumario  Varchar (401))                                                          
-- Insert Into @TblSumario                     
--  Select      '09' --Tipo de Registro                                                    
--             + Replicate('0',7-LEN(LTRIM(CAST(@detalles + 2 AS NVARCHAR))))+LTRIM(CAST(@detalles + 2 AS NVARCHAR(7))) --No Secuencia                                                           
--             + '30' --Codigo de Operacion         
--             + dbo.fn_ChgFormatoNumero(@dia,2)+ REPLICATE('0',5 - len(@NumeroSecuencia)) + cast(@NumeroSecuencia as varchar) ---Numero de Bloque                                                       
--             + Replicate('0',7-LEN(LTRIM(CAST(@detalles AS NVARCHAR))))+LTRIM(CAST(@detalles AS NVARCHAR)) --Numero de Operaciones                                       
--             + Replace(REPLICATE('0',18-LEN(LTRIM(CAST(replace((Select SUM(Importe) From @TblPrueba),'.','') AS NVARCHAR))))+LTRIM(CAST(replace((Select SUM(Importe) From @TblPrueba),'.','') AS NVARCHAR)),'.','') --importe total de Operaciones            









  
     
     
        
          
            
                  
                   
--             --+ REPLICATE(CHAR(32),40) --Uso Futuro CCE                                                          
--             + REPLICATE (CHAR(32), 17) --Uso Futuro Banco                                                           
--             + REPLICATE (CHAR(32), 240) --Uso Futuro Banco                                                           
--             + REPLICATE (CHAR(32) , 100) --Uso Futuro Banco                                                        
                                                                 
--            --- select * from @TblSumario                              
                                                       
----------------------------------------------------------------------------------------------------                                                            
-----------------------------------------CONSULTA FINAL---------------------------------------------                                                            
----------------------------------------------------------------------------------------------------                                                             
--DECLARE @BCP VARCHAR(8000) = ''                             
--Declare @TblFinal Table (Texto Varchar(MAX))                                                              
--Insert @TblFinal                                                               
--Select * from @TblEncabezado ---------------Encabezado                                                               
--union                                                              
--Select * from @TblCadenaDetalle -----------------Detalles                                                             
--union                                                              
--Select * from @TblSumario --------Sumario                                    
                         
                                                    
----Select * from @TblFinal   
----return                                                  
                                                    
--   IF EXISTS (SELECT * FROM tempdb.information_schema.tables WHERE table_name = '##DatosDomi') BEGIN                                                            
--    drop table ##DatosDomi                                                            
--    Print 'Borrada'                              
--   END                                                            
                                                           
--    create table ##DatosDomi(Datos varchar(max))                                                             
        
--         insert into ##DatosDomi                      
--         Select * from @TblFinal                         
                               
--         --------------                      
--        -- Select * from @TblFinal                                        
                    
                    
---------------------------------------PRUEBAS----------------------                    
----if @bursatil = 0                    
----begin                    
                    
---- if (SELECT COUNT(*) from ##DatosDomi )>1 ---Mas registros que el encabezado                    
---- begin---------------84 pruebas                    
----  if @empresa = 1                                                            
----  SET @BCP  = 'bcp "SELECT * from ##DatosDomi" queryout ' + dbo.FNSOFIA_RutaServidor(84) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                    
----  else                                                --  SET @BCP  = 'bcp "SELECT * from ##DatosDomi " queryout ' + dbo.FNSOFIA_RutaServidor(84) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)  









   
    
     
         
          
           
                  
---- end                    
                       
----end                    
                    
----else                    
----begin                    
                     
---- if (SELECT COUNT(*) from ##DatosDomi )>1                    
---- begin                    
----  if @empresa = 1                                                            
----  SET @BCP  = 'bcp "SELECT * from ##DatosDomi" queryout ' + dbo.FNSOFIA_RutaServidor(87) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                    
----  else                                                            
----  SET @BCP  = 'bcp "SELECT * from ##DatosDomi " queryout ' + dbo.FNSOFIA_RutaServidor(88) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                    
---- end                    
                      
----end                    
                    
-----------------------------------PRODUCTIVO----------------------                    
--/*--BLOQUE COMENTADO PARA GENERAR TODOS DE AUTOAHORRO EN UNA CARPETA                    
--if @nobursatil=2
-- begin
--		if @empresa=2
--		  begin
--			 SET @BCP  = 'bcp "SELECT * from ##DatosDomi " queryout ' + dbo.FNSOFIA_RutaServidor(134) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                               
--			 set @VariableRuta =  dbo.FNSOFIA_RutaServidor(134)  
--		  end    
--end              
--else if @nobursatil = 0                    
--begin */                   
--  if (SELECT COUNT(*) from ##DatosDomi )>1 ---Mas registros que el encabezado                    
-- --begin                    
-- -- if @empresa = 1      
--	 begin                                                          
--	  SET @BCP  = 'bcp "SELECT * from ##DatosDomi" queryout ' + dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,8) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                                       
--	  set @VariableRuta = dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,8)    
--	 end    
----  else      
----	 begin                                                          
----	  SET @BCP  = 'bcp "SELECT * from ##DatosDomi" queryout ' + dbo.FNSOFIA_RutaServidor(86) +  replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                                            

----	  set @VariableRuta = dbo.FNSOFIA_RutaServidor(86)    
----	 end		  
---- end                    
------end                    
                    
----else                    
----begin                    
                    
---- if (SELECT COUNT(*) from ##DatosDomi )>1                    
----  begin                  
----  if @empresa = 1     
----   begin                                                           
----    SET @BCP  = 'bcp "SELECT * from ##DatosDomi" queryout ' + dbo.FNSOFIA_RutaServidor(87) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                                         
----    set @VariableRuta = dbo.FNSOFIA_RutaServidor(87)    
----   end     
----  else    
----   begin                                
----    --SET @BCP  = 'bcp "SELECT * from ##DatosDomi " queryout ' + dbo.FNSOFIA_RutaServidor(88) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                               
----    --set @VariableRuta = dbo.FNSOFIA_RutaServidor(88)
----	 SET @BCP  = 'bcp "SELECT * from ##DatosDomi " queryout ' + dbo.FNSOFIA_RutaServidor(86) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar) 
----	set @VariableRuta = dbo.FNSOFIA_RutaServidor(86)    
----   end    
----  end                    
----end                    
                    
                                                            
                                                    
                    
--if @BCP <> ''                    
--begin                    
                    
--Print @BCP                                                            
--EXEC xp_cmdshell @BCP      
--select 1   
--exec SpSofia_ValidacionDomiciliacion  @VariableRuta,@nombreArchivoSinEspacios                    
--drop table ##DatosDomi                     
                   
--end                    
                    
--else                    
--begin                    
--drop table ##DatosDomi                     
--select 0                    
--select 0                    
--end                    
                                                           
--        -----    exec  [SPSOFIA_GetDomiciliacionBanamex]'20130716',2,1,'20130716',1,'DomiBanamex.dom',1,1,0             

end                                       