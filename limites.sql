SELECT * FROM
(
SELECT row_number() OVER (ORDER BY Nota_id) AS rownum, Nota_id, titulo FROM   Notas
) AS A
WHERE A.rownum 
BETWEEN (20) AND (40)