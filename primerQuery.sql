Select nvt.Nombre as Tema,cs.Nombre as Seccion,COUNT(*) as TotalNotas 
from Notas as ntas 
inner join Cat_Medios as cm on ntas.Medio_Id=cm.Medio_Id 
inner join Cat_Secciones as cs on ntas.Seccion_id = cs.Seccion_id 
inner join NV_NotasTemas as nvnt on ntas.Nota_id = nvnt.Nota_id 
inner join NV_Temas as nvt on nvnt.Tema_id = nvt.Tema_id 
Where cm.Medio_id = 7343 
and ntas.fechacaptura between '2012/05/22 00:00:00' and '2012/05/23 23:59:00' 
Group by nvt.Nombre,cs.Nombre

select * from NV_Temas
select * from Cat_Secciones where Nombre='Suplemento Especial'
select cat_medios.Nombre from Cat_Medios,Cat_Secciones where cat_secciones.Nombre='Suplemento Especial'

--------------------------------------------------------------------------------------
Select notas.Titulo,NV_NotasTemas.FechaPublicacion from Notas,NV_NotasTemas 
where notas.Nota_id=NV_NotasTemas.Nota_id

select notas.Titulo,Cat_Medios.Nombre,notas.FechaCaptura from Notas,Cat_Medios
where notas.Medio_Id=Cat_Medios.Medio_Id 
and Cat_Medios.Nombre='El Sol de México'
and notas.FechaCaptura>=GETDATE()-1


--Selecciona las notas de hoy que caen el tema El Occidental (Guadalajara)
select Notas.Titulo,NV_Temas.Nombre,Cat_Medios.Nombre,Cat_Secciones.Nombre from Notas,NV_Temas,NV_NotasTemas,Cat_Medios,Cat_Secciones
where NV_Temas.Tema_id=NV_NotasTemas.Tema_id
and NV_Temas.Nombre='Grupo Salinas'
and NV_NotasTemas.Nota_id=notas.Nota_id
and notas.Medio_Id=Cat_Medios.Medio_Id 
and Cat_Medios.Nombre in (Select * from cat_Medios Where Display >0 and Nombre like '%Guada%'	)
and notas.FechaCaptura>=GETDATE()-1

  
  select distinct notas.Titulo,Cat_Medios.Nombre 
  from Notas,Cat_Medios,Cat_Secciones
  where notas.Medio_Id=Cat_Medios.Medio_Id
  and notas.FechaCaptura>=GETDATE()-1
------------------------------------------------------------------------------

select medio.Nombre as Id,COUNT(*) as TotalNotas
from Notas as n
inner join cat_Medios as medio on n.Medio_Id=medio.Medio_Id
inner join NV_NotasTemas as nTema on nTema.Nota_id=n.Nota_id
inner join NV_Temas as tema on tema.Tema_id=nTema.Tema_id
Where medio.Display >=1 and medio.Nombre like '%Guada%'	
and tema.Tema_id=8596
and n.FechaCaptura between '2012/05/23 00:00:00' and '2012/05/23 23:59:00'
Group by medio.Nombre

select * from NV_MenusSuscriptores