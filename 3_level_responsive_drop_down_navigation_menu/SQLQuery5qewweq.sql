USE [MSCENTRALDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_NotasTemasMenuReportecarpetas]    Script Date: 10/20/2014 08:04:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/****** Object:  Stored Procedure dbo.sp_NotasTemas    Script Date: 12/03/2008 04:25:11 p.m. ******/


ALTER         PROCEDURE [dbo].[sp_NotasTemasMenuReportecarpetas] (@PnTema_id as int, @PsFechaPublicacion as varchar(10))
as
SET NOCOUNT ON

-- Select * from NV_temas Where Tema_id = 128

/**********************************
Drop Procedure 
sp_NotasTemas 48,'2011/04/04'

Autor: Alberto Martínez
Fecha: 11 May 2006
Objet: Trae las notas para crear los archivo XML de cada Tema

**********************************/
set dateformat ymd;
SELECT     nt.Nota_id, ntas.Titulo
	, ntas.Nota
	, ntas.autor1
	, ntas.autor2
	, ntas.autor3
	, ntas.Balazo1
	, ntas.Balazo2
	, ntas.Balazo3
	, ntas.Balazo4
	, nt.Tema_id
	, cm.Nombre AS Medio
	, ctm.TipoMedio_id
	, ctm.Nombre AS TipoMedio
	, cm.Vigencia
	, cm.Logo AS LogoMedio
	, cp.Nombre AS NombrePais
	, cs.Nombre AS Seccion
	, tn.Nombre AS TipoNota
	, nt.FechaPublicacion
	, nt.FechaVencimiento
	, ntas.FechaHoy
	, nt.Calificacion
	, ntas.URL
	, ntas.Costo
	, ntas.DescCosto
	, ce.Nombre AS Estado
	, ce.Estado_id
	, IsNull(cc.Nombre, 'N/D') AS Ciudad
	, IsNull(cc.Ciudad_Id, 0) As Ciudad_id
	, ced.Nombre as GrupoMedio
	, isnull(cpro.Nombre,'') as SeccionRyTV
	, fechahora as fechahoratransmision
	, cs.Conductor_Titular as ConductorTitular
	, cm.Tiraje
FROM         NV_NotasTemas AS nt WITH (nolock) 
				INNER JOIN Notas AS ntas WITH (nolock) 
						ON nt.Nota_id = ntas.Nota_id 
						AND (nt.FechaPublicacion <= @PsFechaPublicacion) 
                        AND (nt.FechaVencimiento > @PsFechaPublicacion) 
                        AND (nt.Tema_id = @PnTema_id)

				INNER JOIN Cat_Medios AS cm ON ntas.Medio_Id = cm.Medio_Id
				INNER JOIN Cat_Editorial as ced ON ced.Editorial_id = cm.Editorial_id
				INNER JOIN Cat_TipoMedios AS ctm ON cm.TipoMedio_id = ctm.TipoMedio_id
			    INNER JOIN Cat_TipoNota AS tn ON ntas.TipoNota_Id = tn.TipoNota_Id
				INNER JOIN Cat_Secciones AS cs ON ntas.Seccion_id = cs.Seccion_id

				LEFT OUTER JOIN Cat_Programas as cpro ON ntas.Programa_id = cpro.Programa_id
				LEFT OUTER JOIN Cat_Ciudades AS cc WITH (nolock) ON cm.Ciudad_id = cc.Ciudad_Id
				LEFT OUTER JOIN Cat_Estados AS ce ON cm.estado_id = ce.Estado_id 
				LEFT OUTER JOIN Cat_Paises AS cp ON cm.Pais_Id = cp.Pais_Id

WHERE     (ntas.Display = 1) AND (nt.Display > 0) AND (ntas.Nota_id IN
                          (SELECT   Nota_id
                            FROM          NV_NotasTemas WITH (nolock)
                            WHERE (     (FechaPublicacion <= @PsFechaPublicacion) 
                               AND (FechaVencimiento > @PsFechaPublicacion) 
                               AND (nt.Tema_id = @PnTema_id)))and ctm.TipoMedio_id in (1,2) )--and tn.TipoNota_Id in(9,10,25)
ORDER BY tn.TipoNota_Id,cm.Orden, ntas.Medio_Id, ntas.Titulo                                
-- ORDER BY cm.Orden, ntas.Medio_Id, ntas.FechaHora

/*
SELECT     nt.Nota_id, ntas.Titulo, ntas.Nota, ntas.autor1, ntas.autor2, ntas.autor3, ntas.Balazo1, ntas.Balazo2, ntas.Balazo3, ntas.Balazo4, nt.Tema_id, 
                      cm.Nombre AS NombreMedio, ctm.TipoMedio_id, ctm.Nombre AS TipoMedio, cm.Vigencia, cm.Logo AS LogoMedio, cp.Nombre AS NombrePais, 
                      cs.Nombre AS NombreSeccion, tn.Nombre AS TipoNota, nt.FechaPublicacion, nt.FechaVencimiento, ntas.FechaHoy, nt.Calificacion, ntas.URL, ntas.Costo, 
                      ntas.DescCosto, ce.Nombre AS Estado, ce.Estado_id, IsNull(cc.Nombre, 'N/D') AS Ciudad, IsNull(cc.Ciudad_Id, 0) As Ciudad_id
FROM         NV_NotasTemas AS nt WITH (nolock) 
				INNER JOIN Notas AS ntas WITH (nolock) 
						ON nt.Nota_id = ntas.Nota_id 
						and (nt.FechaPublicacion <= @PsFechaPublicacion) 
                        AND (nt.FechaVencimiento > @PsFechaPublicacion) 
                        AND (nt.Tema_id = @PnTema_id)
				INNER JOIN
                      Cat_Medios AS cm ON ntas.Medio_Id = cm.Medio_Id INNER JOIN
                      Cat_TipoMedios AS ctm ON cm.TipoMedio_id = ctm.TipoMedio_id INNER JOIN
                      Cat_TipoNota AS tn ON ntas.TipoNota_Id = tn.TipoNota_Id INNER JOIN
                      Cat_Secciones AS cs ON ntas.Seccion_id = cs.Seccion_id LEFT OUTER JOIN
                      Cat_Ciudades AS cc WITH (nolock) ON cm.Ciudad_id = cc.Ciudad_Id LEFT OUTER JOIN
                      Cat_Estados AS ce ON cm.estado_id = ce.Estado_id LEFT OUTER JOIN
                      Cat_Paises AS cp ON cm.Pais_Id = cp.Pais_Id
WHERE     (ntas.Display = 1) AND (nt.Display > 0) AND (ntas.Nota_id IN
                          (SELECT     Nota_id
                            FROM          NV_NotasTemas WITH (nolock)
                            WHERE      (FechaPublicacion <= @PsFechaPublicacion) 
                               AND (FechaVencimiento > @PsFechaPublicacion) 
                               AND (nt.Tema_id = @PnTema_id)))
ORDER BY cm.Orden, ntas.Medio_Id, ntas.Titulo
*/











