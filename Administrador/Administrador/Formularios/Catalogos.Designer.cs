namespace Administrador.Formularios
{
    partial class Catalogos
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Catalogos));
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.medios = new System.Windows.Forms.TabPage();
            this.lbl_ciudad = new System.Windows.Forms.Label();
            this.lbl_estado = new System.Windows.Forms.Label();
            this.lbl_pais = new System.Windows.Forms.Label();
            this.lbl_nomcorto = new System.Windows.Forms.Label();
            this.lbl_nombre = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.btn_filtros = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.dtg_medios = new System.Windows.Forms.DataGridView();
            this.label1 = new System.Windows.Forms.Label();
            this.btn_mod_medio = new System.Windows.Forms.Button();
            this.paises = new System.Windows.Forms.TabPage();
            this.ciudades = new System.Windows.Forms.TabPage();
            this.marcas = new System.Windows.Forms.TabPage();
            this.clientes = new System.Windows.Forms.TabPage();
            this.usuarios = new System.Windows.Forms.TabPage();
            this.id = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nombre = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nomcorto = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.pais = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.estado = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ciudad = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Borrar = new System.Windows.Forms.DataGridViewButtonColumn();
            this.tabControl1.SuspendLayout();
            this.medios.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dtg_medios)).BeginInit();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.medios);
            this.tabControl1.Controls.Add(this.paises);
            this.tabControl1.Controls.Add(this.ciudades);
            this.tabControl1.Controls.Add(this.marcas);
            this.tabControl1.Controls.Add(this.clientes);
            this.tabControl1.Controls.Add(this.usuarios);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Font = new System.Drawing.Font("Comic Sans MS", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(557, 449);
            this.tabControl1.TabIndex = 0;
            // 
            // medios
            // 
            this.medios.Controls.Add(this.lbl_ciudad);
            this.medios.Controls.Add(this.lbl_estado);
            this.medios.Controls.Add(this.lbl_pais);
            this.medios.Controls.Add(this.lbl_nomcorto);
            this.medios.Controls.Add(this.lbl_nombre);
            this.medios.Controls.Add(this.button1);
            this.medios.Controls.Add(this.label6);
            this.medios.Controls.Add(this.label5);
            this.medios.Controls.Add(this.btn_filtros);
            this.medios.Controls.Add(this.label4);
            this.medios.Controls.Add(this.label3);
            this.medios.Controls.Add(this.label2);
            this.medios.Controls.Add(this.dtg_medios);
            this.medios.Controls.Add(this.label1);
            this.medios.Controls.Add(this.btn_mod_medio);
            this.medios.Location = new System.Drawing.Point(4, 28);
            this.medios.Name = "medios";
            this.medios.Padding = new System.Windows.Forms.Padding(3);
            this.medios.Size = new System.Drawing.Size(549, 417);
            this.medios.TabIndex = 0;
            this.medios.Text = "Medios";
            this.medios.UseVisualStyleBackColor = true;
            // 
            // lbl_ciudad
            // 
            this.lbl_ciudad.AutoSize = true;
            this.lbl_ciudad.Location = new System.Drawing.Point(247, 348);
            this.lbl_ciudad.Name = "lbl_ciudad";
            this.lbl_ciudad.Size = new System.Drawing.Size(0, 19);
            this.lbl_ciudad.TabIndex = 15;
            // 
            // lbl_estado
            // 
            this.lbl_estado.AutoSize = true;
            this.lbl_estado.Location = new System.Drawing.Point(247, 278);
            this.lbl_estado.Name = "lbl_estado";
            this.lbl_estado.Size = new System.Drawing.Size(0, 19);
            this.lbl_estado.TabIndex = 14;
            // 
            // lbl_pais
            // 
            this.lbl_pais.AutoSize = true;
            this.lbl_pais.Location = new System.Drawing.Point(247, 211);
            this.lbl_pais.Name = "lbl_pais";
            this.lbl_pais.Size = new System.Drawing.Size(0, 19);
            this.lbl_pais.TabIndex = 13;
            // 
            // lbl_nomcorto
            // 
            this.lbl_nomcorto.AutoSize = true;
            this.lbl_nomcorto.Location = new System.Drawing.Point(247, 144);
            this.lbl_nomcorto.Name = "lbl_nomcorto";
            this.lbl_nomcorto.Size = new System.Drawing.Size(0, 19);
            this.lbl_nomcorto.TabIndex = 12;
            // 
            // lbl_nombre
            // 
            this.lbl_nombre.AutoSize = true;
            this.lbl_nombre.Location = new System.Drawing.Point(247, 82);
            this.lbl_nombre.Name = "lbl_nombre";
            this.lbl_nombre.Size = new System.Drawing.Size(0, 19);
            this.lbl_nombre.TabIndex = 11;
            // 
            // button1
            // 
            this.button1.Image = ((System.Drawing.Image)(resources.GetObject("button1.Image")));
            this.button1.Location = new System.Drawing.Point(502, 376);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(44, 39);
            this.button1.TabIndex = 10;
            this.button1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(194, 315);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(51, 19);
            this.label6.TabIndex = 9;
            this.label6.Text = "Ciudad";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(8, 11);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(44, 19);
            this.label5.TabIndex = 8;
            this.label5.Text = "Filtro";
            // 
            // btn_filtros
            // 
            this.btn_filtros.Image = ((System.Drawing.Image)(resources.GetObject("btn_filtros.Image")));
            this.btn_filtros.Location = new System.Drawing.Point(80, 6);
            this.btn_filtros.Name = "btn_filtros";
            this.btn_filtros.Size = new System.Drawing.Size(47, 28);
            this.btn_filtros.TabIndex = 7;
            this.btn_filtros.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btn_filtros.UseVisualStyleBackColor = true;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(194, 245);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(51, 19);
            this.label4.TabIndex = 6;
            this.label4.Text = "Estado";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(194, 111);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(92, 19);
            this.label3.TabIndex = 5;
            this.label3.Text = "NombreCorto";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(194, 177);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(33, 19);
            this.label2.TabIndex = 4;
            this.label2.Text = "Pais";
            // 
            // dtg_medios
            // 
            this.dtg_medios.AllowUserToAddRows = false;
            this.dtg_medios.AllowUserToDeleteRows = false;
            this.dtg_medios.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dtg_medios.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.id,
            this.nombre,
            this.nomcorto,
            this.pais,
            this.estado,
            this.ciudad,
            this.Borrar});
            this.dtg_medios.Location = new System.Drawing.Point(0, 37);
            this.dtg_medios.Name = "dtg_medios";
            this.dtg_medios.ReadOnly = true;
            this.dtg_medios.RowHeadersVisible = false;
            this.dtg_medios.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dtg_medios.Size = new System.Drawing.Size(188, 374);
            this.dtg_medios.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(194, 53);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(58, 19);
            this.label1.TabIndex = 2;
            this.label1.Text = "Nombre";
            // 
            // btn_mod_medio
            // 
            this.btn_mod_medio.Location = new System.Drawing.Point(321, 380);
            this.btn_mod_medio.Name = "btn_mod_medio";
            this.btn_mod_medio.Size = new System.Drawing.Size(82, 31);
            this.btn_mod_medio.TabIndex = 1;
            this.btn_mod_medio.Text = "Modificar";
            this.btn_mod_medio.UseVisualStyleBackColor = true;
            // 
            // paises
            // 
            this.paises.Location = new System.Drawing.Point(4, 28);
            this.paises.Name = "paises";
            this.paises.Padding = new System.Windows.Forms.Padding(3);
            this.paises.Size = new System.Drawing.Size(549, 417);
            this.paises.TabIndex = 1;
            this.paises.Text = "Paises";
            this.paises.UseVisualStyleBackColor = true;
            // 
            // ciudades
            // 
            this.ciudades.Location = new System.Drawing.Point(4, 28);
            this.ciudades.Name = "ciudades";
            this.ciudades.Size = new System.Drawing.Size(549, 417);
            this.ciudades.TabIndex = 2;
            this.ciudades.Text = "Ciudades";
            this.ciudades.UseVisualStyleBackColor = true;
            // 
            // marcas
            // 
            this.marcas.Location = new System.Drawing.Point(4, 28);
            this.marcas.Name = "marcas";
            this.marcas.Size = new System.Drawing.Size(549, 417);
            this.marcas.TabIndex = 3;
            this.marcas.Text = "Marcas";
            this.marcas.UseVisualStyleBackColor = true;
            // 
            // clientes
            // 
            this.clientes.Location = new System.Drawing.Point(4, 28);
            this.clientes.Name = "clientes";
            this.clientes.Size = new System.Drawing.Size(549, 417);
            this.clientes.TabIndex = 4;
            this.clientes.Text = "Clientes";
            this.clientes.UseVisualStyleBackColor = true;
            // 
            // usuarios
            // 
            this.usuarios.Location = new System.Drawing.Point(4, 28);
            this.usuarios.Name = "usuarios";
            this.usuarios.Size = new System.Drawing.Size(549, 417);
            this.usuarios.TabIndex = 5;
            this.usuarios.Text = "Usuarios";
            this.usuarios.UseVisualStyleBackColor = true;
            // 
            // id
            // 
            this.id.HeaderText = "id";
            this.id.Name = "id";
            this.id.ReadOnly = true;
            // 
            // nombre
            // 
            this.nombre.HeaderText = "Nombre";
            this.nombre.Name = "nombre";
            this.nombre.ReadOnly = true;
            // 
            // nomcorto
            // 
            this.nomcorto.HeaderText = "nomcorto";
            this.nomcorto.Name = "nomcorto";
            this.nomcorto.ReadOnly = true;
            // 
            // pais
            // 
            this.pais.HeaderText = "pais";
            this.pais.Name = "pais";
            this.pais.ReadOnly = true;
            // 
            // estado
            // 
            this.estado.HeaderText = "estado";
            this.estado.Name = "estado";
            this.estado.ReadOnly = true;
            // 
            // ciudad
            // 
            this.ciudad.HeaderText = "ciudad";
            this.ciudad.Name = "ciudad";
            this.ciudad.ReadOnly = true;
            // 
            // Borrar
            // 
            this.Borrar.HeaderText = "";
            this.Borrar.Name = "Borrar";
            this.Borrar.ReadOnly = true;
            // 
            // Catalogos
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(557, 449);
            this.ControlBox = false;
            this.Controls.Add(this.tabControl1);
            this.Name = "Catalogos";
            this.Text = "Catalogos";
            this.Load += new System.EventHandler(this.Catalogos_Load);
            this.tabControl1.ResumeLayout(false);
            this.medios.ResumeLayout(false);
            this.medios.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dtg_medios)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage paises;
        private System.Windows.Forms.TabPage ciudades;
        private System.Windows.Forms.TabPage marcas;
        private System.Windows.Forms.TabPage clientes;
        private System.Windows.Forms.TabPage usuarios;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btn_mod_medio;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button btn_filtros;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button button1;
        public System.Windows.Forms.Label lbl_nombre;
        public System.Windows.Forms.Label lbl_nomcorto;
        public System.Windows.Forms.TabPage medios;
        public System.Windows.Forms.Label lbl_ciudad;
        public System.Windows.Forms.Label lbl_estado;
        public System.Windows.Forms.Label lbl_pais;
        public System.Windows.Forms.DataGridView dtg_medios;
        private System.Windows.Forms.DataGridViewTextBoxColumn id;
        private System.Windows.Forms.DataGridViewTextBoxColumn nombre;
        private System.Windows.Forms.DataGridViewTextBoxColumn nomcorto;
        private System.Windows.Forms.DataGridViewTextBoxColumn pais;
        private System.Windows.Forms.DataGridViewTextBoxColumn estado;
        private System.Windows.Forms.DataGridViewTextBoxColumn ciudad;
        private System.Windows.Forms.DataGridViewButtonColumn Borrar;

    }
}