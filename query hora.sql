

--select FechaCaptura,FechaPublicacion,FechaVencimiento,FechaHoy,CONVERT(VARCHAR(30),FechaHora,108) as Hora from Notas where FechaPublicacion='2011/01/01'


select ntas.FechaPublicacion,ntas.FechaHora,ctm.Nombre as medio,ct.Nombre as tipo from Notas as ntas
inner join Cat_Medios as cm on ntas.Medio_Id=cm.Medio_Id
inner join Cat_TipoMedios as ctm on cm.TipoMedio_Id=ctm.TipoMedio_id
inner join Cat_TipoNota as ct on ntas.TipoNota_Id=ct.TipoNota_Id
where ntas.Nota_id >=  201309010000000000 
    and  ntas.Nota_id <=  201309249999999999 and ctm.TipoMedio_id in 
    --(1,2,3)
    (4,5)
    --(6,7,8)
order by ntas.FechaPublicacion