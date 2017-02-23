select * from nv_usuarios_suscriptor where usuario like'%merida%'

set dateformat YMD 
select nt.Nota_id as "Nota Id",nt.FechaCaptura,cc.NombreCompleto as Capturista,cm.Nombre as Medio,cs.Nombre as Seccion,nt.Costo from Notas as nt
inner join Cat_Medios as cm on nt.Medio_Id=cm.Medio_Id
inner join Cat_Secciones as cs on nt.Seccion_id=cs.Seccion_id
inner join Cat_Usuarios as cc on nt.Usuario_Id=cc.Usuario_Id
inner join Cat_TipoMedios tm on cm.TipoMedio_id=tm.TipoMedio_id
Where  ((nt.fechaPublicacion <= '2014/08/18' 
            and nt.FechaVencimiento > '2014/08/20') 
             or (nt.FechaPublicacion >= '2014/08/18' 
            and nt.FechaPublicacion <= '2014/08/20')) and cc.NombreCompleto like'César Eduardo Zamora Muñoz'