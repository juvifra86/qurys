


use MSCENTRALDB
Select  Termino from NV_TemasTerminos With (nolock) Where Tema_id = 11496

select * from NV_TemasTerminos where Tema_id=11496
and SUBSTRING(Termino,1,3)='Agu'
order by Termino