
Insert srvmspuebla.PUEBLAMS12.dbo.Cat_medios
Select * from Cat_Medios
Where Medio_Id not in (Select Medio_id from srvmspuebla.PUEBLAMS12.dbo.Cat_medios)

Insert srvmspuebla.PUEBLAMS12.dbo.Cat_Secciones
Select * from Cat_Secciones
Where Seccion_Id not in (Select Seccion_id from srvmspuebla.PUEBLAMS12.dbo.Cat_Secciones)

Insert srvmspuebla.PUEBLAMS12.dbo.Cat_Programas
Select * from Cat_Programas
Where Programa_Id not in (Select Programa_id from srvmspuebla.PUEBLAMS12.dbo.Cat_Programas)

Insert srvmspuebla.PUEBLAMS12.dbo.Cat_Usuarios
Select * from Cat_Usuarios
Where Usuario_Id not in (Select Usuario_id from srvmspuebla.PUEBLAMS12.dbo.Cat_Usuarios)