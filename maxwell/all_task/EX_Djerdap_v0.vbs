' ---------------------------------------------
' ANSYS Electronics Desktop script
' May 21, 2020 by Gulay Stanislav 
' ---------------------------------------------
Dim oAnsoftApp, oDesktop, oProject, oDesign, oEditor, oModule
Dim DiaGap, DiaYoke, Bs1, Bs2, Hs0, Hs1, Hs2, Hs, AirGap
Dim Z1, Hsw, Bsw, Hsw_gap, Hsw_between, DiaCal1, Alphas1
Dim Material_stator, Material_rotor, Material_winding, Brw
Dim CoilRotor, Poles, RadiusPole, AlphaD, ShoeWidth, Bso
Dim WindingTop, WindingBottom, DiaDamper, RadiusOutRimRotor
Dim LocusDamper, ShoeHeight, PoleWidth, RadiusInRimRotor
Dim PoleHeight, SlotPole, SlotPoleOpen, Hrw, Srw, Srh, Delete
Dim CurrentTop, CurrentBottom, axColor, byColor, czColor, AngleD
Dim NNull, Imax, MeshOne(), MeshTwo(), MeshThree(), MeshFour()
Dim EdgeIdWR(), EdgeIdDamper(), Branches, SVolt, SCurrent, Frequency 
Dim GenLength
' ---------------------------------------------
' Initial parameters in mm, rad, T, A/m, A
  Station = "HHP Djerdap"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder      = "D:\PhD.Calculation\Matlab_NSGAII_ES_01.06.2020_All_Cases\maxwell\"
ExternalCircuit = "CC_NoLoadDjerdap.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 14190 ' Core diameter on gap side [mm]
DiaYoke = 14880 ' Core diameter on yoke side [mm]
LengthCore = 1750 ' Stator core length [mm]
LenghtTurn = 6105 ' One stator winding turn length [mm]
Z1 = 756 ' Numbers of slots [-]
Bs1 = 32.1 ' Slot wedge maximum width [mm]
Bs2 = 25.9 ' Slot body width [mm]
Hs0 = 169.2 ' Slot opening height [mm]
Hs1 = 7.2 ' Slot wedge height [mm]
Hs2 = 0.8 ' Slot closed bridge height [mm]
Hsw = 75.3 ' Stator winding height [mm]
Bsw = 17.9 ' Stator winding width [mm]
Hsw_gap = 4.1 ' Distance between stator winding and slot bottom [mm]
Hsw_between = 9.2 ' Distance between stator windings [mm]
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]
AirGap = 19 ' Air gap [mm]
Ns = 32 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 3 ' Numbers of branches [-]
CoilPitch = 11 ' Stator coil pitch [-]
SVolt = 15750 ' Stator winding voltage [V]
SCurrent = 7739 ' Stator winding current [A]
Frequency = 50 ' Frequency [Hz]
ExValue = Array(897, 564700) ' 0.rotor current [A], 1.losses [W] 
TypeCore = 0 ' 0 is without joins, 1 is with joins
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 84 ' Numbers of poles [-]
RadiusPole = 1499 ' Pole radius [mm]
DiaDamper = 22.4 ' Pole damper diameter [mm]
LocusDamper = 1483 ' Locus damper radius [mm]
LengthDamper = 2034 ' Damper length [mm]
AlphaD = 2*PiConst/209.38 ' Angle between dampers [rad]
ShoeWidthMinor = 380 ' Minor pole shoe width [mm]
ShoeWidthMajor = 380 ' Major pole shoe width [mm]
ShoeHeight = 50 ' Pole shoe height [mm]
PoleWidth = 290 ' Pole body width [mm]
PoleHeight = 251 ' Pole body height [mm]
PoleLength = 1650 ' Pole body length [mm]
SlotPole = 8 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 6 ' Numbers of damper slots per pole with opening width [-]
Bso = 5 ' Slot opening width [mm]
RadiusInRimRotor = 6150 ' Inner radius of rotor rim [mm]
Brw = 72 ' Rotor winding width [mm]
Hrw = 205.6 ' Rotor winding height [mm]
Srw = 6 ' Distance between rotor winding and pole body [mm]
Srh = 16 ' Distance between rotor winding and shoe bottom [mm]
Tsheet = 1 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing [-]
CoilRotorPr = 18 ' Rotor winding for winding parameters[-]
CalArea = 2 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = -PiConst/Z1 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 2 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .1515 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .00029 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 35.2 ' Rotor voltage [V]
CurrentRotor = 960 ' Rotor current [A]
' ---------------------------------------------
'WindingTop =     Array ("a", "x", "b", "z", "c", "y")
'WindingBottom =  Array ("a", "x", "b", "z", "c", "y")
WindingBottom =  Array ("x", "c", "c", "c", "y", "y", "y", "a", "a", "a", "z", "z", "z", "b", "b", "b", "x", "x")
WindingTop =     Array ("x", "x", "x", "c", "c", "c", "y", "y", "y", "a", "a", "a", "z", "z", "z", "b", "b", "b")
' ---------------------------------------------
' Mesh settings
' ---------------------------------------------
MSizeWSt =  10*0+5 ' Mesh size of stator windings, dampers, diaTooth, poleShoe, band, rotor windings [mm]
MSizeRotBody =  10*0+5 ' Mesh size of rotor body [mm]
MSizeRimRotOut = 10*0+5 ' Mesh size of outside rotor rim [mm]
MSizeRimRotIn = 30 ' Mesh size of inside rotor rim [mm]
MSizeDiaYoke = 20*0+10 ' Mesh size of yoke side [mm]
MSizeAirIn = 75 ' Mesh size of inside air [mm]
' ---------------------------------------------
' Program start. Workbench setting
' ---------------------------------------------
If Solver = 0 then
	Set oAnsoftApp = CreateObject("AnsoftMaxwell.MaxwellScriptInterface")
