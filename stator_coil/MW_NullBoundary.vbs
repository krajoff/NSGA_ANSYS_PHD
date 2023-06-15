' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2018.1.0
' Delete boundaries to get X
' ----------------------------------------------
Set oModule = oDesign.GetModule("BoundarySetup")
BoundaryArray = oModule.GetBoundaries()
Select Case ubound(BoundaryArray)
  Case 9
    oModule.DeleteBoundaries Array("WindingDamper")
	oModule.DeleteBoundaries Array("WindingRotor")	
  Case 7
  	oModule.DeleteBoundaries Array("WindingRotor")	
End Select