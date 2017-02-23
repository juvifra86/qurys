
Declare @Tema_id as int
Set @Tema_id = 13827
Insert NV_TemasTipoAgenciaMedio
Select @Tema_id,3,Medio_Id from Cat_Medios 
Where estado_id=1 
Update NV_Temas Set Medio = 1 
Where Tema_id = @Tema_id 

--Where estado_id=1 and TipoMedio_id=4
--and TipoMedio_id=3

--borra medios
--delete from NV_TemasTipoAgenciaMedio where Tema_id=13827
--and TipoAgenciaMedio_id=3


13826
13827
13828
13829


--Insertar Medios con excepciones
Declare @Tema_id as int
Set @Tema_id = 13827
Insert NV_TemasTipoAgenciaMedio
Select @Tema_id,3,Medio_Id from Cat_Medios 
  Where estado_id=21 and TipoMedio_id in (1,2,4,5)
   and  Medio_Id not in 
   (select Medio_Id from Cat_Medios where  TipoMedio_id in(3) and Medio_Id  in (8601,10854))
Update NV_Temas Set Medio = 1 
       Where Tema_id = @Tema_id 


Declare @Tema_id as int
Set @Tema_id = 13827
Insert NV_TemasTipoAgenciaMedio
Select @Tema_id,3,Medio_Id from Cat_Medios 
  Where TipoMedio_id in (1,2,4,5)
   and  Medio_Id not in 
   (select Medio_Id from Cat_Medios where  TipoMedio_id in(3) and Medio_Id  in (8601,10854))
Update NV_Temas Set Medio = 1 
       Where Tema_id = @Tema_id 
       
select * from Cat_Medios where  TipoMedio_id=1 
--and estado_id=21 
and Medio_Id  in (1475,	7767,	7936)


select * from Cat_Medios where Nombre like '%Tlaxcala%'

select * from Cat_Ciudades
select * from Cat_Estados


select * from NV_MenusSuscriptores where Suscriptor_id=1971

select * from NV_Menus

----estado_id
--Puebla = 21 
--Df = 1 
--Jalisco = 14
--Pasis_id=41



------TipoMedio_id
--1	Periódico              
--2	Revista               
--3	Internet          
--4	Televisión     
--5	Radio                
--6	Blog                 
--7	Encarte        	  
--8	Red Social  
