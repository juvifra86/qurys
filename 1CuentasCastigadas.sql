create table CuentasCastigadas
(CuentaCteId Int,
Capital Float,
Interes float,
Iva float,
IMCV FLOAT,
iimcv FLOAT,
nsa float,
nsau float,
imsa float,
iimsa float,
imnsau float,
iimnsau float,
SD float,
imsd float,
iimsd float,
sv float,
imsv float,
iimsv float,
anualidad float,
svef float,
sdef float,
SaldoOriginal Float,
FechaCastigo date,
Init date,
Finish Date,
Usuario nvarchar(50),
claveobsv nvarchar(50),
primary key (cuentacteid)
)
CREATE TABLE respaldopreviocancelacion
(respaldoKey int, tablaorigen nvarchar, CuentaCteId int, ConceptoContableId int, ImporteEmitido float, primary key (respaldokey))

declare @f1 date
set @f1 = (select GETDATE())


select * from CuentaCte 
where CuentaCtekey = 653
exec SPSOFIA_CuentasCastigadas 242, 'sistemas', 'prueba',@f1
select * from CuentasCastigadas
where CuentaCteId = 242
select * from respaldopreviocancelacion
where CuentaCteId = 242

select * from NotaCargo where CuentaCteId=242

select distinct FechaLiquida from Amortizacion where CuentaCteId=242


select  distinct saldoEmision from Amortizacion where CuentaCteId=242 and year(FechaLiquida)=2015
