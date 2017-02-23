<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Proyectos
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Proyectos))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.ComboBox1 = New System.Windows.Forms.ComboBox()
        Me.AdminRecortesBindingSource1 = New System.Windows.Forms.BindingSource(Me.components)
        Me.MSCENTRALDBDataSet2 = New Apertura_de_archivos_xml.MSCENTRALDBDataSet2()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.AdminRecortesTableAdapter1 = New Apertura_de_archivos_xml.MSCENTRALDBDataSet2TableAdapters.AdminRecortesTableAdapter()
        Me.AdminRecortesTableAdapter = New Apertura_de_archivos_xml.MSCENTRALDBDataSetTableAdapters.AdminRecortesTableAdapter()
        Me.AdminRecortesBindingSource = New System.Windows.Forms.BindingSource(Me.components)
        Me.MSCENTRALDBDataSet = New Apertura_de_archivos_xml.MSCENTRALDBDataSet()
        CType(Me.AdminRecortesBindingSource1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.MSCENTRALDBDataSet2, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.AdminRecortesBindingSource, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.MSCENTRALDBDataSet, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Font = New System.Drawing.Font("Arial", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(19, 84)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(119, 16)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Elige un proyecto"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("Arial", 14.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(78, 23)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(207, 22)
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Control de Proyectos"
        '
        'ComboBox1
        '
        Me.ComboBox1.DataSource = Me.AdminRecortesBindingSource1
        Me.ComboBox1.DisplayMember = "Nombre"
        Me.ComboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.ComboBox1.FormattingEnabled = True
        Me.ComboBox1.Location = New System.Drawing.Point(176, 84)
        Me.ComboBox1.Name = "ComboBox1"
        Me.ComboBox1.Size = New System.Drawing.Size(156, 21)
        Me.ComboBox1.TabIndex = 3
        Me.ComboBox1.ValueMember = "Proyecto_id"
        '
        'AdminRecortesBindingSource1
        '
        Me.AdminRecortesBindingSource1.DataMember = "AdminRecortes"
        Me.AdminRecortesBindingSource1.DataSource = Me.MSCENTRALDBDataSet2
        '
        'MSCENTRALDBDataSet2
        '
        Me.MSCENTRALDBDataSet2.DataSetName = "MSCENTRALDBDataSet2"
        Me.MSCENTRALDBDataSet2.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(173, 133)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(39, 13)
        Me.Label3.TabIndex = 4
        Me.Label3.Text = "Label3"
        Me.Label3.Visible = False
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(272, 133)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(39, 13)
        Me.Label4.TabIndex = 5
        Me.Label4.Text = "Label4"
        Me.Label4.Visible = False
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(137, 180)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(90, 38)
        Me.Button1.TabIndex = 6
        Me.Button1.Text = "Aceptar"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'AdminRecortesTableAdapter1
        '
        Me.AdminRecortesTableAdapter1.ClearBeforeFill = True
        '
        'AdminRecortesTableAdapter
        '
        Me.AdminRecortesTableAdapter.ClearBeforeFill = True
        '
        'AdminRecortesBindingSource
        '
        Me.AdminRecortesBindingSource.DataMember = "AdminRecortes"
        '
        'MSCENTRALDBDataSet
        '
        Me.MSCENTRALDBDataSet.DataSetName = "MSCENTRALDBDataSet"
        Me.MSCENTRALDBDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema
        '
        'Proyectos
        '
        Me.AcceptButton = Me.Button1
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.SystemColors.GradientInactiveCaption
        Me.ClientSize = New System.Drawing.Size(367, 230)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.ComboBox1)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Proyectos"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Proyectos"
        CType(Me.AdminRecortesBindingSource1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.MSCENTRALDBDataSet2, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.AdminRecortesBindingSource, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.MSCENTRALDBDataSet, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents ComboBox1 As System.Windows.Forms.ComboBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents AdminRecortesBindingSource1 As System.Windows.Forms.BindingSource
    Friend WithEvents MSCENTRALDBDataSet2 As Apertura_de_archivos_xml.MSCENTRALDBDataSet2
    Friend WithEvents AdminRecortesTableAdapter1 As Apertura_de_archivos_xml.MSCENTRALDBDataSet2TableAdapters.AdminRecortesTableAdapter
    Friend WithEvents AdminRecortesTableAdapter As Apertura_de_archivos_xml.MSCENTRALDBDataSetTableAdapters.AdminRecortesTableAdapter
    Friend WithEvents AdminRecortesBindingSource As System.Windows.Forms.BindingSource
    Friend WithEvents MSCENTRALDBDataSet As Apertura_de_archivos_xml.MSCENTRALDBDataSet
End Class
