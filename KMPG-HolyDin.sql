Select	nt.Nota_id,
		ntas.Fechapublicacion,
		ntas.Titulo, 
		cm.Nombre as Medio,
		cs.Nombre as Seccion, 
		cp.Nombre as Programa,
		tn.Nombre as TipoNota,
		ntas.Costo as CostoNota,
		cu.NombreCompleto as NombreCompleto,
		isnull((Select costo from VM_NotasPublicidad Where Nota_id = ntas.Nota_id),0) as CostoPublicidad,
		'http:\\www.mediasolutions.com.mx\ncpop.asp?n=' + convert(varchar,nt.Nota_id) 
from NV_NotasTemas nt, Notas ntas, Cat_Medios cm, Cat_Secciones cs, Cat_Programas cp, Cat_TipoNota tn,Cat_Usuarios cu
Where nt.Nota_id = ntas.Nota_id
and ntas.Medio_id = cm.Medio_id
and ntas.Seccion_id = cs.Seccion_id
and ntas.Programa_id = cp.Programa_id
and ntas.TipoNota_id = tn.TipoNota_id
and ntas.Usuario_id = cu.Usuario_id
and ntas.fechapublicacion between '2012/06/01' and '2012/06/30'
and nt.Tema_id in (7966)
Order by Nota_id