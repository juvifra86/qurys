Select m.Marca_id, m.Nombre as NombreMarca 
						 from Cat_Marcas m 
						Where Marca_id in(11589, 5305, 3287)
						
SELECT  cast(cm.Nombre as nchar)+' con '  +cast(cm.Marca_id  as nchar)AS Marca_id 
						FROM   Cat_Marcas cm 
						 Where Anunciante_id in (Select Anunciante_id from Cat_Anunciantes Where Giro_id in 
						 (Select id from VM_TemasGMS Where Tema_id = 1624 and TipoGMS_id = 1)) Order BY cm.Nombre 

select top 10 cast(nota_id as nchar) +' es el id de ' + Titulo as prueba from Notas