SELECT cs.UnidadKey,cs.codigo,u.Unidaddsc,cs.COD_MARCA_MAPFRE,cs.COD_MODELO_MAPFRE,cs.TipoMapfre FROM CodigoSeguroUnidad cs
inner join Unidad u on u.UnidadKey=cs.UnidadKey
where cs.AseguradoraKey = 9 
and cs.Finish is null
--and cs.COD_MARCA_MAPFRE is null --para ver los que no tienen valores
order by cs.init desc 