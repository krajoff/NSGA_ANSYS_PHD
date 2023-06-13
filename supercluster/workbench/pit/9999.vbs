' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
' 22:55:42  сен 15, 2019
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
Set oProject = oDesktop.SetActiveProject("Project5")
Set oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
Set oModule = oDesign.GetModule("ReportSetup")
oModule.ChangeProperty Array("NAME:AllTabs", Array("NAME:Data Filter", Array("NAME:PropServers",  _
  "FFTpLosses:mag(CoreLoss(PoleShoe)):Curve1"), Array("NAME:ChangedProps", Array("NAME:Units", "Value:=",  _
  "kW"))))
