Imports System.Data.Sql
Imports System.Data.SqlClient
Public Class funciones
    Inherits Conexion
    Dim cmd As New SqlCommand
    Public Function validar(ByVal dts As datos1) As Boolean
        Try
            conectado()
            conectado()
            cmd = New SqlCommand("validar")
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@log", dts.gnomusuario)
            cmd.Parameters.AddWithValue("@pas", dts.gpassword)
            Dim dr As SqlDataReader
            dr = cmd.ExecuteReader
            If dr.HasRows = True Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
            Return False
        Finally
            desconectado()
        End Try
    End Function

End Class
