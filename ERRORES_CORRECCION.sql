-- S E G U R O S 

	--Q U A L I T A S

		--VER RESULTADO PARA FORMAR XML
		SPSOFIA_COTIZADORCodigoUnidadSeg 54868 

		--PARA ERROR  "l Codigo P" VERIFICAR EL CAMPO DATOSCLIENTE:
			--SI DESPUES DEL RFC HAY DOS CEROS: EDITAR DIRECCION (CpId), BUSCANDO EL CpKey EN LA TABLA CP CON EL CP DE LA DIRECCION
			--SI HAY DATOS DESPUES DEL RFC: COMPROBAR EL ESTADO DE LA COTIZACION (EstadoId) VS EL ESTADO DE LA DIRECCION 
			----HACIENDO UN JOIN CON CP... SI SON DIFERENTES:INFORMAR A CREDITO

		--PARA ERROR "RFC no V"
			-- SI ES PERSONA FISICA VERIFICAR EL CAMPO RFC VS Nombre,Nombre2,ApPaterno,ApMatrno Y FechaNacimiento
			-- SI ES PERSONA MORAL VERIFICAR EL CAMPO RFC VS Nombre Y FechaConst
			-- SI SON DIFERENTES: INFORMAR A CREDITO

		-----------------------------------------------------------------------------------

		--VER SOLICITUD, COTIZACION Y SU ID CLIENTE

		SELECT S.SolicitudKey
			,S.idcliente -- SI HAY QUE CAMBIAR LA DIRECCION SERA BUSCANDO EL CLIENTE
			,S.FechaSolicitud -- SI LA FECHA DE SOLICITUD ES MENOR A OCTUBRE 1, TENDRA QUE SER MANUAL, SINO VERIFICAR SI SE REALIZO UN CAMBIO DE COTIZACION MANUAL DESDE LOS ARCHIVOS EN SOFIA
			,S.NoCotizacion  -- COTIZACION ASOCIADA A LA SOLICITUD, SI NO CUADRAN LAS PRIMAS TOTALES VERIFICAR SI SE REALIZO UN CAMBIO DE COTIZACION MANUAL DESDE LOS ARCHIVOS EN SOFIA
			,C.FechaCotizacion  -- SI LA FECHA DE SOLICITUD ES MENOR A OCTUBRE 1, TENDRA QUE SER MANUAL, SINO VERIFICAR SI SE REALIZO UN CAMBIO DE COTIZACION MANUAL DESDE LOS ARCHIVOS EN SOFIA
			FROM vwSolicitud S 
			INNER JOIN Cotizacion C ON C.NoCotizacion = S.NoCotizacion
			WHERE S.SolicitudKey = 54868


		SELECT * FROM BitacoraSolicitud WHERE SolicitudId in (51107  ) ORDER BY FechaEstatus desc

		SELECT * FROM Cotizacion C WHERE  NoCotizacion in(173423)

		--SI EXISTE UN CAMBIO DE COTIZACION MANUAL, INFORMAR A SEGUROS

		------------------------------------------------------------------------------------

		--EDITAR CpId DE LA DIRECCION DEL CLIENTE
		-- VER DIRECCION
		SELECT * FROM  DireccionActor WHERE ActorId = 244756 

		--VER EL CP DEL CLIENTE
		SELECT * FROM CP WHERE CP = 81000

		--EDITAR DIRECCION
		--UPDATE DireccionActor SET CpId = 250021 WHERE DireccionActorKey IN(219539)
		--UPDATE DireccionActor SET Numext = 'EDIF D1 9' WHERE DireccionActorKey IN(11023)

		------------------------------------------------------------------------------------

		--PARA CUALQUIER OTRO ERROR, DEBUGEAR EL WS EN SU METODO "COTIZADORSegurosPoliza" Y VERIFICAR QUE DEVUELVE EL WS DE QUALITAS

	--A B A
		--ERROR EN EL RFC CON HOMOCLAVE
			--AVISAR A CREDITO QUE EL RFC ESTA MAL CAPTURADO
		
	--M A P F R E
		--LONGITUD DE CAMPO DEMASIADO LARGO PARA SER ALMACENADO
			--VERIFICAR TELEFONOS, QUE NO TENGAN EL 01
			


