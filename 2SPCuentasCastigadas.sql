--Creado por ARPH 2015-02-11    
--Procedimiento para Castigar cuentas              
--Toma el número de cuenta obtiene los conceptos contables de Amortización y NotaCargo los copia en CuentasCastigadasv              
--luego Cancela los conceptos en NotaCargo y Amortizacion, y liquida capital        
--ejecuta el SPSOFIA_InsertaPagos_Logra para obtener idpago, una vez que tiene ejecuta SPsofia_procesapagocte.    
--cambia el status a 235 y da finish a la cuenta en cuentacte    
--exec SPSOFIA_CUENTASCASTIGADAS 79, 'sistemas', 'clave observacion prueba','20150227'        
Create Procedure SPSOFIA_CuentasCastigadas              
(@CuentaCteId int,              
@usuario nvarchar(50),              
@Cobsv nvarchar(50),          
@FechaCastigo date)              
 as                                        
 set nocount on                                        
begin                
           
Declare @tblCargosyPagosPeriodo table                                    
  (                                    
   tblkey  bigint not null,                                    
   ConceptoContable int not null,                                    
   Desglose varchar(2) not null,                                    
   TipoCargo varchar(2) not null,                                    
   Boleta int not null,                                    
   FechaEmision Date not null,                                    
   FechaVencimiento Date not null,                                    
   FechaLiquida Date  null,                                    
   EstadoPOId int not null ,                                    
   ImporteEmitido money not null,                                    
   ImportePagado money not null,                                    
   Saldo money not null default (0),                              
   DiasAtraso int not null default(0),          
   BoletaASustituir   smallint not null default(-1)                                      
  )                                    
Declare @Capital float
Declare @Interes float              
Declare @Iva float
--CV (Capital Vepido)              
declare @IntereSMCV float              
declare @IvaInteresCV float              
declare @NotaSeguroAuto float              
declare @NotaSeguroAutoUdi float              
declare @InteresMSA float              
declare @ivaInteresMSA float              
declare @InteresMNSA float              
declare @ivaInteresMNSA float
declare @SeguroDesempleo float              
declare @IMSD float              
declare @iimsd float
declare @SeguroVida float              
declare @InteresMSV float
declare @IIMSV float
declare @Anualidad float
declare @SeguroVidaEF float
declare @SeguroDesempleoed float
declare @saldo float        
declare @f1 date      
declare @f2 date      
      
set @f1 = (select distinct top 1 FechaLiquida from  FNSOFIA_GetCargosyPagosPeriodoEdoCtaInterno  (@cuentacteid,@FechaCastigo,@FechaCastigo)      
order by FechaLiquida desc)            
set @f2 = DATEADD(YEAR,-1,@FechaCastigo)      
--if @f1 <= @f2      
begin try          
begin tran  Castigo            
delete from @tblCargosyPagosPeriodo          
where ConceptoContable is not null          
insert into @tblCargosyPagosPeriodo          
select  tblkey, ConceptoContable, Desglose, tipocargo, boleta, fechaemision, fechavencimiento,          
 fechaliquida, estadopoid, importeemitido, ImportePagado, saldo, diasatraso, BoletaASustituir from  FNSOFIA_GetCargosyPagosPeriodoEdoCtaInterno  (@cuentacteid,@FechaCastigo,@FechaCastigo)           
                
set @Capital = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo         
where ConceptoContable = 46            
group by ConceptoContable)          
                
set @Interes = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 47            
group by ConceptoContable)          
              
set @Iva = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 48           
group by ConceptoContable)          
            
set @IntereSMCV = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 49           
group by ConceptoContable)          
            
set @IvaInteresCV = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo
where ConceptoContable = 50
group by ConceptoContable)
          
set @NotaSeguroAuto = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 61           
group by ConceptoContable)          
          
set @NotaSeguroAutoUdi = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 62           
group by ConceptoContable)            
          
set @InteresMSA = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 63           
group by ConceptoContable)          
          
set @ivaInteresMSA = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 64           
group by ConceptoContable)          
          
set @InteresMNSA = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 65           
group by ConceptoContable)          
          
