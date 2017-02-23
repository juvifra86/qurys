   /*          

 exec [SPSOFIA_GetReporteBuro_Texto]   7,2016,2,5

   */          

            

ALTER procedure [SPSOFIA_GetReporteBuro_Texto]            
       
@mes AS integer,            

@anio as integer,            

@empresa AS SMALLINT,  

@periodo as integer            
        

as            

BEGIN            

--Variables para calcular la fecha siempre indicando el ultimo dia del mes-------------------                                                                  

declare @fechaCorte as date                                                                  

declare @UltimaFecha as varchar(20)            

                 

                      

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

                                                                                             

set @UltimaFecha = replace(convert(varchar(10),CAST(@fechaCorte as DATE),103),'/','')                       

         

----------------------TABLA DONDE SE ALMACENAN LOS DATOS GENERADOS-----------            

DECLARE @tbldatos TABLE(                                                                  

  CuentaCteId INT,                                                                      

  Header VARCHAR(150),                                                                            

  Cadena VARCHAR(8000),                                                                      

  Total VARCHAR(8000),                                                                      

  SaldoActual INT,                                                                

  SaldosVencidos int                                                                

  )                                                                      

                                  

DECLARE @countreg INT,                                 

  @saldo AS Int                                                                      

                           

declare @saldosvencidos as integer                  

            

INSERT INTO @tbldatos              

SELECT distinct CuentaCtekey,                                                                      

----------------------------------------------------ENCABEZADO----------------------------------------------                                                                       

   'INTF'             --Etiqueta del Segmento                                                                  

 + '14'             --Version                                                                   

 + replicate(0,10 - len([HD])) + [HD]  --Clave de Usuario                                                                  

 + dbo.trim([02_NomOtorga]) + replicate(char(32), 16 - Len([02_NomOtorga]))--Nombre de Usuario (empresa)          

 + REPLICATE(char(32),2)        --Numero de Ciclo                                                                  

 + @UltimaFecha           --Fecha de Reporte                                                                    

 + REPLICATE (0,10)          --Uso Futuro                                                                         

 + REPLICATE(CHAR(32),98)        --Informacion adicional del usuario               

             

   /*          

   [SPSOFIA_GetReporteBuro1_VerFinal]03,2013,1          

   */          

 -------------------------------------------SEGMENTO DE NOMBRE----------------------------------------------------------------                                                                       

           

 ,'PN'       ----Si bo hay apellido PATERNO se pone el MATERNO    

 + Case when [PN_Paterno] <> '' then          

 dbo.fn_ChgFormatoNumero (LEN( dbo.fn_CambiaCaracter(dbo.trim(DBO.fn_CambiaCaracter([PN_Paterno])))),2)+ dbo.fn_CambiaCaracter(dbo.TRIM(DBO.fn_CambiaCaracter([PN_Paterno]))) --Apellido Paterno          

 else          

 dbo.fn_ChgFormatoNumero (LEN( dbo.fn_CambiaCaracter(dbo.trim(DBO.fn_CambiaCaracter([00_Materno])))),2)+ dbo.fn_CambiaCaracter(dbo.TRIM(DBO.fn_CambiaCaracter([00_Materno]))) --Apellido Paterno          

 end          

    

    

-----------------APELLIDO MATERNO    

