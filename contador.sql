select distinct n.Nota_id as ID, medio.Nombre as nMedio,COUNT(*) as TotalNotas 
from Notas as n 
 inner join cat_Medios as medio on n.Medio_Id=medio.Medio_Id
 inner join NV_NotasTemas as nTema on n.Nota_id=nTema.Nota_id
 inner join NV_Temas as tema on nTema.Tema_id =tema.Tema_id
 Where medio.Display >=1 and medio.Nombre like '%Guada%'
  and nTema.Tema_id=6539
 and ntema.Display>=0 and n.Display>=0
 --and n.FechaCaptura between '2012/05/23 00:00:00' and '2012/05/23 23:59:00' 
 and n.FechaPublicacion between '2012/05/23 00:00:00' and '2012/05/23 23:59:00' 
 Group by medio.Nombre,n.Nota_id 

--select * from Notas where Nota_id=201205221113235015