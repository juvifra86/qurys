using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Administrador.Clases;
using Administrador.Formularios;
namespace Administrador
{
    public partial class Inicio : Form
    {
        public Inicio()
        {
            InitializeComponent();
        }

        private void btn_aceptar_Click(object sender, EventArgs e)
        {
            Usuario usu = new Usuario();
            usu.nombre=txt_nombre.Text;
            usu.password = txt_pass.Text;
           if (usu.ingresar()==true){
               new Catalogos().Show();
               this.Hide();
             }else
           {
                MessageBox.Show("Error de usuario y/o contraseña");   
     
           }
            
        }

        

    }
}
