using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
namespace Administrador
{
    class Conexion
    {
        public static SqlConnection ObtenerConexion()
        {
            SqlConnection Conexion = new SqlConnection("Data Source=SRVMSDBVIR; Initial Catalog=MSCENTRALDB; User=msdes;Password=msdes;");
            Conexion.Open();
            return Conexion;

        }
    }
}
