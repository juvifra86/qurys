Set Dateformat ymd
Select ntas.Nota_id, ntas.Titulo,ntas.FechaCaptura,
	ctn.Nombre as TIPODENOTA,
	cm.Nombre as MEDIO,
	ctm.Nombre as TIPOMEDIO,
	cse.Nombre as SECCION,
	tem.Nombre as MENCION,
	ntas.URL,		
	'http://www.mediasolutions.com.mx/showclipping.asp?id=' + convert(varchar,ntas.Nota_id)as URLMediaSolutions
from Notas as ntas
inner join NV_NotasTemas as nt on nt.Nota_id = ntas.Nota_id 
inner join Cat_medios as cm on ntas.Medio_Id = cm.Medio_Id 
inner join Cat_TipoNota as ctn on ntas.TipoNota_Id = ctn.TipoNota_Id 
inner join Cat_Usuarios as cus on ntas.Usuario_Id = cus.Usuario_Id 
inner join Cat_Secciones as cse on ntas.Seccion_id = cse.Seccion_id 
inner join Cat_TipoMedios as ctm on cm.TipoMedio_id = ctm.TipoMedio_id
inner join NV_Temas as tem on nt.Tema_id=tem.Tema_id
Where nt.Tema_id in (12121,12123,225,1064,4329,4330,5368,12084) 
and cm.Medio_Id in (8,542,843,10,317,318,9,850,423,6570,9945,11165) 
and ntas.FechaCaptura between '2013/11/19 00:00:00' and '2014/01/30 11:59:59'


