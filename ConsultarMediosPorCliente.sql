select medio.Medio_Id,medio.Nombre
from cat_MediosUsuarios as medioUsuario
inner join Cat_Medios as medio on medio.Medio_Id=medioUsuario.medio_id
where usuario_id=57  



select * from NV_MenusSuscriptores where Suscriptor_id=510
select * from NV_Menus where Menu_id=342
select * from NV_TemasTipoAgenciaMedio where Tema_id=85


select distinct menuSuscriptor.Menu_id as MENU_ID, menu.Tema_id
from NV_MenusSuscriptores as menuSuscriptor
inner join NV_Menus as menu on menu.Menu_id=menuSuscriptor.Menu_id
inner join NV_TemasTipoAgenciaMedio as tipoMedio on tipoMedio.TipoAgenciaMedio_id=3
--inner join Cat_Medios as medio on medio.Medio_Id=tipoMedio.Descripcion_id
where menuSuscriptor.Suscriptor_id=510 

---------------
Select distinct cm.Nombre from NV_TemasTipoAgenciaMedio as nvttam, cat_Medios as cm 
Where nvttam.Tema_id in (28,85,12,70,72,71,68,69,81,48,25,18,24,26,27,29,86,437,17,87,16,30,3,41,1059,96,97,45,
99,100,98,44,9,94,101,7,89,95,91,88,23,800,1302,1714,1828,90,4241,4306,4336,4640,5254,9232,2) 
and nvttam.tipoagenciamedio_id=3
and nvttam.Descripcion_id = cm.Medio_Id 
and nvttam.tipoagenciamedio_id=3
and cm.TipoMedio_id=2
