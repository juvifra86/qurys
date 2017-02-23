Select ntas.Nota_id, ntas.FechaHora, ntas.Titulo,cm.Nombre as NombreMedio,cm.Logo as Logo,cs.Nombre as NombreSeccion,cs.Conductor_Titular,ntas.Nota,ntas.FechaCaptura
from NV_NotasTemas as nvntas
Inner Join Notas as ntas on nvntas.Nota_id = ntas.Nota_id 
Inner Join Cat_Medios as cm On ntas.Medio_id = cm.Medio_id 
Inner Join Cat_Secciones as cs On ntas.Seccion_id = cs.Seccion_id 
Where nvntas.Tema_id = 9902
and cm.TipoMedio_id in (4,5) 
and ntas.FechaCaptura between GetDate()-2 and GetDate() 
and ntas.Display>=1 and nvntas.Display>=1 
and ntas.FechaPublicacion>=GetDate()-2

UNION ALL

Select ntas.Nota_id, ntas.FechaHora, ntas.Titulo,cm.Nombre as NombreMedio,cm.Logo as Logo,cs.Nombre as NombreSeccion,cs.Conductor_Titular,ntas.Nota,ntas.FechaCaptura
from NV_NotasTemas as nvntas 
Inner Join Notas as ntas on nvntas.Nota_id = ntas.Nota_id 
Inner Join Cat_Medios as cm On ntas.Medio_id = cm.Medio_id 
Inner Join Cat_Secciones as cs On ntas.Seccion_id = cs.Seccion_id 
Where nvntas.Tema_id = 9902
and cm.Medio_Id in (9325,9905,9787,9323)
and ntas.fechacaptura between GetDate()-2 and GetDate() 
and ntas.FechaPublicacion>=GetDate()-2
and ntas.Display>=1 and nvntas.Display>=1
Order by ntas.FechaCaptura desc  



