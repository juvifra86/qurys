--Creado por JVFM 2015-05-14    
--Procedimiento para Castigar cuentas              
--Toma el número de cuenta Respalda las amortizaciones y NotaCargo              
--luego Cancela los conceptos en NotaCargo y Amortizacion, y liquida capital        
--ejecuta el SPSOFIA_InsertaPagos_Logra para obtener idpago, una vez que tiene ejecuta SPsofia_procesapagocte.    
--cambia el status a 235 y da finish a la cuenta en cuentacte    
    
	
Alter Procedure SPSOFIA_CuentasCastigadas              
(@CuentaCteId int,              
@usuario nvarchar(50),              
@Cobsv nvarchar(50),          
@FechaCastigo date)           
 as                                        
 set nocount on                                        
begin       
	declare @fecha date  
	set @fecha = (select max(FechaVencimiento) from Amortizacion where CuentaCteId=@CuentaCteId and ConceptoContableId=46)
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
		declare @Nombre varchar(40),
		  @Producto varchar(30),
		  @diasdatraso int,
		  @IntMoratorio money,
		  @IvaMoratorio money,
		  @IntOrdinario money,
		  @IvaOrd money,
		  @SubtotalInt money,
		  @SeguroAuto money,
		  @SeguroDesempleo money,
		  @SeguroVida money,
		  @Subtotalseg money,
		  @Capital money,  
		  @Total money	

	insert into @tblCargosyPagosPeriodo          
	select  tblkey, ConceptoContable, Desglose, tipocargo, boleta, fechaemision, fechavencimiento,          
	fechaliquida, estadopoid, importeemitido, ImportePagado, saldo, diasatraso, BoletaASustituir from  FNSOFIA_GetCargosyPagosPeriodoEdoCtaInterno  (@cuentacteid,@FechaCastigo,@FechaCastigo)           
    
	insert into MasterCollectionCastigo
	select * from mastercollection where Contrato=@CuentaCteId and cargasiop=0 and fechacarga=(select max(fechacarga) from mastercollection where Contrato=@CuentaCteId)
  
	set @Nombre=(select NombreCompleto from vwNombreCte where CuentaCtekey=@cuentacteid) 
	set @Producto=(select TipoProdDsc from vwCuenta where  vwCuenta.CuentaCtekey=@cuentacteid)   
	set @Capital = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)             
	set @diasdatraso=(select max(diasatraso) from  @tblCargosyPagosPeriodo) 
	set	@IntMoratorio= (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)  
	set	@IvaMoratorio= (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)  
	set @IntOrdinario= (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)  
	set	@IvaOrd= (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)  
	set	@SubtotalInt =(@IntMoratorio+@IvaMoratorio+@IntOrdinario+@IvaOrd)
	set	@SeguroAuto = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)  
	set	@SeguroDesempleo= (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)  
	set	@SeguroVida = (select isnull(SUM(saldo),0) from @tblCargosyPagosPeriodo where ConceptoContable = 46 group by ConceptoContable)  
	set	@Subtotalseg =(@SeguroAuto+@SeguroDesempleo+@SeguroVida)  
	set	@Total=	(@Capital+@Subtotalseg+@SubtotalInt)

begin try          
begin tran  Castigo                      

insert into rtpcastigo values(@CuentaCteId,@Nombre,@Producto,0,@fechacastigo,@diasdatraso,@IntMoratorio,@IvaMoratorio,
@IntOrdinario,@IvaOrd,@SubtotalInt,@SeguroAuto,@SeguroVida,@SeguroDesempleo,@Subtotalseg,@Capital,@Total)                               
INSERT INTO CuentasCastigadas values (@CuentaCteId, @fechacastigo, @usuario, @cobsv)

          
UPDATE NotaCargo SET ImporteEmitido = 0, EstadoPOId = 28 WHERE ConceptoContableId <> 46 And CuentaCteId =@CuentaCteId;              
UPDATE Amortizacion SET ImporteEmitido = 0, EstadoPOId = 23 WHERE ConceptoContableId <> 46 and CuentaCteId = @CuentaCteId;
                
declare @tasa float
select @tasa=TasaMoratorio from CuentaCte where CuentaCtekey=@CuentaCteId
update CuentaCte set TasaMoratorio=0 where CuentaCtekey=@CuentaCteId

declare @Referencia nvarchar(60)          
set @Referencia = 'Bonificación por Cartera Castigada'
Declare @IdPago as table(idpago int)       
insert @IdPago EXEC SPSOFIA_InsertaPagos_Logra  @CUENTACTEID, @FECHACASTIGO, @FECHACASTIGO, @FECHACASTIGO,@CAPITAL,0,@REFERENCIA, 1,1,0,4,11,@Usuario, 0,1, 0,0,R          
declare @pag as int
select @pag=idpago from @IdPago         
exec SPSOFIA_ProcesaPagoCte @cuentacteid,@pag,@FechaCastigo          
update rtpcastigo set NoPago=@pag where CuentaCtekey=@CuentaCteId       
Update CuentaCte set situacion=235,Finish = @FechaCastigo where CuentaCtekey = @CuentaCteId 
update CuentaCte set TasaMoratorio=@tasa where CuentaCtekey=@CuentaCteId
update MasterCollectionCastigo set mes1=0,mes2=0,mes3=0,mes4=0,mes5=0,mes6=0,mes7=0,MesMas8=0,SaldoSeguros=0,InteresesMoratorios=0,MontoBoletaVigente=0,
MensualidadVigente=0,SaldoVencido=0,SaldoExigible=0,SaldoInsoluto=0,Balance=@Capital,Legal=1,Bucket=0,MopBuro='99',PorcCapital=0,ReservaCapital=0,ReservaInteres=0,
Situacion='Probable Castigo' where Contrato=@CuentaCteId
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