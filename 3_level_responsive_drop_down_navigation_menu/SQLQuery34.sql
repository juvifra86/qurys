Set dateformat ymd
	Select	 nvnt.Nota_id
			,ntas.FechaPublicacion
			,ntas.Titulo
			,ntas.Agencia_Id
			,cm.Nombre as NombreMedio
			,cs.Nombre as NombreSeccion
			,ntas.autor1 +','+ntas.autor2+','+ntas.autor3 as autores
			,ntas.Balazo1
			,ntas.Balazo2 
			,ntas.Balazo3 
			,ntas.Balazo4
			,cm.Revista 
			,ntas.Nota
			,cm.Logo as Logotipo
			,ctm.Nombre as TipoMedio
			,ctn.Nombre as TipoNota
			,ntas.Costo
			,cci.Nombre as Ciudad
			,ntas.kiker 
	from NV_NotasTemas as nvnt 
			Inner Join NV_Menus as nvm ON nvnt.Tema_id = nvm.Tema_id
			Inner Join Notas as ntas ON ntas.Nota_id = nvnt.Nota_id		
			Inner Join NV_MenusSuscriptores as ms ON ms.Menu_id = nvm.Menu_id 
			Inner Join Cat_Medios as cm ON cm.Medio_Id = ntas.Medio_Id 
			Inner Join Cat_Secciones as cs On ntas.Seccion_id = cs.Seccion_id 
			Inner Join Cat_TipoMedios as ctm On ctm.TipoMedio_id = cm.TipoMedio_id 
			Inner Join Cat_TipoNota as ctn On ctn.TipoNota_Id = ntas.TipoNota_Id 
			Inner Join Cat_Ciudades as cci On cci.Ciudad_Id = cm.Ciudad_id 
	Where nvnt.Tema_id = 11618
			and nvm.Menu_id = 18857
			and ntas.FechaCaptura >= '20130529'
			and ntas.Display > 0
			and nvnt.Display > 0
			-- and nvnt.FechaPublicacion >= '2012/12/05 00:00.00'
	Order by cm.Orden, ntas.Medio_id, ntas.Titulo asc
	
	
		Select cim.pagina 
	from notas nt with (nolock), Imagenes_notas imnot with (nolock), cat_imagenes_medios cim with (nolock)
	Where 	nt.nota_id = imnot.nota_id
	and	imnot.imagen_id = cim.imagen_id
	and 	nt.nota_id = 201305290342191201
	order by cim.pagina asc