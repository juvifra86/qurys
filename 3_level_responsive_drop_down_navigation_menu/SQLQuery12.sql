set dateformat ymd
select distinct cu.NombreCompleto,
(select COUNT (*) from notas as ntas where ntas.Usuario_Id=cu.Usuario_Id and ntas.FechaCaptura between '2014/09/08 00:00:00' and '2014/09/08 23:59:59')as NotasCapturadas 
from Cat_Usuarios as cu 
inner join Notas as nt on cu.Usuario_Id=nt.Usuario_Id
where  nt.FechaCaptura between '2014/09/08 00:00:00' and '2014/09/08 23:59:59' and cu.Display=1



Select [Cliente_ID], [Display], [Email_Alarma] 
        From NV_ClientesAlarmas 
         Where Display > 0 And Cliente_ID =  " & pCliente_id & "  "
         Order By Cliente_ID