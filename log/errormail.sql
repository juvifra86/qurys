/*
   exec errormail 5312
*/
create procedure errormail(@mail_id int)
as
begin

	select top 1 description from dbo.sysmail_event_log
	where mailitem_id=@mail_id

end


No se pudo enviar el mensaje de correo a los destinatarios a causa de un error del servidor de correo. (Enviando mensaje de correo electrónico utilizando la cuenta 1014 (2016-05-16T12:16:37). Mensaje de excepción: No se pueden enviar los mensajes de correo al servidor de correo. (Error al enviar correo.).
)