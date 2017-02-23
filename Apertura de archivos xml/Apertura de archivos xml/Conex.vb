Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class Conex

#Region " Variables "
    'Variable que utilizaremos para la conexion
    Private mUsuario As String
    Private mPassword As String
    Private mConSSPI As Boolean = True
    Private mServidor As String
    Private mBaseDatos As String

#End Region

#Region " Propiedades "

    'Propiedades publicas que podrán ser accesadas 
    'desde el form u otra clase
    Public Property Usuario() As String
        Get
            Return mUsuario
        End Get
        Set(ByVal Value As String)
            mUsuario = Value
        End Set
    End Property

    Public Property Password() As String
        Get
            Return mPassword
        End Get
        Set(ByVal Value As String)
            mPassword = Value
        End Set
    End Property
   
    'SSPI indica si queremos la conexion 
    'con Seguridad Integrada
    'En el caso de que ConSSPI sea True no es necesario
    'enviar los datos de usuario y password

    Public Property ConSSPI() As Boolean
        Get
            Return mConSSPI
        End Get
        Set(ByVal Value As Boolean)
            mConSSPI = Value
        End Set
    End Property

    Public Property Servidor() As String
        Get
            Return mServidor
        End Get
        Set(ByVal Value As String)
            mServidor = Value
        End Set
    End Property

    Public Property BaseDatos() As String
        Get
            Return mBaseDatos
        End Get
        Set(ByVal Value As String)
            mBaseDatos = Value
        End Set
    End Property

#End Region

    Private Property cmd As SqlCommand

    'Función privada para el manejo del String de conexion
    Private Function StrConexion() As String

        Try

            Dim strConn As String
            strConn = "Server=" & Servidor & "; " & _
                  "DataBase=" & BaseDatos & "; "


            If ConSSPI Then
                strConn &= "user id=" & Usuario & ";password=" & Password & ";"
            Else
                strConn &= "Integrated Security=SSPI"
            End If

            Return strConn
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    'Funcion a la cual se le envia el query de la 
    'consulta y nos retorna un DataSet
    Public Function ConsultaBD(ByVal pQuery As String) As DataSet
        Try
            Return CreateDataSet(pQuery)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    'Procesa el query y crea el dataset de la consulta
    Public Function CreateDataSet(ByVal strSQL As String) As DataSet
        Try
            'Se crea la conexion a la base de datos.
            Dim sqlConn As New SqlConnection(Me.StrConexion)

            'SqlCommand es utilizado para ejecutar los comandos SQL
            Dim sqlCmd As New SqlCommand(strSQL, sqlConn)

            'Se le define el tiempo de espera en segundos para la consulta,
            'el valor default es 30 segundos.
            'Si una consulta es muy compleja podria ser que dure mucho en retornar los datos,
            'por eso le definimos el tiempo de respuesta en bastantes segundos
            sqlCmd.CommandTimeout = 3600

            'SqlAdapter utiliza el SqlCommand para llenar el Dataset
            Dim sda As New SqlDataAdapter(sqlCmd)

            'Se llena el dataset
            Dim ds As New DataSet
            sda.Fill(ds)

            Dim temporal As String
            temporal = ds.Tables(0).Rows.Item("total").ToString()

            Return (ds)

        Catch ex As Exception
            Throw ex
        End Try
    End Function
  

End Class
