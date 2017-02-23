/*
  exec sysmail_delete_account_sp 9,'prueba'
  exec borracuenta 9,'prueba'
  msdb.dbo.sysmail_account
  select name from msdb.dbo.sysmail_profile
  msdb.dbo.sysmail_profileaccount
  exec sysmail_delete_account_sp 7,'lkala'
  exec sysmail_delete_profile_sp 5,'lkala'
  exec sysmail_delete_profileaccount_sp 5,'lkala',7,'lkala'
*/

create procedure borracuenta(@idcuenta int,@nombre varchar(80))
as
declare @idprofile int
begin 

	select @idprofile=profile_id from msdb.dbo.sysmail_profileaccount
	    where account_id=@idcuenta

	begin try
	 begin tran borrar
	 exec sysmail_delete_account_sp @idcuenta,@nombre

	 exec sysmail_delete_profile_sp @idprofile,@nombre

    commit tran
	end try
	begin catch
	  rollback tran borrar
	  
	end catch
   
end