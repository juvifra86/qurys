/****** Script para el comando SelectTopNRows de SSMS  ******/
SELECT TOP 1000 [Tema_id]
      ,[Suscriptor_id]
      ,[ParaCalifica_id]
  FROM [MSCENTRALDB].[dbo].[ParaTemaCalificaNota] where Suscriptor_id=1707
--insertar tema por suscriptor para calificar negativo/positivo
 
  insert into ParaTemaCalificaNota values(13748 ,1707,6)
  insert into ParaTemaCalificaNota values(13749 ,1707,6) 
  insert into ParaTemaCalificaNota values(13750 ,1707,6) 
  insert into ParaTemaCalificaNota values(13751 ,1707,6) 
  insert into ParaTemaCalificaNota values(13752 ,1707,6) 
  insert into ParaTemaCalificaNota values(13759 ,1707,6) 
  insert into ParaTemaCalificaNota values(13754 ,1707,6)
  insert into ParaTemaCalificaNota values(13755 ,1707,6) 
  insert into ParaTemaCalificaNota values(13757 ,1707,6) 
  insert into ParaTemaCalificaNota values(13758 ,1707,6) 
  insert into ParaTemaCalificaNota values(13753 ,1707,6) 
  
--cambiar idioma  
 update ParaTemaCalificaNota set ParaCalifica_id=6 where Tema_id=13761 
 
Select pcc.ParametroCal_id, pcc.Parametro from ParaTemaCalificaNota ptn, ParaCatCalifica pcc 
Where ptn.ParaCalifica_id = pcc.ParaCalifica_id and ptn.Tema_id = 10232 and ptn.Suscriptor_id = 1707
  Select pcc.ParametroCal_id, pcc.Parametro from ParaTemaCalificaNota ptn, ParaCatCalifica pcc Where ptn.ParaCalifica_id = pcc.ParaCalifica_id and ptn.Tema_id = 13746 and ptn.Suscriptor_id = 1707

 select * from ParaCatCalifica --
 select * from ParaTemaCalificaNota where Tema_id =10232
 select * from ParaTemaCalificaNota where Tema_id =13746
 
 
 --Obtener menus del suscriptor 
  SELECT ms.Display, ms.Menu_id, ms.Padre_id, ms.Nombre, m.Tema_id, ms.Vista_id, ms.Separador 
	  FROM NV_MenusSuscriptores AS ms LEFT OUTER JOIN 
       NV_Menus AS m WITH (nolock) ON ms.Menu_id = m.Menu_id 
	   WHERE     (ms.Suscriptor_id = 1730) AND (ms.Padre_id = 0) 
	  ORDER BY ms.Display 
  
  --borrar tema x suscriptor para calificar negativo/positivo
  delete from ParaTemaCalificaNota where Tema_id=4400 and Suscriptor_id=1730