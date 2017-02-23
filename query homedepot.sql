Set Dateformat ymd  
Select ce.Nombre, ':' + convert(char,ntas.Nota_id) As Nota_ID, ntas.Titulo, np.campana,
 ntas.fechapublicacion, cm.Nombre as medio, cs.Nombre as seccion, cim.Pagina, ntas.nota ,
       'http://www.mediasolutions.com.mx/showclipping.asp?id=' + convert(char,ntas.Nota_id),
            np.ancho, np.alto, np.costo, np.Color,
            (Select Nombre    From Cat_Anunciantes ca, VM_NotasPublicidadGMS gms      
            Where ca.Anunciante_id = gms.id and  gms.TipoGMS_id = 2 and gms.Nota_id = ntas.Nota_id) as Anunciante, 
             IsNull(Resumen, '--') as Resumen From  notas as ntas  
             LEFT OUTER JOIN  VM_NotasPublicidad np  On np.Nota_id = ntas.Nota_id  
             LEFT OUTER JOIN  cat_medios cm On  ntas.medio_id   = cm.Medio_id 
             LEFT OUTER JOIN  cat_secciones as cs On ntas.seccion_id = cs.Seccion_id  
             LEFT OUTER JOIN  imagenes_notas as imn On imn.Nota_id     = ntas.Nota_id  
             LEFT OUTER JOIN  cat_imagenes_medios as cim On imn.Imagen_id   = cim.Imagen_id  
             LEFT OUTER JOIN  cat_Estados ce On ce.Estado_id    = cm.Estado_id  
             LEFT OUTER JOIN Resumen as res  WITH (nolock) ON res.Nota_id = ntas.Nota_id  
             Where ntas.fechacaptura between '2013/07/16' and DATEADD(DAY, 1, '2013/07/16') 
             and  ntas.Usuario_id in (44) Order by ntas.Titulo, np.campana, ntas.fechapublicacion, cm.Nombre, cs.Nombre, cim.Pagina
             
             
