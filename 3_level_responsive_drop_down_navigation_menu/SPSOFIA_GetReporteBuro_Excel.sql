/*                                                             

                                                          

 CREO. EZM                                                                                                 

 SP QUE OBTIENE LOS DATOS PARA EL REPORTE DEL BURO INTF-10081                                                              

                     

                

                     

 Sintaxis                    

 @fechacorte: Periodo, siempre es el ultimo dia del Mes                                                          

 @Empresa : Numero de Empresa                                                              

                                                         

        (mes, año, Empresa)                                                           

 EXEC   [SPSOFIA_GetReporteBuro_Excel] 7,2016,1,5      

               

                                                            

*/                                                              

ALTER  PROCEDURE [dbo].[SPSOFIA_GetReporteBuro_Excel] 

@mes AS integer,

@anio as integer,

@empresa AS SMALLINT,

@Periodo as integer        

AS                                            

                                      

--Variables para calcular la fecha siempre indicando el ultimo dia del mes-------------------                                                          

declare @fechaCorte as date                                                          

declare @UltimaFecha as varchar(20)                                                          

                                                     

declare @PrimerFecha as varchar(20)                                          

declare @diaEscogido integer                                                         

                                                          

                                                        

set @fechaCorte = 

	---Si es Mensual toma la ultima fecha de la tabla CarteraCte

case when @periodo = 5 then

	(select MAX(FechaCorte)                         

	from CarteraCte with(nolock) where Ejercicio = @anio and Periodo = @mes)

	

	---Si es semanal toma la ultima fecha de la tabla CarteraCteFinaliza

	else 

	(select MAX(FechaCorte)                         

	from CarteraCteFinaliza with(nolock) where Ejercicio = @anio and Periodo = @mes )

	

	end

----------------------                                                                         

set @UltimaFecha = replace(convert(varchar(10),CAST(@fechaCorte as DATE),103),'/','')                   

                   

--------------------------------------------------------------------------------------------                                                          

                                                              

DECLARE @tbldatos TABLE(                                                          

 --CuentaCteId INT,                                                               

 HD varchar (10),                                                        

                                                      

                                                         

 --Nombre                                                        

  PN_Paterno varchar(100),  --26                                         

 [00_Materno] varchar (100),   --26                                                     

 [02_Nombre] varchar (100),      --26                                                  

 [03_SegundoN] varchar(100), --26                                                       

 [04_fdn] DATE,                                                        

 [05_RFC] varchar(20),                                                        

 [11_EdoCivil] varchar(1),                                                        

 [12_Sexo] varchar (1),                                                        

 [20_f_def] dATE,                                                        

 [21_Ind_Def] varchar(1),                                                        

                                                        

 --Direccion                                                              

 [PA_Calle]   varchar(40),                                                       

 [00_Calle2]   varchar(40),                                                        

 [01_Colonia]   varchar (40),                             

 [02_Municipio]   varchar(40),             

 [03_Ciudad]   varchar(40),                                           

 [04_Estado]   varchar (4),                                                   

 [05_Cp]   varchar(10),                                                 

 [07_TelDom] varchar(11),                                                        

 [12_Origen del Domicilio] varchar(2),
 
 [PE_Nombre o Razón Social del Empleador] varchar(8000),

[18_Origen de la Razón Social] varchar(4),                                                   

 --Cuentas                                                         

                                                         

 [TL_cuentas] varchar(2),                                                        

 [01_Otorgante] varchar(10),                                                        

 [02_NomOtorga] varchar(16),                                                        

 [04_Cuenta] varchar (25),                                                          

 [05_Resposabilidad]varchar(1),                                                        

 [06_TipoCta] varchar(1),                                                        

 [07_TipoContrato] varchar (2),                                                        

 [08_Moneda] varchar(2),                                                        

 [10_NumPagos] varchar (4),                                                        

 [11_FrecPagos]varchar(1),                                                        

 [12_monto] varchar (9),                                                        

 [13_DteApertura] DATE,                                                        

 [14_DteUltPago]date,                                                        

 [15_DteCompra] date,                                                        

 [16_DteCierre] date,                                                        

 [17_DteReporte] date,                                                        

 [21_CredMaximo] varchar (9),                                                        

 [22_SdoActual] varchar (10),                                                        

 [23_LimCredito] varchar(9),                                                        

 [24_Saldovencido] varchar(30),                                                        

 [25_vencidas] varchar (4),                                                        

 [26_MOP] varchar (2),                                                        

 [30_Observacion] varchar(24),    
 
 [43_Fecha de Primer Incumplimiento] date,
 [44_Saldo Insoluto de Capital] money,
 [45_Monto del último pago] money,
 [46_Fecha de Ingreso a Cartera Vencida] date,
 [47_Monto correspondiente a intereses] money,
 [48_Forma de Pago actual (MOP de los intereses)] varchar(4),
 [49_Días de Vencido] int,[50_Plazo en Meses] int,
 [51_Monto del Crédito de Originación] money,
 [52_Correo Electrónico] varchar(200),                                                    

 [99_fin] varchar(3)                                                                                        

  )                                                                    

                                                             

                                                            

