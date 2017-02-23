Imports System.Data.SqlClient
Public Class Alta_P
    Dim cn As New SqlConnection("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")
    Private dragBoxFromMouseDown As Rectangle
    Private rowIndexFromMouseDown As Integer
    Private rowIndexOfItemUnderMouseToDrop As Integer
    Dim col As New DataGridViewColumn
    Dim b, d, g As Integer
    Private Sub Alta_P_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'TODO: This line of code loads data into the 'DataSetTemas1.NV_Temas' table. You can move, or remove it, as needed.
        Me.NV_TemasTableAdapter.Fill(Me.DataSetTemas1.NV_Temas)
        Me.DataGridView1.DataSource = DataSetTemas1.Tables(0)

        gorden.Enabled = False
        quitar.Enabled = False
        GroupBox1.ForeColor = Color.White



        Dim Proyecto_Id As Integer
        Dim id As New SqlCommand("select max(Proyecto_Id + 1) from AdminRecortes", cn)
        cn.Open()
        Proyecto_Id = Convert.ToInt32(id.ExecuteScalar())
        cn.Close()
        ProyectoId.Text = Proyecto_Id

        'Clonar o...
        'Reproducir la estructura del 1er dataGrid en DataGridView2
        Me.DataGridView2.ColumnCount = Me.DataGridView1.ColumnCount
        For x As Integer = 0 To Me.DataGridView1.ColumnCount - 1
            Me.DataGridView2.Columns(x).Name = Me.DataGridView1.Columns(x).Name
            Me.DataGridView2.Columns(x).HeaderText = Me.DataGridView1.Columns(x).HeaderText
        Next
    End Sub

    Private Sub txtobs_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtobs.TextChanged
        If txtobs.TextLength > 200 Then
            MsgBox("El Nombre no debe rebasar mas de 200 caracteres")
            txtobs.Text = ""
        End If
    End Sub

    Private Sub txtnombre_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtnombre.TextChanged
        If txtnombre.TextLength > 50 Then
            MsgBox("El Nombre no debe rebasar mas de 50 caracteres")
            txtnombre.Text = ""
        End If
    End Sub

    Private Sub buscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles buscar.Click
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

    End Sub

    Private Sub guardar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles guardar.Click
        If txtnombre.Text = "" Then
            MsgBox("Inserta Nombre de Proyecto")
            txtnombre.Focus()
        ElseIf txtobs.Text = "" Then
            MsgBox("Inserta las Observaciones por Favor")
            txtobs.Focus()
        ElseIf g = 0 Then
            MsgBox("Es Necesario que Guarde el Orden")
        Else
            Dim Proyecto_Id As Integer
            Dim id As New SqlCommand("select max(Proyecto_Id) from AdminRecortes", cn)
            cn.Open()

            Proyecto_Id = Convert.ToInt32(id.ExecuteScalar())
            cn.Close()
            Try

                Dim con As New SqlCommand("insertar_Adminrecortes", cn)
                'Dim con As New SqlCommand("insert into AdminRecortes (Proyecto_id,Nombre,Observaciones,MediosExcluir,MediosIncluir,Orden) values  (@Proyecto_Id,@Nombre,@observaciones,@MediosExcluir,@MediosIncluir,@Orden)", cn)
                con.CommandType = CommandType.StoredProcedure
                con.Parameters.AddWithValue("@Proyecto_id", CInt(Proyecto_Id))
                'con.Parameters.Add("@Proyecto_id", SqlDbType.Int).SqlValue = Proyecto_Id
                con.Parameters.AddWithValue("@Nombre", CStr(txtnombre.Text))
                con.Parameters.AddWithValue("@observaciones", CStr(txtobs.Text))
                ' con.Parameters.AddWithValue("@MediosExcluir", CStr(DataGridView2.Item(2, DataGridView2.CurrentRow.Index).Value))
                'con.Parameters.AddWithValue("@MediosIncluir", CStr(DataGridView2.Item(2, DataGridView2.CurrentRow.Index).Value))
                ' con.Parameters.AddWithValue("@orden", SqlDbType.Int).SqlValue = Label4.Text

                cn.Open()
                con.ExecuteNonQuery()
                cn.Close()

                'Dim con As New SqlCommand(" insert into AdminRecortes values('" & Proyecto_Id + 1 & "','" & txtnombre.Text & "','" & dtpfecha.Text & "','" & txtobs.Text & "')", cn)

                'Dim cmd As New SqlCommand("Insert Into AdminRecortes (Proyecto_Id, Nombre,Fecha,Observaciones) values('" & Proyecto_Id + 1 & "','" & txtnombre.Text & "','" & dtpfecha.Text & "','" & txtobs.Text & "')", cn)

                MsgBox("Registrado", MsgBoxStyle.Exclamation, "Inserción")


            Catch ex As Exception
                '   MsgBox(ex.Message)
            End Try
            b = (+1)
        End If
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

    Sub CopiarSeleccionadosDGV1aDGV2()
        For Each Seleccion As DataGridViewRow In DataGridView1.SelectedRows
            Me.DataGridView2.Rows.Add(ObtenerValoresFila(Seleccion)) 'agrega valores a dgv2
        Next
        DataGridView1.ClearSelection()
        DataGridView1.CurrentRow.DefaultCellStyle.BackColor = Color.Coral
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

    Private Sub regresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles regresar.Click
        If b > 0 Then
            Temas.Show()
            Temas.AdminRecortesTableAdapter.Fill(Temas.DataSetAdminRecortes.AdminRecortes)
            Me.Hide()

        ElseIf txtnombre.Text = "" And txtobs.Text = "" Then
            Temas.Show()
            Temas.AdminRecortesTableAdapter.Fill(Temas.DataSetAdminRecortes.AdminRecortes)
            Me.Hide()

        Else
            MsgBox("Guarde los Datos")
        End If
    End Sub

    Private Sub quitar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles quitar.Click
        If DataGridView2.CurrentRow.Selected = True Then
            eliminarfilaDGV2()
        Else
            MsgBox("Selecciona el elemento que deseas Excluir")
        End If
    End Sub

    Private Sub gorden_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles gorden.Click
        g = (+1)
        quitar.Enabled = False
        Dim cantRegistros As Integer = DataGridView2.Rows.Count
        Dim Proyecto_Id As Integer
        '   Label4.Text
        Dim id As New SqlCommand("select max(Proyecto_Id + 1) from AdminRecortes", cn)
        cn.Open()
        Proyecto_Id = Convert.ToInt32(id.ExecuteScalar())
        cn.Close()
        numerar()

        For Each row As DataGridViewRow In DataGridView2.Rows
            Dim sqltema As New SqlCommand("insertar_AdminrecortesTemas", cn)

            'Dim sqltema As New SqlCommand("insert into AdminRecortesTemas(Proyecto_id,Tema_id)values(@Proyecto_Id ,@Tema_Id)", cn)
            sqltema.CommandType = CommandType.StoredProcedure

            sqltema.Parameters.AddWithValue("@Tema_Id", CInt(row.Cells(0).Value))
            sqltema.Parameters.AddWithValue("@Orden", CInt(row.Cells(4).Value))
            sqltema.Parameters.AddWithValue("@Proyecto_Id", CInt(ProyectoId.Text))

            cn.Open()
            sqltema.ExecuteNonQuery()
            cn.Close()
        Next
        MsgBox("Orden Guardado")
        gorden.Enabled = False
    End Sub

    Private Sub DataGridView1_DragDrop(ByVal sender As Object, ByVal e As System.Windows.Forms.DragEventArgs) Handles DataGridView1.DragDrop
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
End Class