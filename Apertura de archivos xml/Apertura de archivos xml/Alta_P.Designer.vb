<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Alta_P
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Alta_P))
        Me.ProyectoId = New System.Windows.Forms.TextBox()
        Me.regresar = New System.Windows.Forms.Button()
        Me.guardar = New System.Windows.Forms.Button()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtnombre = New System.Windows.Forms.TextBox()
        Me.txtobs = New System.Windows.Forms.TextBox()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.buscar = New System.Windows.Forms.Button()
        Me.txttema = New System.Windows.Forms.TextBox()
        Me.RadioButton1 = New System.Windows.Forms.RadioButton()
        Me.radio5 = New System.Windows.Forms.RadioButton()
        Me.radio4 = New System.Windows.Forms.RadioButton()
        Me.radio3 = New System.Windows.Forms.RadioButton()
        Me.radio2 = New System.Windows.Forms.RadioButton()
        Me.radio1 = New System.Windows.Forms.RadioButton()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.quitar = New System.Windows.Forms.Button()
        Me.gorden = New System.Windows.Forms.Button()
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.TemaidDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.NombreDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.DescripcionDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.FechaDataGridViewTextBoxColumn = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.orden = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.NVTemasBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.DataSetTemas1 = New Apertura_de_archivos_xml.DataSetTemas1()
        Me.DataGridView2 = New System.Windows.Forms.DataGridView()
        Me.NV_TemasTableAdapter = New Apertura_de_archivos_xml.DataSetTemas1TableAdapters.NV_TemasTableAdapter()
        Me.GroupBox1.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.NVTemasBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataSetTemas1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'ProyectoId
        '
        Me.ProyectoId.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ProyectoId.Location = New System.Drawing.Point(926, 3)
        Me.ProyectoId.Name = "ProyectoId"
        Me.ProyectoId.ReadOnly = True
        Me.ProyectoId.Size = New System.Drawing.Size(51, 22)
        Me.ProyectoId.TabIndex = 30
        '
        'regresar
        '
        Me.regresar.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.regresar.Location = New System.Drawing.Point(880, 105)
        Me.regresar.Name = "regresar"
        Me.regresar.Size = New System.Drawing.Size(97, 46)
        Me.regresar.TabIndex = 29
        Me.regresar.Text = "Regresar"
        Me.regresar.UseVisualStyleBackColor = True
        '
        'guardar
        '
        Me.guardar.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.guardar.Location = New System.Drawing.Point(880, 51)
        Me.guardar.Name = "guardar"
        Me.guardar.Size = New System.Drawing.Size(97, 46)
        Me.guardar.TabIndex = 27
        Me.guardar.Text = "Guardar Proyecto"
        Me.guardar.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.Label2)
        Me.GroupBox1.Controls.Add(Me.Label1)
        Me.GroupBox1.Controls.Add(Me.txtnombre)
        Me.GroupBox1.Controls.Add(Me.txtobs)
        Me.GroupBox1.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.Location = New System.Drawing.Point(4, -8)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(560, 184)
        Me.GroupBox1.TabIndex = 26
        Me.GroupBox1.TabStop = False
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(9, 81)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(121, 16)
        Me.Label2.TabIndex = 8
        Me.Label2.Text = "OBSERVACIONES"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(9, 22)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(69, 16)
        Me.Label1.TabIndex = 7
        Me.Label1.Text = "NOMBRE:"
        '
        'txtnombre
        '
        Me.txtnombre.Location = New System.Drawing.Point(139, 16)
        Me.txtnombre.Name = "txtnombre"
        Me.txtnombre.Size = New System.Drawing.Size(395, 22)
        Me.txtnombre.TabIndex = 5
        '
        'txtobs
        '
        Me.txtobs.Location = New System.Drawing.Point(139, 71)
        Me.txtobs.Multiline = True
        Me.txtobs.Name = "txtobs"
        Me.txtobs.Size = New System.Drawing.Size(395, 67)
        Me.txtobs.TabIndex = 2
        '
        'GroupBox2
        '
        Me.GroupBox2.Controls.Add(Me.buscar)
        Me.GroupBox2.Controls.Add(Me.txttema)
        Me.GroupBox2.Controls.Add(Me.RadioButton1)
        Me.GroupBox2.Controls.Add(Me.radio5)
        Me.GroupBox2.Controls.Add(Me.radio4)
        Me.GroupBox2.Controls.Add(Me.radio3)
        Me.GroupBox2.Controls.Add(Me.radio2)
        Me.GroupBox2.Controls.Add(Me.radio1)
        Me.GroupBox2.Controls.Add(Me.Label4)
        Me.GroupBox2.Controls.Add(Me.quitar)
        Me.GroupBox2.Controls.Add(Me.gorden)
        Me.GroupBox2.Controls.Add(Me.DataGridView1)
        Me.GroupBox2.Controls.Add(Me.DataGridView2)
        Me.GroupBox2.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox2.Location = New System.Drawing.Point(3, 175)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(987, 800)
        Me.GroupBox2.TabIndex = 28
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "BUSCAR NOMBRE Ó TEMA_ID"
        '
        'buscar
        '
        Me.buscar.Location = New System.Drawing.Point(464, 19)
        Me.buscar.Name = "buscar"
        Me.buscar.Size = New System.Drawing.Size(92, 35)
        Me.buscar.TabIndex = 44
        Me.buscar.Text = "BUSCAR"
        Me.buscar.UseVisualStyleBackColor = True
        '
        'txttema
        '
        Me.txttema.Location = New System.Drawing.Point(6, 22)
        Me.txttema.Name = "txttema"
        Me.txttema.Size = New System.Drawing.Size(415, 22)
        Me.txttema.TabIndex = 43
        '
        'RadioButton1
        '
        Me.RadioButton1.AutoSize = True
        Me.RadioButton1.Location = New System.Drawing.Point(28, 167)
        Me.RadioButton1.Name = "RadioButton1"
        Me.RadioButton1.Size = New System.Drawing.Size(58, 20)
        Me.RadioButton1.TabIndex = 42
        Me.RadioButton1.TabStop = True
        Me.RadioButton1.Text = "todos"
        Me.RadioButton1.UseVisualStyleBackColor = True
        '
        'radio5
        '
        Me.radio5.AutoSize = True
        Me.radio5.Location = New System.Drawing.Point(28, 141)
        Me.radio5.Name = "radio5"
        Me.radio5.Size = New System.Drawing.Size(87, 20)
        Me.radio5.TabIndex = 41
        Me.radio5.TabStop = True
        Me.radio5.Text = "Aerolineas"
        Me.radio5.UseVisualStyleBackColor = True
        '
        'radio4
        '
        Me.radio4.AutoSize = True
        Me.radio4.Location = New System.Drawing.Point(28, 118)
        Me.radio4.Name = "radio4"
        Me.radio4.Size = New System.Drawing.Size(128, 20)
        Me.radio4.TabIndex = 40
        Me.radio4.TabStop = True
        Me.radio4.Text = "Todos los Medios"
        Me.radio4.UseVisualStyleBackColor = True
        '
        'radio3
        '
        Me.radio3.AutoSize = True
        Me.radio3.Location = New System.Drawing.Point(28, 95)
        Me.radio3.Name = "radio3"
        Me.radio3.Size = New System.Drawing.Size(325, 20)
        Me.radio3.TabIndex = 39
        Me.radio3.TabStop = True
        Me.radio3.Text = "Partido Acción Nacional - Todos los medios  cliente"
        Me.radio3.UseVisualStyleBackColor = True
        '
        'radio2
        '
        Me.radio2.AutoSize = True
        Me.radio2.Location = New System.Drawing.Point(28, 72)
        Me.radio2.Name = "radio2"
        Me.radio2.Size = New System.Drawing.Size(66, 20)
        Me.radio2.TabIndex = 38
        Me.radio2.TabStop = True
        Me.radio2.Text = "Cliente"
        Me.radio2.UseVisualStyleBackColor = True
        '
        'radio1
        '
        Me.radio1.AutoSize = True
        Me.radio1.Location = New System.Drawing.Point(29, 48)
        Me.radio1.Name = "radio1"
        Me.radio1.Size = New System.Drawing.Size(417, 20)
        Me.radio1.TabIndex = 37
        Me.radio1.TabStop = True
        Me.radio1.Text = "Tema Creado para el cliente Tv Azteca -- Todos los medios-- cliente"
        Me.radio1.UseVisualStyleBackColor = True
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(920, 199)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(40, 16)
        Me.Label4.TabIndex = 35
        Me.Label4.Text = "orden"
        '
        'quitar
        '
        Me.quitar.Location = New System.Drawing.Point(805, 169)
        Me.quitar.Name = "quitar"
        Me.quitar.Size = New System.Drawing.Size(95, 23)
        Me.quitar.TabIndex = 34
        Me.quitar.Text = "Quitar Temas"
        Me.quitar.UseVisualStyleBackColor = True
        '
        'gorden
        '
        Me.gorden.Location = New System.Drawing.Point(697, 169)
        Me.gorden.Name = "gorden"
        Me.gorden.Size = New System.Drawing.Size(102, 23)
        Me.gorden.TabIndex = 33
        Me.gorden.Text = "Guardar Orden"
        Me.gorden.UseVisualStyleBackColor = True
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
        Me.DataGridView1.Location = New System.Drawing.Point(0, 199)
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.ReadOnly = True
        Me.DataGridView1.RowHeadersVisible = False
        Me.DataGridView1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.DataGridView1.Size = New System.Drawing.Size(433, 581)
        Me.DataGridView1.TabIndex = 12
        Me.DataGridView1.VirtualMode = True
        Me.DataGridView1.Visible = False
        '
        'TemaidDataGridViewTextBoxColumn
        '
        Me.TemaidDataGridViewTextBoxColumn.DataPropertyName = "Tema_id"
        Me.TemaidDataGridViewTextBoxColumn.HeaderText = "TEMA_ID"
        Me.TemaidDataGridViewTextBoxColumn.Name = "TemaidDataGridViewTextBoxColumn"
        Me.TemaidDataGridViewTextBoxColumn.ReadOnly = True
        Me.TemaidDataGridViewTextBoxColumn.Width = 75
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
        '
        'orden
        '
        Me.orden.HeaderText = "ORDEN"
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
        'DataGridView2
        '
        Me.DataGridView2.AllowDrop = True
        Me.DataGridView2.AllowUserToAddRows = False
        Me.DataGridView2.AllowUserToDeleteRows = False
        Me.DataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.DataGridView2.Location = New System.Drawing.Point(453, 198)
        Me.DataGridView2.Name = "DataGridView2"
        Me.DataGridView2.ReadOnly = True
        Me.DataGridView2.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.DataGridView2.Size = New System.Drawing.Size(447, 582)
        Me.DataGridView2.TabIndex = 13
        '
        'NV_TemasTableAdapter
        '
        Me.NV_TemasTableAdapter.ClearBeforeFill = True
        '
        'Alta_P
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.ClientSize = New System.Drawing.Size(992, 966)
        Me.Controls.Add(Me.ProyectoId)
        Me.Controls.Add(Me.regresar)
        Me.Controls.Add(Me.guardar)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.GroupBox2)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Alta_P"
        Me.Text = "Alta_P"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.NVTemasBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataSetTemas1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents ProyectoId As System.Windows.Forms.TextBox
    Friend WithEvents regresar As System.Windows.Forms.Button
    Friend WithEvents guardar As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txtnombre As System.Windows.Forms.TextBox
    Friend WithEvents txtobs As System.Windows.Forms.TextBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents buscar As System.Windows.Forms.Button
    Friend WithEvents txttema As System.Windows.Forms.TextBox
    Friend WithEvents RadioButton1 As System.Windows.Forms.RadioButton
    Friend WithEvents radio5 As System.Windows.Forms.RadioButton
    Friend WithEvents radio4 As System.Windows.Forms.RadioButton
    Friend WithEvents radio3 As System.Windows.Forms.RadioButton
    Friend WithEvents radio2 As System.Windows.Forms.RadioButton
    Friend WithEvents radio1 As System.Windows.Forms.RadioButton
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents quitar As System.Windows.Forms.Button
    Friend WithEvents gorden As System.Windows.Forms.Button
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents DataGridView2 As System.Windows.Forms.DataGridView
    Friend WithEvents DataSetTemas1 As Apertura_de_archivos_xml.DataSetTemas1
    Friend WithEvents NVTemasBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents NV_TemasTableAdapter As Apertura_de_archivos_xml.DataSetTemas1TableAdapters.NV_TemasTableAdapter
    Friend WithEvents TemaidDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents NombreDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents DescripcionDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents FechaDataGridViewTextBoxColumn As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents orden As System.Windows.Forms.DataGridViewTextBoxColumn
End Class
