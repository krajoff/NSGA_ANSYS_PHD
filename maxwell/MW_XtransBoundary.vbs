' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
' Delete boundaries to get X
' ----------------------------------------------
Set oModule = oDesign.GetModule("BoundarySetup")
BoundaryArray = oModule.GetBoundaries()
Select Case ubound(BoundaryArray)
  Case 9
    oModule.DeleteBoundaries Array("WindingDamper")	
'	oModule.RevertSetupToInitial "Setup"
'	oProject.Save
'	oDesign.ApplyMeshOps Array("Setup")
End Select