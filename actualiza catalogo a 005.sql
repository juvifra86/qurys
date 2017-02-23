Insert srvmsreplica.dbmscof005.dbo.cat_medios
Select * from Cat_Medios
Where Medio_Id not in (Select Medio_Id from srvmsreplica.dbmscof005.dbo.cat_medios)

Insert srvmsreplica.dbmscof005.dbo.cat_Secciones
Select * from Cat_Secciones
Where Seccion_Id not in (Select Seccion_Id from srvmsreplica.dbmscof005.dbo.cat_Secciones)

Insert srvmsreplica.dbmscof005.dbo.cat_Programas
Select * from Cat_Programas
Where Programa_Id not in (Select Programa_Id from srvmsreplica.dbmscof005.dbo.cat_Programas)



