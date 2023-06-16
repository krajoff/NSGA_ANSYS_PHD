' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
' 14:58:43  ��� 15, 2023
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
Set oProject = oDesktop.SetActiveProject("Project3")
Set oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true, "XCenter:=",  _
  "0mm", "YCenter:=", "1947mm", "ZCenter:=", "0mm", "Radius:=", "2mm", "WhichAxis:=",  _
  "Z", "NumSegments:=", "0"), Array("NAME:Attributes", "Name:=", "Circle1", "Flags:=",  _
  "", "Color:=", "(143 175 143)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SurfaceMaterialValue:=",  _
  "" & Chr(34) & "" & Chr(34) & "", "SolveInside:=", true, "IsMaterialEditable:=",  _
  true, "UseMaterialAppearance:=", false, "IsLightweight:=", false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
  "Circle1"), Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "Coil1_plus"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
  "Coil1_plus"), Array("NAME:ChangedProps", Array("NAME:Color", "R:=", 255, "G:=", 0, "B:=",  _
  0))))
oEditor.DuplicateAlongLine Array("NAME:Selections", "Selections:=", "Coil1_plus", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:DuplicateToAlongLineParameters", "CreateNewObjects:=", true, "XComponent:=",  _
  "0mm", "YComponent:=", "442mm", "ZComponent:=", "0mm", "NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  _
  false), Array("CreateGroupsForNewObjects:=", false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
  "Coil1_plus_1"), Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "Coil1_minus"))))
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=",  _
  "Coil1_plus,Coil1_minus", "NewPartsModelFlag:=", "Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=",  _
  true, "WhichAxis:=", "Z", "AngleStr:=", "90deg", "NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  _
  false), Array("CreateGroupsForNewObjects:=", false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
  "Coil1_minus_1"), Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "Coil2_minus"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
  "Coil1_plus_1"), Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "Coil2_plus"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCmdTab", Array("NAME:PropServers",  _
  "Band:CreateCircle:1"), Array("NAME:ChangedProps", Array("NAME:Radius", "Value:=",  _
  "$DiaYoke/2+100"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCmdTab", Array("NAME:PropServers",  _
  "Band:CreateCircle:1"), Array("NAME:ChangedProps", Array("NAME:Radius", "Value:=",  _
  "$DiaYoke/2+.1"))))
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignWindingGroup Array("NAME:Coil1", "Type:=", "Current", "IsSolid:=",  _
  false, "Current:=", "0mA", "Resistance:=", "0ohm", "Inductance:=", "0nH", "Voltage:=",  _
  "0mV", "ParallelBranchesNum:=", "1")
oModule.AssignCoilGroup Array("Coil1_minus", "Coil1_plus", "Coil2_minus",  _
  "Coil2_plus"), Array("NAME:Coil1_plus", "Objects:=", Array("Coil1_minus",  _
  "Coil1_plus", "Coil2_minus", "Coil2_plus"), "Conductor number:=", "1", "PolarityType:=",  _
  "Positive")
oModule.EditCoil "Coil1_minus", Array("NAME:Coil1_minus", "Conductor number:=", "1", "PolarityType:=",  _
  "Negative")
oModule.AddCoilstoWinding Array("NAME:AddTerminalsToWinding", Array("NAME:BoundaryList", Array("NAME:Coil1_minus", "Objects:=", Array( _
  "Coil1_minus"), "ParentBndID:=", "Coil1", "Conductor number:=", "1", "Winding:=",  _
  "Coil1", "PolarityType:=", "Negative"), Array("NAME:Coil1_plus", "Objects:=", Array( _
  "Coil1_plus"), "ParentBndID:=", "Coil1", "Conductor number:=", "1", "Winding:=",  _
  "Coil1", "PolarityType:=", "Positive")))
oModule.AssignWindingGroup Array("NAME:Coil2", "Type:=", "Current", "IsSolid:=",  _
  false, "Current:=", "0mA", "Resistance:=", "0ohm", "Inductance:=", "0nH", "Voltage:=",  _
  "0mV", "ParallelBranchesNum:=", "1")
oModule.AddCoilstoWinding Array("NAME:AddTerminalsToWinding", Array("NAME:BoundaryList", Array("NAME:Coil2_minus", "Objects:=", Array( _
  "Coil2_minus"), "ParentBndID:=", "Coil2", "Conductor number:=", "1", "Winding:=",  _
  "Coil2", "PolarityType:=", "Positive"), Array("NAME:Coil2_plus", "Objects:=", Array( _
  "Coil2_plus"), "ParentBndID:=", "Coil2", "Conductor number:=", "1", "Winding:=",  _
  "Coil2", "PolarityType:=", "Positive")))
