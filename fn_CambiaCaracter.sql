      
/*  
CREADO:JVFM 14/10/2016
DESCRIPCION:Funcion que reemplaza caracteres no validos para Bur� de Cr�dito
PARAMETROS:
	@sResultado
SINTAXIS:  select dbo.fn_CambiaCaracterBuro('Cadena con carac/teres a cambiar')  
*/      
ALTER FUNCTION [dbo].[fn_CambiaCaracterBuro] ( @sResultado VARCHAR(4000) )        



RETURNS VARCHAR (4000)        



AS        



BEGIN          



DECLARE @sCadena VARCHAR(1000)        



SET @sCadena = UPPER(@sResultado)        



 SET @sCadena =REPLACE(@sCadena,'MA.','MARIA')        



 SET @sCadena =REPLACE(@sCadena,'.','')        



 SET @sCadena =REPLACE(@sCadena,',','')        



 SET @sCadena =REPLACE(@sCadena,';','')        



 SET @sCadena =REPLACE(@sCadena,'-','')        



 SET @sCadena =REPLACE(@sCadena,'"','')        



 SET @sCadena =REPLACE(@sCadena,'|','')        



 SET @sCadena =REPLACE(@sCadena,'~','')        



 SET @sCadena =REPLACE(@sCadena,'�','#')        



 SET @sCadena =REPLACE(@sCadena,'�','A')        



 SET @sCadena =REPLACE(@sCadena,'�','E')        



 SET @sCadena =REPLACE(@sCadena,'�','I')        



 SET @sCadena =REPLACE(@sCadena,'�','O')        



 SET @sCadena =REPLACE(@sCadena,'�','U') 
 
 SET @sCadena =REPLACE(@sCadena,'�','N')         

 SET @sCadena =REPLACE(@sCadena,'�','U')  
 
 SET @sCadena =REPLACE(@sCadena,'�','O')
 
 SET @sCadena =REPLACE(@sCadena,'@','N') 

 SET @sCadena =REPLACE(@sCadena,'$','N') 

 SET @sCadena =REPLACE(@sCadena,'{','N') 
 
 SET @sCadena =REPLACE(@sCadena,'>','#') 

 SET @sCadena =REPLACE(@sCadena,'<',' ') 

 SET @sCadena =REPLACE(@sCadena,'/','') 

 SET @sCadena =REPLACE(@sCadena,'#A','NA') 
 SET @sCadena =REPLACE(@sCadena,'#B','NB') 
 SET @sCadena =REPLACE(@sCadena,'#C','NC') 
 SET @sCadena =REPLACE(@sCadena,'#D','ND') 
 SET @sCadena =REPLACE(@sCadena,'#E','NE') 
 SET @sCadena =REPLACE(@sCadena,'#F','NF') 
 SET @sCadena =REPLACE(@sCadena,'#G','NG') 
 SET @sCadena =REPLACE(@sCadena,'#H','NH') 
 SET @sCadena =REPLACE(@sCadena,'#I','NI') 
 SET @sCadena =REPLACE(@sCadena,'#J','NJ') 
 SET @sCadena =REPLACE(@sCadena,'#K','NK') 
 SET @sCadena =REPLACE(@sCadena,'#L','NL') 
 SET @sCadena =REPLACE(@sCadena,'#M','NM') 
 SET @sCadena =REPLACE(@sCadena,'#N','NN') 
 SET @sCadena =REPLACE(@sCadena,'#O','NO') 
 SET @sCadena =REPLACE(@sCadena,'#P','NP') 
 SET @sCadena =REPLACE(@sCadena,'#Q','NQ') 
 SET @sCadena =REPLACE(@sCadena,'#R','NR') 
 SET @sCadena =REPLACE(@sCadena,'#S','NS') 
 SET @sCadena =REPLACE(@sCadena,'#T','NT') 
 SET @sCadena =REPLACE(@sCadena,'#U','NU') 
 SET @sCadena =REPLACE(@sCadena,'#V','NV') 
 SET @sCadena =REPLACE(@sCadena,'#W','NW') 
 SET @sCadena =REPLACE(@sCadena,'#X','NX') 
 SET @sCadena =REPLACE(@sCadena,'#Y','NY') 
 SET @sCadena =REPLACE(@sCadena,'#Z','NZ') 



         



RETURN @sCadena        



END 