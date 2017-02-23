Select ce.Nombre,
	   ntas.Nota_id,
       ntas.Titulo,
       np.campana, 
       ntas.fechapublicacion,
	   cm.Nombre as medio,
       cs.Nombre as seccion,
       cim.Pagina,
	   ntas.nota,'http://www.mediasolutions.com.mx/showclipping.asp?id=' + convert(varchar,ntas.Nota_id),
       np.ancho,
       np.alto,
       np.costo,
       np.Color,
	   (Select Nombre from Cat_Anunciantes ca, VM_NotasPublicidadGMS gms
		Where
  		ca.Anunciante_id = gms.id
		and gms.TipoGMS_id = 2
		and gms.Nota_id = ntas.Nota_id) as Anunciante
from notas as ntas, VM_NotasPublicidad np,cat_medios cm, cat_secciones as cs,
	 cat_imagenes_medios as cim,imagenes_notas as imn, cat_Estados ce
Where ntas.fechacaptura between '2012/10/02 00:00:00' and '2012/10/08 23:59:59'
and np.Nota_id = ntas.Nota_id
and ntas.medio_id = cm.Medio_id
and ntas.seccion_id = cs.Seccion_id
and imn.Imagen_id = cim.Imagen_id
and imn.Nota_id = ntas.Nota_id
and ce.Estado_id = cm.Estado_id
and ntas.Usuario_id in (688)
order by ntas.Titulo, np.campana,ntas.fechapublicacion, cm.Nombre, cs.Nombre, cim.Pagina

/*(92,660,10,44,46,688,620)
92 Nancy 660 Alejandro 10 Captura1 44 Captura2 46 Captura3 668 Home 620 Evelin
*/