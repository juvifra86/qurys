/*                                        

Creo : Mauricio Rojas V                                        

Descripcion : proceso que obtiene la informacion a reportar de personas morales                                        
Sintaxis:                    

                       

Exec [SPSOFIA_getdatosPM_Texto] 1,'20130905'                 

Exec [SPSOFIA_getdatosPM_Texto] 1,'20160729',5

                    

          select * from ResultadosBuroCreditoPM where Tempresas is  null          

*/                                        

                                          

ALTER  Procedure [dbo].[SPSOFIA_getdatosPM_Texto]                        

     @EmpresaID Tinyint,                       

     @Periodo Date,    

     @CatPeriodoId integer    
                     

As               

                        

-- = = = = = = = = = = = = = = = = = = = = = = =               

              
declare @nombreotrogante as varchar(50)

Declare @Fecha char(8)                                        

Declare @NumPeriodo char(6)                                        

Declare @mes  int                                         

Declare @año int                                        

Declare @UltimaFecha date           

      

Declare @usuarioFinanciera varchar(4) = '1082'                                   

Declare @usuarioAuto varchar(4) = '9072'                                   

                                        

        Set @Fecha=REPLACE(CONVERT(varchar,@Periodo,103),'/','')                                        

        Set @NumPeriodo=SUBSTRING(@Fecha,3,6)                                        

        Set @mes=DATEPART(MONTH,@Periodo)                                         

        Set @año=DATEPART(YEAR ,@Periodo)                                         

                                        

       -------------------CALCULA FECHA SEMANAL    

  declare @today  date            

  ,  @diasem  tinyint            

  ,  @fechaini   date             

  ,  @fechafin   date             

  ,  @DteCorte   date             

            

Set @diasem= DATEPART(dw,@Periodo)            

Set nocount on            

            

----- DETERMINAMOS LA FECHAS DE PERIODO ANTERIOR            

/**********************************************************/            

if @diasem=1            

begin            

  Set @fechaini = DATEADD(wk,-1,@Periodo)            

  Set @fechafin = DATEADD(dd,4,@fechaini)            

 End            

else            

begin            

 Set @diasem = @diasem-1            

 Set @today = DATEADD(dd,@diasem*-1,@Periodo)            

 Set @fechaini = DATEADD(wk,-1,@today)            

 Set @fechafin = DATEADD(dd,4,@fechaini)            

 End       

--------------------------------    

    

    

if @CatPeriodoId = 5    

begin    

     Set @UltimaFecha=(Select Top 1 FechaCorte From CarteraCte with (nolock) Where Ejercicio =@año and Periodo = @mes Order By FechaCorte Desc)                                      

end    

                                      

else    

begin    

   Set @UltimaFecha= @fechafin    

end    

  

  Set @Fecha=REPLACE(CONVERT(varchar,@UltimaFecha,103),'/','')                                        

        Set @NumPeriodo=SUBSTRING(@Fecha,3,6)                                        

        Set @mes=DATEPART(MONTH,@UltimaFecha)                                         

        Set @año=DATEPART(YEAR ,@UltimaFecha)          

  

                                      
select @nombreotrogante=NombreBC from Empresa where EmpresaKey=@EmpresaID
                                        

-- === Crea el Encabezado ============================================================================              

Declare @header Char(180)                                            

              

        Set @header= case when @EmpresaID = 1 then  'HDBNCPM00'+ @usuarioFinanciera +'0100000200503104' + @Fecha + '05' + @NumPeriodo +'060407'+@nombreotrogante+space(75-len(@nombreotrogante))+'08'+space(52)----------FINANCIERA      

              else 'HDBNCPM00'+ @usuarioAuto +'0100000200503104' + @Fecha + '05' + @NumPeriodo +'060407'+@nombreotrogante+space(75-len(@nombreotrogante))+'08'+space(52) end   ----AutoAhorro      

                            

                          

-- === Declara la Tabla Temporal para Almacenar los Datos Filtrados =================================              

Declare @ConsultaBuroPM Table(SegmentoEMEM Varchar(Max),              

                              SegmentoCRCR Varchar(Max),              

                              SegmentoDEDE1 Varchar(Max),              

                              SegmentoDEDE2 Varchar(Max),              

                              BoletaxVencer Float,              

                              Vencido Float,              

                              Cantidad1 Decimal(30,0),              

                              Cantidad2 Decimal(30,0),              

                              SumaSaldoVencido Decimal(30,0),                

                              TEmpresas Varchar(15),                                             

                              Header Varchar(Max)              

                              )              

