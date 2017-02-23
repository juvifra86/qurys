Declare @Nota_id as bigInt
Select @Nota_id = 201207181030114315  
Select * from Notas Where Nota_id=@Nota_id
Select * from NV_NotasClasificacion Where Nota_id=@Nota_id
Select * from Imagenes_Notas Where Nota_id=@Nota_id
Select * from Cat_Imagenes_medios Where Imagen_id in (Select Imagen_id from Imagenes_Notas Where Nota_id=@Nota_id)
Select * from NotasExtras Where Nota_id=@Nota_id
Select * from RecortesTestigosNotas Where Nota_id=@Nota_id
Select * from VM_NotasPublicidad Where Nota_id=@Nota_id
Select * from VM_NotasPlantillas Where Nota_id=@Nota_id
Select * from VM_NotasPublicidadGMS Where Nota_id=@Nota_id
Select * from NV_NotasTemas Where Nota_id = @Nota_id

