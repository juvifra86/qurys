SELECT cm.Nombre,cm.Marca_id AS Marca_id 
 FROM   Cat_Marcas cm 
 Where Anunciante_id in (Select Anunciante_id from Cat_Anunciantes Where Giro_id in (Select id from VM_TemasGMS Where Tema_id = 1624 and TipoGMS_id = 1)) Order BY cm.Nombre 