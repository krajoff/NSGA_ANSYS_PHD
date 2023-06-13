' ---------------------------------------------
' Script Recorded by Ansoft Maxwell Version 14.0.0
' 10:00:00  Feb 24, 2018 by Gulay Stanislav 
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
  Station = "HHP Ribinsk"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "D:\PhD.Calculation\Matlab_NSGAII_ES_01.06.2020_All_Cases_v3\maxwell\"
ExternalCircuit = "CC_NoLoadRibinsk.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 11870 ' Core diameter on gap side [mm]
DiaYoke = 12430 ' Core diameter on yoke side [mm]
LengthCore = 1650 ' Stator core length [mm]
LenghtTurn = 5454 ' One stator winding turn length [mm]
Z1 = 648 ' Numbers of slots [-]
Bs1 = 30.3 ' Slot wedge maximum width [mm]
Bs2 = 23.7 ' Slot body width [mm]
Hs0 = 133.4 ' Slot opening height [mm]
Hs1 = 5.5 ' Slot wedge height [mm]
Hs2 = .8 ' Slot closed bridge height [mm]
Hsw = 55.3 ' Stator winding height [mm]
Bsw = 15.9 ' Stator winding width [mm]
Hsw_gap = 4.3 ' Distance between stator winding and slot bottom [mm]
Hsw_between = 11.5 ' Distance between stator windings [mm]
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]
AirGap = 18 ' Air gap [mm]
Ns = 29 ' Air duct number of stator core [-]
Bs = 10 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 2 ' Numbers of branches [-]
CoilPitch = 6 ' Stator coil pitch [-] (1-7-14)
SVolt = 13800 ' Stator winding voltage [V]
SCurrent = 3199 ' Stator winding current [A]
Frequency = 50 ' Frequency [Hz]
ExValue = Array(740, 217200) ' 0.Rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
Nsuns = 7
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 96 ' Numbers of poles [-]
RadiusPole = 892.4 ' Pole radius [mm]
DiaDamper = 18' Pole damper diameter [mm]
LocusDamper = 879 ' Locus damper radius [mm]
LengthDamper = 1792 ' Damper length [mm]
AlphaD = 2*PiConst/98.88 ' Angle between dampers [rad]
ShoeWidthMinor = 275 ' Minor pole shoe width [mm]
ShoeWidthMajor = 275 ' Major pole shoe width [mm]
ShoeHeight = 40 ' Pole shoe height [mm]
PoleWidth = 215 ' Pole body width [mm]
PoleHeight = 270 ' Pole body height [mm]
PoleLength = 1550 ' Pole body length [mm]
SlotPole = 5 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 3 ' Numbers of damper slots per pole with opening width [-]
Bso = 4 ' Slot opening width [mm]
RadiusInRimRotor = 10280/2 ' Inner radius of rotor rim [mm]
Brw = 53 ' Rotor winding width [mm]
Hrw = 227' Rotor winding height [mm]
Srw = 10 ' Distance between rotor winding and pole body [mm]
Srh = 17 ' Distance between rotor winding and shoe bottom [mm]
Tsheet = 1.5 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 20 ' Rotor winding for winding parameters[-]
CalArea = 4 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 3 ' Stator winding is in a clockwise direction [-]
AngleR = 0 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 2 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .252 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .0081 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 10 ' Rotor voltage [V]
CurrentRotor = 770 ' Rotor current [A]
' ---------------------------------------------
WindingTop =    Array ("z", "z", "b", "b", "b", "x", "x", "c", "c", "y", "y", "a", "a", "a", "z", "z", "b", "b", "x", "x", "c", "c", "c", "y", "y", "a", "a")
WindingBottom = Array ("a", "z", "z", "b", "b", "x", "x", "x", "c", "c", "y", "y", "a", "a", "z", "z", "z", "b", "b", "x", "x", "c", "c", "y", "y", "y", "a")
' ---------------------------------------------
' Mesh settings
' ---------------------------------------------
MSizeWSt =  10/2 ' Mesh size of stator windings, dampers, diaTooth, poleShoe, band, rotor windings [mm]
MSizeRotBody =  10/2 ' Mesh size of rotor body [mm]
MSizeRimRotOut = 10/2 ' Mesh size of outside rotor rim [mm]
MSizeRimRotIn = 30/2 ' Mesh size of inside rotor rim [mm]
MSizeDiaYoke = 20/2 ' Mesh size of yoke side [mm]
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
Include("MW_StatorLossesCoefficients") 
Include("MW_MainPart_SplitCore")
Include("MW_Analyze")
Include("MW_R_Fields")
Include("MW_FieldReport_SplitCore")
' ---------------------------------------------
' Save solved values
Include("MW_SolvedValues")