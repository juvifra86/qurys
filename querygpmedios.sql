
  
  
  Set Dateformat YMD
  select mr.Nombre as Marca, ntas.FechaPublicacion as Fecha, cm.Nombre as Medio,'http://www.mediasolutions.com.mx/nc.asp?n='+cast(vntas.Nota_id as CHAR) as Link
  from VM_NotasPublicidadGMS vntas
  inner join Notas as ntas on ntas.Nota_id=vntas.Nota_id
  inner join Cat_Medios as cm on cm.Medio_Id=ntas.Medio_Id
  inner join Cat_Marcas as mr on mr.Marca_id=vntas.ID
  where mr.Marca_id in(5978,9120,10526,177,9556,11526,1598,2472,2728,3221,7762,12082,10507,10958,4768,3663,6238,4108,3262,6617,4078,500,501,1715)and
        ntas.FechaPublicacion > '2010-1-1'
  order by ntas.FechaPublicacion,mr.Nombre
  
  
  select * from Cat_Marcas where Nombre like 'lady gaga'
  select * from Cat_Marcas where Nombre like 'OPI'
  select * from Cat_Marcas where Nombre like 'FRIJOLES ISADORA'
  select * from Cat_Marcas where Nombre like 'CASAS HIR'













