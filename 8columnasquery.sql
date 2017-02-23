Set Dateformat YMD;
select * from NV_NotasTemas as nt 
inner join Notas as ntas on nt.Nota_id=ntas.Nota_id
inner join Cat_Medios as cm on ntas.Medio_Id=cm.Medio_Id
where nt.Tema_id=1 and ntas.FechaPublicacion ='2013-08-19 00:00:00.000'

select cim.Nombre as Imagen from Cat_Imagenes_Medios as cim inner join Imagenes_Notas as im on cim.Imagen_id = im.Imagen_id inner join Notas as ntas on im.Nota_id=ntas.Nota_id where ntas.Nota_id=201308190530258701  and cim.Nombre like '%ortad%'
select cim.Nombre as Imagen from Cat_Imagenes_Medios as cim
inner join Imagenes_Notas as im on cim.Imagen_id = im.Imagen_id
inner join Notas as ntas on im.Nota_id=ntas.Nota_id
where ntas.Nota_id=201308190050556101 and cim.Nombre like '%ortad%'