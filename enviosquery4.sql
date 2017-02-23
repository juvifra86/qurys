Select Top 9 ntas.Nota_id,ntas.Titulo, cm.Nombre as nombremedio, cm.logo
     from NV_NotasTemas as nt, Notas as ntas, Cat_Medios as cm 
     Where nt.Tema_id = 1 
     and ntas.fechapublicacion = '2013-05-31'  --fecha de hoy en formato yyyy/mm/dd
     and nt.Nota_id = ntas.Nota_id 
     and ntas.Medio_id = cm.Medio_id 
     Order by cm.Orden 