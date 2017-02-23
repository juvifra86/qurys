/*                
Toma todos los clientes que la fecha de inicio del cotrato sea en el mes especificado                
                
SpSofia_InsertaClientesCartera021215  '20151030',2        
*/                
                
ALTER Procedure SpSofia_InsertaClientesCartera021215                
@Fecha as date,                
@EmpresaId integer                
as                
begin                
                
                
-----------------------------Obtiene el primer y ultimo día del mes                   
                
--declare @EmpresaId as integer                
--set @EmpresaId = 1                     
                        
declare @fechaInicioCAL as date,                 
  @fechaFinCAL as date,                
  @FechaFinalCartera as date                
        --------Fecha de Inicio                
select @fechaInicioCAL = fechaini,                
    @fechaFinCAL = Fechafin                
    from FNSOFIA_GetDiasMes(@Fecha)                     
                    
    --------Fecha de fin ------Toma el ultimo día de la tabla carteracte del mes a consultar                
                    
    set @FechaFinalCartera = (select MAX(fechaCorte)from carteracte where cast(FechaCorte as date) between cast(@fechaInicioCAL as date) and cast(@fechaFinCAL as date))                
                    
--select @fechaInicioCAL,@fechaFinCAL,@FechaFinalCartera                
--   RETURN             
--select *                 
--from CuentaCte CC                
--where cast(FechaInicio as date) between CAST(@fechaInicioCAL as date) and CAST(@fechaFinCAL as date)                
--and CicloCorteId in (1,2,3)                
--and Situacion <> 14                
--and CC.CuentaCtekey not in (select CuentaCteId from carteracte where cast(FechaCorte as date) = @FechaFinalCartera)                
                
---276                
                
                
declare @TablaClientesxGenerar as table (CuentaCteKey integer,          
           CicloCorteid integer,          
           FechaInicio date,           
           FechaSiguienteCorte date,           
           FechaPagoProv date,          
           TipoFiscal varchar(2))                
                
---------------Se obtienen todos los clientes que caigan en los filtros                
insert into @TablaClientesxGenerar                
                
select CC.CuentaCtekey,CC.CicloCorteId,CC.FechaInicio,                
  isnull((Select FechaVencimiento from Amortizacion where CuentaCteId = CC.CuentaCtekey and boleta = 1 and ConceptoContableId = 46),null)FechaSiguienteCorte,                
  CC.FechaPagoProv,          
  vw.TipoFiscal                
                  
from CuentaCte CC                
join vwCuenta vw on vw.CuentaCtekey = CC.CuentaCtekey                
--where cast(CC.FechaInicio as date) between CAST(@fechaInicioCAL as date) and CAST(@fechaFinCAL as date)                
where cast(CC.FechaPagoProv as date) between CAST(@fechaInicioCAL as date) and CAST(@fechaFinCAL as date)                
and CC.CicloCorteId in (1,2,3)                
and CC.Situacion in (72)--,233)  
and CC.CuentaCtekey not in (select CuentaCteId from carteracte where cast(FechaCorte as date) = @FechaFinalCartera)     
and CC.CuentaCtekey not in (select CuentaCteID from CtaSiopSofia where NoTraspaso = 5)           
and CC.EmpresaId = @EmpresaId                
and vw.TipoFiscal in('F','M')---lo genera para personas fisicas y Morales          
                
-------Se eliminan todos los que no tengan tabla de amortizar    
--select * from  @TablaClientesxGenerar
--return
           
delete from @TablaClientesxGenerar where FechaSiguienteCorte is null                
                
------Se eliminan todos los que su siguiente corte sea menor a la fecha de fin de mes del mes consultado                
delete from @TablaClientesxGenerar where cast(FechaSiguienteCorte as date)  < = cast(@fechaFinCAL as date)                
                
--select * from @TablaClientesxGenerar                
                
