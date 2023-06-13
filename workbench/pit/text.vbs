' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
' 21:39:40  сен 14, 2019
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
Set oProject = oDesktop.GetActiveProject()
Set oDesign = oProject.GetActiveDesign()
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _
  "-1.6mm", "YStart:=", "0.8mm", "ZStart:=", "0mm", "Width:=", "0.5mm", "Height:=",  _
  "-0.4mm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Rectangle1", "Flags:=",  _
  "", "Color:=", "(143 175 143)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SurfaceMaterialValue:=",  _
  "" & Chr(34) & "" & Chr(34) & "", "SolveInside:=", true, "IsMaterialEditable:=",  _
  true, "UseMaterialAppearance:=", false, "IsLightweight:=", false)
