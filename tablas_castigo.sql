--Creadas por JVFM 2015/05/14


--Tabla de backup antes de castigar
create table rtpcastigo(
CuentaCtekey bigint,
NombreCte varchar(50),
Prod varchar(25),
NoPago bigint,
FechaPago date,
DiasMora int,
IntereseMora money,	
IvaintMora money,
IntOrd money,
IvaIntOrd money,
SubTotalint money,
SegAuto money,
SegVida money,
SegDesempleo money,
SubTotSeg money,
Capital money,
Total money,
primary key(CuentaCtekey)
)


--Tabla historico de castigos
create table CuentasCastigadas(
CuentaCteId bigint,
FechaCastigo date,
Usuario nvarchar(50),
claveobsv nvarchar(50),
primary key (cuentacteid)
)

--modificacion de tipo de despacho para reporte de cartera
insert into TipoDespacho values(3,'CASTIGO','20150525 14:25:52.863',null,0)


--reporte cartera vencida castigada
insert into ReporteSofia values(227,143,'rptCarteraVencidaCastigo.rpt','Reporte de Cuentas Castigadas','SPSOFIA_rptCarteraVencida',null,'\\svrplanfiaii\Reportes_SOFIA\CarteraVencida','20150526',null,0)