declare @CarteraTemp as table (                
CuentaCteId bigint,                
EstadoCuenta smallint,                
UltimaBoletaPag smallint,                
BoletasVencidas smallint,                
UltimaFechaPago date,                
DiasAtraso smallint,                
SiguienteFechaVenc date,                
MopBuro char,                
Ejercicio smallint,                
Periodo tinyint,                
DespachoId smallint,                
FechaCorte date,                
SaldoCapital decimal,                
SaldoInteres decimal,                
SaldoIva decimal,                
InteresMora decimal,                
IvaMora decimal,       
InteresMoraPagado decimal,                
IvaMoraPagado decimal,                
SaldoTotalBoleta decimal,                
SegCV1 decimal,                
SegCV2 decimal,                
SegCV3 decimal,                
SegCV4 decimal,                
SegCV5 decimal,                
SegCV6 decimal,                
SegCV7 decimal,                
SegCV8 decimal,                
SegCV9 decimal,                
SegmentoCarteraId tinyint,                
SegmentoCVId tinyint,                
BoletasXVencer smallint,                
BoletasXVencerSinActual smallint,                
SaldoInsolutoConActual decimal,                
SaldoInsolutoSinActual decimal,                
SaldoTotalBoletaConAccesorios decimal,                
SeguroAuto money,                
SeguroVida money,                
SeguroDesem money,                
SeguroUDI money,                
SaldoSeguros money,                
SaldoTotalCapital money,                
SaldoTotalInteres money,                
SegmentoReservaID smallint,                
ReservaCapital money,                
ReservaInteres money                
                
)                
                
                                            
Begin Tran                                                 
begin Try                 
                
declare @CuentaCteKey integer,                
  @FechaSiguientecorte date,          
  @TipoFiscal varchar(2)                
                
 declare cursorInsertaCartera cursor for                                          
      select CuentaCteKey,                  
    FechaSiguientecorte,          
    TipoFiscal                
    from @TablaClientesxGenerar                
    --where CuentacteKey in (5424,5919,5925,5953)                
                
Open cursorInsertaCartera                                          
    fetch cursorInsertaCartera into                     
    @CuentaCteKey,                
    @FechaSiguientecorte,                
    @TipoFiscal                
    while (@@FETCH_STATUS = 0)                                          
     begin                 
                     
     --------------Inserta cada clinte encontrado en la tabla de CarteraCte                     
                     
     exec  [SPSOFIA_GetCarteraVencidaCta]  @FechaSiguientecorte  ,0 ,@CuentaCteKey,1   --Cambiar a uno solo para consulta  (el primer cero)           
     --exec  [SPSOFIA_GetCarteraVencidaCta]  @FechaFinalCartera  ,0 ,@CuentaCteKey,1   --Cambiar a uno solo para consulta                
     update CarteraCte set FechaCorte =  @FechaFinalCartera,                 
             
     SaldoCapital = case  when @TipoFiscal = 'F' then 0         
     else SaldoCapital end,        
             
     SaldoInteres = case  when @TipoFiscal = 'F' then 0         
     else SaldoCapital end,  ----Para que el reporte muestre que no debe nada campo 24      
           
     SaldoTotalBoleta = case  when @TipoFiscal = 'F' then 0         
     else SaldoCapital end,  ----       
             
     BoletasVencidas = case @TipoFiscal when 'F' then 0  ---Es de reciente actividad y no tiene movimientos aun    SOLO LAS PERSONAS FISICAS para MORALES NO SE PIDE        
          when 'M' then BoletasVencidas end,             
             
             
     MopBuro = case @TipoFiscal when 'F' then '00'  ---Es de reciente actividad y no tiene movimientos aun    SOLO LAS PERSONAS FISICAS para MORALES NO SE PIDE        
        when 'M' then MopBuro end        
                
                
     where CuentaCteId = @CuentaCteKey and cast(FechaCorte as DATE) =  cast(@FechaSiguientecorte as date)                
                     
     --------------Inserta las cuentas en la tabla ClinetesAgregadosCarteracte para que puedan ser identificados para cualquier aclaración              
     insert into ClinetesAgregadosCarteracte values              
     (@CuentaCteKey,MONTH(@FechaFinalCartera),YEAR(@FechaFinalCartera),dbo.SOFIAGETDATE(),@FechaFinalCartera,@EmpresaId,@TipoFiscal)              
                   
                     
      fetch cursorInsertaCartera into                     
  @CuentaCteKey,                
  @FechaSiguientecorte,          
  @TipoFiscal                
                    
    End                
                                                  
  CLOSE cursorInsertaCartera                                                                
  DEALLOCATE cursorInsertaCartera                    
                     
Commit Tran                                         
   end try                  
                
 ----------Comienza el cacth Errores                                             
   Begin Catch                               
   if @@TRANCOUNT > 0                                                              
   Rollback Tran                                               
    CLOSE cursorInsertaCartera                                                                
DEALLOCATE cursorInsertaCartera                                        
   select  ERROR_NUMBER() AS ErrorNumber                                                            
   ,ERROR_SEVERITY() AS ErrorSeverity                                                             
   ,ERROR_STATE() AS ErrorState                                                                
   ,ERROR_PROCEDURE() AS ErrorProcedure                                                                
   ,ERROR_LINE() AS ErrorLine                                                                
   ,ERROR_MESSAGE() AS ErrorMessage;                                                                
   End Catch                    
                 
                
 end