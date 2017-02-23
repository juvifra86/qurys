Select	ce.Nombre,
		ntas.Nota_id,
		ntas.Titulo,
		np.Campana,
		ntas.fechapublicacion,
		cm.Nombre as Medio,
		cs.Nombre as Seccion,
		cim.Pagina,
		ntas.nota,
		'http://www.mediasolutions.com.mx/showclipping.asp?id=' + convert(varchar,ntas.Nota_id),
		np.Ancho,
		np.Alto,
		np.Costo,
		np.Color,
		ca.Nombre as Anunciante
from Notas as ntas inner join Cat_Medios as cm ON ntas.Medio_id = cm.Medio_id
inner join Cat_Secciones as cs ON ntas.Seccion_id = cs.Seccion_id
inner join VM_NotasPublicidad as np ON ntas.Nota_id = np.Nota_id
inner join Imagenes_notas as imn ON ntas.Nota_id = imn.Nota_id
inner join Cat_Imagenes_Medios cim ON imn.Imagen_id = cim.Imagen_id
inner join Cat_Estados as ce ON cm.Estado_id = ce.Estado_id
inner join VM_NotasPublicidadGMS as gms ON np.Nota_id = gms.Nota_id
inner join Cat_Anunciantes as ca ON ca.Anunciante_id = gms.ID
Where ntas.fechacaptura between '2011/06/01 00:00:00' and '2011/06/30 23:59:59'
and gms.TipoGMS_id = 2
and gms.id in (5323,7192,1672,2210,1622,2525,8121,8360,1576,1583)