------- SI EL APELLIDO PATERNO ESTA EN BLANCO, EL APELLIDO MATERNO SE MANDA COMO 'NO PROPORCIONADO' YA QUE ESTE SE MANDO EN EL APELLIDO PATERNO          

 + Case when [PN_Paterno] = ''     

 then     

   '00' +  dbo.fn_ChgFormatoNumero(LEN( dbo.fn_CambiaCaracter(dbo.Trim(DBO.fn_CambiaCaracter('NO PROPORCIONADO')))),2) + dbo.fn_CambiaCaracter(dbo.TRIM(DBO.fn_CambiaCaracter('NO PROPORCIONADO')))  --Apellido Materno           

      

  else    

         

     case when [00_Materno] <> '' then          

      '00' +  dbo.fn_ChgFormatoNumero(LEN( dbo.fn_CambiaCaracter(dbo.Trim(DBO.fn_CambiaCaracterBuro([00_Materno])))),2) + dbo.fn_CambiaCaracter(dbo.TRIM(DBO.fn_CambiaCaracter([00_Materno])))  --Apellido Materno          

     else          

     ''          

     end      

 end        

           

           

 + '02' + dbo.fn_ChgFormatoNumero(LEN( dbo.fn_CambiaCaracterBuro(dbo.trim(DBO.fn_CambiaCaracterBuro([02_Nombre])))),2)+ dbo.fn_CambiaCaracterBuro(dbo.TRIM(DBO.fn_CambiaCaracter([02_Nombre])))   --Primer Nombre          

           

 + CASE WHEN  [03_SegundoN] <>' '           

  THEN '03'+ dbo.fn_ChgFormatoNumero(LEN(DBO.fn_CambiaCaracterBuro(dbo.TRIM([03_SegundoN]))),2) + dbo.TRIM(DBO.fn_CambiaCaracterBuro([03_SegundoN]))          

  ELSE '' END ------------------------------------------------------------------------------------------------------------------------------------------Segundo Nombre          

            

 + '04' + dbo.fn_ChgFormatoNumero(LEN(REPLACE(CONVERT(VARCHAR(10),[04_fdn],103),'/','')),2) + REPLACE(CONVERT(VARCHAR(10),[04_fdn],103),'/','') --Fecha de Naciminto          

           

           

 + '05' + dbo.fn_ChgFormatoNumero(LEN(DBO.fn_CambiaCaracterBuro([05_RFC])),2)+ dbo.fn_CambiaCaracterBuro(dbo.TRIM(DBO.fn_CambiaCaracter([05_RFC])))           --Número de RFC          

 + '11' + '01' + dbo.trim([11_edoCivil]) --EstadoCivil          

 + '12' + '01' + dbo.trim([12_Sexo]) --Sexo          

           

            

------------------------------------------SEGMENTO DE DIRECCION----------------------------------------------------------------------                                                                      

             

 + 'PA' + dbo.fn_ChgFormatoNumero(LEN(cast(DBO.fn_CambiaCaracterBuro(dbo.TRIM([PA_Calle]))as varchar(40))),2) +           

          cast(DBO.fn_CambiaCaracterBuro(dbo.TRIM([PA_Calle]))as varchar(40)) --Direccion L1                         

                                                                      

