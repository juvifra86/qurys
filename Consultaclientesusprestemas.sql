Select cli.Cliente_id,cli.Nombre_Cliente,cli.Comentarios as comentarioscliente,sus.Suscriptor_id as sus_id,sus.Nombre as NombreSuscriptor,sus.Descripcion as descripcionsuscriptor,nvm.Tema_id,nvt.Nombre as NombreTema,nvt.Descripcion as DescripcionTema,nvuss.usuario,nvuss.clave 
from  Clientes as cli inner join Suscriptores as sus on cli.Cliente_id =sus.Cliente_id 
inner join NV_MenusSuscriptores as nvms on sus.Suscriptor_id = nvms.Suscriptor_id 
inner join NV_Menus as nvm on nvms.Menu_id = nvm.Menu_id 
inner join NV_Temas as nvt on nvt.Tema_id = nvm.Tema_id 
inner join dbo.nv_usuarios_suscriptor as nvuss on sus.Suscriptor_id = nvuss.Suscriptor_id 
Where nvt.Display = 1

