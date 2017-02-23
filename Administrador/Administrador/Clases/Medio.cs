using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using Administrador.Clases;
using Administrador.Formularios;
using System.Data.Sql;
namespace Administrador.Clases
{
    class Medio
    {
        private int medio_id { get; set; }
        public void cargamedios(){
           
                SqlConnection conectar = Conexion.ObtenerConexion();
                SqlDataReader medios_rd;
                string querycarga = "select isnull(cm.Medio_id,'Valor incorrecto')as Id,isnull(cm.Nombre,'Valor incorrecto')as Nombre,isnull(ctm.Nombre,'Valor incorrecto') as Tipo,"
               + " isnull(cm.nomcorto,'Valor incorrecto')as Nom_Corto,isnull(cp.Nombre,'Valor incorrecto')as Pais,isnull(ce.Nombre,'Valor incorrecto') as Estado,"
               + " isnull(cc.Nombre,'Valor incorrecto') as Ciudad from Cat_Medios as cm"
               + " inner join Cat_TipoMedios as ctm on cm.TipoMedio_id=ctm.TipoMedio_id"
               + " inner join Cat_Paises as cp on cm.Pais_Id=cp.Pais_id"
               + " inner join Cat_Estados as ce on cm.estado_id=ce.estado_id"
               + " inner join Cat_Ciudades as cc on cm.Ciudad_id=cc.Ciudad_id"
               + " where cm.Display=1 ";
                SqlCommand comando = new SqlCommand(String.Format(querycarga), conectar);
                medios_rd = comando.ExecuteReader();
                //if (medios_rd.HasRows)
                //{
                while (medios_rd.Read())
                {

                }
                //}
                //else
                //{
                //  Console.WriteLine("No rows found.");
                //}

               
            
            

        }


        
    }

}
