'Imports System.Data.SqlClient

Module General
    
    Public Sub EffectIn()
        Dim Effect As Double
        For Effect = 0.0 To 1.1 Step 0.1
            Login.Opacity = Effect
            Login.Refresh()
            Threading.Thread.Sleep(100)
        Next
    End Sub
    Public Sub EffectOut()
        Dim Effect As Double
        For Effect = 1.1 To 0.0 Step -0.1
            Login.Opacity = Effect
            Login.Refresh()
            Threading.Thread.Sleep(100)
        Next
    End Sub


End Module
