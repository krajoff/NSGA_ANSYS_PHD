# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
# 22:14:43 17, 2019
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("MaxwellProject")
# oProject.InsertDesign("Maxwell 2D", "Maxwell2DDesign1", "Magnetostatic", "")
oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.CreateRectangle(
	[
		"NAME:RectangleParameters",
		"IsCovered:="		, True,
		"XStart:="		, "-2.6mm",
		"YStart:="		, "0.6mm",
		"ZStart:="		, "0mm",
		"Width:="		, "0.6mm",
		"Height:="		, "-0.4mm",
		"WhichAxis:="		, "Z"
	], 
	[
		"NAME:Attributes",
		"Name:="		, "Rectangle1",
		"Flags:="		, "",
		"Color:="		, "(143 175 143)",
		"Transparency:="	, 0,
		"PartCoordinateSystem:=", "Global",
		"UDMId:="		, "",
		"MaterialValue:="	, "\"vacuum\"",
		"SurfaceMaterialValue:=", "\"\"",
		"SolveInside:="		, True,
		"IsMaterialEditable:="	, True,
		"UseMaterialAppearance:=", False,
		"IsLightweight:="	, False
	])