--  M A S T E R    C O L L E C T I O N

-- LEER BITACORA
SELECT * FROM bitacoraMaster WHERE CAST(INIT AS DATE) = CAST(GETDATE() AS DATE)

--SECCION 1 : INICIA EL SELECT PRINCIPAL
--SECCION 2 : SALE DEL SELECT PRINCIPAL DURACION PROMEDIO 45MIN - 1HR
--SECCION 3 : ENTRA AL PROCEDIMIENTO DONDE INSERTA LAS CUENTAS DE INICIO DE MES
--SECCION 4 : INICIA EL INSERT SI ENCONTRO CUENTAS DE INICIO DE MES QUE NO ESTEN EN EL DIA ACTUAL
--SECCION 5 : SALE DEL INSERT DEL PROCEDIMIENTO DONDE INSERTA LAS CUENTAS DE INICIO DE MES
--SECCION 6 : SALE DEL PROCEDIMIENTO DE LA MASTER COLLECTION

--REVISARL EL JOB : Cobranza Master Collection

--FALLA EN EL PASO 7
	--SI LA MASTER FALLA LA SECCION 1, LA SECCION 2 SE INSERTARA SIN PASAR LA DURACION PROMEDIO, EN ESTE CASO INSERTARA TODAS LAS CUENTAS DEL PRIMER DIA DE MES, LAS CUALES SE TENDRAN QUE BORRAR.
	--donde la fechacarga sea el dia actua
	--HACER UN ALTER AL PROCEDIMIENTO spSofia_Mastercollection
	--CORRER EL JOB A PARTIR DEL PASO 7
	
--OTRAS POSIBLES FALLAS
	--ERROR EN EL ENVIO DEL FTP (PASOS 13 Y 14 DEL JOB)
		--SI EN EL DETALLE DEL ERROR INDICA QUE EL ARCHIVO QUE SE INTENTA ENVIAR EXISTE, AVISAS A CRISTAL DE COBRANZA PARA QUE ELLA HABLE A MASTER Y BORREN LOS ARCHIVOS
		--SI EN EL DETALLE DEL ERROR INDICA QUE NO SE PUDO CONECTAR EL FTP, COMPROBAR LA CONECCION CON MARIANO
			-- EN AMBOS CASOS EL ARCHIVO DE MASTERCOLLECTION YA SE ENCUENTRA EN EL SERVIDOR, ya lo pueden ver los de cobranza




--Impresion de polizas
			select top 5 * from UnidadCuentaCte

			select ps.PathPoliza from PolizaseguroUnidad ps    
			inner join UnidadCuentaCte ucc on ucc.UnidadCuentaCtekey=ps.UnidadCuentaCteId
			where ucc.CuentaCteId=12758--cuenta 
			
			select * from EstadoPO




	--------------------		
			--solicitudes que estan autorizadas con las compañias, 
			--cuentas en status activo     vwcuenta

			--axa y mapfre

			--sin mezclar


		--Solicitudes Autorizadas de Mapfre y Axa

	     select * from vwsolicitud vs 
			where vs.EstadoDsc='Autorizada' and vs.AseguradoraId in(4,9) and Init>'20150901'			
			 order by SolicitudKey desc 

		
		--Cuentas en estado activo de Mapfre y Axa
			select * from vwCuenta 
			where Situacion=12 
			and AseguradoraId in(4,9)
			and SolicitudID not in(
					select SolicitudKey from vwsolicitud vs 
					where vs.EstadoDsc='Autorizada' and vs.AseguradoraId in(4,9) and Init>'20150901') 

		