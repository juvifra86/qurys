set dateformat ymd;
select ntas.Nota_id,ntas.titulo,cm.logo as LogoMedio,substring(ntas.nota,1,20),ntas.balazo1,ntas.balazo2,ntas.balazo3,ntas.balazo4 from Notas as ntas
inner join NV_NotasTemas as nvtas on ntas.Nota_id=nvtas.Nota_id
inner join Cat_Medios as cm on ntas.Medio_id=cm.Medio_id
where nvtas.Tema_id=1751 and ntas.FechaPublicacion='2013/09/23' 