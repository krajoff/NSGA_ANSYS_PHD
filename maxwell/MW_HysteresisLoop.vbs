' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
' 16:06:20  мая 25, 2021
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
Set oProject = oDesktop.SetActiveProject("Project62")
Set oDefinitionManager = oProject.GetDefinitionManager()
oDefinitionManager.EditMaterial "m 270-50A d", Array("NAME:m 270-50A d", "CoordinateSystemType:=",  _
  "Cartesian", "BulkOrSurfaceType:=", 1, Array("NAME:PhysicsTypes", "set:=", Array( _
  "Electromagnetic")), Array("NAME:permeability", "property_type:=", "nonlinear", "BTypeForSingleCurve:=",  _
  "normal", "HUnit:=", "A_per_meter", "BUnit:=", "tesla", "IsTemperatureDependent:=",  _
  false, Array("NAME:BHCoordinates", Array("NAME:DimUnits", "", ""), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  0, 0)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1.5, 0.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3.1, 0.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 4.6, 0.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  6.1, 0.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 7.7, 0.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  9.2, 0.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 10.7, 0.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  12.3, 0.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 13.8, 0.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  15.3, 0.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 16.9, 0.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  18.4, 0.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 19.9, 0.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  21.5, 0.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 23, 0.15)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  24.5, 0.16)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 26.1, 0.17)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  27.6, 0.18)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 29.1, 0.19)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  30.7, 0.2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 32.2, 0.21)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  33.7, 0.22)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 35.3, 0.23)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  36.8, 0.24)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 38.3, 0.25)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  39.9, 0.26)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 41.4, 0.27)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  42.9, 0.28)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 44.5, 0.29)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  46, 0.3)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 46.6, 0.31)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  47.2, 0.32)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 47.8, 0.33)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  48.4, 0.34)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 49, 0.35)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  49.8, 0.36)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 50.7, 0.37)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  51.6, 0.38)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 52.5, 0.39)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  53.4, 0.4)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 54, 0.41)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  54.5, 0.42)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 55, 0.43)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  55.5, 0.44)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 55.9, 0.45)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  56.7, 0.46)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 57.5, 0.47)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  58.4, 0.48)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 59.2, 0.49)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  60, 0.5)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 61, 0.51)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  62, 0.52)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 63, 0.53)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  64, 0.54)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 65, 0.55)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  66, 0.56)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 67, 0.57)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  68, 0.58)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 69, 0.59)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  69.5, 0.6)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 70.4, 0.61)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  71.3, 0.62)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 72.2, 0.63)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  73.1, 0.64)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 74, 0.65)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  74.8, 0.66)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 75.6, 0.67)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  76.4, 0.68)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 77.2, 0.69)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  78, 0.7)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 79.1, 0.71)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  80.2, 0.72)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 81.3, 0.73)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  82.4, 0.74)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 83.5, 0.75)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  84.6, 0.76)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 85.7, 0.77)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  86.8, 0.78)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 87.9, 0.79)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  89, 0.8)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 90.5, 0.81)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  92, 0.82)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 93, 0.83)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  94, 0.84)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 95, 0.85)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  96, 0.86)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 97, 0.87)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  98, 0.88)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 99, 0.89)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  100, 0.9)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 101.2, 0.91)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  102.4, 0.92)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 103.6, 0.93)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  104.8, 0.94)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 106, 0.95)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  107.2, 0.96)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 108.4, 0.97)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  109.6, 0.98)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 110.8, 0.99)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  112, 1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 120, 1.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  122.5, 1.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 124.8, 1.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  127, 1.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 129, 1.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  132, 1.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 134, 1.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  137, 1.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 139, 1.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  142, 1.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 144, 1.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  146, 1.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 149, 1.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  152, 1.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 154, 1.15)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  159, 1.16)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 164, 1.17)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  169, 1.18)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 174, 1.19)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  180, 1.2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 188, 1.21)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  196, 1.22)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 205, 1.23)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  213, 1.24)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 230, 1.25)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  246, 1.26)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 262, 1.27)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  278, 1.28)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 294, 1.29)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  310, 1.3)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 318, 1.31)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  326, 1.32)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 334, 1.33)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  342, 1.34)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 350, 1.35)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  393, 1.36)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 436, 1.37)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  480, 1.38)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 523, 1.39)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  566, 1.4)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 673, 1.41)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  780, 1.42)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 886, 1.43)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  993, 1.44)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1100, 1.45)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1250, 1.46)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1400, 1.47)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1550, 1.48)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1700, 1.49)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1850, 1.5)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2010, 1.51)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2180, 1.52)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2340, 1.53)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2500, 1.54)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2660, 1.55)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2810, 1.56)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2970, 1.57)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3130, 1.58)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 3282, 1.59)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3550, 1.6)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 3910, 1.61)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  4280, 1.62)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 4640, 1.63)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  5000, 1.64)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 5400, 1.65)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  5670, 1.66)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 5940, 1.67)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  6210, 1.68)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 6480, 1.69)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  6750, 1.7)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 7050, 1.71)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  7350, 1.72)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 7640, 1.73)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  7940, 1.74)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 8240, 1.75)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  8830, 1.76)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 9410, 1.77)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  10000, 1.78)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 10540, 1.79)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  11080, 1.8)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 11670, 1.81)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  12270, 1.82)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 12860, 1.83)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  13460, 1.84)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 14050, 1.85)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  14800, 1.86)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 15560, 1.87)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  16350, 1.88)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 17070, 1.89)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  17820, 1.9)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 18530, 1.91)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  19230, 1.92)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 19940, 1.93)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  20640, 1.94)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 21350, 1.95)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  22530, 1.96)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 23710, 1.97)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  24890, 1.98)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 26070, 1.99)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  27250, 2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 29040, 2.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  30820, 2.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 32610, 2.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  34390, 2.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 36180, 2.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  39570, 2.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 42960, 2.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  46340, 2.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 49730, 2.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  53120, 2.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 56270, 2.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  59410, 2.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 62560, 2.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  65700, 2.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 68850, 2.15))), Array("NAME:Temperatures")), "conductivity:=",  _
  "1818100", Array("NAME:magnetic_coercivity", "property_type:=", "VectorProperty", "Magnitude:=",  _
  "0A_per_meter", "DirComp1:=", "1", "DirComp2:=", "0", "DirComp3:=", "0"), Array("NAME:core_loss_type", "property_type:=",  _
  "ChoiceProperty", "Choice:=", "Hysteresis Model"), "core_loss_kh:=", "221", "core_loss_kc:=",  _
  "0.75", "core_loss_ke:=", "0.27", "core_loss_kdc:=", "0", "core_loss_hci:=",  _
  "60A_per_meter", "core_loss_br:=", "1tesla", "mass_density:=", "7800")
