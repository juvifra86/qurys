/*                                             
24/04/2012                                         
Procedimiento para crear el layout de BANAMEX de TARJETA DE CREDITO                                      
EZM   

MODIFICO: JVFM
Se modifico la consulta para generar archivos diferentes para cuentas sin bursatilizar, bursatilizado 1 y bursatilizado 2

 MOD: 16/10/2015
  JVFM ...se agrego la funcion FNSOFIA_RutaServidorDomi para identificar las carpetas de generacion de archivos segun empresa,y bursatilizacion
                                              
----------------------------------------Cambio de Bursatilizacion                                                
Sintaxis:                                                
                                                
SPSOFIA_LayoutBanamexTC '20120529','20120601',1,1,1,'CAR1203269999999901.BCA',1                                      
                                                
[SPSOFIA_LayoutBanamexTC] '20150831','20150903',3,2,1,'pruebact.BCA',1,0                                  
[SPSOFIA_LayoutBanamexTC] '20150803','20150803',1,2,1,'pruebactbursa.BCA',1,1
[SPSOFIA_LayoutBanamexTC23112016] '20161117','20161117',2,2,1,'pruebactbursa2.BCA',1,3    
select NumCliente,NumAfiliacion,* from CuentaBanco where NumCuenta='70078425723' 
    
*/                                                
                                      
ALTER Procedure [dbo].[SPSOFIA_LayoutBanamexTC23112016]                                
@FechaGeneracion as date,    --Fecha de Generacion del Archivo                                                            
@Fecha as date,                --Fecha de vencimiento                                
@CicloCorte as integer,                                                
@empresa as integer,                                              
@TipoProd as integer,                                                
@nombreArchivo AS VARCHAR(8000),                                
@aplicaDescuento as bit,              
@nobursatil as int = 0                                  
                                             
as                                                
begin                                                
declare @afiliacion as varchar(8)                                                 
declare @SigDiahabil as date                                                
declare @mesXCobrar as smallint                                              
declare @anioXCobrar as smallint                                              
declare @bursatil as bit=@nobursatil                                              
set @mesXCobrar = MONTH(@Fecha)                                              
set @anioXCobrar = YEAR(@Fecha)                   
                  
                  
declare @Tipoprod2 as integer                            
declare @Tipoprod3 as integer         
declare @Tipoprod4 as integer    
  
declare @VariableRuta as varchar(500),  
@nombreArchivoSinEspacios varchar(8000) = replace(@nombreArchivo,' ','')                        
                           
set @TipoProd2 = 0                            
set @Tipoprod3 = 0         
set @Tipoprod4 = 0             
                            
if @TipoProd = 1 begin                             
   set @Tipoprod2 = 6   ----Balloon                         
   set @Tipoprod3 = 7   ----8/60         
   set @Tipoprod4 = 8   ----Seminuevos                            
    end                                          
                                      
                                      
declare @numeroCliente varchar(12)                                      
--set @numeroCliente = (SELECT NumCliente from dbo.FNSOFIA_GETDATOSEMPRESA (@empresa,4,@bursatil))                     
 if @nobursatil=2 
	begin
		select @numeroCliente=NumCliente,@afiliacion=NumAfiliacion from CuentaBanco where NumCuenta='70078425723'  --Numero de cliente de bursatilizados numero 2
	end
 else
    if @nobursatil=3
	  begin
	    SELECT @numeroCliente = isnull(NumCliente,'0000000'), @afiliacion = isnull(NumAfiliacion,'0000000')
		 from dbo.FNSOFIA_GETDATOSEMPRESA (@empresa,4,0)   
	  end
	 else
		begin
			SELECT @numeroCliente = isnull(NumCliente,'0000000'), @afiliacion = isnull(NumAfiliacion,'0000000')               
			from dbo.FNSOFIA_GETDATOSEMPRESA (@empresa,4,@bursatil)  
		end             
--Se cambio la linea de arriba para optimizar la consulta en una sola              
	            

set @afiliacion =  replicate (0,8 - len(rtrim(ltrim(@afiliacion)))) + rtrim(ltrim(@afiliacion)) --NUMERO DE AFILICACION                                                        
----------------------------------TABLA PRUEBA con IMPORTES A PAGAR-------------------------                                                
--set @SigDiahabil = dbo.FnSofia_GetDiaHabil(@fecha)     
                    
if @CicloCorte <> 3                    
	begin                    
	set @SigDiahabil = dbo.FnSofia_GetDiaHabil(@fecha)                                      
	end                    
                    
else                    
	begin                  
	set @SigDiahabil = @fecha                    
	end                    
                    
