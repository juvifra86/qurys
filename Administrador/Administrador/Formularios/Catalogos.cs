using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Administrador.Clases;
using System.Data.SqlClient;

namespace Administrador.Formularios
{
    public partial class Catalogos : Form
    {
        public Catalogos()
        {
            InitializeComponent();
        }

        private void Catalogos_Load(object sender, EventArgs e)
        {
            /* Forma 1
            SqlConnection conectar=Conexion.ObtenerConexion();
         
            DataTable dtDatos = new DataTable();
            string querycarga = "select isnull(cm.Medio_id,'Valor incorrecto')as Id,isnull(cm.Nombre,'Valor incorrecto')as Nombre,isnull(ctm.Nombre,'Valor incorrecto') as Tipo,"
               + " isnull(cm.nomcorto,'Valor incorrecto')as Nom_Corto,isnull(cp.Nombre,'Valor incorrecto')as Pais,isnull(ce.Nombre,'Valor incorrecto') as Estado,"
               + " isnull(cc.Nombre,'Valor incorrecto') as Ciudad from Cat_Medios as cm"
               + " inner join Cat_TipoMedios as ctm on cm.TipoMedio_id=ctm.TipoMedio_id"
               + " inner join Cat_Paises as cp on cm.Pais_Id=cp.Pais_id"
               + " inner join Cat_Estados as ce on cm.estado_id=ce.estado_id"
               + " inner join Cat_Ciudades as cc on cm.Ciudad_id=cc.Ciudad_id"
               + " where cm.Display=1 ";
           SqlDataAdapter mdaDatos = new SqlDataAdapter(querycarga,conectar);
           mdaDatos.Fill(dtDatos);
           dtg_medios.DataSource = dtDatos;
           
            */
            SqlConnection conectar = Conexion.ObtenerConexion();
            SqlCommand comando = new SqlCommand();
            SqlDataReader dr;
            comando.Connection = conectar;
            string querycarga = "select isnull(cm.Medio_id,'Valor incorrecto')as Id,isnull(cm.Nombre,'Valor incorrecto')as Nombre,isnull(ctm.Nombre,'Valor incorrecto') as Tipo,"
               + " isnull(cm.nomcorto,'Valor incorrecto')as Nom_Corto,isnull(cp.Nombre,'Valor incorrecto')as Pais,isnull(ce.Nombre,'Valor incorrecto') as Estado,"
               + " isnull(cc.Nombre,'Valor incorrecto') as Ciudad from Cat_Medios as cm"
               + " inner join Cat_TipoMedios as ctm on cm.TipoMedio_id=ctm.TipoMedio_id"
               + " inner join Cat_Paises as cp on cm.Pais_Id=cp.Pais_id"
               + " inner join Cat_Estados as ce on cm.estado_id=ce.estado_id"
               + " inner join Cat_Ciudades as cc on cm.Ciudad_id=cc.Ciudad_id"
               + " where cm.Display=1 ";
            comando.CommandText = querycarga;
            comando.CommandType = CommandType.Text;
            dtg_medios.Rows.Clear();
            dr = comando.ExecuteReader();
            while (dr.Read())
            {
                int renglon = dtg_medios.Rows.Add();
                dtg_medios.Rows[renglon].Cells["id"].Value = dr.GetInt32(dr.GetOrdinal("Id")).ToString();
                dtg_medios.Rows[renglon].Cells["nombre"].Value = dr.GetString(dr.GetOrdinal("Nombre"));
                dtg_medios.Rows[renglon].Cells["nomcorto"].Value = dr.GetString(dr.GetOrdinal("Nom_Corto"));
                dtg_medios.Rows[renglon].Cells["pais"].Value = dr.GetString(dr.GetOrdinal("Pais"));
                dtg_medios.Rows[renglon].Cells["estado"].Value = dr.GetString(dr.GetOrdinal("Estado"));
                dtg_medios.Rows[renglon].Cells["ciudad"].Value = dr.GetString(dr.GetOrdinal("Ciudad"));
                dtg_medios.Rows[renglon].Cells["borrar"].Value = "X";
            }
            dtg_medios.Columns["nombre"].Width = 140;
            dtg_medios.Columns["borrar"].Width = 25;
            dtg_medios.Columns["id"].Visible = false;
            dtg_medios.Columns["nomcorto"].Visible = false;
            dtg_medios.Columns["pais"].Visible = false;
            dtg_medios.Columns["estado"].Visible = false;
            dtg_medios.Columns["ciudad"].Visible = false;
            
          
            /*Forma 3
             
             SqlConnection conectar = Conexion.ObtenerConexion();
            Medio cargagrid = new Medio();
            cargagrid.cargamedios();
                /* while (cargagrid.cargamedios().Read())
            {
                int fila=dtg_medios.Rows.Add();
                if (cargagrid.cargamedios().HasRows)
                {
                    MessageBox.Show("hola");
                    //dtg_medios.Rows("0").Cells("id").value = cargagrid.cargamedios().GetInt32(cargagrid.cargamedios().GetOrdinal("Id")).ToString();
                }

            }*/
             
            
        }
       
           /*
            lbl_nombre.Text=dtg_medios.CurrentRow.Cells["nombre"].Value.ToString();
            lbl_nomcorto.Text = dtg_medios.CurrentRow.Cells["nomcorto"].Value.ToString();
            lbl_estado.Text = dtg_medios.CurrentRow.Cells["estado"].Value.ToString();
            lbl_pais.Text = dtg_medios.CurrentRow.Cells["pais"].Value.ToString();
            lbl_ciudad.Text = dtg_medios.CurrentRow.Cells["ciudad"].Value.ToString();
            */
        
        private void button1_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

       

        
    }
}
