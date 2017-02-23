    

--declare @UnidadID as integer  = 676--793--791                      

--declare @precioUnidad as money = 0--316000                      

--declare @plazo as integer  = 12                      

--declare @EstadoId as integer =9 --DF                      

--declare @municiopioID as integer                      

--declare @aseguradoraId as integer = 9                      

                      

--9 MAPFRE-Tepeyac                      

--2 Qualitas                      

--8 ABASeguros              

--4 Axa 

--12 HDI                 

                      

/*                      

exec SpSofia_CotizaSeguroCalculo   --- PARTICULAR   AUTO              

 --975, --Unidad Jeep Compass Limited 2014

 --1034, --Unidad  Attitude GL Aut 1.6L  2014

 --1513, -- Unidad    Attitude SXT AT 2105  

  1425,  --Unidad Wrangler Rubicon 4x4 ATX 2015           

 0,   --Precio                      

 14,   --Estado                      

 2,    -- IdAseguradora

  0  -- Solicitudid



 exec SpSofia_CotizaSeguroCalculolocal   --- PARTICULAR   CAMIONETA              

 --1093,--Unidad    RAM 2500 HEMI SPORT 5.7L 4x2 ATX 2014

 1537,--Unidad      Ram 2500 Promaster 2015                   

 0,   --Precio                      

 14,   --Estado                      

 2,    -- IdAseguradora

  0  -- Solicitudid

 

 exec SpSofia_CotizaSeguroCalculolocal     ---TAXI                

 1139, --Unidad   Lancer ES Manual 2014

 --1640,  --Unidad   Lancer ES Manual 2015               

 0,   --Precio                      

 14,   --Estado                      

 0,    --IdAseguradora

  0  --      

  

  

 exec SpSofia_CotizaSeguroCalculolocal     ---SEMINUEVOS               

 20867, --Unidad   GIULIETTA QUADRIFOGLIO 2014      

 0,   --Precio                      

 14,   --Estado                      

 0,    --CuentacteId    

 0  -- IdAseguradora   

               

 exec SpSofia_CotizaSeguroCalculo                      

 0, --Unidad                      

 0,   --Precio                      

 0,   --Estado              

 8099    --CuentacteId              

              

EXEC SpSofia_CotizaSeguroCalculO 1034, 199900, 9, 0              

                      

*/                      

                      

CREATE procedure SpSofia_CotizaSeguroCalculo 

@UnidadID as integer,                       

@precioUnidad as money,                       

@EstadoId as integer,                      

@IdAseguradora as int,

@Solicitudid as int



              

as                      

begin                      

Declare @CuentacteId as int, @AseguradoraId int , @Modelo int     

      

      

    --recibe solicitudkey envia cuentacteid          

      

if @Solicitudid<>0      

begin      

 select @CuentacteId =CuentaCteKey, @AseguradoraId=AseguradoraId from CuentaCte where SolicitudID = @Solicitudid       

end  

    

select UnidadKey,UnidadDsc, case when @precioUnidad = 0 then PrecioPublico else @precioUnidad end  PrecioPublico,TipoUsoId,Modelo              

from Unidad where UnidadKey = @UnidadID     



set @precioUnidad = case when @precioUnidad = 0 then (select PrecioPublico from Unidad where UnidadKey = @UnidadID) else @precioUnidad end



SET @Modelo = (SELECT Modelo from Unidad where UnidadKey = @UnidadID)

              

select * from CodigoSeguroUnidad csu              

inner join CotizaSeguro cs 

	on case csu.AseguradoraKey when 9 then case when LEN(csu.Codigo) = 6 then right(cs.ClaveSeguro,6) else cs.ClaveSeguro end

			else cast(cs.ClaveSeguro as varchar) end

		= cast((case csu.AseguradoraKey when 4 then (case len(csu.Codigo) when 7 then LEFT(csu.Codigo,5) when 6 then LEFT(csu.Codigo,4) else csu.Codigo end) 

										else csu.Codigo end) as varchar) 

where csu.UnidadKey = @UnidadID

	AND cs.Modelo = @Modelo

	AND cs.Finish IS NULL

	and cs.TipoUsoID = (select TipoUsoID from Unidad where UnidadKey = @UnidadID)

	--and AseguradoraKey not in (6,10)    

	and cs.ZonaId = case cs.AseguradoraID when 8 then @EstadoId else cs.ZonaId end  

	and csu.AseguradoraKey = cs.AseguradoraID      

   order by csu.AseguradoraKey   



          

declare @ResultadoCotizacion as table (              

aseguradoraKey int,              

DerechoPoliza money,              

PrimaNeta12 money,              

PrimaTotal12 money,              

PrimaNeta24 money,              

PrimaTotal24 money,              

PrimaNeta36 money,              

PrimaTotal36 money,              

PrimaNeta48 money,              

PrimaTotal48 money,              

PrimaNeta60 money,              

PrimaTotal60 money,              

Encontrado bit,              

Detalle VarchaR(50),              

AseguradoraDsc varchar(50)              

)                          



--if @AseguradoraId =2 or @SolicitudId=0              

---------------------------------------------------QUALITAS-------------------------------------------------------              

--begin

Insert into @ResultadoCotizacion (aseguradoraKey ,DerechoPoliza,PrimaNeta12,PrimaTotal12,PrimaNeta24,PrimaTotal24,              

PrimaNeta36,PrimaTotal36,PrimaNeta48,PrimaTotal48,PrimaNeta60,PrimaTotal60,              

Encontrado,Detalle,AseguradoraDsc)      

exec SpSofia_CotizaSeguroCalculo_QUALITAS_temp  @UnidadID, @precioUnidad, @EstadoId, @CuentacteId                      

--end      

