
select cnta.Nota_id,cnta.Tema_id,tms.Nombre as Tema,ntas.Titulo,cnta.Calf_Contenido,cnta.Calf_Titular,cnta.Calf_Porcentaje,
	   cnta.Calf_Imagenes,cnta.Obs,ntas.FechaPublicacion,cm.Nombre as Medio,cs.Nombre as Seccion,
	   ctm.Nombre as Tipo_Medio,ctn.Nombre as Tipo_Nota,ntas.Costo,ntx.Valor as Medida
from Califica_nota as cnta
inner join NV_Temas as tms on tms.Tema_id=cnta.Tema_id
left join Notas as ntas on ntas.Nota_id=cnta.Nota_id
inner join Cat_TipoNota as ctn on ctn.TipoNota_Id=ntas.TipoNota_Id
inner join NotasExtras as ntx on ntx.Nota_id=ntas.Nota_id
inner join Cat_Medios as cm on cm.Medio_Id=ntas.Medio_Id
inner join Cat_TipoMedios as ctm on ctm.TipoMedio_id=cm.TipoMedio_id
inner join Cat_Secciones as cs on cs.Seccion_id=ntas.Seccion_id

