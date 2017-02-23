using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
namespace Administrador.Clases
{
    class Usuario
    {
        public string nombre { get; set; }
        public string password { get; set; }
        
        public Boolean ingresar(){
            string querycompara = "select password from cat_usuarios where Nombre='" + nombre + "'";
            SqlConnection conectar = Conexion.ObtenerConexion();
            SqlCommand comando = new SqlCommand(String.Format(querycompara), conectar);
            object compara = comando.ExecuteScalar();
            if (password == Convert.ToString(compara)) 
            { 
                return true;
            }
                else
            {
                    return false;
            }
           
        }

    }
}
