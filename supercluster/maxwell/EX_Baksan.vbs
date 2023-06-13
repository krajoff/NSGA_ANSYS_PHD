' ---------------------------------------------
' ANSYS Electronics Desktop script
' Sep 23, 2019 by Gulay Stanislav 
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
  Station = "HHP Baksan"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "C:\Matlab_NSGAII_ES_10.04.2021\maxwell\"
ExternalCircuit = "CC_NoLoadBaksan.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry: (Poles/CalArea)*(LengthCore-Ns*Bs)*10^-3*Ksr=(12/2)*(750-13*7)*10-3*.95=0.003756
' ---------------------------------------------
DiaGap = 2500 ' Core diameter on gap side [mm]
LengthCore = 750 ' Stator core length [mm]
LenghtTurn = 3596 ' One stator winding turn length [mm]
Z1 = 180 ' Numbers of slots [-]
Bs1 = 21.12 ' Slot wedge maximum width [mm]
Bs2 = 16.6 ' Slot body width [mm]
Hs1 = 5.5 ' Slot wedge height [mm]
Hs2 = .5 ' Slot closed bridge height [mm]
Bsw = Bs2 - 5.1 ' Stator winding width [mm]
Hsw = 52*11.5/Bsw' Stator winding height [mm]
Hsw_gap = 2.95 ' Distance between stator winding and slot bottom [mm]
Hsw_between = 6.9 ' Distance between stator windings [mm]
Hs0 = 2*Hsw+Hsw_between+Hsw_gap+5.95 ' Slot opening height [mm]
DiaYoke = 3140 ' Core diameter on yoke side [mm]
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]
AirGap = 13 ' Air gap [mm]
Ns = 13 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 1 ' Numbers of branches [-]
CoilPitch = 12 ' Stator coil pitch [-] (1-13)
SVolt = 6300 ' Stator winding voltage [V]
SCurrent = 916 ' Stator winding current [A]
Frequency = 50 ' Frequency [Hz]
ExValue = Array(350, 37600) ' 0.Rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
' ---------------------------------------------
' Rotor geometry 
' ---------------------------------------------
Poles = 12 ' Numbers of poles [-]
RadiusPole = 970 ' Pole radius [mm]
DiaDamper = 14.4 ' Pole damper diameter [mm]
LocusDamper = 953 ' Locus damper radius [mm]
LengthDamper = 962 ' Damper length [mm]
AlphaD = 2*PiConst/108.86 ' Angle between dampers [rad]
ShoeWidthMinor = 475 ' Minor pole shoe width [mm]
ShoeWidthMajor = 495 ' Major pole shoe width [mm]
ShoeHeight = 65 ' Pole shoe height [mm]
PoleWidth = 315 ' Pole body width [mm]
PoleHeight = 225 ' Pole body height [mm]
PoleLength = 700 ' Pole body length [mm]
SlotPole = 8 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 4 ' Numbers of damper slots per pole with opening width [-]
Bso = 3 ' Slot opening width [mm]
RadiusInRimRotor = 370 ' Inner radius of rotor rim [mm]
Srw = 6 ' Distance between rotor winding and pole body [mm]
Srh = 18 ' Distance between rotor winding and shoe bottom [mm]
Hrw = PoleHeight - Srh - 17 ' Rotor winding height [mm]
Brw = 45 ' Rotor winding width [mm]
Tsheet = 2 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 35 ' Rotor winding for winding parameters[-]
CalArea = 1 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 1 ' Stator winding is in a clockwise direction [-]
AngleR = 0*(-PiConst/Z1) ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 2 ' Solution type. 0 is x, 1 is x', 2 is x" - initial type of boundary
ResistanceRotor_15C = .09 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .01 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 10 ' Rotor voltage [V]
CurrentRotor = 336 ' Rotor current [A]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
WindingTop =    Array ("a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b")
WindingBottom = Array ("a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b", "x", "x")
' ---------------------------------------------
' Mesh settings
' ---------------------------------------------
MSizeWSt = 5 ' Mesh size of stator windings, dampers, diaTooth, poleShoe, band, rotor windings [mm]
MSizeRotBody = 10 ' Mesh size of rotor body [mm]
MSizeRimRotOut = 10 ' Mesh size of outside rotor rim [mm]
MSizeRimRotIn = 30 ' Mesh size of inside rotor rim [mm]
MSizeDiaYoke = 15 ' Mesh size of yoke side [mm]
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
	oProject.SaveAs MainFolder & mid(Station, 5) & mid(IncTitle, 6)  & ".aedt", true
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
' Return X'' or X'
Include("MW_Reactances")
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