Declare @TblPrueba  Table  (CuentaCteId bigint,                                                
       Importe  Decimal(20,2),          
       boleta integer                                      
       )     
	 
			Insert Into @TblPrueba                                           
			Select BCC.CuentaCteId,                                                
				  (select importe from dbo.FnSofia_GetPagoDomi(BCC.CuentaCteId,@SigDiahabil,@FechaGeneracion,@aplicaDescuento)) [importe],                                      
				  (select boleta from  dbo.FnSofia_GetPagoDomi(BCC.CuentaCteId,@SigDiahabil,@FechaGeneracion,@aplicaDescuento)) [Boleta]                                   
				  From BancoCargoCuenta BCC                                                 
			join CuentaCte CC on CC.CuentaCtekey = BCC.CuentaCteId          
      
			------------------------------------Se agrego para saber si realmente es bursatilizado para tomar cuentas bursatilizadas      
			join vwCuentasBursaDomi cb on cb.CuentaCtekey = CC.CuentaCtekey      
                
			join Producto P on P.ProductoKey = CC.ProductoId                                              
			join TipoProd TP on TP.TipoProdKey = P.TipoProdId                                       
			 where BCC.FormaPagoID = 7               
			 and BCC.Finish is null               
			 and BCC.TipoProductoId <> 2               
			 and BCC.Status = 0               
			 and BCC.CicloCorteId = @CicloCorte               
			 and CC.EmpresaId = @empresa               
			 and TP.TipoProdKey in  (@TipoProd,@tipoprod2,@Tipoprod3,@Tipoprod4)              
			 and CC.Situacion in(12,33,34,39,72,73,223)              
			 and cb.Bursatil = @bursatil   
			 --and cb.BursatilDomi = @bursatil           
			  and cb.NoBursatil = @nobursatil       
			 --and BCC.AnioVenc > = @anioXCobrar and BCC.MesVenc > = case when BCC.AnioVenc = @anioXCobrar then @mesXCobrar else 0 end
		--end                                           
			                                               
                         
           delete from  @TblPrueba where isnull(Importe,0) < = 1   

                select * from @TblPrueba order by 1                 
-----------------------------------------------DETALLE------------------------------------------                                                
--declare @tableDetalle as table(detalle varchar(86))                                                
              
----Se sustituyo la linea por la consulta en una sola linea (arriba)              
----set @afiliacion = (SELECT NumAfiliacion from dbo.FNSOFIA_GETDATOSEMPRESA (@empresa,4))                                        
                                                
--insert into @tableDetalle                                                
--  select replicate (0,8 - len(rtrim(ltrim(@afiliacion)))) + rtrim(ltrim(@afiliacion)) --NUMERO DE AFILICACION                                       
--  + replicate (' ',16 - len(cast(BCC.NumCuenta  as varchar(16)))) + cast(BCC.NumCuenta  as varchar(16)) --NUMERO DE TARJETA                                      
--  +'80'--CLAVE TRANSACCION                                      
--  + REPLICATE (0,10 - len(ltrim(rtrim(replace(tp.Importe,'.',''))))) + ltrim(rtrim(replace(tp.Importe,'.','')))--IMPORTE DE LA TRANSACCION                                      
--  + CONVERT(varchar(06),@FechaGeneracion,12)--FECHA DE LA TRANSACCION                                    
--  + (select dbo.FNSOFIA_GetReferenciaBanamex(BCC.NumCuenta,@afiliacion,BCC.CuentaCteId,@FechaGeneracion))  --Referencia a 23 posiciones                              
                                      
--  ----se manda la cuentacteKey y el numero de boleta (longitud 10 cuentacte, 9 boleta)                                    
--  + REPLICATE(0,10 - len (CAST(BCC.CuentaCteId as varchar))) + CAST(BCC.CuentaCteId as varchar) --REFERENCIA PARA EL COMERCIO                                        
--  + REPLICATE(0,8 - len (CAST(TP.boleta as varchar))) + CAST(TP.boleta as varchar) --REFERENCIA PARA EL COMERCIO      
--  + REPLICATE(CHAR(32),1 - len (CAST(@aplicaDescuento as varchar))) + CAST(@aplicaDescuento as varchar) --REFERENCIA PARA EL COMERCIO                                
--  ------------------------------------------------------------------------------------------------------------------------------------                  
                                      
--  + REPLICATE(char(32),2)                                      
--  from bancoCargoCuenta BCC                                                
--  join @TblPrueba TP on TP.CuentaCteId = BCC.CuentaCteId                                         
-- where BCC.FormaPagoID = 7               
-- and BCC.CicloCorteId =@CicloCorte               
-- and BCC.Finish is null and               
-- BCC.Status = 0  and               
-- BCC.TipoProductoId <> 2     
                                        
-- --select * from @TblPrueba                                  
----select * from @tableDetalle
----return
-------------------------------------------------HEADER---------------------------------------                                                
                                              
--declare @header as table(header varchar(86))                                                  
--  insert @header                                        
--  select                                       
-- 'S244' --Valor Fijo                                      
--  + replace(CONVERT(varchar(10),@FechaGeneracion,112),'.','') --Fecha del archivo                                      
--  + 'A' --Solicitud CAB                        
--  + REPLICATE('0',12 - len(@numeroCliente)) + CAST(@numeroCliente as varchar)--Numero del cliente                                      
--  + '01' --Version del Formato                                      
--  + REPLICATE(char(32),59)                                      
                                        