Set oModule = oDesign.GetModule("MeshSetup")
oModule.AssignLengthOp Array("NAME:Coils", "RefineInside:=", true, "Enabled:=",  _
  true, "Objects:=", Array("Coil1_minus", "Coil1_plus", "Coil2_minus",  _
  "Coil2_plus"), "RestrictElem:=", false, "NumMaxElem:=", "1000", "RestrictLength:=",  _
  true, "MaxLength:=", "0.5mm")
oModule.RenameOp "Coils", "7.Coils"
Set oModule = oDesign.GetModule("ReportSetup")
oModule.CreateReport "Winding Plot 1", "Transient", "Rectangular Plot",  _
  "Setup : Transient", Array("Domain:=", "Sweep"), Array("Time:=", Array("All"), "$DiaGap:=", Array( _
  "Nominal"), "$DiaYoke:=", Array("Nominal"), "$Z1:=", Array("Nominal"), "$Poles:=", Array( _
  "Nominal"), "$Alphas1:=", Array("Nominal"), "$Bs2:=", Array("Nominal"), "$Hs0:=", Array( _
  "Nominal"), "$Hs1:=", Array("Nominal"), "$Hs2:=", Array("Nominal"), "$Hsw:=", Array( _
  "Nominal"), "$Bsw:=", Array("Nominal"), "$Hsw_gap:=", Array("Nominal"), "$Hsw_between:=", Array( _
  "Nominal"), "$AirGap:=", Array("Nominal"), "$Ns:=", Array("Nominal"), "$Bs:=", Array( _
  "Nominal"), "$Ksr:=", Array("Nominal"), "$LengthCore:=", Array("Nominal"), "$LenghtTurn:=", Array( _
  "Nominal"), "$Branches:=", Array("Nominal"), "$RadiusPole:=", Array("Nominal"), "$DiaDamper:=", Array( _
  "Nominal"), "$LocusDamper:=", Array("Nominal"), "$LengthDamper:=", Array( _
  "Nominal"), "$AlphaD:=", Array("Nominal"), "$ShoeWidthMinor:=", Array("Nominal"), "$ShoeWidthMajor:=", Array( _
  "Nominal"), "$ShoeHeight:=", Array("Nominal"), "$PoleWidth:=", Array("Nominal"), "$PoleHeight:=", Array( _
  "Nominal"), "$PoleLength:=", Array("Nominal"), "$SlotPole:=", Array("Nominal"), "$SlotPoleOpen:=", Array( _
  "Nominal"), "$Bso:=", Array("Nominal"), "$Brw:=", Array("Nominal"), "$Hrw:=", Array( _
  "Nominal"), "$Srw:=", Array("Nominal"), "$Srh:=", Array("Nominal"), "$CoilRotor:=", Array( _
  "Nominal"), "$CoilRotorPr:=", Array("Nominal"), "$RadiusInRimRotor:=", Array( _
  "Nominal"), "$CalArea:=", Array("Nominal"), "$Imax:=", Array("Nominal"), "$AngleD:=", Array( _
  "Nominal"), "$NNull:=", Array("Nominal"), "$NumberWSE:=", Array("Nominal"), "$MSizeWSt:=", Array( _
  "Nominal"), "$MSizeRotBody:=", Array("Nominal"), "$MSizeRimRotOut:=", Array( _
  "Nominal"), "$MSizeRimRotIn:=", Array("Nominal"), "$MSizeDiaYoke:=", Array( _
  "Nominal"), "$MSizeAirIn:=", Array("Nominal"), "$AngleR:=", Array("Nominal"), "$MaxAngleR:=", Array( _
  "Nominal"), "$SVolt:=", Array("Nominal"), "$SCurrent:=", Array("Nominal"), "$Frequency:=", Array( _
  "Nominal"), "$GenLength:=", Array("Nominal"), "$ActiveResistanceRotor:=", Array( _
  "Nominal"), "$ActiveResistanceStator:=", Array("Nominal"), "$NoLoadTime:=", Array( _
  "Nominal"), "$TestTime:=", Array("Nominal"), "$VoltageRotor:=", Array("Nominal")), Array("X Component:=",  _
  "Time", "Y Component:=", Array("InducedVoltage(Coil1)", "InducedVoltage(Coil2)")), Array()
