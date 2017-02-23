Option Explicit On
Imports System.IO
Imports System.Collections

Public Class Form1
    Private Sub Button2_Click(sender As System.Object, e As System.EventArgs) Handles btn_exa1.Click
        Dim openFD As New FolderBrowserDialog()
        Try
            With openFD
                .Reset()
                .Description = " Seleccionar una carpeta de origen "
                .SelectedPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
                .ShowNewFolderButton = False
                Dim ret As DialogResult = .ShowDialog
                If ret = Windows.Forms.DialogResult.OK Then
                    Me.lbl_ruta1.Text = .SelectedPath
                End If
                .Dispose()
            End With
        Catch oe As Exception
            MsgBox(oe.Message, MsgBoxStyle.Critical)
        End Try
    End Sub

    Private Sub Button3_Click(sender As System.Object, e As System.EventArgs) Handles btn_exa2.Click
        Dim openFD As New FolderBrowserDialog()
        Try
            With openFD
                .Reset()
                .Description = " Seleccionar una carpeta de origen "
                .SelectedPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
                .ShowNewFolderButton = False
                Dim ret As DialogResult = .ShowDialog
                If ret = Windows.Forms.DialogResult.OK Then
                    Me.lbl_ruta2.Text = .SelectedPath
                End If
                .Dispose()
            End With
        Catch oe As Exception
            MsgBox(oe.Message, MsgBoxStyle.Critical)
        End Try
    End Sub

    Private Sub btn_exa3_Click(sender As System.Object, e As System.EventArgs)
     
    End Sub

    Private Sub btn_exa4_Click(sender As System.Object, e As System.EventArgs)
       
    End Sub

    Private Sub btn_exa5_Click(sender As System.Object, e As System.EventArgs)
        
    End Sub

    Private Sub btn_exa6_Click(sender As System.Object, e As System.EventArgs)
       
    End Sub

    Private Sub btn_iniciar_Click(sender As System.Object, e As System.EventArgs) Handles btn_iniciar.Click
        If Timer1.Enabled = True Then
            btn_iniciar.Text = "Iniciar"
            Timer1.Enabled = False
        Else
            btn_iniciar.Text = "Detener"
            Timer1.Enabled = True
        End If

    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        'If CheckBox1.Checked = True Then
        Try
            For Each foundFile As String In My.Computer.FileSystem.GetFiles(
                lbl_ruta1.Text,
                 Microsoft.VisualBasic.FileIO.SearchOption.SearchAllSubDirectories, "*.*")
                Dim foundFileInfo As New System.IO.FileInfo(foundFile)
                Try
                    My.Computer.FileSystem.CopyFile(foundFile, lbl_ruta2.Text & "\" & foundFileInfo.Name)
                    'System.IO.File.Copy(foundFile, lbl_ruta2.Text & "\" & foundFileInfo.Name, True)
                Catch ex As Exception

                End Try
            Next
        Catch ex As Exception

        End Try
        'End If
        ' If CheckBox2.Checked = True Then
        'Try
        '  For Each foundFile As String In My.Computer.FileSystem.GetFiles(
        '                lbl_ruta3.Text,
        '               Microsoft.VisualBasic.FileIO.SearchOption.SearchAllSubDirectories, "*.*")
        ' Dim foundFileInfo As New System.IO.FileInfo(foundFile)
        '  Try
        'My.Computer.FileSystem.MoveFile(foundFile, lbl_ruta4.Text & "\" & foundFileInfo.Name)
        '  Catch ex As Exception

        ' End Try
        ' Next
        '  Catch ex As Exception

        '   End Try

        ' End If
        '  If CheckBox3.Checked = True Then
        'Try
        ' For Each foundFile As String In My.Computer.FileSystem.GetFiles(
        'lbl_ruta5.Text,
        ' Microsoft.VisualBasic.FileIO.SearchOption.SearchAllSubDirectories, "*.*")
        'Dim foundFileInfo As New System.IO.FileInfo(foundFile)
        ' Try
        'My.Computer.FileSystem.MoveFile(foundFile, lbl_ruta6.Text & "\" & foundFileInfo.Name)
        'Catch ex As Exception

        'End Try

        'Next
        'Catch ex As Exception

        'End Try

        'End If
    End Sub

   
    

  
    Private Sub Button1_Click_1(sender As System.Object, e As System.EventArgs) Handles Button1.Click
        Hide()
        NotifyIcon1.Visible = True
    End Sub

    Private Sub NotifyIcon1_MouseDoubleClick(sender As System.Object, e As System.Windows.Forms.MouseEventArgs) Handles NotifyIcon1.MouseDoubleClick
        Show()
    End Sub
End Class
