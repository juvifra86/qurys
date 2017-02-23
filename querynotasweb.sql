
--create table CostosMediosWeb_jv(Medio_id int not null,Costo varchar(25) not null,primary key (Medio_id))


set dateformat ymd
select ntas.Nota_id,cm.Medio_id,ntas.Costo from Notas as ntas 
inner join Cat_Medios as cm on ntas.Medio_id=cm.Medio_Id
where cm.TipoMedio_id in(3) and ntas.FechaCaptura>'2014/06/09'
order by ntas.FechaCaptura


select * from Cat_Medios where Nombre like'%El Salvador.com%'
	
--insert into CostosMediosWeb_jv values(13730,'26,838.56')


Select distinct nvms.Nombre as Menu,ntas.Titulo,ntas.FechaPublicacion as Fecha,ce.NombreCorto as Estado,cp.Nombre as Pais,cm.Nombre as Medio,cs.Nombre as Seccion,ntas.autor1 as Autor,cnt.Nombre as Tipo_Nota,tm.Nombre as Tipo_Medio,ntas.descCosto as Tamaño,ntas.Costo as Costo from Notas as ntas inner join NV_NotasTemas  nvntas on nvntas.Nota_id = ntas.Nota_id inner join NV_Menus nvm on nvm.Tema_id=nvntas.Tema_id inner join NV_MenusSuscriptores nvms on nvms.Menu_id=nvm.Menu_id inner join Cat_Medios cm on ntas.Medio_id = cm.Medio_id inner join Cat_Secciones cs on ntas.Seccion_id = cs.Seccion_id inner join Cat_TipoNota cnt on ntas.TipoNota_Id = cnt.TipoNota_Id inner join Cat_Paises cp on cm.Pais_Id=cp.Pais_Id inner join Cat_Estados ce on cm.estado_id=ce.Estado_id inner join Cat_TipoMedios tm on cm.TipoMedio_id=tm.TipoMedio_id Where nvntas.Tema_id = '85' and nvntas.FechaPublicacion between '2014/06/06' and '2014/06/06'

Select distinct nvms.Nombre as Menu,ntas.Titulo,ntas.FechaPublicacion as Fecha,ce.NombreCorto as Estado,cp.Nombre as Pais,cm.Nombre as Medio,cs.Nombre as Seccion,ntas.autor1 as Autor,cnt.Nombre as Tipo_Nota,tm.Nombre as Tipo_Medio,ntas.descCosto as Tamaño,ntas.Costo as Costo from Notas as ntas inner join NV_NotasTemas  nvntas on nvntas.Nota_id = ntas.Nota_id inner join NV_Menus nvm on nvm.Tema_id=nvntas.Tema_id inner join NV_MenusSuscriptores nvms on nvms.Menu_id=nvm.Menu_id inner join Cat_Medios cm on ntas.Medio_id = cm.Medio_id inner join Cat_Secciones cs on ntas.Seccion_id = cs.Seccion_id inner join Cat_TipoNota cnt on ntas.TipoNota_Id = cnt.TipoNota_Id inner join Cat_Paises cp on cm.Pais_Id=cp.Pais_Id inner join Cat_Estados ce on cm.estado_id=ce.Estado_id inner join Cat_TipoMedios tm on cm.TipoMedio_id=tm.TipoMedio_id Where nvntas.Tema_id = '0' and nvntas.FechaPublicacion between '2014/06/03' and '2014/06/03'