oDefinitionManager.EditMaterial "m 270-50A q", Array("NAME:m 270-50A q", "CoordinateSystemType:=",  _
  "Cartesian", "BulkOrSurfaceType:=", 1, Array("NAME:PhysicsTypes", "set:=", Array( _
  "Electromagnetic")), Array("NAME:permeability", "property_type:=", "nonlinear", "BTypeForSingleCurve:=",  _
  "normal", "HUnit:=", "A_per_meter", "BUnit:=", "tesla", "IsTemperatureDependent:=",  _
  false, Array("NAME:BHCoordinates", Array("NAME:DimUnits", "", ""), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  0, 0)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1.5, 0.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3.1, 0.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 4.6, 0.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  6.1, 0.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 7.7, 0.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  9.2, 0.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 10.7, 0.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  12.3, 0.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 13.8, 0.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  15.3, 0.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 16.9, 0.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  18.4, 0.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 19.9, 0.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  21.5, 0.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 23, 0.15)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  24.5, 0.16)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 26.1, 0.17)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  27.6, 0.18)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 29.1, 0.19)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  30.7, 0.2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 32.2, 0.21)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  33.7, 0.22)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 35.3, 0.23)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  36.8, 0.24)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 38.3, 0.25)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  39.9, 0.26)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 41.4, 0.27)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  42.9, 0.28)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 44.5, 0.29)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  46, 0.3)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 46.6, 0.31)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  47.2, 0.32)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 47.8, 0.33)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  48.4, 0.34)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 49, 0.35)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  49.8, 0.36)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 50.7, 0.37)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  51.6, 0.38)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 52.5, 0.39)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  53.4, 0.4)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 54, 0.41)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  54.5, 0.42)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 55, 0.43)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  55.5, 0.44)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 55.9, 0.45)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  56.7, 0.46)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 57.5, 0.47)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  58.4, 0.48)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 59.2, 0.49)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  60, 0.5)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 61, 0.51)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  62, 0.52)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 63, 0.53)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  64, 0.54)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 65, 0.55)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  66, 0.56)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 67, 0.57)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  68, 0.58)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 69, 0.59)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  69.5, 0.6)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 70.4, 0.61)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  71.3, 0.62)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 72.2, 0.63)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  73.1, 0.64)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 74, 0.65)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  74.8, 0.66)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 75.6, 0.67)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  76.4, 0.68)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 77.2, 0.69)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  78, 0.7)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 79.1, 0.71)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  80.2, 0.72)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 81.3, 0.73)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  82.4, 0.74)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 83.5, 0.75)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  84.6, 0.76)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 85.7, 0.77)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  86.8, 0.78)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 87.9, 0.79)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  89, 0.8)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 90.5, 0.81)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  92, 0.82)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 93, 0.83)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  94, 0.84)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 95, 0.85)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  96, 0.86)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 97, 0.87)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  98, 0.88)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 99, 0.89)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  100, 0.9)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 101.2, 0.91)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  102.4, 0.92)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 103.6, 0.93)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  104.8, 0.94)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 106, 0.95)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  107.2, 0.96)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 108.4, 0.97)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  109.6, 0.98)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 110.8, 0.99)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  112, 1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 120, 1.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  122.5, 1.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 124.8, 1.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  127, 1.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 129, 1.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  132, 1.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 134, 1.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  137, 1.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 139, 1.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  142, 1.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 144, 1.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  146, 1.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 149, 1.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  152, 1.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 154, 1.15)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  159, 1.16)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 164, 1.17)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  169, 1.18)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 174, 1.19)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  180, 1.2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 188, 1.21)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  196, 1.22)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 205, 1.23)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  213, 1.24)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 230, 1.25)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  246, 1.26)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 262, 1.27)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  278, 1.28)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 294, 1.29)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  310, 1.3)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 318, 1.31)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  326, 1.32)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 334, 1.33)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  342, 1.34)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 350, 1.35)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  393, 1.36)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 436, 1.37)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  480, 1.38)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 523, 1.39)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  566, 1.4)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 673, 1.41)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  780, 1.42)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 886, 1.43)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  993, 1.44)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1100, 1.45)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1250, 1.46)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1400, 1.47)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1550, 1.48)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1700, 1.49)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1850, 1.5)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2010, 1.51)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2180, 1.52)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2340, 1.53)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2500, 1.54)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2660, 1.55)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2810, 1.56)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2970, 1.57)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3130, 1.58)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 3282, 1.59)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3550, 1.6)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 3910, 1.61)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  4280, 1.62)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 4640, 1.63)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  5000, 1.64)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 5400, 1.65)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  5670, 1.66)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 5940, 1.67)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  6210, 1.68)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 6480, 1.69)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  6750, 1.7)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 7050, 1.71)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  7350, 1.72)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 7640, 1.73)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  7940, 1.74)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 8240, 1.75)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  8830, 1.76)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 9410, 1.77)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  10000, 1.78)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 10540, 1.79)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  11080, 1.8)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 11670, 1.81)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  12270, 1.82)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 12860, 1.83)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  13460, 1.84)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 14050, 1.85)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  14800, 1.86)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 15560, 1.87)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  16350, 1.88)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 17070, 1.89)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  17820, 1.9)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 18530, 1.91)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  19230, 1.92)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 19940, 1.93)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  20640, 1.94)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 21350, 1.95)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  22530, 1.96)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 23710, 1.97)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  24890, 1.98)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 26070, 1.99)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  27250, 2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 29040, 2.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  30820, 2.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 32610, 2.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  34390, 2.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 36180, 2.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  39570, 2.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 42960, 2.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  46340, 2.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 49730, 2.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  53120, 2.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 56270, 2.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  59410, 2.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 62560, 2.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  65700, 2.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 68850, 2.15))), Array("NAME:Temperatures")), "conductivity:=",  _
  "1818100", Array("NAME:magnetic_coercivity", "property_type:=", "VectorProperty", "Magnitude:=",  _
  "0A_per_meter", "DirComp1:=", "1", "DirComp2:=", "0", "DirComp3:=", "0"), Array("NAME:core_loss_type", "property_type:=",  _
  "ChoiceProperty", "Choice:=", "Hysteresis Model"), "core_loss_kh:=", "273", "core_loss_kc:=",  _
  "0.75", "core_loss_ke:=", "0.27", "core_loss_kdc:=", "0", "core_loss_hci:=",  _
  "60A_per_meter", "core_loss_br:=", "1tesla", "mass_density:=", "7800")
