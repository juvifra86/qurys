Imports System.Data.SqlClient
Public Class conexion
    Public Shared con As New SqlConnection("Data Source=SRVMSDBVIR;Initial Catalog=MSCENTRALDB;User ID=captura;Password=operaciones")
    Protected Function conectado()
        Try
            con.Open()
            Return True
        Catch ex As Exception
            'MsgBox(ex.Message)
            Return False
        End Try
    End Function
    Protected Function desconectado()
        Try
            If con.State = ConnectionState.Open Then
                con.Close()
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
            Return False
        End Try
    End Function
End Class
