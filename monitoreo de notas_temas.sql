Declare @NotaINI as bigint
Declare @NotaFIN as bigint

 Set @NotaINI = 201405300000000000
 Set @NotaFIN = 201405309999999999                                                                                   

  SELECT  COUNT(*) as 'En espera'
    --[Nota_id], [Display], [Status]
  FROM   [MSCENTRALDB].[dbo].[Notas]                    
  Where   Nota_id >=  @NotaINI 
    and   Nota_id <=  @NotaFIN
    and   status = 0    
    --and   SUBSTRING(convert(varchar, Nota_id), 17, 2) = 12
    --Order By [Nota_id]
   
  SELECT  --COUNT(*) as 'En Proceso'
       [Nota_id], [Display], [Status]
  FROM [MSCENTRALDB].[dbo].[Notas]
  Where     Nota_id >=  @NotaINI
      and   Nota_id <=  @NotaFIN
    --and    SUBSTRING(convert(varchar, Nota_id), 17, 2) = 12
    and  status  > 1  
    --Order By [Status] desc
   
  SELECT  COUNT(*) as 'Of D.F. Procesadas'
       -- [Nota_id], [Display], [Status]
  FROM [MSCENTRALDB].[dbo].[Notas]
  Where  Nota_id >=  @NotaINI
    and  Nota_id <=  @NotaFIN  
    and  SUBSTRING(convert(varchar, Nota_id), 17, 2) <> 12
    and  status  =   1  
      
  SELECT  COUNT(*) as 'Of Puebla Procesadas'
       -- [Nota_id], [Display], [Status]
   FROM [MSCENTRALDB].[dbo].[Notas]
  Where  Nota_id >=  @NotaINI 
    and  Nota_id <=  @NotaFIN
    and    SUBSTRING(convert(varchar, Nota_id), 17, 2) = 12
    and  status  =   1  