oDefinitionManager.EditMaterial "rotor steel", Array("NAME:rotor steel", "CoordinateSystemType:=",  _
  "Cartesian", "BulkOrSurfaceType:=", 1, Array("NAME:PhysicsTypes", "set:=", Array( _
  "Electromagnetic")), Array("NAME:permeability", "property_type:=", "nonlinear", "BTypeForSingleCurve:=",  _
  "normal", "HUnit:=", "A_per_meter", "BUnit:=", "tesla", "IsTemperatureDependent:=",  _
  false, Array("NAME:BHCoordinates", Array("NAME:DimUnits", "", ""), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  0, 0)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 25, 0.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  49, 0.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 74, 0.15)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  98, 0.2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 123, 0.25)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  148, 0.3)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 172, 0.35)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  197, 0.4)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 221, 0.45)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  246, 0.5)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 270, 0.55)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  295, 0.6)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 320, 0.65)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  345, 0.7)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 375, 0.75)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  405, 0.8)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 440, 0.85)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  480, 0.9)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 490, 0.91)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  495, 0.92)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 505, 0.93)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  510, 0.94)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 520, 0.95)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  530, 0.96)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 540, 0.97)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  550, 0.98)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 560, 0.99)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  570, 1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 582, 1.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  595, 1.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 607, 1.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  615, 1.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 630, 1.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  642, 1.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 655, 1.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  665, 1.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 680, 1.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  690, 1.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 703, 1.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  720, 1.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 731, 1.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  748, 1.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 760, 1.15)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  775, 1.16)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 790, 1.17)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  808, 1.18)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 825, 1.19)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  845, 1.2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 860, 1.21)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  880, 1.22)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 900, 1.23)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  920, 1.24)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 940, 1.25)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  960, 1.26)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 992, 1.27)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1015, 1.28)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1045, 1.29)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1080, 1.3)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1112, 1.31)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1145, 1.32)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1175, 1.33)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1220, 1.34)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1260, 1.35)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1300, 1.36)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1350, 1.37)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1393, 1.38)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1450, 1.39)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1490, 1.4)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1530, 1.41)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1595, 1.42)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1645, 1.43)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1700, 1.44)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1750, 1.45)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  1835, 1.46)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 1920, 1.47)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2010, 1.48)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2110, 1.49)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2270, 1.5)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2450, 1.51)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2560, 1.52)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 2710, 1.53)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  2880, 1.54)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 3050, 1.55)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3200, 1.56)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 3400, 1.57)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  3650, 1.58)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 3750, 1.59)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  4000, 1.6)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 4250, 1.61)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  4500, 1.62)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 4750, 1.63)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  5000, 1.64)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 5250, 1.65)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  5580, 1.66)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 5950, 1.67)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  6230, 1.68)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 6600, 1.69)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  7050, 1.7)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 7530, 1.71)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  7950, 1.72)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 8400, 1.73)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  8850, 1.74)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 9320, 1.75)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  9800, 1.76)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 10300, 1.77)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  10800, 1.78)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 11400, 1.79)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  11900, 1.8)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 12400, 1.81)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  13000, 1.82)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 13500, 1.83)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  14100, 1.84)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 14800, 1.85)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  15600, 1.86)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 16200, 1.87)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  17000, 1.88)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 17800, 1.89)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  18800, 1.9)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 19700, 1.91)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  20700, 1.92)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 21500, 1.93)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  22600, 1.94)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 23500, 1.95)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  24500, 1.96)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 25600, 1.97)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  26500, 1.98)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 27500, 1.99)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  29000, 2)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 30200, 2.01)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  31500, 2.02)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 32800, 2.03)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  34200, 2.04)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 36100, 2.05)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  38000, 2.06)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 40000, 2.07)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  42000, 2.08)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 44000, 2.09)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  46000, 2.1)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 48000, 2.11)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  50000, 2.12)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 52000, 2.13)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  54000, 2.14)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 56000, 2.15)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  58000, 2.16)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 60000, 2.17)), Array("NAME:Coordinate", Array("NAME:CoordPoint",  _
  62000, 2.18)), Array("NAME:Coordinate", Array("NAME:CoordPoint", 64000, 2.19))), Array("NAME:Temperatures")), "conductivity:=",  _
  "7690000", Array("NAME:magnetic_coercivity", "property_type:=", "VectorProperty", "Magnitude:=",  _
  "0A_per_meter", "DirComp1:=", "1", "DirComp2:=", "0", "DirComp3:=", "0"), Array("NAME:core_loss_type", "property_type:=",  _
  "ChoiceProperty", "Choice:=", "Hysteresis Model"), "core_loss_kh:=", "4500", "core_loss_kc:=",  _
  "11.96", "core_loss_ke:=", "0", "core_loss_kdc:=", "0", "core_loss_hci:=",  _
  "120A_per_meter", "core_loss_br:=", "1tesla", "mass_density:=", "7800")
