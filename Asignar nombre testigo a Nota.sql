Select * from Notas where Nota_id=201207190756008301

select * from imagenes_notas where nota_id=201207260804037315
select * from cat_imagenes_medios where imagen_id = 201207190821447701

update cat_imagenes_medios set nombre= '20120719-mexpop.JPG' 
where imagen_id = 201207190821447701



select imagenes_notas.*, cat_imagenes_medios.*  from imagenes_notas
inner join cat_imagenes_medios on imagenes_notas.imagen_id=cat_imagenes_medios.imagen_id 
where imagenes_notas.nota_id=201104062104517905