set @ivaInteresMNSA = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 66           
group by ConceptoContable)          
          
set @SeguroDesempleo = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 73           
group by ConceptoContable)
          
set @IMSD = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 75           
group by ConceptoContable)
          
set @iimsd = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 76           
group by ConceptoContable)
          
set @SeguroVida = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 85           
group by ConceptoContable)
          
set @InteresMSV = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 87            
group by ConceptoContable)
          
set @IIMSV = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 88           
group by ConceptoContable)
     
set @Anualidad = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 154          
group by ConceptoContable)
          
set @SeguroVidaEF = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 166          
group by ConceptoContable)          
          
set @SeguroDesempleoed = 
(select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo          
where ConceptoContable = 177          
group by ConceptoContable)       
          
DECLARE @PARAM TABLE              
(CuentaCteid int,              
 usuario nvarchar(50),              
 CObsv INT)              
             
             
 set @saldo = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo)
          
INSERT INTO CuentasCastigadas 
SELECT @CuentaCteId, @Capital, @Interes, @Iva, @IntereSMCV, @IvaInteresCV, @NotaSeguroAuto, 
@NotaSeguroAutoUdi, @InteresMSA,@ivaInteresMSA, @InteresMNSA, @ivaInteresMNSA, @SeguroDesempleo,
@IMSD, @iimsd, @SeguroVida, @InteresMSV, @IIMSV, @Anualidad, @SeguroVidaEF, @SeguroDesempleoed,
@saldo, @fechacastigo, @fechacastigo, NULL , @usuario, @cobsv

insert into respaldopreviocancelacion              
 selecT NotaCargoKey,'N', CuentaCteId, ConceptoContableId, ImporteEmitido from NotaCargo              
 where CuentaCteId = @CuentaCteId              
  
 insert into respaldopreviocancelacion              
 select AmortizacionKey,'A',CuentaCteId, ConceptoContableId, ImporteEmitido from Amortizacion              
 where CuentaCteId = @CuentaCteId              
          
UPDATE NotaCargo              
SET ImporteEmitido = 0, EstadoPOId = 28        
WHERE ConceptoContableId <> 46              
And CuentaCteId =@CuentaCteId;              
UPDATE Amortizacion              
SET ImporteEmitido = 0, EstadoPOId = 23              
WHERE ConceptoContableId <> 46          
 and CuentaCteId = @CuentaCteId;                 
          

declare @Referencia nvarchar(60)          
set @Referencia = 'Bonificación por Cartera Castigada'          
EXEC SPSOFIA_InsertaPagos_Logra  @CUENTACTEID, @FECHACASTIGO, @FECHACASTIGO, @FECHACASTIGO,@CAPITAL,0,@REFERENCIA, 1,1,0,4,11,@Usuario, 0,1, 0,0,R          
Declare @IdPago int          
set @IdPago =(select PagoCajaKey from PagoCaja          
where CuentaCteId = @CuentaCteId          
and Importe = @CAPITAL)          
exec SPSOFIA_ProcesaPagoCte @cuentacteid, @idpago, @FechaCastigo          
Update CuentaCte  
set Status = 235, Finish = @FechaCastigo  
where CuentaCtekey = @CuentaCteId            
            
            
 
          
commit tran Castigo                  
END TRY                  
                   
 begin catch                                        
                                       
    IF @@ROWCOUNT = 0                                           
      BEGIN                                                        
  SELECT 0                               
  DECLARE @ErrorMessage AS VARCHAR (4000)                                          
  DECLARE @ErrorSeverity INT;                                          
  DECLARE @ErrorState INT;                    
                                      
  SET @ErrorMessage = ERROR_MESSAGE()                                             
   SET @ErrorSeverity = ERROR_SEVERITY()                                          
  SET  @ErrorState = ERROR_STATE()                                       
                    
  rollback tran  Castigo                  
                    
  RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState)                                                       
  RAISERROR( 'NO SE PUDO REALIZAR EL CASTIGO',16, -1) WITH SETERROR                                                                       
      END                                                       
                             
     RETURN                                          
 end catch                       
      
                   
                   
 end 