+ case when dbo.trim([00_Calle2])<>''           

  then          

  '00' + dbo.fn_ChgFormatoNumero(LEN(cast(DBO.fn_CambiaCaracter(dbo.TRIM([00_Calle2]))as varchar(40))),2) +           

           cast(DBO.fn_CambiaCaracterBuro(dbo.TRIM([00_Calle2]))as varchar(40)) --Direccion L2          

  else ''          

                        

     end                          

                                                                  

 + '01' + isnull(cast(dbo.fn_ChgFormatoNumero(len(replace(replace(dbo.TRIM(DBO.fn_CambiaCaracter(dbo.TRIM([01_Colonia]))),'(',''),')','')),2) as varchar(40)),'')+dbo.fn_CambiaCaracter(replace(replace(cast(dbo.TRIM(DBO.fn_CambiaCaracter([01_Colonia])) as varchar(40)),'(',''),')',''))  --Colonia Población          

 + '02' + isnull(dbo.fn_ChgFormatoNumero(LEN(dbo.fn_CambiaCaracter([02_Municipio])),2)+ dbo.fn_CambiaCaracter(dbo.TRIM(DBO.fn_CambiaCaracter([02_Municipio]))),'') --Delegacion Municipio          

 + '04' +  dbo.fn_ChgFormatoNumero(LEN(dbo.TRIM([04_Estado])),2) + dbo.TRIM([04_Estado])    --Estado          

           

 + '05' +  dbo.fn_ChgFormatoNumero(LEN(replicate(0,5 - len(dbo.fn_ChgFormatoNumero([05_Cp],5))) + dbo.fn_ChgFormatoNumero([05_Cp],5)),2) + replicate(0,5 - len(dbo.fn_ChgFormatoNumero([05_Cp],5))) + dbo.fn_ChgFormatoNumero([05_Cp],5) --+ --Codigo Postal   

 --+ '12' +  dbo.fn_ChgFormatoNumero(LEN(replicate(0,2 - len(dbo.fn_ChgFormatoNumero([12_Origen del Domicilio],2))) + dbo.fn_ChgFormatoNumero([12_Origen del Domicilio],2)),2) + replicate(0,2 - len(dbo.fn_ChgFormatoNumero([12_Origen del Domicilio],2))) + dbo.fn_ChgFormatoNumero([12_Origen del Domicilio],2)

 +'1202'+[12_Origen del Domicilio]

 +'PE'
 
 +  dbo.fn_ChgFormatoNumero(LEN([PE_Nombre o Razón Social del Empleador]),2)+dbo.fn_CambiaCaracterBuro(cast(dbo.fn_CambiaCaracterBuro([PE_Nombre o Razón Social del Empleador]) as varchar(99)))--+ replicate(' ',(99-len([PE_Nombre o Razón Social del Empleador])))

 +'1802'+ [18_Origen de la Razón Social]

   

