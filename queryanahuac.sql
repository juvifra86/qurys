Set dateformat ymd
	Select	 nvnt.Nota_id
			,cua.Calificacion
			,ntas.FechaPublicacion
			,ntas.Titulo
			,ms.Suscriptor_id as Suscriptor
			,ms.Menu_id 
			,nvnt.Tema_id
			,ntas.Agencia_Id
			,ms.Nombre as NombreMenu
			,cm.Nombre as NombreMedio
			,cs.Nombre as NombreSeccion
			,ntas.autor1
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
			left join Calificacion_Anahuac as cua on cua.Nota_id=ntas.Nota_id
	Where nvnt.Tema_id = 1203
			and nvm.Menu_id = 2222
			and ntas.FechaCaptura >= '2014/01/30'
			and ntas.Display > 0
			and nvnt.Display > 0
			-- and nvnt.FechaPublicacion >= '2012/12/05 00:00.00'
	Order by cm.Orden, ntas.Medio_id, ntas.Titulo,cua.Tipo_Cal asc