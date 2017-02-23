select * from NV_Temas where Nombre like'%VISITA%'


set dateformat ymd
select  * from Notas as ntas
inner join NV_NotasTemas as ntmas on ntmas.nota_id=ntas.Nota_id
inner join NV_Temas as tem on tem.Tema_id=ntmas.Tema_id
where tem.tema_id in(11791,11793,12866,6824,11798,12867,12868)
and ntas.FechaPublicacion between '2014/01/01' and '2014/01/07'
order by tem.Tema_id