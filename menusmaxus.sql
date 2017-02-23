
Select ms.Display, ms.Menu_id, ms.Padre_id, ms.Nombre,nvt.Tema_id as tema 
	 from  NV_MenusSuscriptores ms (nolock) 
      --right join NV_Menus m on ms.Menu_id =  m.menu_id 
      right join NV_Temas nvt on ms.Nombre=nvt.Nombre
	   Where ms.Suscriptor_id = 1944 
	   and ms.Padre_id = 0 
	   and nvt.Descripcion='Maxus Calificada'
	   Order by Display 


