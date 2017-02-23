select CP.COL,
	   CP2.COL,
	    * from CP091115 CP
INNER JOIN CP091115 CP2 ON CP.CP = CP2.CP
WHERE
CP.EdoPaisId = CP2.EdoPaisId
AND CP.CiudadId = CP2.CiudadId
AND CP.DelegMunicipio = CP2.DelegMunicipio
AND CP.Col = CP2.COL
AND CP.finish IS NOT NULL
AND CP2.finish IS NULL 
order by CP.CiudadId

--select * from cp where col ='La Otra Banda' order by DelegMunicipio

--select * into CP091115 from CP  --copia de tabla cp


--select * from CP091115