---------------------------------------------CRÉDITO--SEGMENTO DE CUENTAS----------------------------------------------------------------                                                                      
                                       

 + 'TL02TL'--Etiqueta del Segmento                                                                  

 + '01' + dbo.fn_ChgFormatoNumero(LEN([01_Otorgante]),2) + dbo.trim([01_Otorgante]) --Clave del otorgante          

 + '02' + dbo.fn_ChgFormatoNumero(LEN(replace([02_NomOtorga],' ','')),2)+dbo.TRIM(replace([02_NomOtorga],' ',''))--Nombre del Usuario   EMPRESA            

 + '04' + dbo.fn_ChgFormatoNumero(LEN([04_Cuenta]),2)+dbo.TRIM([04_Cuenta])--Cuenta          

 + '05' + dbo.fn_ChgFormatoNumero(LEN([05_Resposabilidad]),2)+dbo.TRIM([05_Resposabilidad])    --Indicador de Tipo de Responsabilidad          

 + '06' + dbo.fn_ChgFormatoNumero(LEN([06_TipoCta]),2) + dbo.TRIM([06_TipoCta])       --Tipo de cuenta            

 + '07' + dbo.fn_ChgFormatoNumero(LEN([07_TipoContrato]),2) + dbo.Trim([07_TipoContrato])    --Tipo Contrato            

 + '08' + dbo.fn_ChgFormatoNumero(LEN([08_Moneda]),2)+ [08_Moneda]         --Clave de unidad monetaria          

 + '10' + dbo.fn_ChgFormatoNumero(LEN([10_NumPagos]),2)+ CAST([10_NumPagos] AS VARCHAR(3))--Numero de Pagos            

 + '11' + dbo.fn_ChgFormatoNumero(LEN([11_FrecPagos]),2)+ dbo.trim([11_FrecPagos])  -- Frecuencia de Pagos            

 + '12' + dbo.fn_ChgFormatoNumero(LEN(ROUND(CAST ([12_monto] AS INT),0)),2)+CAST(CAST(ROUND([12_monto],0) AS INT) AS VARCHAR(10))  --Monto a PAgar          

 + '13' + dbo.fn_ChgFormatoNumero(LEN(REPLACE(CONVERT(VARCHAR(10),[13_DteApertura],103),'/','')),2) + REPLACE(CONVERT(VARCHAR(10),[13_DteApertura],103),'/','')  --FechaApertura          

 + '14' 
 
 + case [14_DteUltPago] when '01/01/1900' then
	'00'
   else
      dbo.fn_ChgFormatoNumero(LEN(Replace(convert(varchar(10),[14_DteUltPago],103),'/','')),2) + Replace(convert(varchar(10),[14_DteUltPago],103),'/','') --FechaUltimoPago          
   end

 + '15' + dbo.fn_ChgFormatoNumero(len(Replace(convert(varchar(10),[15_DteCompra],103),'/','')),2) + Replace(convert(varchar(10),[15_DteCompra],103),'/','')  --FechaUlima Compra          

          

 + case when CAST([16_DteCierre] as date) = '19000101'          

  then ''          

  else          

   '16' + dbo.fn_ChgFormatoNumero(LEN(REPLACE(CONVERT(VARCHAR(10),[16_DteCierre],103),'/','')),2)+REPLACE(CONVERT(VARCHAR(10),[16_DteCierre],103),'/','')          

  end --FechaCierre          

           

 + '17' + dbo.fn_ChgFormatoNumero(LEN(REPLACE(CONVERT(VARCHAR(10),[17_DteReporte],103),'/','')),2)+REPLACE(CONVERT(VARCHAR(10),[17_DteReporte],103),'/','') --FechaReporte          

 + '21' + dbo.fn_ChgFormatoNumero(LEN(ROUND(CAST([21_CredMaximo] AS INT),0)),2)+ CAST(CAST(ROUND([21_CredMaximo],0) AS INT) AS VARCHAR(10)) --Credito Maximo                                 

 + '2300'

 + '22' + dbo.fn_ChgFormatoNumero(LEN(isnull(CAST([22_SdoActual] aS INT),0)),2) + isnull(CAST(CAST( [22_SdoActual] AS INT) AS VARCHAR(10)),0)    --Saldo Actual          

 + '24' + dbo.fn_ChgFormatoNumero(LEN(isnull(CAST([24_Saldovencido] AS INT),0)),2) +  isnull(CAST(CAST( [24_Saldovencido] AS INT) AS VARCHAR(10)),0) --Saldo Vencido          

 + case when [25_vencidas] > 0           

  then          

  '25' + dbo.fn_ChgFormatoNumero(LEN([25_vencidas]),2) +  CAST([25_vencidas] AS VARCHAR(10))          

  else          

  ''          

  end   -----------Pagos Vencidos          

           

 + '26' + dbo.fn_ChgFormatoNumero(LEN(dbo.TRIM([26_MOP])),2)+ dbo.TRIM([26_MOP])  --Forma de Pago MOP Actual          

               

 + case when [30_Observacion]<> '' then          

   '30'+ dbo.fn_ChgFormatoNumero(LEN([30_Observacion]),2)+[30_Observacion] --ClaveObservacion          

   else ''          

   end          

 +'TL'
 
 + '4308'+REPLACE(CONVERT(VARCHAR(10),[43_Fecha de Primer Incumplimiento],103),'/','')     
        
 + '44'+ dbo.fn_ChgFormatoNumero(LEN(ROUND(CAST ([44_Saldo Insoluto de Capital] AS INT),0)),2)+CAST(CAST(ROUND([44_Saldo Insoluto de Capital],0) AS INT) AS VARCHAR(10))     

 + '45'+ dbo.fn_ChgFormatoNumero(LEN(ROUND(CAST ([45_Monto del último pago] AS INT),0)),2)+CAST(CAST(ROUND([45_Monto del último pago],0) AS INT) AS VARCHAR(9)) 
 
 + '4608'+REPLACE(CONVERT(VARCHAR(10),[46_Fecha de Ingreso a Cartera Vencida],103),'/','')
 
 + '47'+ dbo.fn_ChgFormatoNumero(LEN(ROUND(CAST ([47_Monto correspondiente a intereses] AS INT),0)),2)+CAST(CAST(ROUND([47_Monto correspondiente a intereses],0) AS INT) AS VARCHAR(9))
 
 + '48'+ dbo.fn_ChgFormatoNumero(LEN(dbo.TRIM([48_Forma de Pago actual (MOP de los intereses)])),2)+ dbo.TRIM([48_Forma de Pago actual (MOP de los intereses)])
 
 + '49'
 
 + case  when [49_Días de Vencido]>=999 then
	'999'
   else 
	dbo.fn_ChgFormatoNumero(LEN([49_Días de Vencido]),2)+ CAST([49_Días de Vencido] AS VARCHAR(3))
   end

 +'50'+  dbo.fn_ChgFormatoNumero(LEN([50_Plazo en Meses]),2)+ CAST([50_Plazo en Meses] AS VARCHAR(6))
 
 +'51'+ dbo.fn_ChgFormatoNumero(LEN(ROUND(CAST ([51_Monto del Crédito de Originación] AS INT),0)),2)+CAST(CAST(ROUND([51_Monto del Crédito de Originación],0) AS INT) AS VARCHAR(9))
 
 +'52'+ dbo.fn_ChgFormatoNumero(LEN([52_Correo Electrónico]),2)+cast(dbo.fn_CambiaCaracterBuro([52_Correo Electrónico]) as varchar(99))

 + '99'+'03'+'FIN'            

    

