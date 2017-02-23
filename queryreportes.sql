set dateformat YMD 
            Select distinct nvms.Nombre as Menu,ntas.Titulo,ntas.FechaPublicacion as Fecha,
           ce.Nombre as Estado,cp.Nombre as Pais,cm.Nombre as Medio,cs.Nombre as Seccion,
            ISNULL(ntas.Autor1,'s/a') as Autor,ISNULL(ntas.Autor2,'s/a') as Autor2,ISNULL(ntas.Autor3,'s/a') as Autor3,cnt.Nombre as Tipo_Nota,tm.Nombre as Tipo_Medio,ntas.descCosto as Tamaño,
           ntas.FechaCaptura as Hora,isnull((Select Valor from NotasExtras nex Where nex.Nota_id = ntas.Nota_id and NotaExtra_id = 1),'0') as Calificacion 
            ,cs.Conductor_Titular as Conductor 
            ,cm.Tiraje,isnull(cte.Reiting,0)as Rating,ntas.Costo as Costo,'http://www.mediasolutions.com.mx/ncpop.asp?n='+cast(ntas.nota_id as nchar)as URL 
           from Notas as ntas
            inner join NV_NotasTemas  nvntas on nvntas.Nota_id = ntas.Nota_id 
            inner join NV_Menus nvm on nvm.Tema_id=nvntas.Tema_id 
            inner join NV_MenusSuscriptores nvms on nvms.Menu_id=nvm.Menu_id 
            inner join Cat_Medios cm on ntas.Medio_id = cm.Medio_id 
            inner join Cat_Secciones cs on ntas.Seccion_id = cs.Seccion_id 
            inner join Cat_TipoNota cnt on ntas.TipoNota_Id = cnt.TipoNota_Id 
            inner join Cat_Paises cp on cm.Pais_Id=cp.Pais_Id 
            inner join Cat_Estados ce on cm.estado_id=ce.Estado_id 
            Left JOIN cat_TarifasElectronicos as cte On cte.Medio_id = cm.Medio_id and cte.Seccion_id = cs.Seccion_id 
            inner join Cat_TipoMedios tm on cm.TipoMedio_id=tm.TipoMedio_id 
            Where nvntas.Tema_id in (13057) and --aqui van los temas
            ((ntas.fechaPublicacion <= '2013/01/1' --fecha inicio
            and ntas.FechaVencimiento > '2014/08/20') --fechafin
             or (ntas.FechaPublicacion >= '2013/01/1' --fecha inicio
            and ntas.FechaPublicacion <= '2014/08/20'))--fechafin
            
            
            
            
            