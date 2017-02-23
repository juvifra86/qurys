/*                                          
CREO : EZM                                           
                                          
Descripcion: Crea el layout de American Express                                          

                                      
sintaxis:                                          
           
drop procedure SPSOFIA_LayoutAMEX '20160203','20160202',1,2,'AUTO AHORRO AUTOMOTRIZ, S.A. DE C.V.', 1 ,'prueba.txt',1,3                                       
                                    
              APLICA DESCUENTO                          
  ----------------------------------------Cambio de Bursatilizacion                      
                        
MOD: 21/08/2013          
  EZM ... se agrego el campo de bursatil.   
 
MODIFICO: JVFM 
Se modifico la consulta para generar archivos diferentes para cuentas sin bursatilizar, bursatilizado 1 y bursatilizado 2
           
 MOD: 16/10/2015
  JVFM ...se agrego la funcion FNSOFIA_RutaServidorDomi para identificar las carpetas de generacion de archivos segun empresa,y bursatilizacion
                              
*/												
                                          
CREATE procedure [dbo].[SPSOFIA_LayoutAMEX1811]                                          
@FechaGeneracion as date,                                          
@Fecha as date,                                          
@CicloCorte as integer,                                          
@empresa as integer,                                          
@EmpresaDSC AS VARCHAR(50),                                        
@TipoProd as integer,                                      
@nombreArchivo varchar(max),                          
@aplicaDescuento as bit,          
@nobursatil as int = 0                                                  
as                                          
                                          
begin                                          
declare @SigDiahabil as date                                          
declare @header as table(header varchar(max))                                          
declare @afiliacion as varchar(7)                                          
declare @cadena as varchar(20)                                        
declare @mesXCobrar as smallint                                        
declare @anioXCobrar as smallint                                        
declare @bursatil as bit=@nobursatil                                         
set @mesXCobrar = MONTH(@Fecha)                                        
set @anioXCobrar = YEAR(@Fecha)                                        
                                        
declare @Tipoprod2 as integer                          
declare @Tipoprod3 as integer      
declare @Tipoprod4 as integer                         
set @TipoProd2 = 0                          
set @Tipoprod3 = 0    
set @Tipoprod4 = 0 

declare @VariableRuta as varchar(500),
@nombreArchivoSinEspacios varchar(max) = replace(@nombreArchivo,' ','')             
            
if @TipoProd = 1 begin                           
   set @Tipoprod2 = 6   ----Balloon                       
   set @Tipoprod3 = 7   ----8/60       
   set @Tipoprod4 = 8   ----Seminuevos                 
end                                          
                                          
                                           
Declare @TblPrueba  Table  (CuentaCteId bigint,                                                  
       Importe  Decimal(20,2),                                
       boleta integer                                                  
          )                                            
                
if  @CicloCorte <> 3                
begin                                                  
set @SigDiahabil = dbo.FnSofia_GetDiaHabil(@fecha)                                          
end                
else                
begin                
set @SigDiahabil = @fecha                
end                
set @cadena = 'Planfia'                                          

set @EmpresaDSC = Replace(@EmpresaDSC,' ','')                                          
   
           
--------------------------Datos De la Empresa-------------------------------------------------------------------------                                          
Declare @datosEmpresa Table  (CuentaCteId bigint,             
        numCuenta varchar(20),                                          
        nomComercial varchar(40),          
        rfc varchar(20))                                          
declare @numafiliacion as varchar(20)
	if @nobursatil =2 
		begin
		 select @numafiliacion=NumAfiliacion from CuentaBanco where NumCuenta='935'  --Numero de cliente de bursatilizados numero 2
		end   
	else	
	   if @nobursatil=3
	      begin
		     select @numafiliacion=NumAfiliacion from FNSOFIA_GETDATOSEMPRESA(@empresa,6,0)
		  end
	   else
		begin
		select @numafiliacion=NumAfiliacion from FNSOFIA_GETDATOSEMPRESA(@empresa,4,@bursatil)
		end           
		                                    