,0 --Campototal          

,0 --SaldoActual          

,0 --SaldoVencido             

             

from ResultadosBuroCredito          

where cast([17_DteReporte]as date) = cast(@fechaCorte as date)          

and finish is null and status = 0          

and Empresaid = @empresa 

and periodoid =   @periodo

          

            

-- ---------------------------------TOTALES------------------------------------------             

SELECT @countreg    = COUNT(1)                    

   ,@saldo     = CAST(SUM([22_SdoActual]) AS INT)       

      ,@saldosvencidos = cast(SUM([24_Saldovencido])as int)          

from ResultadosBuroCredito          

where cast([17_DteReporte]as date) = cast(@fechaCorte as date)          

and finish is null and status = 0          

and Empresaid = @empresa 

and periodoid =   @periodo        

 

            

--------------------------------CIFRAS DE CONTROL-------------------------------------                                                                  

                                                           

UPDATE @tbldatos SET Total=(                     

select top 1          

 'TRLR'                                                                   

 + CAST(dbo.fn_ChgFormatoNumero(@saldo,14)AS VARCHAR(20))   --Total de Saldos Actuales                                                                  

 + cast(dbo.fn_ChgFormatoNumero(@saldosvencidos,14)as varchar(14)) --Total Saldos Vencido          

 + '001'               --Total de Segmentos del Encabezado                                                                  

 + CAST(dbo.fn_ChgFormatoNumero(@countreg,9)AS VARCHAR(9))   --Total de Segmentos de PN                                                                      

 + CAST(dbo.fn_ChgFormatoNumero(@countreg,9)AS VARCHAR(9))   --Total de Segmentos de PA                                      

 + CAST(dbo.fn_ChgFormatoNumero(@countreg,9)AS VARCHAR(9))    --Total de Segmentos de PE                                                              

 + CAST(dbo.fn_ChgFormatoNumero(@countreg,9)AS VARCHAR(9))   --Total de Segmentos de PL                                                                      

 + REPLICATE(0,6)       --Contador de Bloques                                                                     

 + [02_NomOtorga] + replicate(char(32), 16 - Len([02_NomOtorga])) --Nombre del Otorgante                                                                  

 --+ REPLACE(STR(0,160),'0',)         --Domicilio para Devolucion                
 +(select DBO.fn_CambiaCaracterBuro(Domicilio) from Empresa where EmpresaKey=@empresa)
           

 from ResultadosBuroCredito          

 where cast([17_DteReporte]as date) = cast(@fechaCorte as date)          

 and finish is null and status = 0          

 and Empresaid = @empresa  

 and PeriodoId = @periodo          

 )                       

            

SELECT * FROM @tbldatos            

             

             

 /*            

   [SPSOFIA_GetReporteBuro1_VerFinal]03,2013,1          

*/          

END