DECLARE @countreg INT,                                                              

  @saldo AS Int                                                              

                                             

                                                              

-----------------------------------INSERTAMOS EN @tbldatos--------------------------------------------------                                                              

                  

                                                               

INSERT INTO @tbldatos         

select          

      [HD],[PN_Paterno],[00_Materno],[02_Nombre],[03_SegundoN],cast([04_fdn] as date)[04_fdn] ,[05_RFC],[11_EdoCivil],[12_Sexo],      

            

      case when cast([20_f_def]as date) = '19000101' then null       

   else [20_f_def] end [20_f_def],         

            

      [21_Ind_Def],        

            

      DBO.TRIM([PA_Calle]),DBO.TRIM([00_Calle2]),DBO.TRIM([01_Colonia]),DBO.TRIM([02_Municipio]),DBO.TRIM([03_Ciudad]),        

      [04_Estado],[05_Cp],[07_TelDom],[12_Origen del Domicilio],[PE_Nombre o Razón Social del Empleador],

	  [18_Origen de la Razón Social], [TL_cuentas],[01_Otorgante],        

      [02_NomOtorga],[04_Cuenta],[05_Resposabilidad],[06_TipoCta],[07_TipoContrato],[08_Moneda],[10_NumPagos],[11_FrecPagos],        

      [12_monto],      

            

      case when [13_DteApertura] = '19000101' then null       

   else cast([13_DteApertura] as date) end [13_DteApertura],         

            

      case when [14_DteUltPago] = '19000101' then null       

   else cast([14_DteUltPago] as date) end [14_DteUltPago],         

            

      case when [15_DteCompra] = '19000101' then null       

   else cast([15_DteCompra]as date) end [15_DteCompra],            

       

            

      case when [16_DteCierre] = '19000101' then null       

   else cast([16_DteCierre] as date) end [16_DteCierre],            

         

         

      cast([17_DteReporte] as date)[17_DteReporte],      

      [21_CredMaximo],[22_SdoActual],        

      [23_LimCredito],[24_Saldovencido],[25_vencidas],[26_MOP],[30_Observacion],
	  
	  case when [43_Fecha de Primer Incumplimiento]= '19000101' then null       

       else cast([43_Fecha de Primer Incumplimiento] as date)end [43_Fecha de Primer Incumplimiento],

	  [44_Saldo Insoluto de Capital],
      [45_Monto del último pago],

      case when [46_Fecha de Ingreso a Cartera Vencida]= '19000101' then null       

       else cast([46_Fecha de Ingreso a Cartera Vencida] as date)end [46_Fecha de Ingreso a Cartera Vencida],

      [47_Monto correspondiente a intereses],

      [48_Forma de Pago actual (MOP de los intereses)],
      [49_Días de Vencido],
	  [50_Plazo en Meses],
      [51_Monto del Crédito de Originación] ,
      [52_Correo Electrónico],
	  [99_fin]        

from ResultadosBuroCredito   with(nolock)     

      

where EmpresaID = @empresa      

and CAST([init] as date) = cast(@fechaCorte as date) and finish is null and [status] = 0        

and PeriodoId = @Periodo

        

                                                

SELECT * FROM @tbldatos       

      

      

      

      

--select * from ResultadosBuroCredito