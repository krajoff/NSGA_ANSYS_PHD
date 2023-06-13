' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
' 21:52:05  сен 18, 2019
' ----------------------------------------------
Dim oAnsoftApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oAnsoftApp = CreateObject("Ansoft.ElectronicsDesktop")
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
Set oProject = oDesktop.SetActiveProject("MaxwellProject1")
Set oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _
  "-2.6mm", "YStart:=", "1.2mm", "ZStart:=", "0mm", "Width:=", "0.4mm", "Height:=",  _
  "-0.8mm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Rectangle1", "Flags:=",  _
  "", "Color:=", "(143 175 143)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SurfaceMaterialValue:=",  _
  "" & Chr(34) & "" & Chr(34) & "", "SolveInside:=", true, "IsMaterialEditable:=",  _
  true, "UseMaterialAppearance:=", false, "IsLightweight:=", false)