--insert into @datosEmpresa                                          
--Select BCC.CuentaCteId,                                          
----(select numCuenta from FNSOFIA_GETDATOSEMPRESA(CC.EmpresaId,4,@bursatil)),
--@numafiliacion,                                          
--(select nomComercial from FNSOFIA_GETDATOSEMPRESA(CC.EmpresaId,4,@bursatil)),                                          
--(select rfc from FNSOFIA_GETDATOSEMPRESA(CC.EmpresaId,4,@bursatil))             
--from BancoCargoCuenta BCC                                          
--join CuentaCte CC on CC.CuentaCtekey = BCC.CuentaCteId                                        
--join Producto P on P.ProductoKey = CC.ProductoId                                        
--join TipoProd TP on TP.TipoProdKey = P.TipoProdId    
--------------------------------------Se agrego para saber si realmente es bursatilizado para tomar cuentas bursatilizadas  
--join vwCuentasBursaDomi cb on cb.CuentaCtekey = CC.CuentaCtekey  
--where BCC.FormaPagoID = 6           
-- and CC.EmpresaId = @empresa              
-- and TP.TipoProdKey in (@TipoProd,@Tipoprod2,@Tipoprod3,@Tipoprod4)            
-- and BCC.CicloCorteId = @CicloCorte                                 
-- and BCC.Finish is null           
-- and BCC.Status = 0           
-- and BCC.TipoProductoId <> 2 --AHORRO                          
-- --and isnull(CC.Bursatil,0) = @bursatil       
-- and cb.NoBursatil = @nobursatil   
-- and CC.Situacion in(12,33,34,39,72,73,223)          
                                      
----and BCC.AnioVenc > = @anioXCobrar and BCC.MesVenc > = case when BCC.AnioVenc = @anioXCobrar then @mesXCobrar else 0 end                                         
                                           
--------------------------------Tabla Prueba--------------------------------                                      
                                   
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
			where BCC.FormaPagoID = 6 and                       
			 BCC.Finish is null and BCC.Status = 0 and BCC.CicloCorteId = @CicloCorte and BCC.TipoProductoId <> 2 --AHORRO                        
			 and CC.EmpresaId = @empresa          
			 and TP.TipoProdKey in (@TipoProd,@Tipoprod2,@Tipoprod3,@Tipoprod4)            
			 --and isnull(CC.Bursatil,0) = @bursatil          
			 and cb.Bursatil = @bursatil  
			 and cb.NoBursatil=@nobursatil 
			 --and cb.BursatilDomi = @bursatil
			 and CC.Situacion in(12,33,34,39,72,73,223)        
		--end	                        
			  
           
--and BCC.AnioVenc > = @anioXCobrar and BCC.MesVenc > = case when BCC.AnioVenc = @anioXCobrar then @mesXCobrar else 0 end                                  
                                  
delete from  @TblPrueba where isnull(Importe,0) <=0     
select * from @TblPrueba                             
                                          
-----------------------------ENCABAZADO---------------------------------------                                          
--insert @header                                   
--select 'AMEX'                                          
--  +'PLPFIA'                                          
--  +replace(CONVERT(varchar(8),DBO.SOFIAGETDATE(),04),'.','') --fecha en formato DDMMAA Fecha Actual                                          
--  +'NPS'                                          
--  +REPLICATE(CHAR(32),71)                                          
------------------------------------------------------------------------------                                          
                                          
-----------------------------DETALLE------------------------------------------                                         
----set @afiliacion = (select dbo.FNSOFIA_GetCveAmEx(@empresa))            
----------------Obtiene el nummero de afiliacion de banamex                           ----6 = AMEX          
--if @nobursatil=2
--	begin
--		set @afiliacion =@numafiliacion
--	end
--else
--    if @nobursatil=3
--	      begin
--		     select @afiliacion=NumAfiliacion from FNSOFIA_GETDATOSEMPRESA(@empresa,6,0)
--		  end
--	   else
--	begin
--		set @afiliacion = (select isnull(numCliente,'0000000')           
--			  from CuentaBanco           
--			  where BancoId = 6           
--			  and EmpresaId = @empresa           
--			  and Bursatil = @bursatil           
--			  and Domicilia = 1)  
--	end

		                                                                      
                                          
