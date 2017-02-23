<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class actualizarpro
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(actualizarpro))
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.pblogo = New System.Windows.Forms.PictureBox()
        Me.GroupBox4 = New System.Windows.Forms.GroupBox()
        Me.DataGridView3 = New System.Windows.Forms.DataGridView()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.ag_tema = New System.Windows.Forms.Button()
        Me.btnagtema = New System.Windows.Forms.Button()
        Me.eli_tema = New System.Windows.Forms.Button()
        Me.orden_tema = New System.Windows.Forms.Button()
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.TemaidDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.NombreDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DescripcionDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.FechaDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.orden = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.NVTemasBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.DataSetTemas1 = New Apertura_de_archivos_xml.DataSetTemas1()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.quitar = New System.Windows.Forms.Button()
        Me.gorden = New System.Windows.Forms.Button()
        Me.DataGridView2 = New System.Windows.Forms.DataGridView()
        Me.GroupBox3 = New System.Windows.Forms.GroupBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.RadioButton1 = New System.Windows.Forms.RadioButton()
        Me.radio5 = New System.Windows.Forms.RadioButton()
        Me.radio4 = New System.Windows.Forms.RadioButton()
        Me.radio3 = New System.Windows.Forms.RadioButton()
        Me.radio2 = New System.Windows.Forms.RadioButton()
        Me.radio1 = New System.Windows.Forms.RadioButton()
        Me.buscar = New System.Windows.Forms.Button()
        Me.txttema = New System.Windows.Forms.TextBox()
        Me.id = New System.Windows.Forms.Label()
        Me.ProyectoId = New System.Windows.Forms.TextBox()
        Me.Button6 = New System.Windows.Forms.Button()
        Me.guardar = New System.Windows.Forms.Button()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtnombre = New System.Windows.Forms.TextBox()
        Me.txtobs = New System.Windows.Forms.TextBox()
        Me.NV_TemasTableAdapter = New Apertura_de_archivos_xml.DataSetTemas1TableAdapters.NV_TemasTableAdapter()
        CType(Me.pblogo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox4.SuspendLayout()
        CType(Me.DataGridView3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox2.SuspendLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.NVTemasBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataSetTemas1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox3.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(909, 21)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(100, 20)
        Me.TextBox1.TabIndex = 54
        Me.TextBox1.Visible = False
        '
        'pblogo
        '
        Me.pblogo.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch
        Me.pblogo.Location = New System.Drawing.Point(763, 31)
        Me.pblogo.Name = "pblogo"
        Me.pblogo.Size = New System.Drawing.Size(100, 100)
        Me.pblogo.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.pblogo.TabIndex = 52
        Me.pblogo.TabStop = False
        '
        'GroupBox4
        '
        Me.GroupBox4.Controls.Add(Me.DataGridView3)
        Me.GroupBox4.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox4.Location = New System.Drawing.Point(2, 160)
        Me.GroupBox4.Name = "GroupBox4"
        Me.GroupBox4.Size = New System.Drawing.Size(611, 778)
        Me.GroupBox4.TabIndex = 53
        Me.GroupBox4.TabStop = False
        Me.GroupBox4.Text = "TEMAS QUE SE DESEAN ACTUALIZAR"
        '
        'DataGridView3
        '
        Me.DataGridView3.AllowDrop = True
        Me.DataGridView3.AllowUserToAddRows = False
        Me.DataGridView3.AllowUserToDeleteRows = False
        Me.DataGridView3.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView3.Location = New System.Drawing.Point(5, 20)
        Me.DataGridView3.Name = "DataGridView3"
        Me.DataGridView3.ReadOnly = True
        Me.DataGridView3.RowHeadersVisible = False
        Me.DataGridView3.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.DataGridView3.Size = New System.Drawing.Size(600, 758)
        Me.DataGridView3.TabIndex = 40
        '
        'GroupBox2
        '
        Me.GroupBox2.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.GroupBox2.Controls.Add(Me.ag_tema)
        Me.GroupBox2.Controls.Add(Me.btnagtema)
        Me.GroupBox2.Controls.Add(Me.eli_tema)
        Me.GroupBox2.Controls.Add(Me.orden_tema)
        Me.GroupBox2.Controls.Add(Me.DataGridView1)
        Me.GroupBox2.Controls.Add(Me.Label4)
        Me.GroupBox2.Controls.Add(Me.quitar)
        Me.GroupBox2.Controls.Add(Me.gorden)
        Me.GroupBox2.Controls.Add(Me.DataGridView2)
        Me.GroupBox2.Controls.Add(Me.GroupBox3)
        Me.GroupBox2.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox2.Location = New System.Drawing.Point(5, 160)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(1101, 784)
        Me.GroupBox2.TabIndex = 47
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "*"
        '
        'ag_tema
        '
        Me.ag_tema.Location = New System.Drawing.Point(964, 123)
        Me.ag_tema.Name = "ag_tema"
        Me.ag_tema.Size = New System.Drawing.Size(100, 45)
        Me.ag_tema.TabIndex = 41
        Me.ag_tema.Text = "Agregar Tema"
        Me.ag_tema.UseVisualStyleBackColor = True
        '
        'btnagtema
        '
        Me.btnagtema.Location = New System.Drawing.Point(864, 181)
        Me.btnagtema.Name = "btnagtema"
        Me.btnagtema.Size = New System.Drawing.Size(100, 25)
        Me.btnagtema.TabIndex = 44
        Me.btnagtema.Text = "Agregar Tema"
        Me.btnagtema.UseVisualStyleBackColor = True
        '
        'eli_tema
        '
        Me.eli_tema.Location = New System.Drawing.Point(964, 70)
        Me.eli_tema.Name = "eli_tema"
        Me.eli_tema.Size = New System.Drawing.Size(100, 45)
        Me.eli_tema.TabIndex = 43
        Me.eli_tema.Text = "Eliminar Tema"
        Me.eli_tema.UseVisualStyleBackColor = True
        '
        'orden_tema
        '
        Me.orden_tema.Location = New System.Drawing.Point(964, 19)
        Me.orden_tema.Name = "orden_tema"
        Me.orden_tema.Size = New System.Drawing.Size(100, 45)
        Me.orden_tema.TabIndex = 42
        Me.orden_tema.Text = "Ordenar Tema"
        Me.orden_tema.UseVisualStyleBackColor = True
        '
        'DataGridView1
        '
        Me.DataGridView1.AllowDrop = True
        Me.DataGridView1.AllowUserToAddRows = False
        Me.DataGridView1.AllowUserToDeleteRows = False
        Me.DataGridView1.AutoGenerateColumns = False
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView1.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.TemaidDataGridViewTextBoxColumn, Me.NombreDataGridViewTextBoxColumn, Me.DescripcionDataGridViewTextBoxColumn, Me.FechaDataGridViewTextBoxColumn, Me.orden})
        Me.DataGridView1.DataSource = Me.NVTemasBindingSource
        Me.DataGridView1.Location = New System.Drawing.Point(6, 213)
        Me.DataGridView1.MultiSelect = False
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.ReadOnly = True
        Me.DataGridView1.RowHeadersVisible = False
        Me.DataGridView1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.DataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.DataGridView1.Size = New System.Drawing.Size(481, 536)
        Me.DataGridView1.TabIndex = 42
        Me.DataGridView1.VirtualMode = True
        Me.DataGridView1.Visible = False
        '
        'TemaidDataGridViewTextBoxColumn
        '
        Me.TemaidDataGridViewTextBoxColumn.DataPropertyName = "Tema_id"
        Me.TemaidDataGridViewTextBoxColumn.HeaderText = "TEMA_ID"
        Me.TemaidDataGridViewTextBoxColumn.Name = "TemaidDataGridViewTextBoxColumn"
        Me.TemaidDataGridViewTextBoxColumn.ReadOnly = True
        '
        'NombreDataGridViewTextBoxColumn
        '
        Me.NombreDataGridViewTextBoxColumn.DataPropertyName = "Nombre"
        Me.NombreDataGridViewTextBoxColumn.HeaderText = "NOMBRE"
        Me.NombreDataGridViewTextBoxColumn.Name = "NombreDataGridViewTextBoxColumn"
        Me.NombreDataGridViewTextBoxColumn.ReadOnly = True
        Me.NombreDataGridViewTextBoxColumn.Width = 150
        '
        'DescripcionDataGridViewTextBoxColumn
        '
        Me.DescripcionDataGridViewTextBoxColumn.DataPropertyName = "Descripcion"
        Me.DescripcionDataGridViewTextBoxColumn.HeaderText = "DESCRIPCION"
        Me.DescripcionDataGridViewTextBoxColumn.Name = "DescripcionDataGridViewTextBoxColumn"
        Me.DescripcionDataGridViewTextBoxColumn.ReadOnly = True
        '
        'FechaDataGridViewTextBoxColumn
        '
        Me.FechaDataGridViewTextBoxColumn.DataPropertyName = "Fecha"
        Me.FechaDataGridViewTextBoxColumn.HeaderText = "FECHA"
        Me.FechaDataGridViewTextBoxColumn.Name = "FechaDataGridViewTextBoxColumn"
        Me.FechaDataGridViewTextBoxColumn.ReadOnly = True
        Me.FechaDataGridViewTextBoxColumn.Width = 150
        '
        'orden
        '
        Me.orden.HeaderText = "orden"
        Me.orden.Name = "orden"
        Me.orden.ReadOnly = True
        '
        'NVTemasBindingSource
        '
        Me.NVTemasBindingSource.DataMember = "NV_Temas"
        Me.NVTemasBindingSource.DataSource = Me.DataSetTemas1
        '
        'DataSetTemas1
        '
        Me.DataSetTemas1.DataSetName = "DataSetTemas1"
        Me.DataSetTemas1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(1045, 196)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(40, 16)
        Me.Label4.TabIndex = 35
        Me.Label4.Text = "orden"
        '
        'quitar
        '
        Me.quitar.Location = New System.Drawing.Point(758, 183)
        Me.quitar.Name = "quitar"
        Me.quitar.Size = New System.Drawing.Size(100, 25)
        Me.quitar.TabIndex = 34
        Me.quitar.Text = "Quitar Temas"
        Me.quitar.UseVisualStyleBackColor = True
        '
        'gorden
        '
        Me.gorden.Location = New System.Drawing.Point(634, 183)
        Me.gorden.Name = "gorden"
        Me.gorden.Size = New System.Drawing.Size(112, 25)
        Me.gorden.TabIndex = 33
        Me.gorden.Text = "Guardar Orden"
        Me.gorden.UseVisualStyleBackColor = True
        '
        'DataGridView2
        '
        Me.DataGridView2.AllowDrop = True
        Me.DataGridView2.AllowUserToAddRows = False
        Me.DataGridView2.AllowUserToDeleteRows = False
        Me.DataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView2.Location = New System.Drawing.Point(634, 212)
        Me.DataGridView2.MultiSelect = False
        Me.DataGridView2.Name = "DataGridView2"
        Me.DataGridView2.ReadOnly = True
        Me.DataGridView2.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.DataGridView2.Size = New System.Drawing.Size(447, 566)
        Me.DataGridView2.TabIndex = 13
        '
        'GroupBox3
        '
        Me.GroupBox3.Controls.Add(Me.Label6)
        Me.GroupBox3.Controls.Add(Me.RadioButton1)
        Me.GroupBox3.Controls.Add(Me.radio5)
        Me.GroupBox3.Controls.Add(Me.radio4)
        Me.GroupBox3.Controls.Add(Me.radio3)
        Me.GroupBox3.Controls.Add(Me.radio2)
        Me.GroupBox3.Controls.Add(Me.radio1)
        Me.GroupBox3.Controls.Add(Me.buscar)
        Me.GroupBox3.Controls.Add(Me.txttema)
        Me.GroupBox3.Location = New System.Drawing.Point(0, 0)
        Me.GroupBox3.Name = "GroupBox3"
        Me.GroupBox3.Size = New System.Drawing.Size(441, 207)
        Me.GroupBox3.TabIndex = 29
        Me.GroupBox3.TabStop = False
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.Location = New System.Drawing.Point(9, 15)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(157, 16)
        Me.Label6.TabIndex = 35
        Me.Label6.Text = "Buscar Nombre ó Tema"
        '
        'RadioButton1
        '
        Me.RadioButton1.AutoSize = True
        Me.RadioButton1.Location = New System.Drawing.Point(303, 166)
        Me.RadioButton1.Name = "RadioButton1"
        Me.RadioButton1.Size = New System.Drawing.Size(58, 20)
        Me.RadioButton1.TabIndex = 34
        Me.RadioButton1.TabStop = True
        Me.RadioButton1.Text = "todos"
        Me.RadioButton1.UseVisualStyleBackColor = True
        '
        'radio5
        '
        Me.radio5.AutoSize = True
        Me.radio5.Location = New System.Drawing.Point(22, 166)
        Me.radio5.Name = "radio5"
        Me.radio5.Size = New System.Drawing.Size(87, 20)
        Me.radio5.TabIndex = 33
        Me.radio5.TabStop = True
        Me.radio5.Text = "Aerolineas"
        Me.radio5.UseVisualStyleBackColor = True
        '
        'radio4
        '
        Me.radio4.AutoSize = True
        Me.radio4.Location = New System.Drawing.Point(22, 143)
        Me.radio4.Name = "radio4"
        Me.radio4.Size = New System.Drawing.Size(128, 20)
        Me.radio4.TabIndex = 32
        Me.radio4.TabStop = True
        Me.radio4.Text = "Todos los Medios"
        Me.radio4.UseVisualStyleBackColor = True
        '
        'radio3
        '
        Me.radio3.AutoSize = True
        Me.radio3.Location = New System.Drawing.Point(22, 120)
        Me.radio3.Name = "radio3"
        Me.radio3.Size = New System.Drawing.Size(325, 20)
        Me.radio3.TabIndex = 31
        Me.radio3.TabStop = True
        Me.radio3.Text = "Partido Acción Nacional - Todos los medios  cliente"
        Me.radio3.UseVisualStyleBackColor = True
        '
        'radio2
        '
        Me.radio2.AutoSize = True
        Me.radio2.Location = New System.Drawing.Point(22, 97)
        Me.radio2.Name = "radio2"
        Me.radio2.Size = New System.Drawing.Size(66, 20)
        Me.radio2.TabIndex = 30
        Me.radio2.TabStop = True
        Me.radio2.Text = "Cliente"
        Me.radio2.UseVisualStyleBackColor = True
        '
        'radio1
        '
        Me.radio1.AutoSize = True
        Me.radio1.Location = New System.Drawing.Point(23, 73)
        Me.radio1.Name = "radio1"
        Me.radio1.Size = New System.Drawing.Size(417, 20)
        Me.radio1.TabIndex = 29
        Me.radio1.TabStop = True
        Me.radio1.Text = "Tema Creado para el cliente Tv Azteca -- Todos los medios-- cliente"
        Me.radio1.UseVisualStyleBackColor = True
        '
        'buscar
        '
        Me.buscar.Location = New System.Drawing.Point(318, 28)
        Me.buscar.Name = "buscar"
        Me.buscar.Size = New System.Drawing.Size(92, 35)
        Me.buscar.TabIndex = 16
        Me.buscar.Text = "BUSCAR"
        Me.buscar.UseVisualStyleBackColor = True
        '
        'txttema
        '
        Me.txttema.Location = New System.Drawing.Point(3, 36)
        Me.txttema.Name = "txttema"
        Me.txttema.Size = New System.Drawing.Size(310, 22)
        Me.txttema.TabIndex = 0
        '
        'id
        '
        Me.id.AutoSize = True
        Me.id.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.id.Location = New System.Drawing.Point(1027, 31)
        Me.id.Name = "id"
        Me.id.Size = New System.Drawing.Size(68, 16)
        Me.id.TabIndex = 51
        Me.id.Text = "proyectoid"
        '
        'ProyectoId
        '
        Me.ProyectoId.Location = New System.Drawing.Point(1030, 5)
        Me.ProyectoId.Name = "ProyectoId"
        Me.ProyectoId.ReadOnly = True
        Me.ProyectoId.Size = New System.Drawing.Size(51, 20)
        Me.ProyectoId.TabIndex = 50
        '
        'Button6
        '
        Me.Button6.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button6.Location = New System.Drawing.Point(966, 110)
        Me.Button6.Name = "Button6"
        Me.Button6.Size = New System.Drawing.Size(100, 45)
        Me.Button6.TabIndex = 49
        Me.Button6.Text = "Regresar"
        Me.Button6.UseVisualStyleBackColor = True
        '
        'guardar
        '
        Me.guardar.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.guardar.Location = New System.Drawing.Point(966, 59)
        Me.guardar.Name = "guardar"
        Me.guardar.Size = New System.Drawing.Size(100, 45)
        Me.guardar.TabIndex = 48
        Me.guardar.Text = "Actualizar Proyecto"
        Me.guardar.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.Label2)
        Me.GroupBox1.Controls.Add(Me.Label1)
        Me.GroupBox1.Controls.Add(Me.txtnombre)
        Me.GroupBox1.Controls.Add(Me.txtobs)
        Me.GroupBox1.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.Location = New System.Drawing.Point(2, -8)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(611, 203)
        Me.GroupBox1.TabIndex = 46
        Me.GroupBox1.TabStop = False
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(9, 81)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(121, 16)
        Me.Label2.TabIndex = 8
        Me.Label2.Text = "OBSERVACIONES"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(9, 33)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(69, 16)
        Me.Label1.TabIndex = 7
        Me.Label1.Text = "NOMBRE:"
        '
        'txtnombre
        '
        Me.txtnombre.Location = New System.Drawing.Point(136, 30)
        Me.txtnombre.Name = "txtnombre"
        Me.txtnombre.Size = New System.Drawing.Size(395, 22)
        Me.txtnombre.TabIndex = 5
        '
        'txtobs
        '
        Me.txtobs.Location = New System.Drawing.Point(136, 81)
        Me.txtobs.Multiline = True
        Me.txtobs.Name = "txtobs"
        Me.txtobs.Size = New System.Drawing.Size(395, 67)
        Me.txtobs.TabIndex = 2
        '
        'NV_TemasTableAdapter
        '
        Me.NV_TemasTableAdapter.ClearBeforeFill = True
        '
        'actualizarpro
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.ClientSize = New System.Drawing.Size(1109, 974)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.pblogo)
        Me.Controls.Add(Me.GroupBox4)
        Me.Controls.Add(Me.GroupBox2)
        Me.Controls.Add(Me.id)
        Me.Controls.Add(Me.ProyectoId)
        Me.Controls.Add(Me.Button6)
        Me.Controls.Add(Me.guardar)
        Me.Controls.Add(Me.GroupBox1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "actualizarpro"
        Me.Text = "actualizarpro"
        CType(Me.pblogo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox4.ResumeLayout(False)
        CType(Me.DataGridView3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.NVTemasBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataSetTemas1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox3.ResumeLayout(False)
        Me.GroupBox3.PerformLayout()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents pblogo As System.Windows.Forms.PictureBox
    Friend WithEvents GroupBox4 As System.Windows.Forms.GroupBox
    Friend WithEvents DataGridView3 As System.Windows.Forms.DataGridView
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents ag_tema As System.Windows.Forms.Button
    Friend WithEvents btnagtema As System.Windows.Forms.Button
    Friend WithEvents eli_tema As System.Windows.Forms.Button
    Friend WithEvents orden_tema As System.Windows.Forms.Button
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents quitar As System.Windows.Forms.Button
    Friend WithEvents gorden As System.Windows.Forms.Button
    Friend WithEvents DataGridView2 As System.Windows.Forms.DataGridView
    Friend WithEvents GroupBox3 As System.Windows.Forms.GroupBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents RadioButton1 As System.Windows.Forms.RadioButton
    Friend WithEvents radio5 As System.Windows.Forms.RadioButton
    Friend WithEvents radio4 As System.Windows.Forms.RadioButton
    Friend WithEvents radio3 As System.Windows.Forms.RadioButton
    Friend WithEvents radio2 As System.Windows.Forms.RadioButton
    Friend WithEvents radio1 As System.Windows.Forms.RadioButton
    Friend WithEvents buscar As System.Windows.Forms.Button
    Friend WithEvents txttema As System.Windows.Forms.TextBox
    Friend WithEvents id As System.Windows.Forms.Label
    Friend WithEvents ProyectoId As System.Windows.Forms.TextBox
    Friend WithEvents Button6 As System.Windows.Forms.Button
    Friend WithEvents guardar As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txtnombre As System.Windows.Forms.TextBox
    Friend WithEvents txtobs As System.Windows.Forms.TextBox
    Friend WithEvents DataSetTemas1 As Apertura_de_archivos_xml.DataSetTemas1
    Friend WithEvents NVTemasBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents NV_TemasTableAdapter As Apertura_de_archivos_xml.DataSetTemas1TableAdapters.NV_TemasTableAdapter
    Friend WithEvents TemaidDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents NombreDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DescripcionDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents FechaDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents orden As System.Windows.Forms.DataGridViewTextBoxColumn
End Class
