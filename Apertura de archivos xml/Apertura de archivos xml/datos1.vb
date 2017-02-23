Public Class datos1
    Dim nomusuario As String
    Dim password As String
    Public Property gnomusuario
        Get
            Return nomusuario
        End Get
        Set(ByVal value)
            nomusuario = value
        End Set
    End Property
    Public Property gpassword
        Get
            Return password
        End Get
        Set(ByVal value)
            password = value
        End Set
    End Property
    Public Sub New(ByVal nomusuario As String, ByVal password As String)
        gnomusuario = nomusuario
        gpassword = password
    End Sub
    Public Sub New()

    End Sub
End Class

