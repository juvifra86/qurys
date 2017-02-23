/*                        

Procedimineto que regresa los clintes que estan asignados a un tipo ce cargo automatico               

MOD: EZM 23/08/2013 se agregó campo de bursatilizacion                      

                        

SPSOFIA_BuscaClinetesCargoAtrasados 0, 8,1,'20120514'                        

go                        

SPSOFIA_BuscaClinetesCargoAtrasados 39, 8,1,'20120514',1                       

go                   

SPSOFIA_BuscaClinetesCargoAtrasados 0, 8,2,'20150815',0,2,1        

*/                        

alter procedure SPSOFIA_BuscaClinetesCargoAtrasados                        

@cuentaCteKey as integer,                        

@formaPago as integer,                        

@empresa as integer,                        

@fechaConsulta as date,                  

@IncluirMoratorios as bit,      -----------Fecha en que se consultan los datos (importe)            

@nobursatil as int,        

@CicloCorteid as integer                   

as                        

begin                        

                         

                            

declare @SigDiahabil as date                               

                         

                          

set @SigDiahabil = dbo.FnSofia_GetDiaHabil(@fechaConsulta)    --'20140603'--        

declare @bursatil as bit=@nobursatil        

declare @CuentasConSaldo as table(CuentaCliente integer,NombreCompleto varchar(200), CicloCorte integer ,Monto money , ultimoVencimiento date,Boleta integer)                        

                        

--------------Si la Cuenta del clintes es = 0 -----------------                        

 if @cuentaCteKey = 0                        

  begin                        

        

insert into @CuentasConSaldo                            

  Select BCC.CuentaCteId   [CuentaCliente]                          

    ,DC.NombreCompleto [NombreCompleto]                          

    ,BCC.CicloCorteId  [CicloCorte]                        

   ,(select importe from [FnSofia_GetPagoDomiAtrasadosFull](BCC.CuentaCteId,@SigDiahabil,@IncluirMoratorios))  [Monto]                        

                        

   ,isnull(        

   (select top 1 cast(FechaVencimiento as DATE) from Amortizacion where CuentaCteId = BCC.CuentaCteId                  

   and FechaVencimiento < = @fechaConsulta and ConceptoContableId = 46 and EstadoPOId in (20,22)                  

    order by cast(FechaVencimiento as DATE) desc),        

            

    (select top 1 cast(FechaVencimiento as DATE) from notacargo where CuentaCteId = BCC.CuentaCteId                  

   and FechaVencimiento < = @fechaConsulta   and EstadoPOId in (25,27)                  

    --order by cast(FechaVencimiento as DATE) desc))        

    order by boleta desc))        

            

    [ultimoVencimiento]                  

        

------------Si no tiene amortizaciones toma la fecha de la ultima nota                      

     ,isnull(        

     (select top 1 Boleta from Amortizacion where CuentaCteId = BCC.CuentaCteId                  

      and FechaVencimiento < = @SigDiahabil and conceptocontableId = 46 and EstadoPOId in (20,22)                  

    order by cast(FechaVencimiento as DATE) desc),        

            

    (select top 1 Boleta from notacargo  where CuentaCteId = BCC.CuentaCteId                  

      and FechaVencimiento < = @SigDiahabil  and EstadoPOId in (25,27)                  

    --order by cast(FechaVencimiento as DATE) desc)            

     order by boleta desc)        

            

            

    ) [Boleta]                          

                  

     --isnull(CC.bursatil,0) [bursatil]                               

                    

    From BancoCargoCuenta BCC                                     

    inner join vwDatosCredito DC on DC.cuentaCteKey = BCC.CuentaCteId   and DC.PlanKey <> 4                                                

    inner join Cuentacte CC on CC.cuentactekey = BCC.CuentaCteId            

   

      

