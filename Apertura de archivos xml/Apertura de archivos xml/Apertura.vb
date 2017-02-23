Imports System.IO
Imports System.Xml
Imports System.Security.Cryptography
'Imports System.Security.Cryptography.Xml
Imports System.Diagnostics
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic
Imports System.Text
'Imports CAPICOM

Public Class Apertura
    ' Dim key As New EncryptedData
    Dim cadena As String
    Dim con As New SqlConnection("Data Source=Sistemas01;Initial Catalog=MSDBPRODUCCION;Integrated Security=true")
    Dim datos As String
    Dim openFileDialog1 As New OpenFileDialog()
    Dim Archivo As System.IO.FileStream
    Dim sRenglon As String = Nothing
    Dim strStreamW As Stream = Nothing
    Dim strStreamWriter As StreamWriter = Nothing
    Dim ContenidoArchivo As String = Nothing
    Dim PathArchivo As String
    Dim i As Integer

    Private Sub Examinar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Examinar.Click
        ' Try

        'Dim Val1 As String = "10"

        'Dim Val2 As Int16 = 0


        'Dim result As Integer = CInt(CDbl(Val1) / Val2)

        ' MsgBox(result)


        'Catch ex As Exception

        ' My.Computer.FileSystem.WriteAllText(My.Computer.FileSystem.SpecialDirectories.MyDocuments & "\Error Generado.txt", ex.Message & vbNewLine & ex.StackTrace, True)

        ' MsgBox("Error no se puede dividir entre Cero , se ha generado un archivo en la carpeta mis documentos llamado Error Generado.txt el cual contiene detalles del error ")

        ' End Try
        Try

            If Directory.Exists("C:\Log-2013") = False Then ' si no existe la carpeta se crea
                Directory.CreateDirectory("C:\Log-2013")
            End If

            Windows.Forms.Cursor.Current = Cursors.WaitCursor
            PathArchivo = "C:\Log-2013\Archivo" & Format(Today.Date, "ddMMyyyy") & ".txt" ' Se determina el nombre del archivo con la fecha actual
            'verificamos si existe el archivo
            If File.Exists(PathArchivo) Then
                strStreamW = File.Open(PathArchivo, FileMode.Open) 'Abrimos el archivo
            Else
                strStreamW = File.Create(PathArchivo) ' lo creamos
            End If

            strStreamWriter = New StreamWriter(strStreamW, System.Text.Encoding.Default) 'tipo de codificacion para escritura
            'escribimos en el archivo
            strStreamWriter.WriteLine("Primera linea")
            strStreamWriter.Close() ' cerramos

        Catch ex As Exception
            MsgBox("Error al Guardar la informacion en el archivo. " & ex.ToString, MsgBoxStyle.Critical, Application.ProductName)
            strStreamWriter.Close() ' cerramos
        End Try


        openFileDialog1.InitialDirectory = "C:\"
        openFileDialog1.Filter = "txt files (*.txt)|*.txt|All files (*.*)|*.*"
        openFileDialog1.FilterIndex = 2
        openFileDialog1.RestoreDirectory = True

        If openFileDialog1.ShowDialog() = System.Windows.Forms.DialogResult.OK Then

            TextBox1.Text = openFileDialog1.FileName()

        End If

    End Sub


    Private Sub Abrir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Abrir.Click
        Process.Start("Notepad.exe", "C:\Documents and Settings\smartinez\Escritorio\XMLPrueba.xml")


        Dim TodoTexto As String = ""
        Dim LineaDeTexto As String = ""
        'openFileDialog1.Filter = "Formato de archivo (*.XML)|*.XML"
        'openFileDialog1.ShowDialog() 'cuadro de dialogo abrir
        If openFileDialog1.FileName <> "" Then 'si el nombre del archivo no es nulo
            Try 'detecta posibles errores al abrir
                FileOpen(1, openFileDialog1.FileName, OpenMode.Input) ' el archivo que hemos abierto se denotara por 1
                Do Until EOF(1) 'EOF devuelve verdadero si se termina de leer un archivo (archivo=1)
                    LineaDeTexto = LineInput(1) 'LineInput lee linea por linea de un archivo (archivo=1)
                    TodoTexto = TodoTexto & LineaDeTexto & vbCrLf
                Loop
                TextBox2.Text = TodoTexto 'abre el archivo 
            Catch
                MsgBox("Error al leer el archivo") 'Error al leer 
            Finally
                FileClose(1) 'cierra el archivo 
            End Try
        End If
        ' Detectar una excepción iniciada por el procedimiento llamado.

         

    End Sub

    Private Sub TextBox2_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)

        If Me.TextBox2.Text.Length = 0 Then
            ErrorProvider1.SetError(Me.TextBox2, "Debe tener un valor")
        Else
            ErrorProvider1.SetError(Me.TextBox2, "")
        End If
    End Sub

    Private Sub Apertura_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub TextBox1_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TextBox1.TextChanged

        If Me.TextBox1.Text.Length = 0 Then
            ErrorProvider1.SetError(Me.TextBox1, "Debe tener un valor")
        Else
            ErrorProvider1.SetError(Me.TextBox1, "")
        End If
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        On Error GoTo Ver


        cadena = Trim(TextBox2.Text)
        'key.Algorithm.Name = CAPICOM_ENCRYPTION_ALGORITHM_3DES
        'key.SetSecret("www.foro.lospillaos.es")
        'key.Decrypt(cadena)
        'TextBox2.Text = key.Content

        Exit Sub
Ver:
        MsgBox("Nº de error: " & Err.Number & " | " & Err.Description, vbCritical, "Control de errores")
        Err.Clear()

        'Me.TextBox2.Text = Cifrador.Descifrar(Me.TextBox2.Text)


    End Sub
    Private Sub EventLog1_EntryWritten(ByVal sError As System.Object, ByVal e As System.Diagnostics.EntryWrittenEventArgs)

    End Sub

    Private Sub Button1_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click

        On Error GoTo Ver

        cadena = Trim(TextBox2.Text)
        'key.Content = cadena
        'key.Algorithm.Name = CAPICOM_ENCRYPTION_ALGORITHM_3DES
        'key.SetSecret("www.foro.lospillaos.es")
        'TextBox2.Text = key.Encrypt

        Exit Sub
Ver:
        MsgBox("Nº de error: " & Err.Number & " | " & Err.Description, vbCritical, "Control de errores")
        Err.Clear()
        'Me.TextBox2.Text = Cifrador.Cifrar(Me.TextBox2.Text)
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Conectar.Click
        Dim con2 As New SqlConnection(connectionString:=TextBox2.Text)
        If con2.State = ConnectionState.Open Then
        Else
            MsgBox("Conectado a la Base de Datos")

        End If

        

    End Sub
End Class

