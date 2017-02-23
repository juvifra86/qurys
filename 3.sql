/*    

creo EZM    

    

Valida que la informacion del buro de Credito se haya generado    

    

exec SPSOFIA_ValidaGeneracionBuro 5,2016,2,5,'20160601' 

    

*/    

		

ALTER procedure SPSOFIA_ValidaGeneracionBuro    

@mes AS integer,                  

@anio as integer,                  

@empresa AS SMALLINT,  

@periodo as integer, -- 5 Mensual por defecto  (info de la tabla periodo)                

      --2 para semanal  

@fecha as date ----------se toma en cuenta solo para los semanales      

as    

begin    

    

declare @fechaCorte as date     



		declare @today  date    

		,  @diasem  tinyint    

		,  @fechaini   date     

		,  @fechafin   date     

		,  @DteCorte   date     

    

Set @diasem= DATEPART(dw,@fecha)    

Set nocount on    

    

----- DETERMINAMOS LA FECHAS DE PERIODO ANTERIOR    

/**********************************************************/    

if @diasem=1    

begin    

  Set @fechaini = DATEADD(wk,-1,@today)    

  Set @fechafin = DATEADD(dd,4,@fechaini)    

 End    

else    

begin    

 Set @diasem = @diasem-1    

 Set @today = DATEADD(dd,@diasem*-1,@today)    

 Set @fechaini = DATEADD(wk,-1,@today)    

 Set @fechafin = DATEADD(dd,4,@fechaini)    

 End   



  

  

        --------------Fecha que se busca en la tabla de Carteracte o CarteracteFinaliza                                                             

        

   set @fechaCorte =   

 ---Si es Mensual toma la ultima fecha de la tabla CarteraCte  

 case when @periodo = 5 then  

  (select MAX(FechaCorte)                           

  from CarteraCte with(nolock) where Ejercicio = @anio and Periodo = @mes)  

   

 -----Si es semanal toma la ultima fecha de la tabla CarteraCteFinaliza  

 else

  

   cast(@fechafin as DATE)

 -- (select MAX(FechaCorte)                           

 -- from CarteraCteFinaliza with(nolock) where Ejercicio = @anio and Periodo = @mes )  

   

 end                   

    

if cast(@fechaCorte as date) in (select distinct cast([init] as DATE) from ResultadosBuroCredito where EmpresaID = @empresa and PeriodoId = @periodo and CargaSiop=0)                   

select 1    

    

else    

select 0              

    

end 