--declare @tableDetalle as table(Detalle varchar(max))                                          
--insert into @tableDetalle                                
--  select (replicate(char(32),7 - len(@afiliacion))+ cast(@afiliacion as varchar(7)) ---Afiliacion                          
--  + REPLICATE (char(32),1)   --Resultado                                       
--  + REPLICATE (char(32),15 - len(CAST(BCC.NumCuenta as nvarchar(15)))) + ltrim(CAST(BCC.NumCuenta as varchar(15))) --Numero de cuenta                          
--  + '80'--Tipo de Movimiento                                          
--  + Replace(REPLICATE (0,11 - len(replace(tp.Importe,'.',''))) + CAST(tp.Importe as Varchar(11)),'.','') --Importe del cargo                          
--  + replace(CONVERT(varchar(8),@FechaGeneracion,04),'.','') --fecha del cargo                          
--  -----------------------------------------------                          
                            
--  + @cadena + CAST(@aplicaDescuento as varchar) + cast(BCC.CuentaCteId as varchar(10))                           
--  + REPLICATE(char(32),20 - len(@cadena + CAST(@aplicaDescuento as varchar) +  cast(BCC.CuentaCteId as varchar(10))))    --Descripcion del cargo                          
                            
--  -----------------------------------------------                          
--  --+ REPLICATE (char(32),20)--descripcion del cargo                                          
--  + 'Boleta'+ cast(tp.boleta as varchar) + REPLICATE(char(32),20-len('Boleta'+ cast(tp.boleta as varchar)))                                                 
--  + REPLICATE (char(32),8) --filler                          
--  )                                          
--  from BancoCargoCuenta BCC --on BCC.CuentaCteId = CC.CuentaCtekey                                          
--  join @TblPrueba tp  ON tp.CuentaCteId = BCC.CuentaCteId                                          
--  JOIN @datosEmpresa DE ON DE.CuentaCteId = BCC.CuentaCteId               
--  join CuentaCte CC on CC.CuentaCtekey = BCC.CuentaCteId                                        
--  Join Producto P on P.ProductoKey = CC.ProductoId                                        
--  join TipoProd TPR on TPR.TipoProdKey = P.TipoProdId                                            
--  where FormaPagoID = 6           
--  and BCC.CicloCorteId = @CicloCorte              
--  and TPR.TipoProdKey in (@TipoProd,@Tipoprod2,@Tipoprod3,@Tipoprod4)                                    
--  and BCC.Finish is null           
--  and BCC.Status = 0           
--  ---and isnull(CC.Bursatil,0) = @bursatil          
                                           
--------------------------------------------------------------------------------------                                          
-------------------------------------TRAILER------------------------------------------                                          
                                          
--declare @tableTrailer as table(Trailer varchar(max))                                          
--declare @TotalMonto as money                                           
--declare @totalDetalles as varchar(6)                                          
                                          
--set @totalDetalles = (select COUNT (Detalle) from @tableDetalle)                                          
--set @TotalMonto = (select SUM(importe) from @TblPrueba)                                          
                                          
--insert into @tableTrailer                                          
--select ('ENDFILE' --constante                     
--  + REPLICATE(0,6 - len(@totalDetalles)) + @totalDetalles   ---Movimientos                                          
--  + Replace(REPLICATE (0,11 - len(replace(@TotalMonto,'.',''))) + CAST(@TotalMonto as Varchar(11)),'.','') --- importe Movimientos                                          
--  + REPLICATE(0,6) -- Abonos                                          
--  + REPLICATE(0,11) --importe abonos                                          
--  + REPLICATE(0,6 - len(@totalDetalles)) + @totalDetalles --cargos                                          
--  + Replace(REPLICATE (0,11 - len(replace(@TotalMonto,'.',''))) + CAST(@TotalMonto as Varchar(11)),'.','') --importe cargos                                          
--  + REPLICATE(0,6)--movimientos aceptados                                          
--  + REPLICATE(0,13) --importe aceptado                                          
--  + REPLICATE (char(32),13)                                            
--  )                                          
                                            
                                            
--  IF EXISTS (SELECT * FROM tempdb.information_schema.tables WHERE table_name = '##Resultados') BEGIN                                          
--    drop table ##Resultados                           
--   Print 'Borrada'                                          
--   END                                          
                                             