------------------------------------Se agrego para saber si realmente es bursatilizado para tomar cuentas bursatilizadas  

 join vwCuentasBursaDomi cb on cb.CuentaCtekey = CC.CuentaCtekey  

                

    where BCC.FormaPagoID = @formaPago                           

    and BCC.Finish is null                           

    and BCC.Status = 0                                

    and DC.EmpresaId = @empresa                    

    and BCC.TipoProductoId <> 2               

    --and isnull(CC.bursatil,0) = @bursatil          

    --and cb.BursatilDomi = @bursatil   

	and cb.NoBursatil=@nobursatil

    and BCC.CicloCorteId = @CicloCorteid          

    --and (select top 1 MontoAmortizacionesVencidasconMoratorios + MontoNotasVencidasConMoratorios                       

    --from dbo.fnsofia_GetEstadoCta2 (BCC.CuentaCteId,@SigDiahabil))>0    
	and BCC.CuentaCteId in(select CuentasDomiciliacionAtrasadakey from CuentasDomiciliacionAtrasada where finish is null)                  

    order by 1              

            

    delete from @CuentasConSaldo where monto < = 0        

            

   -- select CuentaCliente,        

   --NombreCompleto,        

   --CicloCorte,        

   --Monto,        

   --ultimoVencimiento,        

   --Boleta        

   -- from @CuentasConSaldo  cs            

     
	  select cs.CuentaCliente,        

   cs.NombreCompleto,        

   cs.CicloCorte,        

   td.[monto a cargar] Monto,        

   cs.ultimoVencimiento,        

   cs.Boleta        

    from @CuentasConSaldo   cs
	 inner join tmpDomiciliacion td on td.Contrato=cs.CuentaCliente                                

  end                        

--------------Si la Cuenta del clintes es diferente de 0 -----------------                        

 else                        

     begin           

          

  insert into @CuentasConSaldo                  

  Select BCC.CuentaCteId[CuentaCliente]                          

    ,DC.NombreCompleto [NombreCompleto]                          

    ,BCC.CicloCorteId  [CicloCorte]                        

    ,(select importe from [FnSofia_GetPagoDomiAtrasadosFull](BCC.CuentaCteId,@SigDiahabil,@IncluirMoratorios))[Monto]--  a la fecha consultada                  

                      

,isnull(        

   (select top 1 cast(FechaVencimiento as DATE) from Amortizacion where CuentaCteId = BCC.CuentaCteId                  

   and FechaVencimiento < = @fechaConsulta and ConceptoContableId = 46 and EstadoPOId in (20,22)                  

    order by cast(FechaVencimiento as DATE) desc),        

            

    (select top 1 cast(FechaVencimiento as DATE) from notacargo where CuentaCteId = BCC.CuentaCteId                  

   and FechaVencimiento < = @fechaConsulta   and EstadoPOId in (25,27)                  

   -- order by cast(FechaVencimiento as DATE) desc))        

    order by boleta desc))        

            

    [ultimoVencimiento]          

                       

  ------------Si no tiene amortizaciones toma la fecha de la ultima nota                      

     ,isnull(        

     (select top 1 Boleta from Amortizacion where CuentaCteId = BCC.CuentaCteId                  

      and FechaVencimiento < = @SigDiahabil and conceptocontableId = 46 and EstadoPOId in (20,22)                  

    order by cast(FechaVencimiento as DATE) desc),        

            

    (select top 1 Boleta from notacargo  where CuentaCteId = BCC.CuentaCteId                  

      and FechaVencimiento < = @SigDiahabil  and EstadoPOId in (25,27)                  

    --order by cast(FechaVencimiento as DATE) desc)          

     order by boleta desc)          

            

            

    )  [Boleta]                    

     --isnull(CC.bursatil,0) [bursatil]                          

                  

                     

                     

    From BancoCargoCuenta BCC                                     

    inner join vwDatosCredito DC  on DC.cuentaCteKey = BCC.CuentaCteId   and DC.PlanKey <> 4                                                

    inner join Cuentacte CC on CC.cuentactekey = BCC.CuentaCteId  

       

------------------------------------Se agrego para saber si realmente es bursatilizado para tomar cuentas bursatilizadas  

 join vwCuentasBursaDomi cb on cb.CuentaCtekey = CC.CuentaCtekey  

                                                          

    where BCC.FormaPagoID = @formaPago                           

    and BCC.Finish is null                           

    and BCC.Status = 0                                

    and DC.EmpresaId = @empresa                             

    and BCC.CuentaCteId = @cuentaCteKey                  

    and BCC.TipoProductoId <> 2              

    --and isnull(CC.bursatil,0) = @bursatil    

    --and cb.BursatilDomi = @bursatil             

    and BCC.CicloCorteId = @CicloCorteid                                             

    --and (select top 1 MontoAmortizacionesVencidasconMoratorios  + MontoNotasVencidasConMoratorios                        

    --from dbo.fnsofia_GetEstadoCta2 (BCC.CuentaCteId,@SigDiahabil))>0                          

  order by 1                    

          

  delete from @CuentasConSaldo where monto < = 0        

            

        select cs.CuentaCliente,        

   cs.NombreCompleto,        

   cs.CicloCorte,        

   td.[monto a cargar] Monto,        

   cs.ultimoVencimiento,        

   cs.Boleta        

    from @CuentasConSaldo   cs
	 inner join tmpDomiciliacion td on td.Contrato=cs.CuentaCliente       

          

  end                        

end 