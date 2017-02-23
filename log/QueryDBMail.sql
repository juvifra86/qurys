USE master
GO
sp_configure 'show advanced options',1
GO
RECONFIGURE WITH OVERRIDE
GO
sp_configure 'Database Mail XPs',1
GO
RECONFIGURE 
GO




--2. Configurar DatabaseMail para ser usado con GMail

--Dentro de la base msdb vamos a utilizar un conjunto de procedimientos almacenados para configurar el correo, en este caso usando GMail como SMTP:

sysmail_add_account_sp  
     @account_name =  'Prueba nombre',
     @email_address =  'alertas@ixs.mx' ,
     @display_name =  'Alertas Prueba IXS' ,
     @replyto_address =  'alertas@ixs.mx' ,
     @mailserver_name =  'cp115.webempresa.eu',
     @mailserver_type =  'SMTP' ,
     @port =  587,
     @username =  'alertas@ixs.mx',
     @password =  'Alertas1!',
     @enable_ssl =  FALSE


sysmail_add_profile_sp @profile_name = 'Prueba nombre'

sysmail_add_profileaccount_sp
    @profile_name = 'Prueba nombre' ,
    @account_name = 'Prueba nombre',
    @sequence_number = 1

 
--3. Enviar un correo de prueba


sp_configure 'show advanced options', 1;

GO
RECONFIGURE;

--Para enviar un correo de prueba, podemos utilizar un procedimiento como el siguiente, siempre dentro de la base de datos msdb:

EXEC sp_send_dbmail @profile_name='Pruebaplan',
@recipients='jfranco@planfia.com',
@subject='Mensaje de prueba 4',
@body='Mi primer prueba de Database Mail'

--Y obtendremos un mensaje como el siguiente:

--Mail queued.

--Si todo funcionó bien, recibiremos el correo sin problemas. Sino, podemos explorar algunas de las opciones de la siguiente sección.

 
--4 Análisis de problemas

--Las siguientes consultas, nos pueden ayudar a hacer un análisis de los problemas y a conocer en qué estado quedaron nuestros correos:

select * from msdb.dbo.sysmail_sentitems
select * from msdb.dbo.sysmail_unsentitems
select * from msdb.dbo.sysmail_faileditems

--Esta consulta nos puede brindar más información si el estado es failed:

SELECT
items.subject,
items.last_mod_date,
l.description
FROM dbo.sysmail_faileditems as items
INNER JOIN dbo.sysmail_event_log AS l
ON items.mailitem_id = l.mailitem_id

--Si reciben un error como el siguiente “The server response was: 5.7.0 Must issue a STARTTLS command first”, lo más probable es que hayamos olvidado configurar la opción de SSL en la cuenta.

 
--5. Configurar DatabaseMail para ser usado con BlueHost

--habilitar el agente

USE msdb
GO
EXEC master.dbo.xp_instance_regwrite
N'HKEY_LOCAL_MACHINE',
N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
N'UseDatabaseMail',
N'REG_DWORD', 1
EXEC master.dbo.xp_instance_regwrite
N'HKEY_LOCAL_MACHINE',
N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
N'DatabaseMailProfile',
N'REG_SZ',
N'admin'






-- Revisar mails pendientes

SELECT * FROM sysmail_allitems 

select * from msdb.dbo.sysmail_sentitems 
select * from msdb.dbo.sysmail_unsentitems 
select * from msdb.dbo.sysmail_faileditems 

SELECT 
items.subject, 
items.last_mod_date,
l.description 
FROM dbo.sysmail_faileditems as items
INNER JOIN dbo.sysmail_event_log AS l 
ON items.mailitem_id = l.mailitem_id


