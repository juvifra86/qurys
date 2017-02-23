Set dateformat ymd 
 select cnta.Nota_id,cnta.Tema_id,tms.Nombre as Tema,ntas.Titulo,
 cnta.Calf_Contenido,cnta.Calf_Titular,cnta.Calf_Porcentaje, 
 cnta.Calf_Imagenes,cnta.Obs,ntas.FechaPublicacion,cm.Nombre as Medio,
 cs.Nombre as Seccion, ctm.Nombre as Tipo_Medio,ctn.Nombre as Tipo_Nota,ntas.Costo 
from Califica_nota as cnta 
inner join NV_Temas as tms on tms.Tema_id=cnta.Tema_id 
inner join Notas as ntas on ntas.Nota_id=cnta.Nota_id 
inner join Cat_TipoNota as ctn on ctn.TipoNota_Id=ntas.TipoNota_Id 

inner join Cat_Medios as cm on cm.Medio_Id=ntas.Medio_Id 
inner join Cat_TipoMedios as ctm on ctm.TipoMedio_id=cm.TipoMedio_id 
inner join Cat_Secciones as cs on cs.Seccion_id=ntas.Seccion_id 
where ntas.FechaPublicacion between '20130501' and '20130528' 
					 --and cnta.Tema_id in("& LaMenus &")

--inner join Imagenes_Notas as imn on imn.Nota_id=cnta.Nota_id 
--inner join Cat_Imagenes_Medios as cim on cim.Imagen_id=imn.Imagen_id 
--right join NotasExtras as ntx on cnta.Nota_id=ntx.Nota_id