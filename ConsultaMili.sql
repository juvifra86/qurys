Select distinct ntas.Nota_id as ID, ntas.Titulo as TITULO_NOTA, ntas.FechaCaptura as FECHA_CAPTURA,cm.Nombre as MEDIO, cs.Nombre as SECCION,tnota.Nombre as TIPO_NOTA,'http://www.mediasolutions.com.mx/ncvpop.asp?n=' + convert(varchar,ntas.Nota_id) as URL
from NV_NotasTemas as nvntas
inner Join Notas as ntas on nvntas.Nota_id = ntas.Nota_id 
Inner Join Cat_Medios as cm On ntas.Medio_id = cm.Medio_id 
Inner Join Cat_Secciones as cs On ntas.Seccion_id = cs.Seccion_id 
Inner Join Cat_TipoNota as tnota on ntas.TipoNota_Id=tnota.TipoNota_Id
and cm.Medio_Id in (542,8,10) and cs.Seccion_id in (1225,1453,1271)
and ntas.Display>=1 and nvntas.Display>=1 
and ntas.FechaCaptura between '2012/05/31 00:00:00' and '2012/05/31 23:59:00'
order by cm.Nombre,ntas.FechaCaptura


--universal 542  1225
--REforma 8 1453
-- Jornada 10 1271


select * from Cat_TipoNota