Else 
	Set oAnsoftApp = CreateObject("Ansoft.ElectronicsDesktop")
End If
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
Set oProject = oDesktop.NewProject
oProject.InsertDesign "Maxwell 2D", "", "Magnetostatic", ""
Set oDesign = oProject.GetActiveDesign()
Set oDefinitionManager = oProject.GetDefinitionManager()
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
Set oModule = oDesign.GetModule("BoundarySetup")
If IncTitle <> "" then
	oProject.SaveAs MainFolder & mid(Station, 1) & mid(IncTitle, 6)  & ".aedt", true
End If
' ---------------------------------------------
' Include sub
' ---------------------------------------------
Sub Include(strScriptName)
  Dim objFSO, objFile
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objFile = objFSO.OpenTextFile(MainFolder & strScriptName & ".vbs")
  ExecuteGlobal objFile.ReadAll()
  objFile.Close
End Sub  
' ---------------------------------------------
' Transient setup: NumberSteps has to be «200»
' ---------------------------------------------
NumberSteps = 200
RtFrq = 1 ' 1 is 20ms; 2 is 10ms
If RtFrq = 1 Then
  TimeStopStr = "20ms"
ElseIf RtFrq = 2 Then
  TimeStopStr = "10ms"    
End If
' ---------------------------------------------
' Included files
' ---------------------------------------------
' Return THD, losses, mass and rotor current. Update 25.09.2019
Include("MW_MainPart")
Include("MW_Analyze")
Include("MW_FieldReport")
' ---------------------------------------------
' Return X''
Include("MW_Reactances")
Include("MW_Analyze")
Include("MW_FieldReport_MVP")
' ---------------------------------------------
' Return X'
Include("MW_XtransBoundary")
Include("MW_Analyze")
Include("MW_FieldReport_MVP")
' ---------------------------------------------
' Return X
Include("MW_NullBoundary")
Include("MW_Analyze")
Include("MW_FieldReport_MVP")
' ---------------------------------------------
' Save solved values
Include("MW_SolvedValues")