Imports System.Data.SqlClient
Imports System.Data.Sql
Imports System.Configuration

Public Class NotasTemas
    Dim o As Integer = 0
    Dim resultado, renglon, j As Integer
    Shared iProyecto_Id As Integer
    Dim u As Integer = 2
    Dim nts As Integer
    Dim fecha, cin As String
    Dim ds As New DataSet
    Dim con As New SqlConnection("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")
    Private Sub NotasTemas_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.Alt And e.KeyCode.ToString = "F" Then
            ftemas.PerformClick()
        End If
        If e.Alt And e.KeyCode.ToString = "V" Then
            vernota.PerformClick()
        End If
        If e.Alt And e.KeyCode.ToString = "N" Then
            no_notas.PerformClick()
        End If
        If e.Alt And e.KeyCode.ToString = "R" Then
            btnrecorte.PerformClick()
        End If
        If e.Alt And e.KeyCode.ToString = "A" Then
            Actualizar.PerformClick()
        End If
        If e.Alt And e.KeyCode.ToString = "P" Then
            btnadmpro.PerformClick()
        End If
        If e.Alt And e.KeyCode.ToString = "S" Then
            pdf.PerformClick()
        End If
        If e.KeyCode = Keys.Back Then
            btnregresar.PerformClick()
        End If
    End Sub
    Private Sub DataGridView1_CellDoubleClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellDoubleClick
        vernota.PerformClick()
    End Sub
    Private Sub DataGridView1_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView1.CellContentClick
        Dim valorCheck As Integer
        Dim valoruno As Integer
        If e.ColumnIndex = DataGridView1.Columns("Publicar").Index Then
            valorCheck = DataGridView1.Rows(e.RowIndex).Cells(e.ColumnIndex).Value
            valoruno = Math.Abs(valorCheck)  'valorCheck obtiene  1
            Label2.Text = valoruno
            con.Open()
            Dim cmd As New SqlCommand("Update NV_NotasTemas Set Display = '" & Label2.Text & "' Where Tema_id ='" & DataGridView1.CurrentRow.Cells(2).EditedFormattedValue.ToString & "'  and Nota_id ='" & DataGridView1.CurrentRow.Cells(7).EditedFormattedValue.ToString & "'", con)
            cmd.ExecuteNonQuery()
            con.Close()
        End If

        If e.ColumnIndex = DataGridView1.Columns("Recorte").Index Then
            u = 1
            btnrecorte.PerformClick()
        End If
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        FlowLayoutPanel1.Size = New Point(0, 0)
        iProyecto_Id = Proyectos.ComboBox1.SelectedValue.ToString
        fecha = Today.ToString("yyyy/MM/dd")
        Dim cadenaconexion As String = ("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")
        Dim cone As New SqlConnection()
        Dim comando, comando2 As New SqlCommand()
        Dim dr, dr2 As SqlDataReader
        con.ConnectionString = cadenaconexion
        comando2.Connection = con
        comando2.CommandText = "Select distinct nt.Nombre as Temas " & _
 "from NV_NotasTemas as nvnt " & _
 "inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id " & _
 "inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id " & _
 "Where(nvnt.Display >= 0)" & _
 "and nvnt.FechaPublicacion between '" & fecha & "' and  '" & fecha & "'" & _
 "and nvnt.Tema_id in (Select Tema_id from AdminRecortesTemas Where Proyecto_id = '" & iProyecto_Id & "')"
        comando2.CommandType = CommandType.Text
        con.Open()
        DataGridView2.Rows.Clear()
        dr2 = comando2.ExecuteReader()
        While (dr2.Read())
            Dim renglon2 As Integer = (DataGridView2.Rows.Add())
            '// especificamos en que fila se mostrará cada registro
            '// nombredeldatagrid.filas[numerodefila].celdas[nombredelacelda].valor=
            '// dr.tipodedatosalmacenado(dr.getordinal(nombredelcampo_en_la_base_de_datos)conviertelo_a_string_sino_es_del_tipo_string)
            DataGridView2.Rows(renglon2).Cells("temao").Value = dr2.GetString(dr2.GetOrdinal("Temas")).ToString()
            ' DataGridView1.Rows(renglon).Cells("eliminado").Value = dr.GetBoolean(dr.GetOrdinal("Eliminado"))
        End While
        dr2.Dispose()
        comando.Connection = con
        comando.CommandText = "Select nvnt.Tema_id" & _
        ",nt.Nombre as Tema" & _
        ",cm.Nombre as Medio" & _
        ",ntas.Titulo,nvnt.Display" & _
        ",ntas.Nota_id" & _
        ",(Select COUNT(*) from RecortesTestigosNotas as rtn Where rtn.Nota_id=ntas.Nota_id) as Recortes" & _
        ",isnull(ctrrec.Nota_id,0) as Nota_ides" & _
        ",isNull(cu.Nombre,'S/A') as Nombre" & _
        " from NV_NotasTemas as nvnt" & _
        " inner join notas as ntas on ntas.Nota_id = nvnt.Nota_id" & _
        " inner join Cat_Medios as cm on cm.Medio_Id = ntas.Medio_Id" & _
        " inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id" & _
        " inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id" & _
        " left join AdminRecortesProceso as ctrrec on ctrrec.Nota_id = nvnt.Nota_id and ctrrec.Tema_id = nvnt.Tema_id" & _
    " left join Cat_Usuarios as cu On cu.Usuario_Id = ctrrec.Usuario_id" & _
        " Where(nvnt.Display >= 0)" & _
        "and nvnt.FechaPublicacion between '" & fecha & "' and  '" & fecha & "'" & _
    "and nvnt.Tema_id in (Select Tema_id from AdminRecortesTemas Where Proyecto_id = '" & iProyecto_Id & "'" & _
    "and cm.TipoMedio_id=1)" & _
        "Order by art.Orden"
        comando.CommandType = CommandType.Text
        DataGridView1.Rows.Clear()
        dr = comando.ExecuteReader()
        While (dr.Read())
            Dim renglon As Integer = (DataGridView1.Rows.Add())
            '// especificamos en que fila se mostrará cada registro
            '// nombredeldatagrid.filas[numerodefila].celdas[nombredelacelda].valor=
            '// dr.tipodedatosalmacenado(dr.getordinal(nombredelcampo_en_la_base_de_datos)conviertelo_a_string_sino_es_del_tipo_string)
            DataGridView1.Rows(renglon).Cells("Tema_id").Value = dr.GetInt32(dr.GetOrdinal("Tema_id")).ToString()
            DataGridView1.Rows(renglon).Cells("Tema").Value = dr.GetString(dr.GetOrdinal("Tema"))
            DataGridView1.Rows(renglon).Cells("Medio").Value = dr.GetString(dr.GetOrdinal("Medio"))
            DataGridView1.Rows(renglon).Cells("Titulo").Value = dr.GetString(dr.GetOrdinal("Titulo"))
            DataGridView1.Rows(renglon).Cells("Display").Value = dr.GetInt32(dr.GetOrdinal("Display")).ToString()
            DataGridView1.Rows(renglon).Cells("Nota_id").Value = dr.GetInt64(dr.GetOrdinal("Nota_id")).ToString()
            DataGridView1.Rows(renglon).Cells("Recortes").Value = dr.GetInt32(dr.GetOrdinal("Recortes")).ToString()
            DataGridView1.Rows(renglon).Cells("Nombre").Value = dr.GetString(dr.GetOrdinal("Nombre"))
            DataGridView1.Rows(renglon).Cells("Nota_ides").Value = dr.GetInt64(dr.GetOrdinal("Nota_ides")).ToString()
            ' DataGridView1.Rows(renglon).Cells("eliminado").Value = dr.GetBoolean(dr.GetOrdinal("Eliminado"))
        End While
        con.Close()
        With DataGridView1
            .Columns("Tema_id").Visible = False
            .Columns("Display").Visible = False
            .Columns("Nota_id").Visible = False
            .Columns("Nota_ides").Visible = False
            .Columns("Tema").DisplayIndex = 0
            .Columns("Tema").Width = 170
            .Columns("Medio").DisplayIndex = 1
            .Columns("Medio").Width = 125
            .Columns("Titulo").DisplayIndex = 2
            .Columns("Titulo").Width = 250
            .Columns("Publicar").DisplayIndex = 3
            .Columns("Recorte").DisplayIndex = 4
            .Columns("Recortes").Width = 54
            .Columns("Recortes").DefaultCellStyle.Alignment = 2
            .Columns("Recortes").DisplayIndex = 5
            .Columns("Recortes").Visible = False
        End With
        Label2.BackColor = Color.Transparent
        For Each Row As DataGridViewRow In DataGridView1.Rows
            If Row.Cells("Display").Value >= 1 Then
                Row.Cells("Publicar").Value = True
                resultado = 1
            ElseIf Row.Cells("Display").Value = 0 Then
                Row.Cells("Publicar").Value = False
                resultado = 0
            End If
        Next
        For Each Row As DataGridViewRow In DataGridView1.Rows
            If Row.Cells(1).Value = True Then
                If Row.Cells("Nota_ides").Value >= 1 Then
                    Row.Cells("Recorte").Value = True
                    Row.DefaultCellStyle.BackColor = Color.Yellow
                    resultado = 1
                End If
            ElseIf Row.Cells("Nota_ides").Value = 0 Then
                Row.Cells("Recorte").Value = False
                resultado = 0
            End If
        Next
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnrecorte.Click
        Select Case (u)
            Case 1

                If DataGridView1.CurrentRow.Cells("Recorte").Value = False Then
                    DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.White
                    Dim cmd As New SqlCommand("delete from AdminRecortesProceso where Nota_id=" & DataGridView1.CurrentRow.Cells(7).EditedFormattedValue.ToString & "", con)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                Else
                    If DataGridView1.CurrentRow.Cells("Publicar").Value = True Then
                        DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.Yellow
                        Dim cmd As New SqlCommand("Insert Into AdminRecortesProceso values('" & DataGridView1.CurrentRow.Cells(7).EditedFormattedValue.ToString & "', '" & DataGridView1.CurrentRow.Cells(2).EditedFormattedValue.ToString & "','" & iProyecto_Id & "','1',getdate(), '0','0')", con)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                    Else
                        DataGridView1.CurrentRow.Cells("Recorte").Value = False
                        MsgBox("La Nota no esta publicada...")
                    End If
                End If
                u = 2
            Case 2
                If DataGridView1.CurrentRow.Cells("Recorte").Value = True Then
                    DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.White
                    Dim cmd As New SqlCommand("delete from AdminRecortesProceso where Nota_id=" & DataGridView1.CurrentRow.Cells(7).EditedFormattedValue.ToString & "", con)
                    con.Open()
                    cmd.ExecuteNonQuery()
                    con.Close()
                    DataGridView1.CurrentRow.Cells("Recorte").Value = False
                Else
                    If DataGridView1.CurrentRow.Cells("Publicar").Value = True Then
                        DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.Yellow
                        Dim cmd As New SqlCommand("Insert Into AdminRecortesProceso values('" & DataGridView1.CurrentRow.Cells(7).EditedFormattedValue.ToString & "', '" & DataGridView1.CurrentRow.Cells(2).EditedFormattedValue.ToString & "','" & iProyecto_Id & "','1',getdate(), '0','0')", con)
                        con.Open()
                        cmd.ExecuteNonQuery()
                        con.Close()
                        DataGridView1.CurrentRow.Cells("Recorte").Value = True
                    Else
                        DataGridView1.CurrentRow.Cells("Recorte").Value = False
                        MsgBox("La Nota no esta publicada...")
                    End If
                End If
        End Select
    End Sub
    Private Sub Actualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Actualizar.Click
        fecha = DateTimePicker1.Value.ToString("yyyy/MM/dd")
        Dim cadenaconexion As String = ("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")
        Dim cone As New SqlConnection()
        Dim comando As New SqlCommand()
        Dim dr As SqlDataReader
        con.ConnectionString = cadenaconexion
        comando.Connection = con
        If o > 0 Then
            comando.CommandText = "Select nvnt.Tema_id" & _
            ",nt.Nombre as Tema" & _
            ",cm.Nombre as Medio" & _
            ",ntas.Titulo,nvnt.Display" & _
            ",ntas.Nota_id" & _
            ",(Select COUNT(*) from RecortesTestigosNotas as rtn Where rtn.Nota_id=ntas.Nota_id) as Recortes" & _
            ",isnull(ctrrec.Nota_id,0) as Nota_ides" & _
            ",isNull(cu.Nombre,'S/A') as Nombre" & _
            " from NV_NotasTemas as nvnt" & _
            " inner join notas as ntas on ntas.Nota_id = nvnt.Nota_id" & _
            " inner join Cat_Medios as cm on cm.Medio_Id = ntas.Medio_Id" & _
            " inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id" & _
            " inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id" & _
            " left join AdminRecortesProceso as ctrrec on ctrrec.Nota_id = nvnt.Nota_id and ctrrec.Tema_id = nvnt.Tema_id" & _
        " left join Cat_Usuarios as cu On cu.Usuario_Id = ctrrec.Usuario_id" & _
            " Where(nvnt.Display >= 0)" & _
            "and nvnt.FechaPublicacion between '" & fecha & "' and  '" & fecha & "'" & _
        "and nvnt.Tema_id in (Select Tema_id from AdminRecortesTemas Where Proyecto_id = '" & iProyecto_Id & "'" & _
         "and nt.Nombre in(" & cin & ")" & _
         "and cm.TipoMedio_id=1)" & _
                    "Order by art.Orden"
        Else
            comando.CommandText = "Select nvnt.Tema_id" & _
            ",nt.Nombre as Tema" & _
            ",cm.Nombre as Medio" & _
            ",ntas.Titulo,nvnt.Display" & _
            ",ntas.Nota_id" & _
            ",(Select COUNT(*) from RecortesTestigosNotas as rtn Where rtn.Nota_id=ntas.Nota_id) as Recortes" & _
            ",isnull(ctrrec.Nota_id,0) as Nota_ides" & _
            ",isNull(cu.Nombre,'S/A') as Nombre" & _
            " from NV_NotasTemas as nvnt" & _
            " inner join notas as ntas on ntas.Nota_id = nvnt.Nota_id" & _
            " inner join Cat_Medios as cm on cm.Medio_Id = ntas.Medio_Id" & _
            " inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id" & _
            " inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id" & _
            " left join AdminRecortesProceso as ctrrec on ctrrec.Nota_id = nvnt.Nota_id and ctrrec.Tema_id = nvnt.Tema_id" & _
        " left join Cat_Usuarios as cu On cu.Usuario_Id = ctrrec.Usuario_id" & _
            " Where(nvnt.Display >= 0)" & _
            "and nvnt.FechaPublicacion between '" & fecha & "' and  '" & fecha & "'" & _
        "and nvnt.Tema_id in (Select Tema_id from AdminRecortesTemas Where Proyecto_id = '" & iProyecto_Id & "'" & _
                  "and cm.TipoMedio_id=1)" & _
                    "Order by art.Orden"
        End If
        comando.CommandType = CommandType.Text
        con.Open()
        DataGridView1.Rows.Clear()
        dr = comando.ExecuteReader()
        While (dr.Read())
            Dim renglon As Integer = (DataGridView1.Rows.Add())
            '// especificamos en que fila se mostrará cada registro
            '// nombredeldatagrid.filas[numerodefila].celdas[nombredelacelda].valor=
            '// dr.tipodedatosalmacenado(dr.getordinal(nombredelcampo_en_la_base_de_datos)conviertelo_a_string_sino_es_del_tipo_string)
            DataGridView1.Rows(renglon).Cells("Tema_id").Value = dr.GetInt32(dr.GetOrdinal("Tema_id")).ToString()
            DataGridView1.Rows(renglon).Cells("Tema").Value = dr.GetString(dr.GetOrdinal("Tema"))
            DataGridView1.Rows(renglon).Cells("Medio").Value = dr.GetString(dr.GetOrdinal("Medio"))
            DataGridView1.Rows(renglon).Cells("Titulo").Value = dr.GetString(dr.GetOrdinal("Titulo"))
            DataGridView1.Rows(renglon).Cells("Display").Value = dr.GetInt32(dr.GetOrdinal("Display")).ToString()
            DataGridView1.Rows(renglon).Cells("Nota_id").Value = dr.GetInt64(dr.GetOrdinal("Nota_id")).ToString()
            DataGridView1.Rows(renglon).Cells("Recortes").Value = dr.GetInt32(dr.GetOrdinal("Recortes")).ToString()
            DataGridView1.Rows(renglon).Cells("Nombre").Value = dr.GetString(dr.GetOrdinal("Nombre"))
            DataGridView1.Rows(renglon).Cells("Nota_ides").Value = dr.GetInt64(dr.GetOrdinal("Nota_ides")).ToString()
            ' DataGridView1.Rows(renglon).Cells("eliminado").Value = dr.GetBoolean(dr.GetOrdinal("Eliminado"))
        End While
        con.Close()
        With DataGridView1
            .Columns("Tema_id").Visible = False
            .Columns("Display").Visible = False
            .Columns("Nota_id").Visible = False
            .Columns("Nota_ides").Visible = False
            .Columns("Tema").DisplayIndex = 0
            .Columns("Tema").Width = 170
            .Columns("Medio").DisplayIndex = 1
            .Columns("Medio").Width = 125
            .Columns("Titulo").DisplayIndex = 2
            .Columns("Titulo").Width = 250
            .Columns("Publicar").DisplayIndex = 3
            .Columns("Recorte").DisplayIndex = 4
            .Columns("Recortes").Width = 54
            .Columns("Recortes").DefaultCellStyle.Alignment = 2
            .Columns("Recortes").DisplayIndex = 5
            .Columns("Recortes").Visible = False
        End With
        Label2.BackColor = Color.Transparent
        For Each Row As DataGridViewRow In DataGridView1.Rows
            If Row.Cells("Display").Value >= 1 Then
                Row.Cells("Publicar").Value = True
                resultado = 1
            ElseIf Row.Cells("Display").Value = 0 Then
                Row.Cells("Publicar").Value = False
                resultado = 0
            End If
        Next
        For Each Row As DataGridViewRow In DataGridView1.Rows
            If Row.Cells(1).Value = True Then
                If Row.Cells("Nota_ides").Value >= 1 Then
                    Row.Cells("Recorte").Value = True
                    Row.DefaultCellStyle.BackColor = Color.Yellow
                    resultado = 1
                End If
            ElseIf Row.Cells("Nota_ides").Value = 0 Then
                Row.Cells("Recorte").Value = False
                resultado = 0
            End If
        Next
        Label2.BackColor = Color.Transparent
    End Sub
    Private Sub DataGridView1_CurrentCellDirtyStateChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataGridView1.CurrentCellDirtyStateChanged
        If DataGridView1.IsCurrentCellDirty Then
            DataGridView1.CommitEdit(DataGridViewDataErrorContexts.Commit)
        End If
    End Sub
    Private Sub Button2_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnadmpro.Click
        Temas.Show()
        Me.Hide()
    End Sub
    Private Sub pdf_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pdf.Click
        seltema.Show()
        Me.Hide()
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnregresar.Click
        Close()
        Proyectos.Show()
    End Sub


    Private Sub Button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ftemas.Click
        j = 0
        FlowLayoutPanel1.Size = New Point(280, 420)
    End Sub

    Private Sub Button4_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        o = 1
        TextBox1.Text = ""
        cin = ""
        For Each row As DataGridViewRow In DataGridView2.Rows
            If row.Cells(0).Value = True Then
                j = j + 1
            End If
        Next
        If j >= 1 Then
            For Each row As DataGridViewRow In DataGridView2.Rows
                If row.Cells(0).Value = True Then
                    TextBox1.Text = TextBox1.Text + "'" + row.Cells(1).EditedFormattedValue.ToString + "'" + ","
                End If
            Next
            cin = Mid(TextBox1.Text, 1, Len(TextBox1.Text) - 1)
            fecha = DateTimePicker1.Value.ToString("yyyy/MM/dd")
            Dim cadenaconexion As String = ("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")
            Dim cone As New SqlConnection()
            Dim comando As New SqlCommand()
            Dim dr As SqlDataReader
            con.ConnectionString = cadenaconexion
            comando.Connection = con
            comando.CommandText = "Select nvnt.Tema_id" & _
            ",nt.Nombre as Tema" & _
            ",cm.Nombre as Medio" & _
            ",ntas.Titulo,nvnt.Display" & _
            ",ntas.Nota_id" & _
            ",(Select COUNT(*) from RecortesTestigosNotas as rtn Where rtn.Nota_id=ntas.Nota_id) as Recortes" & _
            ",isnull(ctrrec.Nota_id,0) as Nota_ides" & _
            ",isNull(cu.Nombre,'S/A') as Nombre" & _
            " from NV_NotasTemas as nvnt" & _
            " inner join notas as ntas on ntas.Nota_id = nvnt.Nota_id" & _
            " inner join Cat_Medios as cm on cm.Medio_Id = ntas.Medio_Id" & _
            " inner join AdminRecortesTemas as art on art.Tema_id = nvnt.Tema_id" & _
            " inner join NV_Temas as nt On nt.Tema_id = nvnt.Tema_id" & _
            " left join AdminRecortesProceso as ctrrec on ctrrec.Nota_id = nvnt.Nota_id and ctrrec.Tema_id = nvnt.Tema_id" & _
        " left join Cat_Usuarios as cu On cu.Usuario_Id = ctrrec.Usuario_id" & _
            " Where(nvnt.Display >= 0)" & _
            "and nvnt.FechaPublicacion between '" & fecha & "' and  '" & fecha & "'" & _
        "and nvnt.Tema_id in (Select Tema_id from AdminRecortesTemas Where Proyecto_id = '" & iProyecto_Id & "')" & _
        "and nt.Nombre in(" & cin & ")" & _
        "and cm.TipoMedio_id=1" & _
            "Order by art.Orden"
            comando.CommandType = CommandType.Text
            con.Open()
            DataGridView1.Rows.Clear()
            dr = comando.ExecuteReader()
            While (dr.Read())
                Dim renglon As Integer = (DataGridView1.Rows.Add())
               DataGridView1.Rows(renglon).Cells("Tema_id").Value = dr.GetInt32(dr.GetOrdinal("Tema_id")).ToString()
                DataGridView1.Rows(renglon).Cells("Tema").Value = dr.GetString(dr.GetOrdinal("Tema"))
                DataGridView1.Rows(renglon).Cells("Medio").Value = dr.GetString(dr.GetOrdinal("Medio"))
                DataGridView1.Rows(renglon).Cells("Titulo").Value = dr.GetString(dr.GetOrdinal("Titulo"))
                DataGridView1.Rows(renglon).Cells("Display").Value = dr.GetInt32(dr.GetOrdinal("Display")).ToString()
                DataGridView1.Rows(renglon).Cells("Nota_id").Value = dr.GetInt64(dr.GetOrdinal("Nota_id")).ToString()
                DataGridView1.Rows(renglon).Cells("Recortes").Value = dr.GetInt32(dr.GetOrdinal("Recortes")).ToString()
                DataGridView1.Rows(renglon).Cells("Nombre").Value = dr.GetString(dr.GetOrdinal("Nombre"))
                DataGridView1.Rows(renglon).Cells("Nota_ides").Value = dr.GetInt64(dr.GetOrdinal("Nota_ides")).ToString()
                End While
            con.Close()

            With DataGridView1
                .Columns("Tema_id").Visible = False
                .Columns("Display").Visible = False
                .Columns("Nota_id").Visible = False
                .Columns("Nota_ides").Visible = False
                .Columns("Tema").DisplayIndex = 0
                .Columns("Tema").Width = 170
                .Columns("Medio").DisplayIndex = 1
                .Columns("Medio").Width = 125
                .Columns("Titulo").DisplayIndex = 2
                .Columns("Titulo").Width = 250
                .Columns("Publicar").DisplayIndex = 3
                .Columns("Recorte").DisplayIndex = 4
                .Columns("Recortes").Width = 54
                .Columns("Recortes").DefaultCellStyle.Alignment = 2
                .Columns("Recortes").DisplayIndex = 5
                .Columns("Recortes").Visible = False
            End With
            Label2.BackColor = Color.Transparent
            For Each Row2 As DataGridViewRow In DataGridView1.Rows
                If Row2.Cells("Display").Value >= 1 Then
                    Row2.Cells("Publicar").Value = True
                    resultado = 1
                ElseIf Row2.Cells("Display").Value = 0 Then
                    Row2.Cells("Publicar").Value = False
                    resultado = 0
                End If
            Next
            For Each Row2 As DataGridViewRow In DataGridView1.Rows
                If Row2.Cells(1).Value = True Then
                    If Row2.Cells("Nota_ides").Value >= 1 Then
                        Row2.Cells("Recorte").Value = True
                        Row2.DefaultCellStyle.BackColor = Color.Yellow
                        resultado = 1
                    End If
                ElseIf Row2.Cells("Nota_ides").Value = 0 Then
                    Row2.Cells("Recorte").Value = False
                    resultado = 0
                End If
            Next
           
            FlowLayoutPanel1.Size = New Point(0, 0)
        Else
            MsgBox("Escoja un Tema Porfavor")
        End If
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click
        FlowLayoutPanel1.Size = New Point(0, 0)
    End Sub

    Private Sub vernota_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles vernota.Click
        Ver_Nota.Text = "Nota Id " + DataGridView1.CurrentRow.Cells("Nota_id").Value
        Ver_Nota.TextBox3.Text = "Nota Id " + DataGridView1.CurrentRow.Cells("Nota_id").Value
        Ver_Nota.TextBox4.Text = NotasTemas.iProyecto_Id
        Ver_Nota.Show()
    End Sub

    Private Sub no_notas_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles no_notas.Click
        For Each gt As DataGridViewRow In DataGridView1.Rows
            If gt.Cells("Tema").Value = DataGridView1.CurrentRow.Cells("Tema").Value Then
                nts += 1
            End If
        Next
        MsgBox(nts, vbInformation, "No. Notas")
    End Sub
End Class