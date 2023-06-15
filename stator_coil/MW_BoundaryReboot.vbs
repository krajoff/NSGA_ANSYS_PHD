' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
' 11:24:12  июн 05, 2020
' ----------------------------------------------
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.DeleteBoundaries Array("Master")
oModule.DeleteBoundaries Array("Slave")
oModule.AssignMaster Array("NAME:Master", _
  "Edges:=", Array(17), _
  "ReverseV:=", true)
If CalArea mod 2 = 0 Then
  oModule.AssignSlave Array("NAME:Slave", _
    "Edges:=", Array(26), _
    "ReverseU:=", false, _
    "Master:=", "Master", _
    "SameAsMaster:=", true)
Else
  oModule.AssignSlave Array("NAME:Slave", _
    "Edges:=", Array(26), _
    "ReverseU:=", false, _
    "Master:=", "Master", _
    "SameAsMaster:=", false)
End If

