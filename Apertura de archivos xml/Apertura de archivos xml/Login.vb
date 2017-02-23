Imports System.Data
Imports System.Data.SqlClient


Public Class Login


    Dim i As Integer

    Dim mLocation As String

    Dim con As New SqlConnection("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")

    Private Sub Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles aceptar.Click

        Try
            Dim dts As New datos1
            Dim func As New funciones
            dts.gnomusuario = usuario.Text
            dts.gpassword = Password.Text
            If func.validar(dts) = True Then
                Dim frm2 As New Proyectos
                Proyectos.Show()
                Me.Hide()
                Proyectos.Location = Me.Location
            Else
                MsgBox("Contraseña y/o Usuario incorrectos")
                Password.Clear()
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        Finally
            Close()
        End Try

    End Sub

    Private Sub LinkLabel1_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs)
        
    End Sub

    Private Sub usuario_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles usuario.TextChanged

    End Sub

    Private Sub Password_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles Password.KeyDown
        If e.KeyCode = Keys.Enter Then
            Try
                Dim dts As New datos1
                Dim func As New funciones
                dts.gnomusuario = usuario.Text
                dts.gpassword = Password.Text
                If func.validar(dts) = True Then
                    Dim frm2 As New Proyectos
                    Proyectos.Show()
                    Me.Hide()
                    Proyectos.Location = Me.Location
                Else
                    MsgBox("Contraseña y/o Usuario incorrectos")
                    Password.Clear()
                End If
            Catch ex As Exception
                MsgBox(ex.Message)
            End Try


        End If
    End Sub

   
    Private Sub Login_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'EffectOut()
        Label3.Text = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString()
    End Sub
    Private Sub Login_clossing(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'EffectIn()
    End Sub

    Private Sub Label1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label1.Click

    End Sub

End Class

