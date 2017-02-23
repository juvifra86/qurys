Imports System.Data.SqlClient
Imports System.Data
Public Class actualizarpro
    Dim cn As New SqlConnection("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;Persist Security Info=True;User ID=captura;Password=operaciones")
    Dim ds As New DataTable
    Dim b, g, dat, t, d1, ORD, agr, d2 As Integer
    Private dragBoxFromMouseDown As Rectangle
    Private rowIndexFromMouseDown As Integer
    Private rowIndexOfItemUnderMouseToDrop As Integer
    Dim logoimagen As String
    Private Sub actualizarpro_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        cn.Open()
        'TODO: This line of code loads data into the 'DataSetTemas1.NV_Temas' table. You can move, or remove it, as needed.
        Me.NV_TemasTableAdapter.Fill(Me.DataSetTemas1.NV_Temas)

        ProyectoId.Visible = True
        With Me.DataGridView3
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .MultiSelect = False
            DataGridView3.Visible = True
        End With
        With Me.DataGridView2
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .MultiSelect = False
        End With


        GroupBox2.Visible = True
        GroupBox4.Visible = True
        GroupBox3.Visible = False
        'dtgv2,btnelim,btnord
        DataGridView2.Visible = False
        gorden.Visible = False
        quitar.Visible = False
        btnagtema.Visible = False


        Dim p As New SqlDataAdapter(" select nv.tema_Id,nv.Nombre,nv.Descripcion,nv.fecha,art.orden,art.Proyecto_Id " & _
                                  " from NV_Temas as nv inner join AdminRecortesTemas as art " & _
                                  " on nv.tema_id=art.tema_Id and art.Proyecto_id='" & Temas.DataGridView1.Item(0, Temas.DataGridView1.CurrentRow.Index).Value & "'", cn)
        p.Fill(ds)
        Me.DataGridView3.DataSource = ds

        Dim se As New SqlCommand("select * from AdminRecortes where Proyecto_Id='" & id.Text & "'", cn)
        Dim da As New SqlDataAdapter(se)
        Dim dta As New DataTable
        da.Fill(dta)
        se.ExecuteNonQuery()
        'Dim imagen = Convert.ToString(se.ExecuteScalar())
        Dim imagen As String = dta.Rows(0)("Logo").ToString

        'Me.pblogo.Image = New System.Drawing.Bitmap("\\srvmsft\Logos\'" & imagen & "'")


        Me.DataGridView2.ColumnCount = Me.DataGridView1.ColumnCount
        For x As Integer = 0 To Me.DataGridView1.ColumnCount - 1
            Me.DataGridView2.Columns(x).Name = Me.DataGridView1.Columns(x).Name
            Me.DataGridView2.Columns(x).HeaderText = Me.DataGridView1.Columns(x).HeaderText
        Next
    End Sub

    Function ObtenerValoresFila(ByVal fila As DataGridViewRow) As String()
        'Dimensionar el array al tamaño de columnas del DGV
        Dim Contenido(Me.DataGridView1.ColumnCount - 1) As String
        'Rellenar el contenido con el valor de las celdas de la fila
        For Ndx As Integer = 0 To Contenido.Length - 1
            Contenido(Ndx) = fila.Cells(Ndx).Value
        Next
        Return Contenido
    End Function

    Sub CopiarSeleccionadosDGV1aDGV2()
        For Each Seleccion As DataGridViewRow In DataGridView1.SelectedRows
            Me.DataGridView2.Rows.Add(ObtenerValoresFila(Seleccion)) 'agrega valores a dgv2
        Next
        DataGridView1.ClearSelection()
        DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.Coral
    End Sub

    Function ObtenerValoresFilaactu(ByVal fila As DataGridViewRow) As String()
        'Dimensionar el array al tamaño de columnas del DGV
        Dim Contenido(Me.DataGridView3.ColumnCount - 1) As String
        'Rellenar el contenido con el valor de las celdas de la fila
        For Ndx As Integer = 0 To Contenido.Length - 1
            Contenido(Ndx) = fila.Cells(Ndx).Value
        Next
        Return Contenido
    End Function

    Sub numerar()
        Dim val As String
        Dim orden As String
        For Each r As DataGridViewRow In DataGridView2.Rows
            r.HeaderCell.Value = (r.Index + 1).ToString()
            val = r.HeaderCell.Value
            r.Cells(4).Value = r.Index + 1.ToString()
            orden = r.Cells(4).Value
            Label4.Text = val
        Next

    End Sub

    Sub CopiarSeleccionadosDGV3aDGV2()
        For Each Seleccion As DataGridViewRow In DataGridView3.Rows
            Me.DataGridView2.Rows.Add(ObtenerValoresFila(Seleccion)) 'agrega valores a dgv3
        Next
        DataGridView3.ClearSelection()
        '  DataGridView3.CurrentRow.DefaultCellStyle.BackColor = Color.Coral
    End Sub

    Sub eliminarfilaDGV3()

        For Each Seleccion As DataGridViewRow In DataGridView3.SelectedRows
            Me.DataGridView3.Rows.Remove(Seleccion) ' elimina seleccion
        Next
        DataGridView3.ClearSelection()

    End Sub
    Sub eliminarfilaDGV2()

        For Each row As DataGridViewRow In DataGridView1.Rows 'recorre data1
            Dim id As String = row.Cells(0).Value.ToString
            If id = DataGridView2.CurrentRow.Cells(0).Value.ToString Then 'compara valores
                row.Cells(0).Selected = True 'los selecciona
                DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.White
                row.Cells(0).Selected = False
            End If
        Next
        For Each Seleccion As DataGridViewRow In DataGridView2.SelectedRows
            Me.DataGridView2.Rows.Remove(Seleccion) ' elimina seleccion
        Next
        DataGridView2.ClearSelection()

    End Sub



    Private Sub txtnombre_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtnombre.TextChanged
        If txtnombre.TextLength > 50 Then
            MsgBox("El Nombre no debe rebasar mas de 50 caracteres")
            txtnombre.Text = ""
        End If
    End Sub

    Private Sub txtobs_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtobs.TextChanged
        If txtobs.TextLength > 200 Then
            MsgBox("El Nombre no debe rebasar mas de 200 caracteres")
            txtobs.Text = ""
        End If
    End Sub

    Private Sub txttema_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txttema.KeyDown
        If e.KeyCode = Keys.Enter Then
            If txttema.Text = "" Then
                MsgBox("Inserta el Nombre del Tema", vbExclamation, "AVISO")
            End If

            If IsNumeric(txttema.Text) = False Then
                Try
                    Me.NV_TemasTableAdapter.FillBy(Me.DataSetTemas1.NV_Temas, txttema.Text)

                    With Me.DataGridView1
                        .SelectionMode = DataGridViewSelectionMode.FullRowSelect
                        .MultiSelect = False
                        DataGridView1.Visible = True
                        quitar.Enabled = True
                        gorden.Enabled = True
                    End With

                    If radio1.Checked = True Then
                        Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio1.Text)
                    ElseIf radio2.Checked = True Then
                        Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio2.Text)
                    ElseIf radio3.Checked = True Then
                        Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio3.Text)
                    ElseIf radio4.Checked = True Then
                        Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio4.Text)
                    ElseIf radio5.Checked = True Then
                        Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio5.Text)
                    End If
                    If DataGridView1.SelectedRows.Count = 0 Then
                        MsgBox("No hay registros")
                    End If

                Catch ex As Exception
                    MessageBox.Show(ex.Message)
                End Try
            ElseIf IsNumeric(txttema.Text) = True Then
                With Me.DataGridView1
                    .SelectionMode = DataGridViewSelectionMode.FullRowSelect
                    .MultiSelect = False
                    DataGridView1.Visible = True
                End With
                Me.NV_TemasTableAdapter.FillBy2(Me.DataSetTemas1.NV_Temas, txttema.Text)
                'MsgBox("es numero")
            End If

        End If
    End Sub

    Private Sub txttema_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txttema.TextChanged
        If txttema.TextLength > 200 Then
            MsgBox("El Nombre no debe rebasar mas de 200 caracteres")
            txttema.Text = ""
        End If
    End Sub

   
    Private Sub buscar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles buscar.Click
        If txttema.Text = "" Then
            MsgBox("Inserta el Nombre del Tema", vbExclamation, "AVISO")
        End If

        If IsNumeric(txttema.Text) = False Then
            Try
                Me.NV_TemasTableAdapter.FillBy(Me.DataSetTemas1.NV_Temas, txttema.Text)

                With Me.DataGridView1
                    .SelectionMode = DataGridViewSelectionMode.FullRowSelect
                    .MultiSelect = False
                    DataGridView1.Visible = True
                    quitar.Enabled = True
                    gorden.Enabled = True
                    btnagtema.Enabled = True
                End With

                If radio1.Checked = True Then
                    Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio1.Text)
                ElseIf radio2.Checked = True Then
                    Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio2.Text)
                ElseIf radio3.Checked = True Then
                    Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio3.Text)
                ElseIf radio4.Checked = True Then
                    Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio4.Text)
                ElseIf radio5.Checked = True Then
                    Me.NV_TemasTableAdapter.FillBy1(Me.DataSetTemas1.NV_Temas, txttema.Text, radio5.Text)
                End If
                If DataGridView1.SelectedRows.Count = 0 Then
                    MsgBox("No hay registros")
                End If

            Catch ex As Exception
                MessageBox.Show(ex.Message)
            End Try
        ElseIf IsNumeric(txttema.Text) = True Then
            With Me.DataGridView1
                .SelectionMode = DataGridViewSelectionMode.FullRowSelect
                .MultiSelect = False
                DataGridView1.Visible = True
            End With
            Me.NV_TemasTableAdapter.FillBy2(Me.DataSetTemas1.NV_Temas, txttema.Text)
            ' MsgBox("Es numero")
        End If
    End Sub

    Private Sub guardar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles guardar.Click
        If txtnombre.Text = "" Then
            MsgBox("Inserta Nombre de Proyecto")
            txtnombre.Focus()
        ElseIf txtobs.Text = "" Then
            MsgBox("Inserta las Observaciones por Favor")
            txtobs.Focus()
            ' ElseIf g = 0 Then
            '    MsgBox("Es Necesario que Guarde el Orden")
        Else
            Temas.AdminRecortesTableAdapter.Editar_AdminRecortes(id.Text, txtnombre.Text, txtobs.Text)
            Temas.AdminRecortesTableAdapter.Fill(Temas.DataSetAdminRecortes.AdminRecortes)

            MsgBox("Se Actualizó Correctamente")
            b = (+1)
        End If
    End Sub

    Private Sub Button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button6.Click

        Dim Mensaje, Estilo, Título, Respuesta, MiCadena

        Mensaje = "No se han guardado Datos desea Salir ?"   ' cuerpo del mensaje.

        Estilo = vbYesNo + vbCritical   ' Define el estilo, los botones, lo que está después del mas es el circulo rojo con la cruz.

        Título = "SALIR"   ' es el título.

        Respuesta = MsgBox(Mensaje, Estilo, Título) 'el paréntesis se pone también

        If Respuesta = vbYes Then   ' El usuario eligió el botón Sí.

            MiCadena = "Sí"   ' Ejecuta una acción.
            Temas.Show()
            Me.Hide()
            Temas.AdminRecortesTableAdapter.Fill(Temas.DataSetAdminRecortes.AdminRecortes)

            For i As Integer = 0 To Me.DataGridView3.RowCount - 1
                Me.DataGridView3.Rows.Remove(Me.DataGridView3.CurrentRow)
            Next
        Else   ' El usuario eligió el botón No.
            Me.Show()

        End If
    End Sub

    Private Sub orden_tema_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles orden_tema.Click
        GroupBox4.Visible = True
        GroupBox3.Visible = False
        'dtgv2,btnelim,btnord
        DataGridView2.Visible = True
        gorden.Visible = True
        quitar.Visible = True
        gorden.Enabled = True
        quitar.Enabled = True
        btnagtema.Visible = False

        If DataGridView2.SelectedRows.Count = 0 And d2 = 0 Then
            GroupBox4.Visible = True
            GroupBox3.Visible = False
            CopiarSeleccionadosDGV3aDGV2()
            'dtgv2,btnelim,btnord
            DataGridView2.Visible = True
            gorden.Visible = True
            quitar.Visible = True
            btnagtema.Visible = False
            DataGridView3.DataSource = ds
        ElseIf DataGridView2.SelectedRows.Count > 0 And d2 > 0 Then
            GroupBox4.Visible = True
            GroupBox3.Visible = False
            'dtgv2,btnelim,btnord
            DataGridView2.Visible = True
            gorden.Visible = True
            quitar.Visible = True
            btnagtema.Visible = False
            DataGridView3.DataSource = ds
        End If
    End Sub

    Private Sub eli_tema_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles eli_tema.Click
        If gorden.Visible = True And quitar.Visible = True And DataGridView2.Visible = True Then
            GroupBox4.Visible = True
            gorden.Visible = False
            quitar.Visible = False
            DataGridView2.Visible = False
        End If
        If GroupBox3.Visible = True And gorden.Visible = True And quitar.Visible = True And DataGridView2.Visible = True Then
            GroupBox4.Visible = True
            gorden.Visible = False
            quitar.Visible = False
            DataGridView2.Visible = False
        End If


        If t > 0 And DataGridView3.CurrentRow.Selected = True Then
            eliminarfilaDGV3()

            For Each row As DataGridViewRow In DataGridView3.Rows
                Dim sqltema As New SqlCommand("Eliminar_RecortesTemas", cn)
                sqltema.CommandType = CommandType.StoredProcedure
                sqltema.Parameters.AddWithValue("@Proyecto_Id", CInt(id.Text))
                DataGridView3.DataSource = ds
                cn.Open()
                sqltema.ExecuteNonQuery()
                cn.Close()
            Next
            For Each row As DataGridViewRow In DataGridView3.Rows
                Dim sqltema As New SqlCommand("insertar_AdminrecortesTemas", cn)

                'Dim sqltema As New SqlCommand("insert into AdminRecortesTemas(Proyecto_id,Tema_id)values(@Proyecto_Id ,@Tema_Id)", cn)
                sqltema.CommandType = CommandType.StoredProcedure

                sqltema.Parameters.AddWithValue("@Tema_Id", CInt(row.Cells(0).Value))
                sqltema.Parameters.AddWithValue("@Orden", CInt(row.Cells(4).Value))
                sqltema.Parameters.AddWithValue("@Proyecto_Id", CInt(id.Text))

                cn.Open()
                sqltema.ExecuteNonQuery()
                cn.Close()
            Next
            MsgBox("Tema Eliminado")
        Else
            MsgBox("Seleccione Tema que Desea eliminar")
            'End If

            '  Else ' USUARIO NO
            GroupBox4.Visible = True
            DataGridView1.Visible = False
            DataGridView2.Visible = False
            gorden.Visible = False
            quitar.Visible = False
            btnagtema.Visible = False
        End If
    End Sub

    Private Sub ag_tema_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ag_tema.Click
        DataGridView2.Visible = True
        btnagtema.Visible = True
        GroupBox4.Visible = False
        GroupBox3.Visible = True
        quitar.Visible = True
        gorden.Visible = True
        quitar.Enabled = False
        gorden.Enabled = False
        DataGridView1.Visible = False

        If DataGridView2.SelectedRows.Count = 0 And d2 = 0 Then
            CopiarSeleccionadosDGV3aDGV2()
            DataGridView2.Visible = True
            btnagtema.Visible = True
            GroupBox4.Visible = False
            GroupBox3.Visible = True
            quitar.Visible = True
            gorden.Visible = True
            quitar.Enabled = True
            gorden.Enabled = True
            DataGridView1.Visible = False

        ElseIf DataGridView2.SelectedRows.Count > 0 And d2 > 0 Then
            DataGridView2.Visible = True
            btnagtema.Visible = True
            GroupBox4.Visible = False
            GroupBox3.Visible = True
            quitar.Enabled = True
            gorden.Enabled = True
            quitar.Visible = True
            gorden.Visible = True
            DataGridView1.Visible = False
        End If


        If DataGridView2.Visible = True And gorden.Visible = True And quitar.Visible = True And GroupBox4.Visible = True Then
            GroupBox4.Visible = False
            GroupBox3.Visible = True
        End If
    End Sub

    Private Sub gorden_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles gorden.Click
        g = (+1)
        numerar()

        For Each row As DataGridViewRow In DataGridView2.Rows
            Dim sqltema As New SqlCommand("Eliminar_RecortesTemas", cn)
            sqltema.CommandType = CommandType.StoredProcedure
            sqltema.Parameters.AddWithValue("@Proyecto_Id", CInt(id.Text))
            DataGridView3.DataSource = ds
            cn.Open()
            sqltema.ExecuteNonQuery()
            cn.Close()
        Next
        For Each row As DataGridViewRow In DataGridView2.Rows
            Dim sqltema As New SqlCommand("insertar_AdminrecortesTemas", cn)

            'Dim sqltema As New SqlCommand("insert into AdminRecortesTemas(Proyecto_id,Tema_id)values(@Proyecto_Id ,@Tema_Id)", cn)
            sqltema.CommandType = CommandType.StoredProcedure

            sqltema.Parameters.AddWithValue("@Tema_Id", CInt(row.Cells(0).Value))
            sqltema.Parameters.AddWithValue("@Orden", CInt(row.Cells(4).Value))
            sqltema.Parameters.AddWithValue("@Proyecto_Id", CInt(id.Text))

            cn.Open()
            sqltema.ExecuteNonQuery()
            cn.Close()
        Next
        MsgBox("Orden Guardado")
        gorden.Enabled = False
        quitar.Enabled = False
    End Sub

    Private Sub quitar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles quitar.Click
        If DataGridView2.CurrentRow.Selected = True Then
            eliminarfilaDGV2()
        Else
            MsgBox("Selecciona el elemento que deseas Excluir")
        End If
    End Sub

    Private Sub btnagtema_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnagtema.Click
        If g > 0 Then
            If DataGridView1.Visible = True Then
                If DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.Coral Then

                    For Each row As DataGridViewRow In DataGridView2.Rows
                        Dim sqltema As New SqlCommand("Eliminar_RecortesTemas", cn)
                        sqltema.CommandType = CommandType.StoredProcedure
                        sqltema.Parameters.AddWithValue("@Proyecto_Id", CInt(id.Text))
                        DataGridView3.DataSource = ds
                        cn.Open()
                        sqltema.ExecuteNonQuery()
                        cn.Close()
                    Next
                    For Each row As DataGridViewRow In DataGridView2.Rows
                        Dim sqltema As New SqlCommand("insertar_AdminrecortesTemas", cn)

                        'Dim sqltema As New SqlCommand("insert into AdminRecortesTemas(Proyecto_id,Tema_id)values(@Proyecto_Id ,@Tema_Id)", cn)
                        sqltema.CommandType = CommandType.StoredProcedure

                        sqltema.Parameters.AddWithValue("@Tema_Id", CInt(row.Cells(0).Value))
                        sqltema.Parameters.AddWithValue("@Orden", CInt(row.Cells(4).Value))
                        sqltema.Parameters.AddWithValue("@Proyecto_Id", CInt(id.Text))

                        cn.Open()
                        sqltema.ExecuteNonQuery()
                        cn.Close()
                    Next
                    MsgBox("Tema Agregado")
                    btnagtema.Enabled = False
                Else
                    MsgBox("Elija Temas a Incluir")
                End If

            End If
        Else
            MsgBox("Se Requiere Guardar El Orden")
            btnagtema.Enabled = True
        End If
    End Sub

    Private Sub DataGridView3_CellClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles DataGridView3.CellClick
        t = (+1)
    End Sub

    Private Sub DataGridView1_DragDrop(ByVal sender As Object, ByVal e As System.Windows.Forms.DragEventArgs) Handles DataGridView1.DragDrop
        ' The mouse locations are relative to the screen, so they must be
        ' converted to client coordinates.
        Dim clientPoint As Point = DataGridView1.PointToClient(New Point(e.X, e.Y))

        ' Get the row index of the item the mouse is below.
        rowIndexOfItemUnderMouseToDrop = DataGridView1.HitTest(clientPoint.X, clientPoint.Y).RowIndex

        If rowIndexOfItemUnderMouseToDrop = -1 Then Exit Sub

        If e.Effect = DragDropEffects.Move Then
            ' Comprobar que existen columnas seleccionadas
            If DataGridView1.SelectedRows.Count > 0 Then
                CopiarSeleccionadosDGV1aDGV2()
            End If

        End If
    End Sub

    Private Sub DataGridView1_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles DataGridView1.MouseDown
        ' Get the index of the item the mouse is below.
        rowIndexFromMouseDown = sender.HitTest(e.X, e.Y).RowIndex
        If rowIndexFromMouseDown = -1 Then Exit Sub
        If rowIndexFromMouseDown <> -1 Then
            ' Remember the point where the mouse down occurred.
            ' The DragSize indicates the size that the mouse can move
            ' before a drag event should be started.               
            Dim dragSize As Size = SystemInformation.DragSize
            ' Create a rectangle using the DragSize, with the mouse position being
            ' at the center of the rectangle.
            dragBoxFromMouseDown = New Rectangle(New Point(e.X - (dragSize.Width / 2), e.Y - (dragSize.Height / 2)), dragSize)
        Else
            ' Reset the rectangle if the mouse is not over an item in the ListBox.
            dragBoxFromMouseDown = Rectangle.Empty
        End If
    End Sub

    Private Sub DataGridView1_MouseMove(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles DataGridView1.MouseMove
        If e.Button = Windows.Forms.MouseButtons.Left Then

            If rowIndexFromMouseDown = -1 Then Exit Sub

            Try
                ' If the mouse moves outside the rectangle, start the drag.
                If dragBoxFromMouseDown <> Rectangle.Empty AndAlso Not dragBoxFromMouseDown.Contains(e.X, e.Y) Then
                    ' Proceed with the drag and drop, passing in the list item.                   
                    Dim dropEffect As DragDropEffects = sender.DoDragDrop(DataGridView1.Rows(rowIndexFromMouseDown), DragDropEffects.Move)
                End If
            Catch ex As Exception
                ex.Data.Clear()
            End Try

        End If
    End Sub

    Private Sub DataGridView2_DragDrop(ByVal sender As Object, ByVal e As System.Windows.Forms.DragEventArgs) Handles DataGridView2.DragDrop
        d2 = (+1)

        ' The mouse locations are relative to the screen, so they must be
        ' converted to client coordinates.
        Dim clientPoint As Point = DataGridView2.PointToClient(New Point(e.X, e.Y))

        ' Get the row index of the item the mouse is below.
        rowIndexOfItemUnderMouseToDrop = DataGridView2.HitTest(clientPoint.X, clientPoint.Y).RowIndex

        If rowIndexOfItemUnderMouseToDrop = -1 Then Exit Sub

        DataGridView2.CurrentRow.DefaultCellStyle.BackColor = Color.LightCyan 'color de fila que se cambia

        If e.Effect = DragDropEffects.Copy Then
            Dim rowToMove As DataGridViewRow

            rowToMove = TryCast(e.Data.GetData(GetType(DataGridViewRow)), DataGridViewRow)

            DataGridView2.Rows.RemoveAt(rowIndexFromMouseDown)
            DataGridView2.Rows.Insert(rowIndexOfItemUnderMouseToDrop, rowToMove)
            ' DataGridView2.Rows.Insert(e.Data.GetData("System.String").ToString)
        End If
    End Sub

    Private Sub DataGridView2_DragOver(ByVal sender As Object, ByVal e As System.Windows.Forms.DragEventArgs) Handles DataGridView2.DragOver
        e.Effect = DragDropEffects.Move
        e.Effect = DragDropEffects.Copy
        With Me.DataGridView2
            .SelectionMode = DataGridViewSelectionMode.FullRowSelect
            .MultiSelect = False
            DataGridView1.Visible = True

        End With
        If DataGridView1.SelectedRows.Count > 0 Then
            CopiarSeleccionadosDGV1aDGV2()
        End If
    End Sub

    Private Sub DataGridView2_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles DataGridView2.MouseDown
        ' Get the index of the item the mouse is below.
        rowIndexFromMouseDown = sender.HitTest(e.X, e.Y).RowIndex
        If rowIndexFromMouseDown = -1 Then Exit Sub
        If rowIndexFromMouseDown <> -1 Then
            ' Remember the point where the mouse down occurred.
            ' The DragSize indicates the size that the mouse can move
            ' before a drag event should be started.               
            Dim dragSize As Size = SystemInformation.DragSize
            ' Create a rectangle using the DragSize, with the mouse position being
            ' at the center of the rectangle.

            dragBoxFromMouseDown = New Rectangle(New Point(e.X - (dragSize.Width / 2), e.Y - (dragSize.Height / 2)), dragSize)
        Else
            'Reset the rectangle if the mouse is not over an item in the ListBox.
            dragBoxFromMouseDown = Rectangle.Empty
        End If
    End Sub

    Private Sub DataGridView2_MouseMove(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles DataGridView2.MouseMove
        If e.Button = Windows.Forms.MouseButtons.Left Then

            If rowIndexFromMouseDown = -1 Then Exit Sub

            Try
                ' If the mouse moves outside the rectangle, start the drag.
                If dragBoxFromMouseDown <> Rectangle.Empty AndAlso Not dragBoxFromMouseDown.Contains(e.X, e.Y) Then
                    ' Proceed with the drag and drop, passing in the list item.                   
                    Dim dropEffect As DragDropEffects = sender.DoDragDrop(DataGridView2.Rows(rowIndexFromMouseDown), DragDropEffects.Copy)


                End If
            Catch ex As Exception
                ex.Data.Clear()
            End Try
            DataGridView2.CurrentRow.Selected = False
        End If
    End Sub

    Private Sub GroupBox2_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GroupBox2.Enter

    End Sub
End Class