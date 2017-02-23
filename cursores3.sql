
CREATE TABLE #TablaRecorteTemporal (Tema_id int, Nota_id bigint,FechaPublicacion date,FechaVencimiento date,Display int,Usuario_id int,Calificacion int)

declare @tipoieI as int
declare @tipoieE as int
declare @Tema_id as int
declare @Tipoie as int
declare @Proyecto_id as int

Select @Proyecto_id = 1
Select @Tema_id = 10129

Select @tipoieI = (Select COUNT(*) From AdminRecortesTemasMedios Where tipoie=1 AND Proyecto_id=@Proyecto_id and Tema_id = @Tema_id) 
Select @tipoieE = (Select COUNT(*) From AdminRecortesTemasMedios Where tipoie=0 AND Proyecto_id=@Proyecto_id and Tema_id = @Tema_id) 

if @tipoieI = 0 and @tipoieE = 0
BEGIN
			Insert into #TablaRecorteTemporal
            Select nvnt.Tema_id,nt.Nombre as Tema,cm.Nombre as Medio,ntas.Medio_Id,ntas.Titulo,nvnt.Display,ntas.Nota_id,(Select COUNT(*) from RecortesTestigosNotas as rtn Where rtn.Nota_id=ntas.Nota_id) as Recortes,isnull(ctrrec.Nota_id,0) as Nota_ides,isNull(cu.Nombre,'S/A') as Nombre
            from NV_NotasTemas as nvnt 
            inner join notas as ntas on ntas.Nota_id = nvnt.Nota_id 
            inner join Cat_Medios as cm on cm.Medio_Id = ntas.Medio_Id 
            inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id 
            inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id 
            left join AdminRecortesProceso as ctrrec on ctrrec.Nota_id = nvnt.Nota_id and ctrrec.Tema_id = nvnt.Tema_id 
            left join Cat_Usuarios as cu On cu.Usuario_Id = ctrrec.Usuario_id 
            Where(nvnt.Display >= 0)
            and nvnt.FechaPublicacion between '2013/03/27' and  '2013/03/27'
            and cm.TipoMedio_id = 1
            and nvnt.Tema_id = @Tema_id 
            Order by art.Orden  
END

 IF @tipoieI > 0
BEGIN
			Insert into #TablaRecor
            Select nvnt.Tema_id,nt.Nombre as Tema,cm.Nombre as Medio,ntas.Medio_Id,ntas.Titulo,nvnt.Display,ntas.Nota_id,(Select COUNT(*) from RecortesTestigosNotas as rtn Where rtn.Nota_id=ntas.Nota_id) as Recortes,isnull(ctrrec.Nota_id,0) as Nota_ides,isNull(cu.Nombre,'S/A') as Nombre
            from NV_NotasTemas as nvnt 
            inner join notas as ntas on ntas.Nota_id = nvnt.Nota_id 
            inner join Cat_Medios as cm on cm.Medio_Id = ntas.Medio_Id 
            inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id 
            inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id 
            left join AdminRecortesProceso as ctrrec on ctrrec.Nota_id = nvnt.Nota_id and ctrrec.Tema_id = nvnt.Tema_id 
            left join Cat_Usuarios as cu On cu.Usuario_Id = ctrrec.Usuario_id 
            Where(nvnt.Display >= 0)
            and nvnt.FechaPublicacion between '2013/03/27' and  '2013/03/27'
            and cm.TipoMedio_id = 1
            and nvnt.Tema_id = @Tema_id
            and cm.Medio_Id in (Select Medio_Id From AdminRecortesTemasMedios Where tipoie=1 AND Proyecto_id=@Proyecto_id and Tema_id = @Tema_id )
            Order by art.Orden  
END

 IF @tipoieE >0
BEGIN
			Insert into #TablaRecor
            Select nvnt.Tema_id,nt.Nombre as Tema,cm.Nombre as Medio,ntas.Medio_Id,ntas.Titulo,nvnt.Display,ntas.Nota_id,(Select COUNT(*) from RecortesTestigosNotas as rtn Where rtn.Nota_id=ntas.Nota_id) as Recortes,isnull(ctrrec.Nota_id,0) as Nota_ides,isNull(cu.Nombre,'S/A') as Nombre
            from NV_NotasTemas as nvnt 
            inner join notas as ntas on ntas.Nota_id = nvnt.Nota_id 
            inner join Cat_Medios as cm on cm.Medio_Id = ntas.Medio_Id 
            inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id 
            inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id 
            left join AdminRecortesProceso as ctrrec on ctrrec.Nota_id = nvnt.Nota_id and ctrrec.Tema_id = nvnt.Tema_id 
            left join Cat_Usuarios as cu On cu.Usuario_Id = ctrrec.Usuario_id 
            Where(nvnt.Display >= 0)
            and nvnt.FechaPublicacion between '2013/03/27' and  '2013/03/27'
            and cm.TipoMedio_id = 1
            and nvnt.Tema_id = @Tema_id
            and cm.Medio_Id not in (Select Medio_Id From AdminRecortesTemasMedios Where tipoie=0 AND Proyecto_id=@Proyecto_id and Tema_id = @Tema_id)
            Order by art.Orden  

END