-----------------------------------------------TRAILER------------------------------------------                                        
                                      
--declare @TableTrailer as table (trailer varchar(86))                                      
--insert into @TableTrailer                                      
--select  'ENDFILE'                                      
--  + REPLICATE(0,6 - len((select COUNT(*) from @tableDetalle))) + cast((select COUNT(*) from @tableDetalle) as varchar) --Numero total de detalles                                      
--  + REPLICATE(0,10 - len(replace((select sum(Importe) from @TblPrueba),'.',''))) + cast(replace((select sum(Importe) from @TblPrueba),'.','')as varchar) --Numero total de detalles                                      
--  + REPLICATE (CHAR(32),63)                                      
                                        
--  --select * from @header     
--  --return                                           
--------------------------------------------------RESULTADOS--------------------------------------                                          
                                                   
--  IF EXISTS (SELECT * FROM tempdb.information_schema.tables WHERE table_name = '##Resultados') BEGIN                     
--    drop table ##Resultados                                                
--    Print 'Borrada'                                       
--   END                                                
                                                   
--    create table ##Resultados(Resultado varchar(86))                                               
                                                
--  insert into ##Resultados                                                
--   select * from @header     
                                                  
--  insert into ##Resultados                                                
--   select * from @tableDetalle                                                   
                                                
--     insert into ##Resultados                                                
--   select * from @TableTrailer                                          
                                   
                                                
--   --select * from ##Resultados                                                
                                                   
--   DECLARE @BCP VARCHAR(8000)  = ''                                              
                                                   
                                                   
----------------Lo guarda en diferentes carpetas dependiendo de la empresa seleccionada                                                
              
                
              
              
----   ----------------------------------PRUEBAS----------------------              
----if @bursatil = 0              
----begin              
----  if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado              
----  BEGIN-----------------------------------------------------------------84 pruebas              
----   if @empresa = 1  --Empresa Sucredito y ahorro                                               
----     SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(84) + replace(@nombreArchivo,' ','') + ' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                             
----     else   --Empresa Auto Ahorro                                                
----     SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(84) + replace(@nombreArchivo,' ','') +' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                                  
----  END              
              
----  end              
              
----else ----------BURSATILIZADO              
----begin              
              
---- if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado              
----  BEGIN              
----   if @empresa = 1                                                      
----   SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(95) + replace(@nombreArchivo,' ','') + ' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                                      






----   else                                                      
----   SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(96) + replace(@nombreArchivo,' ','') + ' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                               
----  END              
----end               
                                                 
----   ----------------------------------PRODUCTIVO----------------------              
----------if @bursatil = 0              
----------	begin              
              
--	  if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado              
--			BEGIN              
--				------if @empresa = 1  --Empresa Sucredito y ahorro    
--				------	  begin                                             
--				------	   SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7) + replace(@nombreArchivo,' ','') + ' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                      
                 
--				------	   set @VariableRuta = dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7)  
--				------	  end  
--				------else   --Empresa Auto Ahorro                                                
--				------  begin  
--				------		--if @nobursatil=2 
--				------		--	begin
--				------		--	SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(136) + replace(@nombreArchivo,' ','') +' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                            


--				------		--	set @VariableRuta = dbo.FNSOFIA_RutaServidor(136) 
--				------		--	end
--				------		--else
--				------			begin
--							SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7) + replace(@nombreArchivo,' ','') +' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                              
              
--							set @VariableRuta = dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7) 
--						--------	end
   
--				  --------end  
--			END              
--	 ------end              
              
------------else              
------------	begin              
------------	  if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado              
------------		  BEGIN              
------------			  if @empresa = 1     
------------					 begin                                                   
------------						  SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7) + replace(@nombreArchivo,' ','') + ' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                  
                                  

------------						  set @VariableRuta = dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7)  
------------					 end  
------------			  else   
------------					if @nobursatil=2
------------						begin
------------							SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7) + replace(@nombreArchivo,' ','') + ' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                   
                                


------------							set @VariableRuta = dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7)  
------------						end
------------					else
------------						 begin                                                     
------------							  SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7) + replace(@nombreArchivo,' ','') + ' -T -c -r -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                 
                                  

------------							  set @VariableRuta = dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,7)
------------						 end  
------------		  END              
------------	end               
              
              
              
                                                 
----EXEC xp_cmdshell @BCP                  
                
----select * from     ##Resultados                                 
----select * from ##Resultados                                                     
----drop table ##Resultados                                                
              
              
--if @BCP <> ''           
--	begin              
              
--		Print @BCP                                                      
--		EXEC xp_cmdshell @BCP    
--		exec SpSofia_ValidacionTarjetaCredito  @VariableRuta,@nombreArchivoSinEspacios,@afiliacion  
             
--		drop table ##Resultados               
--		select 1              
--	end              
              
--else              
--	begin              
--		drop table ##Resultados               
--		select 0              
--		select 0              
--	end              

end
              
                                                