/*              

  Captura los Datos de la consulta para el Buro de Credito en la Tabla                     

  Campos que se Incluyen para formar cada uno de los segmentos de Buro de Credito              

*/              
Insert Into @ConsultaBuroPM                                     
Select                               
      -- [Segmento EM]                      
     'EMEM' +                      
       '00' + dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_EM,''),13)-- RFC          
     + '01' + dbo.FNSOFIA_GetCadenaBC('C',isnull(curp,''),18)-- Curp                   
     + '02' + dbo.FNSOFIA_GetCadenaBC('C',isnull(NumBC,''),10)-- NumBC          
     + '03' + dbo.FNSOFIA_GetCadenaBC('C',isnull(SUBSTRING(RazonSocial,1,75),''),75) -- [RazonSocial]                        
     + '04' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Nombre1,''),75) -- Nombre1                         
     + '05' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Nombre2,''),75)-- Nombre2                      
     + '06' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Apaterno,''),25) -- Apaterno                      
     + '07' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Amaterno,''),25) -- Amaterno                      
     + '08' + dbo.FNSOFIA_GetCadenaBC('C',isnull('MX',''),2) -- Nacionalidad                      
     + '09' + dbo.FNSOFIA_GetCadenaBC('C',isnull('B3',''),2) -- Calif                                          
     + '10' + dbo.FNSOFIA_GetCadenaBC('C',isnull(banxico1,''),11)--- Banxico1                                           
     + '11' + dbo.FNSOFIA_GetCadenaBC('C',isnull(banxico2,''),11) -- Banxico2                                           
     + '12' + dbo.FNSOFIA_GetCadenaBC('C',isnull(banxico3,''),11) -- Banxico3                                          
     + '13' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Domicilio,0),40) --[Domicilio]                      
     + '14' + dbo.FNSOFIA_GetCadenaBC('C',isnull('',''),40) --[Domicilio2]                                          
     + '15' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Colonia,''),60)  -- [Colonia]                                          
     + '16' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Delegacion,''),40) -- [Delegacion]                                          
     + '17' + dbo.FNSOFIA_GetCadenaBC('C',isnull('',''),40) --[Ciudad]                                          
     + '18' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Estado,''),4) -- Estado                    
     + '19' + dbo.FNSOFIA_GetCadenaBC('C',isnull(CP,'') ,10) --CP                                       
     + '20' + dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,11)-- [telefono]                                          
     + '21' + dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,8) -- [Ext]                                          
     + '22' + dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,11) --[Fax]                        
     + '23' + dbo.FNSOFIA_GetCadenaBC('C',isnull(tipoCliente,'') ,1) --tipoCliente                                          
     + '24' + dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,40) --[Estado Extranjero]                             
     + '25' + dbo.FNSOFIA_GetCadenaBC('C',isnull(PaisDom,'') ,2)--[Pais Origen Domicilio]            
	--[Segmento AC]
	+ 'AC'+dbo.fn_CambiaCaracterBuro(Accionistas)+space(30)                               
   --[Segmento CR]                      
     ,'CRCR'                       
     + '00' + dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_CR,''),13) --RFC CREDITO          
     + '01' + dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,6) --[Numero de Experiencias crediticia]     
     + '02' + dbo.FNSOFIA_GetCadenaBC('C',isnull(NoContrato,''),25) --[NoContrato]                                          
     + '03' + dbo.FNSOFIA_GetCadenaBC('C',isnull('','') ,25) --No Contrato Anterior          
     + '04' + dbo.FNSOFIA_GetCadenaBC('C',isnull(FechaApert,'') ,8) --[FechaApert]                                          
     + '05' + dbo.FNSOFIA_GetCadenaBC('N',isnull(Plazo,0),5) -- [Plazo]                                          
     + '06' + dbo.FNSOFIA_GetCadenaBC('N',isnull(TipoCred,''),4)  --  [TipoCred]                                          
     + '07' + dbo.FNSOFIA_GetCadenaBC('N',isnull(cast(saldoIni as int),0) , 20) --[SaldoIni]                                          
     + '08' + dbo.FNSOFIA_GetCadenaBC('N',isnull(Moneda,0),3)             --[Moneda]          
     + '09' + dbo.FNSOFIA_GetCadenaBC('N',isnull(NumPagos,0),4)   --[NumPagos]                                          
     + '10' + dbo.FNSOFIA_GetCadenaBC('N',isnull(FrecPag,0),3)           --[Frecuencia de Pagos]                                          
     + '11' + dbo.FNSOFIA_GetCadenaBC('N',isnull(cast(ImportePago as int),0),20)  --[ImportePago]                                          
     + '12' + dbo.FNSOFIA_GetCadenaBC('C',isnull(UltimaFechaPago,''),8)--[UltimaFechaPago]                                       
     + '13' + dbo.FNSOFIA_GetCadenaBC('N',isnull(DteReestructura,0),8)  -- [DteReestructura]           
     + '14' + dbo.FNSOFIA_GetCadenaBC('N',isnull(PagoEfec,0),20) --[pagoEfec]                                          
     + '15' + dbo.FNSOFIA_GetCadenaBC('N',isnull(DteLiquida,0),8)  --[DteLiquida]                                             
     + '16' + dbo.FNSOFIA_GetCadenaBC('N',isnull(montoQuita,0),20) --[montoQuita]                                          
     + '17' + dbo.FNSOFIA_GetCadenaBC('N',isnull(montoDacion,0),20) --[montoDacion]                                            
     + '18' + dbo.FNSOFIA_GetCadenaBC('N',isnull(montoQuebranto,0),20) --[montoQuebranto]                                          
     + '19' + dbo.FNSOFIA_GetCadenaBC('C',isnull(ClaveObs,''),4) --[ClaveObs]                                            
     + '20' + dbo.FNSOFIA_GetCadenaBC('C',isnull(Especial,''),1) --[Especial] 
	 + '23'+ cast([23_Crédito Máximo Autorizado] as varchar(15))                                      
     + '24' + space(107) --[FillerCR]                      
    --[Primer Segmento DE]                      
     , 'DEDE' --SEGCR                      
     + '00' + dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_DE1,''),13)-- RFC  Detalle 1          
     + '01' + dbo.FNSOFIA_GetCadenaBC('C',isnull(noContratoDE1,''),25) -- [NoContrato DE1]          
     + '02' + dbo.FNSOFIA_GetCadenaBC('N',isnull(VencidoDE1,0),3) --[Vencido]               
     + '03' + dbo.FNSOFIA_GetCadenaBC('N',isnull(CantidadDE1,0), 20)--[Cantidad]                
     + '04' + space(75)  --[FillDE]                                          
     ----------------------------VENCIDO--------------------------------------                       
     --[Segundo Segmento DE]                      
     , 'DEDE'                      
     + '00' + dbo.FNSOFIA_GetCadenaBC('C',isnull(RFC_DE2,''),13)-- RFC                                    
     + '01' + dbo.FNSOFIA_GetCadenaBC('C',isnull(NoContratoDE2,''),25) -- [NoContratoDE]                                          
     + '02' + dbo.FNSOFIA_GetCadenaBC('N',isnull(VencidoDE2,0),3) --[Vencido]                     
     + '03' + dbo.FNSOFIA_GetCadenaBC('N',isnull(CantidadDE2,0),20)--[Cantidad]          
     + '04' + space(75)  --[FillDE]    
	 --[Segmento Avales]
	 + 'AV'+DBO.fn_CambiaCaracterBuro(Avales)+space(94)                                    
     ------------------------------------------------------------------                                        
     , BoletasXVencer  -- Total de Boletas por Vencer                                       
     , cast(SaldoTotalBoleta as Int) --Campo Saldo Total de la Boleta    [VENCIDO]                                   
     ,isnull(CantidadDE1,0)  --[CantidadDE1]                                    
     ,isnull(CantidadDE2,0)  --[CantidadDE2]                                                      
     /*                
       Sumar Totales                 
       [La suma del total de saldo para el segmento TSTS se realiza                 
       sumando el campo cantidad del segmento DEDE1 y el campo cantidad del segmento DEDE2]                
       [CantidadDE1] + [CantidadDE2]                
    */              
    ,isnull(CantidadDE1,0) + isnull(CantidadDE2,0) -- SumaSaldoVencido          
    ,Tempresas --TEmpresas -----------SE DEJA SI ES NULO          
    ----- [Encabezado - Header] -----------------------------------------------------------------------------------------------------                                       
     ,@header                  
    from ResultadosBuroCreditoPM with (nolock)         
     where empresaID =  @EmpresaID                                 
     and cast(init as date) =  cast(@UltimaFecha as date)          
     and finish is null          
     and status = 0     
     and periodoid = @CatPeriodoId         
     Order By [RazonSocial] Desc--,d.DiasAtraso Desc              
  -------------------------------Crea el Segmento TSTS ----------------------------------------------------          