--if @AseguradoraId =9 or @SolicitudId=0                                          

---------------------------------------------------MAPFRE-------------------------------------------------------               

----begin      

--Insert into @ResultadoCotizacion (aseguradoraKey ,DerechoPoliza,PrimaNeta12,PrimaTotal12,PrimaNeta24,PrimaTotal24,              

--PrimaNeta36,PrimaTotal36,PrimaNeta48,PrimaTotal48,PrimaNeta60,PrimaTotal60,              

--Encontrado,Detalle,AseguradoraDsc)              

--exec SpSofia_CotizaSeguroCalculo_MAPFRE_temp  @UnidadID, @precioUnidad, @EstadoId, @CuentacteId                  

----end                  

--if @AseguradoraId =8 or @SolicitudId=0                                       

 ---------------------------------------------------ABA-------------------------------------------------------              

----begin      

--Insert into @ResultadoCotizacion (aseguradoraKey ,DerechoPoliza,PrimaNeta12,PrimaTotal12,PrimaNeta24,PrimaTotal24,              

--PrimaNeta36,PrimaTotal36,PrimaNeta48,PrimaTotal48,PrimaNeta60,PrimaTotal60,              

--Encontrado,Detalle,AseguradoraDsc)         

--exec SpSofia_CotizaSeguroCalculo_ABA_temp  @UnidadID,                      

--            @precioUnidad,                       

--            @EstadoId,                      

--            @CuentacteId              

----end                         

             

      

--if @AseguradoraId =12 or @SolicitudId=0                                               

--begin      

---------------------------------------------------HDI-------------------------------------------------------      

--Insert into @ResultadoCotizacion (aseguradoraKey ,DerechoPoliza,PrimaNeta12,PrimaTotal12,PrimaNeta24,PrimaTotal24,            

--PrimaNeta36,PrimaTotal36,PrimaNeta48,PrimaTotal48,PrimaNeta60,PrimaTotal60,            

--Encontrado,Detalle,AseguradoraDsc)            

--exec SpSofia_CotizaSeguroCalculo_HDI_temp   @UnidadID, @precioUnidad, @EstadoId, @CuentacteId     

    

--insert into @ResultadoCotizacion  Select * from ResultadoCotizacion2                          

--end

              

/*        if @AseguradoraId =6 or @SolicitudId=0                                               

begin      

Insert into @ResultadoCotizacion (aseguradoraKey ,DerechoPoliza,PrimaNeta12,PrimaTotal12,PrimaNeta24,PrimaTotal24,              

PrimaNeta36,PrimaTotal36,PrimaNeta48,PrimaTotal48,PrimaNeta60,PrimaTotal60,              

Encontrado,Detalle,AseguradoraDsc)              

exec SpSofia_CotizaSeguroCalculo_GNP  @UnidadID,                      

           @precioUnidad,                       

           @plazo,                        

           @EstadoId,                      

           @CuentacteId      

           */      

                   

----if @AseguradoraId =4 or @SolicitudId=0  

---------------------------------------------------AXA-------------------------------------------------------              

 

----begin      



--Insert into @ResultadoCotizacion (aseguradoraKey ,DerechoPoliza,PrimaNeta12,PrimaTotal12,PrimaNeta24,PrimaTotal24,              

--PrimaNeta36,PrimaTotal36,PrimaNeta48,PrimaTotal48,PrimaNeta60,PrimaTotal60,              

--Encontrado,Detalle,AseguradoraDsc)              

--exec SpSofia_CotizaSeguroCalculo_AXA_temp    @UnidadID, --Unidad                      

--          @precioUnidad,--  0,   --Precio                      

--          @EstadoId, -- 0,   --Estado                      

--          @CuentacteId--  9640   --CuentacteID                

----end       





---------------------------------------------------GNP-------------------------------------------------------      



             

      

--select vw.AseguradoraKey,                      

--  isnull(PrimaNeta,0)PrimaNeta,                      

--  isnull(ivaPrimaNeta,0)ivaPrimaNeta,                      

--  isnull(ct.DerechoPoliza,0)DerechoPoliza,              

--  isnull(PrimaTotal,0)PrimaTotal,                      

--  Encontrado,                      

--  Detalle,                      

--  vw.AseguradoraDsc,                  

--  FechaEmision,                   

--  FechaPolizaIni,                  

--  FechaPolizafin                     

--from vwAseguradora vw                       

--left join @CotizacionesTotales  CT on vw.AseguradoraKey = CT.aseguradoraId                

              

              

                      

--end                      

                      

if @IdAseguradora <> 0                      

	begin                      

		select * from @ResultadoCotizacion where aseguradoraKey = @IdAseguradora             



	--select vw.AseguradoraKey,                      

	--  isnull(PrimaNeta,0)PrimaNeta,                      

	--  isnull(ivaPrimaNeta,0)ivaPrimaNeta,                      

	--  isnull(ct.DerechoPoliza,0)DerechoPoliza,              

	--  isnull(PrimaTotal,0)PrimaTotal,                      

	--  isnull(Encontrado,0)Encontrado,                      

	--  Detalle,                   

	--  vw.AseguradoraDsc,                  

	--  FechaEmision,                   

	--  FechaPolizaIni,                  

	--  FechaPolizafin                                 

	--from  vwAseguradora vw                      

	--left join @CotizacionesTotales  CT on vw.AseguradoraKey = CT.aseguradoraId                      

	--where aseguradoraId = @aseguradoraId                      

	end  

  

else

	begin

		select * from @ResultadoCotizacion order by aseguradoraKey 

	end                  

----select * from CodigoSeguroUnidad where Codigo in (select ClaveSeguro from CotizaSeguro )                      

----and AseguradoraKey = 2                       

                      

end
