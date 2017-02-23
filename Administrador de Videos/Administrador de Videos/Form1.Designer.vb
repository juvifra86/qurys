<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Form1))
        Me.btn_iniciar = New System.Windows.Forms.Button()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.btn_exa1 = New System.Windows.Forms.Button()
        Me.btn_exa2 = New System.Windows.Forms.Button()
        Me.lbl_ruta1 = New System.Windows.Forms.Label()
        Me.lbl_ruta2 = New System.Windows.Forms.Label()
        Me.Timer1 = New System.Windows.Forms.Timer(Me.components)
        Me.NotifyIcon1 = New System.Windows.Forms.NotifyIcon(Me.components)
        Me.Button1 = New System.Windows.Forms.Button()
        Me.SuspendLayout()
        '
        'btn_iniciar
        '
        Me.btn_iniciar.Font = New System.Drawing.Font("News706 BT", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btn_iniciar.ForeColor = System.Drawing.Color.Red
        Me.btn_iniciar.Location = New System.Drawing.Point(132, 114)
        Me.btn_iniciar.Name = "btn_iniciar"
        Me.btn_iniciar.Size = New System.Drawing.Size(105, 47)
        Me.btn_iniciar.TabIndex = 3
        Me.btn_iniciar.Text = "Iniciar"
        Me.btn_iniciar.UseVisualStyleBackColor = True
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Font = New System.Drawing.Font("News706 BT", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.Color.Crimson
        Me.Label2.Location = New System.Drawing.Point(24, 74)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(25, 19)
        Me.Label2.TabIndex = 5
        Me.Label2.Text = "A:"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Font = New System.Drawing.Font("News706 BT", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.ForeColor = System.Drawing.Color.Crimson
        Me.Label3.Location = New System.Drawing.Point(24, 26)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(36, 19)
        Me.Label3.TabIndex = 6
        Me.Label3.Text = "De:"
        '
        'btn_exa1
        '
        Me.btn_exa1.BackColor = System.Drawing.Color.DarkKhaki
        Me.btn_exa1.Location = New System.Drawing.Point(84, 26)
        Me.btn_exa1.Name = "btn_exa1"
        Me.btn_exa1.Size = New System.Drawing.Size(30, 23)
        Me.btn_exa1.TabIndex = 83
        Me.btn_exa1.UseVisualStyleBackColor = False
        '
        'btn_exa2
        '
        Me.btn_exa2.BackColor = System.Drawing.Color.DarkKhaki
        Me.btn_exa2.Location = New System.Drawing.Point(84, 74)
        Me.btn_exa2.Name = "btn_exa2"
        Me.btn_exa2.Size = New System.Drawing.Size(30, 23)
        Me.btn_exa2.TabIndex = 84
        Me.btn_exa2.UseVisualStyleBackColor = False
        '
        'lbl_ruta1
        '
        Me.lbl_ruta1.AutoSize = True
        Me.lbl_ruta1.Font = New System.Drawing.Font("OCR A Extended", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbl_ruta1.ForeColor = System.Drawing.Color.Black
        Me.lbl_ruta1.Location = New System.Drawing.Point(153, 30)
        Me.lbl_ruta1.Name = "lbl_ruta1"
        Me.lbl_ruta1.Size = New System.Drawing.Size(0, 13)
        Me.lbl_ruta1.TabIndex = 100
        '
        'lbl_ruta2
        '
        Me.lbl_ruta2.AutoSize = True
        Me.lbl_ruta2.Font = New System.Drawing.Font("OCR A Extended", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lbl_ruta2.ForeColor = System.Drawing.Color.Black
        Me.lbl_ruta2.Location = New System.Drawing.Point(153, 78)
        Me.lbl_ruta2.Name = "lbl_ruta2"
        Me.lbl_ruta2.Size = New System.Drawing.Size(0, 13)
        Me.lbl_ruta2.TabIndex = 101
        '
        'Timer1
        '
        Me.Timer1.Interval = 600000
        '
        'NotifyIcon1
        '
        Me.NotifyIcon1.BalloonTipIcon = System.Windows.Forms.ToolTipIcon.Info
        Me.NotifyIcon1.BalloonTipText = "Mueve archivos entre carpetas."
        Me.NotifyIcon1.Icon = CType(resources.GetObject("NotifyIcon1.Icon"), System.Drawing.Icon)
        Me.NotifyIcon1.Text = "Adm. de Archivos"
        '
        'Button1
        '
        Me.Button1.Font = New System.Drawing.Font("News706 BT", 12.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button1.ForeColor = System.Drawing.Color.Red
        Me.Button1.Location = New System.Drawing.Point(294, 114)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(105, 47)
        Me.Button1.TabIndex = 102
        Me.Button1.Text = "Ocultar"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AcceptButton = Me.btn_iniciar
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 14.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink
        Me.BackColor = System.Drawing.Color.DarkSeaGreen
        Me.ClientSize = New System.Drawing.Size(536, 173)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.lbl_ruta2)
        Me.Controls.Add(Me.lbl_ruta1)
        Me.Controls.Add(Me.btn_exa2)
        Me.Controls.Add(Me.btn_exa1)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.btn_iniciar)
        Me.Font = New System.Drawing.Font("NewsGoth BT", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Crimson
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.Name = "Form1"
        Me.Text = "Administrador de Archivos"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btn_iniciar As System.Windows.Forms.Button
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents btn_exa1 As System.Windows.Forms.Button
    Friend WithEvents btn_exa2 As System.Windows.Forms.Button
    Friend WithEvents lbl_ruta1 As System.Windows.Forms.Label
    Friend WithEvents lbl_ruta2 As System.Windows.Forms.Label
    Friend WithEvents Timer1 As System.Windows.Forms.Timer
    Friend WithEvents NotifyIcon1 As System.Windows.Forms.NotifyIcon
    Friend WithEvents Button1 As System.Windows.Forms.Button

End Class