Declare @TotalEmpresa Integer,                 
        @SumaSaldo Varchar(30),                         
        @SegmentoTSTS varchar(4),                
        @SumaTotalEmpresas varchar(7),                
        @SumaTotalSaldo varchar(30),                
        @FillerTS Varchar(53) ,                
        @SEGTSTS Varchar(Max)               
Select @SumaSaldo = Sum(SumaSaldoVencido) From @ConsultaBuroPM                      
Select @TotalEmpresa = count(distinct(TEmpresas)) From @ConsultaBuroPM where TEmpresas is not null                
Set @SegmentoTSTS = 'TSTS'                                 
Set @SumaTotalEmpresas = (dbo.FNSOFIA_GetCadenaBC('N',cast(@TotalEmpresa as varchar(7)) , 7))    --[TotalEmpresa]                                      
Set @SumaTotalSaldo= (dbo.FNSOFIA_GetCadenaBC('N',cast(@SumaSaldo as varchar(30)) , 30))  --[SumaSaldo]                                        
Set @FillerTS = space(53) --[FillTS]                    
Set @SEGTSTS = @SegmentoTSTS           
    + '00' + @SumaTotalEmpresas           
    + '01' + @SumaTotalSaldo        
    + '02' + @FillerTS              
-- ==== Mostrar el Resultado Para Buro de Credito Para Personas Morales =====================================================              
Select              
SegmentoEMEM,              
SegmentoCRCR,              
BoletaxVencer,              
Vencido,              
SegmentoDEDE1,              
SegmentoDEDE2,              
@SEGTSTS[SegmentoTSTS],              
Header        
From @ConsultaBuroPM 