/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [Tema_id]
      ,[Suscriptor_id]
      ,[ParaCalifica_id]
  FROM [MSCENTRALDB].[dbo].[ParaTemaCalificaNota] where Tema_id=10383 
  
  insert into ParaTemaCalificaNota values(10343,1729,6)