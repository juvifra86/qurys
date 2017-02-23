Select ms.Display, ms.Menu_id, ms.Padre_id, ms.Nombre as NombreMenu, m.Tema_id 
       from  NV_MenusSuscriptores ms (nolock)
       left join NV_Menus m on ms.Menu_id =  m.menu_id 
       Where ms.Suscriptor_id = 1191 
       and ms.Padre_id = 0 
       Order by Display 
       
       
Select Termino,TipoBusqueda from NV_TemasTerminos With (nolock) Where Tema_id =11618

Select ms.Display, ms.Menu_id, ms.Padre_id, ms.Nombre,nvt.Tema_id as Tema_id 
	   from  NV_MenusSuscriptores ms (nolock) 
      right join NV_Temas nvt on ms.Nombre=nvt.Nombre
	  Where ms.Suscriptor_id = 1952
	   and ms.Padre_id = 0
	  Order by Display 
	  
	  Select ms.Display, ms.Menu_id, ms.Padre_id, ms.Nombre, isnull(m.Tema_id,0) as Tema_id  " _
		  & " from  NV_MenusSuscriptores ms (nolock) " _
	      & " left join NV_Menus m on ms.Menu_id =  m.menu_id " _
		  & " Where ms.Suscriptor_id = " & iSuscriptor_id & " " _
		  & " and ms.Padre_id = " & Padre_id & "and display > 0 " _
		  & " Order by Display "
	  
	  select * from NV_Temas where Tema_id =11683
	  select * from NV_Temas where Tema_id =5009