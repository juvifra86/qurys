
/*
exec getdatoscuentamail 1016
select * from msdb.dbo.sysmail_account
select * from  msdb.dbo.sysmail_server
*/

alter procedure getdatoscuentamail(@idcuenta int)
as
begin
	select   c.name
	,c.email_address
	,c.display_name
	,c.replyto_address
	,c.description
	,s.servername
	,s.port
	,s.username
	--,cre.credential_identity 
	,s.enable_ssl
	from  msdb.dbo.sysmail_account c
	inner join msdb.dbo.sysmail_server s with(nolock) on c.account_id=s.account_id
	--inner join sys.credentials cre with(nolock) on s.credential_id=cre.credential_id
	where c.account_id=@idcuenta
end