<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class NotasTemas
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
        Dim DataGridViewCellStyle1 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle3 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle4 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle6 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle7 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim DataGridViewCellStyle5 As System.Windows.Forms.DataGridViewCellStyle = New System.Windows.Forms.DataGridViewCellStyle()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(NotasTemas))
        Me.DataGridView1 = New System.Windows.Forms.DataGridView()
        Me.Recorte = New System.Windows.Forms.DataGridViewCheckBoxColumn()
        Me.Nota_ides = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Tema_id = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Tema = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Medio = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Titulo = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Display = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Nota_id = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Recortes = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Nombre = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.Publicar = New System.Windows.Forms.DataGridViewCheckBoxColumn()
        Me.btnrecorte = New System.Windows.Forms.Button()
        Me.DateTimePicker1 = New System.Windows.Forms.DateTimePicker()
        Me.Actualizar = New System.Windows.Forms.Button()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.maschora = New System.Windows.Forms.MaskedTextBox()
        Me.btnadmpro = New System.Windows.Forms.Button()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.pdf = New System.Windows.Forms.Button()
        Me.btnregresar = New System.Windows.Forms.Button()
        Me.DataGridView2 = New System.Windows.Forms.DataGridView()
        Me.Seleccion = New System.Windows.Forms.DataGridViewCheckBoxColumn()
        Me.temao = New System.Windows.Forms.DataGridViewTextBoxColumn()
        Me.ftemas = New System.Windows.Forms.Button()
        Me.Button4 = New System.Windows.Forms.Button()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.FlowLayoutPanel1 = New System.Windows.Forms.FlowLayoutPanel()
        Me.Button5 = New System.Windows.Forms.Button()
        Me.vernota = New System.Windows.Forms.Button()
        Me.no_notas = New System.Windows.Forms.Button()
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FlowLayoutPanel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'DataGridView1
        '
        Me.DataGridView1.AllowUserToAddRows = False
        Me.DataGridView1.AllowUserToDeleteRows = False
        Me.DataGridView1.AllowUserToOrderColumns = True
        Me.DataGridView1.AllowUserToResizeColumns = False
        Me.DataGridView1.AllowUserToResizeRows = False
        Me.DataGridView1.BackgroundColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.DataGridView1.BorderStyle = System.Windows.Forms.BorderStyle.None
        DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.DataGridView1.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        Me.DataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        Me.DataGridView1.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Recorte, Me.Nota_ides, Me.Tema_id, Me.Tema, Me.Medio, Me.Titulo, Me.Display, Me.Nota_id, Me.Recortes, Me.Nombre, Me.Publicar})
        Me.DataGridView1.Dock = System.Windows.Forms.DockStyle.Left
        Me.DataGridView1.Location = New System.Drawing.Point(0, 0)
        Me.DataGridView1.MultiSelect = False
        Me.DataGridView1.Name = "DataGridView1"
        Me.DataGridView1.RowHeadersVisible = False
        Me.DataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.DataGridView1.ShowCellErrors = False
        Me.DataGridView1.ShowCellToolTips = False
        Me.DataGridView1.ShowEditingIcon = False
        Me.DataGridView1.ShowRowErrors = False
        Me.DataGridView1.Size = New System.Drawing.Size(764, 567)
        Me.DataGridView1.TabIndex = 0
        '
        'Recorte
        '
        DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.TopCenter
        DataGridViewCellStyle2.NullValue = False
        Me.Recorte.DefaultCellStyle = DataGridViewCellStyle2
        Me.Recorte.FillWeight = 25.44529!
        Me.Recorte.HeaderText = "Recorte"
        Me.Recorte.Name = "Recorte"
        Me.Recorte.Width = 50
        '
        'Nota_ides
        '
        Me.Nota_ides.HeaderText = "Nota_ides"
        Me.Nota_ides.Name = "Nota_ides"
        Me.Nota_ides.ReadOnly = True
        '
        'Tema_id
        '
        Me.Tema_id.HeaderText = "Tema_id"
        Me.Tema_id.Name = "Tema_id"
        '
        'Tema
        '
        Me.Tema.HeaderText = "Tema"
        Me.Tema.Name = "Tema"
        Me.Tema.ReadOnly = True
        '
        'Medio
        '
        Me.Medio.HeaderText = "Medio"
        Me.Medio.Name = "Medio"
        Me.Medio.ReadOnly = True
        '
        'Titulo
        '
        Me.Titulo.HeaderText = "Titulo"
        Me.Titulo.Name = "Titulo"
        Me.Titulo.ReadOnly = True
        '
        'Display
        '
        Me.Display.HeaderText = "Display"
        Me.Display.Name = "Display"
        Me.Display.ReadOnly = True
        '
        'Nota_id
        '
        Me.Nota_id.HeaderText = "Nota_id"
        Me.Nota_id.Name = "Nota_id"
        Me.Nota_id.ReadOnly = True
        '
        'Recortes
        '
        Me.Recortes.HeaderText = "Recortes"
        Me.Recortes.Name = "Recortes"
        Me.Recortes.ReadOnly = True
        '
        'Nombre
        '
        Me.Nombre.HeaderText = "Nombre"
        Me.Nombre.Name = "Nombre"
        Me.Nombre.ReadOnly = True
        '
        'Publicar
        '
        DataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.TopCenter
        DataGridViewCellStyle3.NullValue = False
        Me.Publicar.DefaultCellStyle = DataGridViewCellStyle3
        Me.Publicar.FillWeight = 25.44529!
        Me.Publicar.HeaderText = "Publicar"
        Me.Publicar.Name = "Publicar"
        Me.Publicar.Width = 50
        '
        'btnrecorte
        '
        Me.btnrecorte.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.btnrecorte.Location = New System.Drawing.Point(772, 236)
        Me.btnrecorte.Name = "btnrecorte"
        Me.btnrecorte.Size = New System.Drawing.Size(108, 34)
        Me.btnrecorte.TabIndex = 1
        Me.btnrecorte.Text = "Recorte"
        Me.btnrecorte.UseVisualStyleBackColor = True
        '
        'DateTimePicker1
        '
        Me.DateTimePicker1.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.DateTimePicker1.CustomFormat = "yyyy/MM/dd"
        Me.DateTimePicker1.Location = New System.Drawing.Point(772, 69)
        Me.DateTimePicker1.Name = "DateTimePicker1"
        Me.DateTimePicker1.Size = New System.Drawing.Size(108, 20)
        Me.DateTimePicker1.TabIndex = 2
        '
        'Actualizar
        '
        Me.Actualizar.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.Actualizar.Location = New System.Drawing.Point(772, 276)
        Me.Actualizar.Name = "Actualizar"
        Me.Actualizar.Size = New System.Drawing.Size(108, 36)
        Me.Actualizar.TabIndex = 4
        Me.Actualizar.Text = "Actualizar"
        Me.Actualizar.UseVisualStyleBackColor = True
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(829, 497)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(39, 13)
        Me.Label2.TabIndex = 6
        Me.Label2.Text = "Label2"
        Me.Label2.Visible = False
        '
        'maschora
        '
        Me.maschora.Location = New System.Drawing.Point(790, 538)
        Me.maschora.Mask = "00/00/0000 00:00"
        Me.maschora.Name = "maschora"
        Me.maschora.Size = New System.Drawing.Size(108, 20)
        Me.maschora.TabIndex = 7
        Me.maschora.ValidatingType = GetType(Date)
        Me.maschora.Visible = False
        '
        'btnadmpro
        '
        Me.btnadmpro.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.btnadmpro.Location = New System.Drawing.Point(772, 318)
        Me.btnadmpro.Name = "btnadmpro"
        Me.btnadmpro.Size = New System.Drawing.Size(108, 47)
        Me.btnadmpro.TabIndex = 8
        Me.btnadmpro.Text = "Administrador de Proyectos"
        Me.btnadmpro.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(829, 522)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(39, 13)
        Me.Label1.TabIndex = 9
        Me.Label1.Text = "Label1"
        Me.Label1.Visible = False
        '
        'pdf
        '
        Me.pdf.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.pdf.Location = New System.Drawing.Point(772, 371)
        Me.pdf.Name = "pdf"
        Me.pdf.Size = New System.Drawing.Size(108, 47)
        Me.pdf.TabIndex = 10
        Me.pdf.Text = "Sintexis Digital"
        Me.pdf.UseVisualStyleBackColor = True
        '
        'btnregresar
        '
        Me.btnregresar.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.btnregresar.Location = New System.Drawing.Point(772, 424)
        Me.btnregresar.Name = "btnregresar"
        Me.btnregresar.Size = New System.Drawing.Size(108, 47)
        Me.btnregresar.TabIndex = 11
        Me.btnregresar.Text = "Regresar"
        Me.btnregresar.UseVisualStyleBackColor = True
        '
        'DataGridView2
        '
        Me.DataGridView2.AllowUserToAddRows = False
        Me.DataGridView2.AllowUserToDeleteRows = False
        Me.DataGridView2.AllowUserToResizeColumns = False
        Me.DataGridView2.AllowUserToResizeRows = False
        Me.DataGridView2.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.DisplayedCells
        Me.DataGridView2.BackgroundColor = System.Drawing.Color.SteelBlue
        Me.DataGridView2.BorderStyle = System.Windows.Forms.BorderStyle.None
        DataGridViewCellStyle4.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control
        DataGridViewCellStyle4.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText
        DataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]
        Me.DataGridView2.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle4
        Me.DataGridView2.Columns.AddRange(New System.Windows.Forms.DataGridViewColumn() {Me.Seleccion, Me.temao})
        DataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        DataGridViewCellStyle6.BackColor = System.Drawing.SystemColors.Window
        DataGridViewCellStyle6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        DataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.ControlText
        DataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight
        DataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        DataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]
        Me.DataGridView2.DefaultCellStyle = DataGridViewCellStyle6
        Me.DataGridView2.Location = New System.Drawing.Point(3, 3)
        Me.DataGridView2.MultiSelect = False
        Me.DataGridView2.Name = "DataGridView2"
        Me.DataGridView2.RowHeadersVisible = False
        Me.DataGridView2.RowHeadersWidthSizeMode = System.Windows.Forms.DataGridViewRowHeadersWidthSizeMode.AutoSizeToFirstHeader
        DataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        Me.DataGridView2.RowsDefaultCellStyle = DataGridViewCellStyle7
        Me.DataGridView2.ScrollBars = System.Windows.Forms.ScrollBars.Vertical
        Me.DataGridView2.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect
        Me.DataGridView2.ShowCellErrors = False
        Me.DataGridView2.ShowCellToolTips = False
        Me.DataGridView2.ShowEditingIcon = False
        Me.DataGridView2.ShowRowErrors = False
        Me.DataGridView2.Size = New System.Drawing.Size(272, 376)
        Me.DataGridView2.TabIndex = 14
        '
        'Seleccion
        '
        DataGridViewCellStyle5.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle5.NullValue = False
        Me.Seleccion.DefaultCellStyle = DataGridViewCellStyle5
        Me.Seleccion.HeaderText = "Sel"
        Me.Seleccion.Name = "Seleccion"
        Me.Seleccion.Width = 37
        '
        'temao
        '
        Me.temao.HeaderText = "Tema"
        Me.temao.Name = "temao"
        Me.temao.ReadOnly = True
        Me.temao.Width = 73
        '
        'ftemas
        '
        Me.ftemas.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.ftemas.Location = New System.Drawing.Point(772, 95)
        Me.ftemas.Name = "ftemas"
        Me.ftemas.Size = New System.Drawing.Size(108, 34)
        Me.ftemas.TabIndex = 16
        Me.ftemas.Text = "Filtrar Temas"
        Me.ftemas.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(3, 385)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(94, 29)
        Me.Button4.TabIndex = 17
        Me.Button4.Text = "Seleccionar"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(332, 560)
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(100, 20)
        Me.TextBox1.TabIndex = 18
        Me.TextBox1.Visible = False
        '
        'FlowLayoutPanel1
        '
        Me.FlowLayoutPanel1.BackColor = System.Drawing.Color.SteelBlue
        Me.FlowLayoutPanel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.FlowLayoutPanel1.Controls.Add(Me.DataGridView2)
        Me.FlowLayoutPanel1.Controls.Add(Me.Button4)
        Me.FlowLayoutPanel1.Controls.Add(Me.Button5)
        Me.FlowLayoutPanel1.Location = New System.Drawing.Point(2, 56)
        Me.FlowLayoutPanel1.Name = "FlowLayoutPanel1"
        Me.FlowLayoutPanel1.Size = New System.Drawing.Size(276, 436)
        Me.FlowLayoutPanel1.TabIndex = 19
        '
        'Button5
        '
        Me.Button5.Location = New System.Drawing.Point(103, 385)
        Me.Button5.Name = "Button5"
        Me.Button5.Size = New System.Drawing.Size(67, 29)
        Me.Button5.TabIndex = 18
        Me.Button5.Text = "Volver"
        Me.Button5.UseVisualStyleBackColor = True
        '
        'vernota
        '
        Me.vernota.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.vernota.Location = New System.Drawing.Point(772, 135)
        Me.vernota.Name = "vernota"
        Me.vernota.Size = New System.Drawing.Size(108, 34)
        Me.vernota.TabIndex = 20
        Me.vernota.Text = "Ver Nota"
        Me.vernota.UseVisualStyleBackColor = True
        '
        'no_notas
        '
        Me.no_notas.Anchor = System.Windows.Forms.AnchorStyles.Top
        Me.no_notas.Location = New System.Drawing.Point(772, 184)
        Me.no_notas.Name = "no_notas"
        Me.no_notas.Size = New System.Drawing.Size(108, 34)
        Me.no_notas.TabIndex = 21
        Me.no_notas.Text = "No. de Notas"
        Me.no_notas.UseVisualStyleBackColor = True
        '
        'NotasTemas
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.ClientSize = New System.Drawing.Size(906, 567)
        Me.Controls.Add(Me.no_notas)
        Me.Controls.Add(Me.vernota)
        Me.Controls.Add(Me.FlowLayoutPanel1)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.ftemas)
        Me.Controls.Add(Me.btnregresar)
        Me.Controls.Add(Me.pdf)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.btnadmpro)
        Me.Controls.Add(Me.maschora)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Actualizar)
        Me.Controls.Add(Me.DateTimePicker1)
        Me.Controls.Add(Me.btnrecorte)
        Me.Controls.Add(Me.DataGridView1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.KeyPreview = True
        Me.Name = "NotasTemas"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Administrador de Carpetas"
        Me.WindowState = System.Windows.Forms.FormWindowState.Maximized
        CType(Me.DataGridView1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.DataGridView2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FlowLayoutPanel1.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents DataGridView1 As System.Windows.Forms.DataGridView
    Friend WithEvents btnrecorte As System.Windows.Forms.Button
    Friend WithEvents DateTimePicker1 As System.Windows.Forms.DateTimePicker
    Friend WithEvents Actualizar As System.Windows.Forms.Button
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents maschora As System.Windows.Forms.MaskedTextBox
    Friend WithEvents btnadmpro As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents pdf As System.Windows.Forms.Button
    Friend WithEvents btnregresar As System.Windows.Forms.Button
    Friend WithEvents DataGridView2 As System.Windows.Forms.DataGridView
    Friend WithEvents ftemas As System.Windows.Forms.Button
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents FlowLayoutPanel1 As System.Windows.Forms.FlowLayoutPanel
    Friend WithEvents Seleccion As System.Windows.Forms.DataGridViewCheckBoxColumn
    Friend WithEvents Button5 As System.Windows.Forms.Button
    Friend WithEvents temao As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents vernota As System.Windows.Forms.Button
    Friend WithEvents Recorte As System.Windows.Forms.DataGridViewCheckBoxColumn
    Friend WithEvents Nota_ides As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Tema_id As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Tema As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Medio As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Titulo As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Display As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Nota_id As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Recortes As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Nombre As System.Windows.Forms.DataGridViewTextBoxColumn
    Friend WithEvents Publicar As System.Windows.Forms.DataGridViewCheckBoxColumn
    Friend WithEvents no_notas As System.Windows.Forms.Button
End Class
