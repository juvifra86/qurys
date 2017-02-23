
Set dateformat ymd 
	Select 	Count(ntas.Nota_id) as Total 
	from 	NV_NotasTemas ntmas with (nolock), 
		Notas ntas with (nolock), 
		NV_MenusSuscriptores ms with (nolock), 
		NV_Menus men with (nolock)
	Where	ntmas.Tema_id = 11618
		and ms.Menu_id = 18857
		and ms.Suscriptor_id = 1944
		and (ntas.FechaCaptura >= '20130529' and ntas.FechaCaptura <= '20130529')
		and ntmas.Nota_id = ntas.Nota_id 
		and ms.menu_id = men.Menu_id 
		and men.Tema_id = ntmas.Tema_id 
		and ntmas.Display > 0 
		
		