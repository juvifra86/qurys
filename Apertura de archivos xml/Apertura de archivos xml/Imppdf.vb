Imports System.Data.SqlClient
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports iTextSharp.text.Font
Imports System.IO
Public Class Imppdf
    Dim con As New SqlConnection("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")
    Dim co, ci As New DataSet
    Dim i, col, r, r1, col2, c, indi, l, w, ancho, alto, ancho1, alto1 As Integer
    Dim maxancho As Integer = 620
    Dim maxalto As Integer = 800
    Dim b As Integer = 0
    Dim d As Integer = 0
    Dim temas, term As String
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim oDoc As New iTextSharp.text.Document(PageSize.LETTER)
        Dim pdfw As iTextSharp.text.pdf.PdfWriter
        Dim cb As PdfContentByte
        Dim oImagen, oImagen2, oImagen3 As iTextSharp.text.Image
        Dim fuente As iTextSharp.text.pdf.BaseFont
        Dim nota, notam As String
        Try
            pdfw = PdfWriter.GetInstance(oDoc, New FileStream("" + temas + ".pdf", FileMode.Create, FileAccess.Write, FileShare.None))
            oDoc.Open()
            cb = pdfw.DirectContent
            oDoc.NewPage()
            cb.BeginText()
            fuente = FontFactory.GetFont(FontFactory.COURIER, iTextSharp.text.Font.BOLD, iTextSharp.text.Font.BOLD, iTextSharp.text.BaseColor.BLUE).BaseFont
            cb.SetFontAndSize(fuente, 20)
            cb.SetColorFill(iTextSharp.text.BaseColor.BLACK)
            cb.ShowTextAligned(PdfContentByte.ALIGN_CENTER, "   .:" + temas + ":.", 270, PageSize.LETTER.Height - 150, 0)
            cb.EndText()
            pdfw.Flush()
            Dim logos As iTextSharp.text.Image
            logos = iTextSharp.text.Image.GetInstance("\\srvmsft\images\" + logo.Text + "")
            logos.Alignment = 3
            logos.ScaleAbsolute(70, 70)
            oDoc.Add(New Paragraph(""))
            oDoc.Add(logos)
            Dim tem As New PdfPTable(1)
            tem.SetWidthPercentage({550}, PageSize.A4)
            tem.SpacingBefore = 40
            Dim cell As New PdfPCell(New Phrase("Indice", FontFactory.GetFont("Arial", 20)))
            cell.BackgroundColor = iTextSharp.text.pdf.ExtendedColor.WHITE
            cell.HorizontalAlignment = iTextSharp.text.Element.ALIGN_CENTER
            cell.VerticalAlignment = iTextSharp.text.Element.ALIGN_TOP
            oDoc.Add(New Paragraph(""))
            tem.AddCell(cell)
            Dim ind As New PdfPTable(7)
            ind.SetWidthPercentage({100, 180, 60, 60, 50, 70, 30}, PageSize.A4)
            ind.AddCell(New Paragraph("Medio", FontFactory.GetFont("Arial", 12)))
            ind.AddCell(New Paragraph("Titulo", FontFactory.GetFont("Arial", 12)))
            ind.AddCell(New Paragraph("Fecha", FontFactory.GetFont("Arial", 12)))
            ind.AddCell(New Paragraph("Seccion", FontFactory.GetFont("Arial", 12)))
            ind.AddCell(New Paragraph("Tipo nota", FontFactory.GetFont("Arial", 12)))
            ind.AddCell(New Paragraph("Pagina(s)", FontFactory.GetFont("Arial", 12)))
            ind.AddCell(New Paragraph("No.", FontFactory.GetFont("Arial", 12)))
            oDoc.Add(tem)
            oDoc.Add(ind)
            For a = 0 To col - 2
                con.Open()
                Dim cmd1 As New SqlCommand("sp_clippings")
                cmd1.CommandType = CommandType.StoredProcedure
                cmd1.Connection = con
                cmd1.Parameters.AddWithValue("@PnNota_id", DataGridView1.Rows(a).Cells(0).EditedFormattedValue.ToString)
                Dim dt1 As New DataTable
                Dim da1 As New SqlDataAdapter(cmd1)
                da1.Fill(dt1)
                DataGridView2.DataSource = dt1
                Dim rec As New SqlCommand("Select Count(*) as total from ControlRecortes Where Nota_id = " & DataGridView1.Rows(a).Cells(0).EditedFormattedValue.ToString & " and Tema_id =" & seltema.DataGridView1.CurrentRow.Cells(0).EditedFormattedValue.ToString & "", con)
                r = rec.ExecuteScalar
                con.Close()
                If r > 0 Then
                    b = b + 1
                    Dim table = New PdfPTable(7)
                    table.SetWidthPercentage({100, 180, 60, 60, 50, 70, 30}, PageSize.A4)
                    oImagen = iTextSharp.text.Image.GetInstance("\\srvmsft\images\" + DataGridView1.Rows(a).Cells(15).EditedFormattedValue.ToString + "")
                    oImagen.ScalePercent(30)
                    table.AddCell(oImagen)
                    table.AddCell(New Paragraph(DataGridView1.Rows(a).Cells(1).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 12, BaseColor.BLUE)))
                    table.AddCell(New Paragraph(DataGridView1.Rows(a).Cells(19).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 8)))
                    table.AddCell(New Paragraph(DataGridView1.Rows(a).Cells(17).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 8)))
                    table.AddCell(New Paragraph(DataGridView1.Rows(a).Cells(18).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 8)))
                    table.AddCell(New Paragraph("Pagina(s): " + DataGridView2.Rows(0).Cells(3).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 8)))
                    table.AddCell(New Paragraph(b, FontFactory.GetFont("Calibri", 8)))
                    oDoc.Add(table)
                End If
                dt1.Clear()
                da1.Dispose()
                r = 0
            Next a
            For Me.i = 0 To col - 2
                Dim rec1 As New SqlCommand("Select Count(*) as total from ControlRecortes Where Nota_id = " & DataGridView1.Rows(0).Cells(0).EditedFormattedValue.ToString & " and Tema_id =" & seltema.DataGridView1.CurrentRow.Cells(0).EditedFormattedValue.ToString & "", con)
                con.Open()
                r1 = rec1.ExecuteScalar
                con.Close()
                If r1 > 0 Then
                    d = d + 1
                    oDoc.NewPage()
                    'oDoc.Add(New Paragraph(""))
                    cb.BeginText()
                    cb.SetFontAndSize(fuente, 12)
                    cb.SetColorFill(iTextSharp.text.BaseColor.BLACK)
                    cb.EndText()
                    pdfw.Flush()
                    Dim tablademo As New PdfPTable(2)
                    tablademo.HorizontalAlignment = 0
                    tablademo.SetWidthPercentage({400, 100}, PageSize.A4)
                    tablademo.HorizontalAlignment = 2
                    tablademo.AddCell(New Paragraph(DataGridView1.Rows(0).Cells(1).EditedFormattedValue.ToString, FontFactory.GetFont("Arial", "", False, 14, 1, BaseColor.BLACK, False)))
                    tablademo.AddCell(New Paragraph(d, FontFactory.GetFont("Calibri", 10)))
                    Dim tablademo2 As New PdfPTable(2)
                    tablademo2.HorizontalAlignment = 2
                    tablademo2.SetWidthPercentage({280, 220}, PageSize.A4)
                    tablademo2.AddCell(New Paragraph("Seccion: " + DataGridView1.Rows(0).Cells(17).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 10)))
                    tablademo2.AddCell(New Paragraph("Tipo Nota: " + DataGridView1.CurrentRow.Cells(18).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 10)))
                    Dim tablademo3 As New PdfPTable(1)
                    tablademo3.HorizontalAlignment = 2
                    tablademo3.SetWidthPercentage({500}, PageSize.A4)
                    tablademo3.AddCell(New Paragraph("Autores: " + DataGridView1.Rows(0).Cells(3).EditedFormattedValue.ToString + "," + DataGridView1.Rows(0).Cells(4).EditedFormattedValue.ToString + "," + DataGridView1.Rows(0).Cells(5).EditedFormattedValue.ToString, FontFactory.GetFont("Arial", 10)))
                    Dim tablademo4 As New PdfPTable(1)
                    tablademo4.HorizontalAlignment = 2
                    tablademo4.SetWidthPercentage({500}, PageSize.A4)
                    tablademo4.AddCell(New Paragraph("Fecha de Publicacion: " + DataGridView1.Rows(0).Cells(19).EditedFormattedValue.ToString, FontFactory.GetFont("Calibri", 10)))
                    Dim tablademo5 As New PdfPTable(1)
                    tablademo5.HorizontalAlignment = 2
                    tablademo5.SetWidthPercentage({500}, PageSize.A4)
                    TextBox1.Text = DataGridView1.Rows(0).Cells(2).EditedFormattedValue.ToString
                    nota = TextBox1.Text
                    Dim ter As New SqlCommand("Select Termino from NV_TemasTerminos With (nolock) Where Tema_id ='" & DataGridView1.Rows(0).Cells(10).EditedFormattedValue.ToString & "'", con)
                    con.Open()
                    term = Trim(CStr(ter.ExecuteScalar()))
                    con.Close()
                    'indi = nota.IndexOf(term)
                    ' If indi < 200 Then
                    'notam = Mid(nota, 1, (indi + term.Length + 200))
                    'ElseIf indi > 200 And nota.Length - indi > 200 Then
                    'notam = Mid(nota, (indi - 199), (indi + term.Length + 200))
                    'End If
                    'Dim Y As Integer = notam.Length
                    'indi = 0
                    notam = Mid(nota, 1, 400)
                    Dim notasc As New PdfPCell(New Paragraph("Nota:..." + "*" + notam + "...", FontFactory.GetFont("Calibri", 10)))
                    notasc.HorizontalAlignment = 3
                    tablademo5.AddCell(notasc)
                    'tablademo5.AddCell(New Paragraph("Nota:..." + notam + "...", FontFactory.GetFont("Calibri", 9)))
                    oDoc.Add(tablademo)
                    oDoc.Add(tablademo2)
                    oDoc.Add(tablademo3)
                    oDoc.Add(tablademo4)
                    oDoc.Add(tablademo5)
                    con.Open()
                    Dim cmd1 As New SqlCommand("sp_clippings")
                    cmd1.CommandType = CommandType.StoredProcedure
                    cmd1.Connection = con
                    cmd1.Parameters.AddWithValue("@PnNota_id", DataGridView1.Rows(0).Cells(0).EditedFormattedValue.ToString)
                    Dim dt1 As New DataTable
                    Dim da1 As New SqlDataAdapter(cmd1)
                    da1.Fill(dt1)
                    DataGridView2.DataSource = dt1
                    con.Close()
                    For Me.l = 0 To DataGridView2.RowCount - 2
                        Dim si = DataGridView2.Rows(l).Cells(1).EditedFormattedValue.ToString
                        oImagen3 = iTextSharp.text.Image.GetInstance("\\srvmsft\images\" + DataGridView1.CurrentRow.Cells(15).EditedFormattedValue.ToString + "")
                        oImagen3.ScaleAbsoluteWidth(90) 'Ancho de la imagen
                        oImagen3.ScaleAbsoluteHeight(15) 'Altura de la imagen
                        oImagen3.SetAbsolutePosition(0, 745)
                        oDoc.Add(oImagen3)
                        oImagen2 = iTextSharp.text.Image.GetInstance("\\srvmsft\TestigosWeb\" + si + "")
                        oImagen2.ScaleAbsoluteWidth(90) 'Ancho de la imagen
                        oImagen2.ScaleAbsoluteHeight(100) 'Altura de la imagen
                        oImagen2.SetAbsolutePosition(0, 645)
                        oDoc.Add(oImagen2)
                        oDoc.Add(New Paragraph(""))
                        si = ""
                        nota = ""
                        notam = ""
                        oImagen = Nothing
                        Dim recor As New SqlDataAdapter("Select * from RecortesTestigosNotas Where Imagen_id=" & DataGridView2.Rows(l).Cells(2).EditedFormattedValue.ToString & " and Nota_id =" & DataGridView2.Rows(l).Cells(0).EditedFormattedValue.ToString & " order by orden asc", con)
                        recor.Fill(co, "RecortesTestigosNotas")
                        DataGridView3.DataSource = co.Tables("RecortesTestigosNotas")
                        col2 = DataGridView3.RowCount
                        For o = 0 To DataGridView3.RowCount - 2
                            Dim recorte As iTextSharp.text.Image
                            recorte = iTextSharp.text.Image.GetInstance("\\srvmsft\TestigosWeb\" + DataGridView3.Rows(0).Cells(3).EditedFormattedValue.ToString + "")
                            PictureBox1.Load("\\srvmsft\TestigosWeb\" + DataGridView3.Rows(0).Cells(3).EditedFormattedValue.ToString + "")
                            ancho = PictureBox1.Image.Width
                            alto = PictureBox1.Image.Height
                            '-----------------------------------------------------------------------------
                            'If ancho > maxancho Or alto > maxalto Then
                            'Dim anchodelta, altodelta, alt, anc As Integer
                            'Dim scaleFactor As Double
                            'anchodelta = ancho - maxancho
                            'altodelta = alto - maxalto
                            'If altodelta > anchodelta Then
                            'Scale by the height
                            'scaleFactor = maxalto / alto
                            'Else
                            'Scale by the Width
                            'scaleFactor = maxancho / ancho
                            'End If
                            'anc = scaleFactor * ancho
                            'alt = scaleFactor * alto
                            'recorte.ScaleAbsoluteHeight(alt)
                            'recorte.ScaleAbsoluteWidth(anc)
                            'End If
                            '-------------------------------------------------------------------------------
                            If ancho > maxancho Or alto > maxalto Then
                                ancho1 = 520
                                alto1 = 500
                            ElseIf alto > maxalto Then
                                alto1 = 500
                                ancho1 = ancho
                            ElseIf ancho > maxancho Then
                                ancho1 = 520
                                alto1 = alto
                            Else
                                ancho1 = ancho
                                alto1 = alto
                            End If
                            '-------------------------------------------------------------------------------
                            recorte.ScaleAbsoluteHeight(alto1)
                            recorte.ScaleAbsoluteWidth(ancho1)
                            recorte.SetAbsolutePosition(50, 50)
                            'recorte.Border = Rectangle.ALIGN_CENTER
                            'recorte.BorderColor = BaseColor.BLACK
                            'recorte.BorderWidth = 5.0F
                            oDoc.Add(New Paragraph(""))
                            oDoc.Add(recorte)
                            ancho1 = 0
                            alto1 = 0
                            DataGridView3.Rows.RemoveAt(0)
                            col2 = col2 - 1
                            If col2 > 0 Then
                                oDoc.NewPage()
                            End If
                        Next o
                        col2 = 0
                    Next l
                    co.Dispose()
                    dt1.Clear()
                    da1.Dispose()

                End If
                DataGridView1.Rows.RemoveAt(0)
                DataGridView1.Refresh()
                r1 = 0
            Next i
            oDoc.Close()
            System.Diagnostics.Process.Start("" + temas + ".pdf")
        Catch ex As Exception
            If File.Exists("" + temas + ".pdf") Then
                If oDoc.IsOpen Then oDoc.Close()
                File.Delete("" + temas + ".pdf")
            End If
            Throw New Exception("Error al generar archivo PDF ")
        Finally
            cb = Nothing
            pdfw = Nothing
            oDoc = Nothing
        End Try
        Close()
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        con.Open()
        Dim cmd As New SqlCommand("sp_NotasTemasMenuReporte")
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Connection = con
        Dim tem As String = seltema.DataGridView1.CurrentRow.Cells(0).EditedFormattedValue.ToString
        Dim fecha As String = seltema.DateTimePicker1.Value.ToString("yyyy/MM/dd")
        cmd.Parameters.AddWithValue("@PnTema_id", tem)
        cmd.Parameters.AddWithValue("@PsFechaPublicacion", fecha)
        Dim dt As New DataTable
        Dim da As New SqlDataAdapter(cmd)
        da.Fill(dt)
        DataGridView1.DataSource = dt
        col = DataGridView1.RowCount
        Dim tema As New SqlCommand("select Nombre from NV_Temas where Tema_id='" & DataGridView1.Rows(0).Cells(10).EditedFormattedValue.ToString & "'", con)
        temas = CStr(tema.ExecuteScalar())
        con.Close()
    End Sub
End Class