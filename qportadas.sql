Set Dateformat YMD; 
        Select distinct cim.Nombre From Imagenes_Notas as im
        Inner Join Cat_Imagenes_Medios as cim on im.Imagen_id = cim.Imagen_id
       Where Nota_id in (Select Nota_id From notas 
        Where Medio_Id in (8,850,843,542,10,423,318,317,9,1768)
       And (FechaPublicacion =  '20130607')) and cim.Nombre like '%portada%'
       
    -- select * from Cat_Medios where Medio_Id in (8,850,843,542,10,423,318,317,9,1768)
   