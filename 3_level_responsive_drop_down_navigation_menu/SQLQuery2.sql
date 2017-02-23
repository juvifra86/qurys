
INSERT INTO SRVGUADALAJARA.[MSDBOF015].dbo.Cat_medios
SELECT * FROM  Cat_Medios Where Medio_id not in (
Select Medio_id from SRVGUADALAJARA.[MSDBOF015].dbo.Cat_medios )

INSERT INTO SRVGUADALAJARA.[MSDBOF015].dbo.Cat_Secciones
Select * from Cat_Secciones Where Seccion_id not in (
Select Seccion_id from SRVGUADALAJARA.[MSDBOF015].dbo.Cat_Secciones )

INSERT INTO SRVGUADALAJARA.[MSDBOF015].dbo.Cat_Programas
Select * from Cat_Programas Where Programa_id not in (
Select Programa_id from SRVGUADALAJARA.[MSDBOF015].dbo.Cat_Programas )

INSERT INTO SRVGUADALAJARA.[MSDBOF015].dbo.Cat_Usuarios
Select * from Cat_Usuarios Where Usuario_id not in (
Select Usuario_id from SRVGUADALAJARA.[MSDBOF015].dbo.Cat_Usuarios )