--    create table ##Resultados(Resultado varchar(max))                                           
                                             
                                             
--  insert into ##Resultados                                          
--  select * from @header                            
--  insert into ##Resultados                                          
--  select * from @tableDetalle    
--  union                 
--  select * from  @tableTrailer                                          
--  ----------------------------------------------------------------------------                       
--  --select * from ##Resultados                                          
--  DECLARE @BCP VARCHAR(8000) = ''                                         
                                          
                    
          
----   ----------------------------------PRUEBAS----------------------          
----if @bursatil = 0          
----begin          
          
----       if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado          
----  BEGIN          
----    --------------------------------------84 pruebas        
----  if @empresa = 1                                                  
----  SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(84) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                                
----  else                                                  
----  SET @BCP  = 'bcp "SELECT * from ##Resultados " queryout ' + dbo.FNSOFIA_RutaServidor(84) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                               
     
----  END          
----end          
          
----else          
----begin          
          
----  if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado          
----  BEGIN          
----  if @empresa = 1                                                  
----  SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(91) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                        
                                
----  else                                                  
----  SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(92) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                        
                                
----  END       
----end           
                                             
--   --------------------------------PRODUCTIVO----------------------          
----if @bursatil = 0          
----begin          
          
--   if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado          
--  BEGIN          
--  --   if @empresa = 1  --Empresa Sucredito y ahorro  
--		--begin                                       
--           SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,6) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                           
                
--           set @VariableRuta = dbo.FNSOFIA_RutaServidorDomi(@empresa,@nobursatil,6)
--  --      end
                 
--  --    else   --Empresa Auto Ahorro     
		
--		--if @nobursatil=2
--		-- begin
--		--	SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(135) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                    
--  --         set @VariableRuta = dbo.FNSOFIA_RutaServidor(135)
--		-- end
--		--else
--		-- begin                                
--  --         SET @BCP  = 'bcp "select * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(90) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                                    
--  --         set @VariableRuta = dbo.FNSOFIA_RutaServidor(90)
--  --       end
--  END          
             
----end          
          
----else          
----begin          
----    if (SELECT COUNT(*) from ##Resultados )>2 ---Mas registros que el encabezado          
----   BEGIN          
----    if @empresa = 1
----		begin                                                  
----			SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(91) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)                
----			set @VariableRuta = dbo.FNSOFIA_RutaServidor(91)
----		end
----   else
----		if @nobursatil=2
----			begin
----				SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(135) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)               
----				set @VariableRuta = dbo.FNSOFIA_RutaServidor(135)
----			end
----		else
----		if @nobursatil=3
----			begin
----				SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(90) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)               
----				set @VariableRuta = dbo.FNSOFIA_RutaServidor(90)
----			end
----		else
----			begin                                                  
----				SET @BCP  = 'bcp "SELECT * from ##Resultados" queryout ' + dbo.FNSOFIA_RutaServidor(92) + replace(@nombreArchivo,' ','') + ' -T -c -ULograDesa -PLograDesa1 -S ' + cast(@@servername as varchar)               
----				set @VariableRuta = dbo.FNSOFIA_RutaServidor(92)
----			end
                                    
----   END           
----end           
          
                           
                                         
----Print @BCP           
          
--if @BCP <> ''          
--begin          
          
--Print @BCP                                                  
--EXEC xp_cmdshell @BCP            
--exec SpSofia_ValidacionAmex  @VariableRuta,@nombreArchivoSinEspacios
--drop table ##Resultados           
--select 1          
--end          
          
--else          
--begin          
--drop table ##Resultados           
--select 0          
--select 0          
end          
          