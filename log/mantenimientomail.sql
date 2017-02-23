/*
	exec mantenimientomail
*/

alter procedure mantenimientomail
as
begin

           select account_id 'ID',name 'Cuenta' from msdb.dbo.sysmail_account

	       select se.mailitem_id 'ID Correo',c.name 'Cuenta',se.recipients 'Enviado A',se.subject 'Asunto' from msdb.dbo.sysmail_unsentitems se
		    inner join msdb.dbo.sysmail_profile c with(nolock) on se.profile_id=c.profile_id

		   select e.mailitem_id 'ID Correo',c.name 'Cuenta',e.recipients 'Enviado A',e.subject 'Asunto' from msdb.dbo.sysmail_sentitems e
		    inner join msdb.dbo.sysmail_profile c with(nolock) on e.profile_id=c.profile_id

		   select er.mailitem_id 'ID Correo',c.name 'Cuenta',er.recipients 'Enviado A',er.subject 'Asunto' from msdb.dbo.sysmail_faileditems er
		    inner join msdb.dbo.sysmail_profile c with(nolock) on er.profile_id=c.profile_id
end