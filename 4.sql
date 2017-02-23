
alter table ResultadosBuroCredito add CargaSiop int

update ResultadosBuroCredito set CargaSiop=0


select * from ResultadosBuroCredito where CargaSiop=1