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
  Station = "HHP Niznekamskaya"																				
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "D:\PhD.Calculation\Matlab_NSGAII_ES_01.06.2020_All_Cases\maxwell\"
ExternalCircuit = "CC_NoLoadNiznekamskaya.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 14120 ' Core diameter on gap side [mm]																OK
DiaYoke = 14695 ' Core diameter on yoke side [mm]															OK
LengthCore = 1490 ' Stator core length [mm]																	OK
LenghtTurn = 5105 ' One stator winding turn length [mm]													OK
Z1 = 624 ' Numbers of slots [-]																			OK
Bs1 = 33.6 ' Slot wedge maximum width [mm] 																	OK
Bs2 = 26.5 ' Slot body width [mm]																			OK
Hs0 = 126.5 ' Slot opening height [mm] 																		OK
Hs1 = 9 ' Slot wedge height [mm] 																			OK
Hs2 = 1 ' Slot closed bridge height [mm] 																	OK
Hsw = 58.9 ' Stator winding height [mm]																		OK
Bsw = 26.0 ' Stator winding width [mm] 																	OK
Hsw_gap = 1 ' Distance between stator winding and slot bottom [mm] 										OK
Hsw_between = 4 ' Distance between stator windings [mm] 													OK
Alphas1 = PiConst/3 ' Angle base of wedge  [rad] 															OK
AirGap = 17 ' Air gap [mm] 																				OK
Ns = 28 ' Air duct number of stator core [-]																OK
Bs = 7 ' Air duct width of stator core  [mm]																OK
Ksr = .95 ' Stacking factor of stator core [-]																OK
Branches = 2 ' Numbers of branches [-]																		OK
CoilPitch = 5 ' Stator coil pitch [-] 'шаг переменный 1-6-13, в данный момент введено среднее значение		????
SVolt = 13800 ' Stator winding voltage [V]																	OK
SCurrent = 3841 ' Stator winding current [A] I=S/3Uф														OK
Frequency = 50 ' Frequency [Hz]																				OK
ExValue = Array(770, 281600) ' 0.Rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 104 ' Numbers of poles [-]																			OK
RadiusPole = 1172 ' Pole radius [mm]																		OK		
DiaDamper = 20 ' Pole damper diameter [mm] 																OK
LocusDamper = 1157 ' Locus damper radius [mm]																OK
LengthDamper = 1662 ' Damper length [mm]																	OK
AlphaD = 2*PiConst/146.64 ' Angle between dampers [rad]													OK
ShoeWidthMinor = 309 ' Minor pole shoe width [mm]
ShoeWidthMajor = 325 ' Major pole shoe width [mm]																OK
ShoeHeight = 35 ' Pole shoe height [mm]																	OK
PoleWidth = 230 ' Pole body width [mm]																		OK
PoleHeight = 240 ' Pole body height [mm]																	OK
PoleLength = 1440 ' Pole body length [mm]																	OK
SlotPole = 4 ' Numbers of damper slots per pole [-]														OK
SlotPoleOpen = 4 ' Numbers of damper slots per pole with opening width [-]									OK
Bso = 2.2 ' Slot opening width [mm]																		OK
RadiusInRimRotor = 6316.5 ' Inner radius of rotor rim [mm] 'внешний радиус остова ротора					OK
Brw = 64 ' Rotor winding width [mm] 																		OK
Hrw = 190' Rotor winding height [mm] 																		--??--
Srw = 4 ' Distance between rotor winding and pole body [mm]												--??--
Srh = 20 ' Distance between rotor winding and shoe bottom [mm]												--??--
Tsheet = 1.5 ' Sheet thickness [mm]	
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 19 ' Rotor winding for winding parameters[-]													OK
CalArea = 2 ' Rotor poles for calculation [-]																OK
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = -PiConst/Z1/2 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 2 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .2180 ' Calculated rotor active resistance 15 C [ohm]								OK
ResistanceStator_15C = .00619 ' Calculated phase stator active resistance 15 C [ohm]						OK
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 345 ' Rotor voltage [V]																		OK
CurrentRotor = 780 ' Rotor current [A]																	OK
' ---------------------------------------------
WindingTop = Array ("a", "a", "z", "z", "b", "b", "x", "x", "c", "c", "y", "y")							
WindingBottom = Array ("a", "z", "z", "b", "b", "x", "x", "c", "c", "y", "y", "a")
'WindingTop =    Array ("a", "a", "z", "z", "b", "c")							
'WindingBottom = Array ("a", "z", "y", "b", "b", "x")								
' ---------------------------------------------
' Mesh settings
' ---------------------------------------------
MSizeWSt =  10/2 ' Mesh size of stator windings, dampers, diaTooth, poleShoe, band, rotor windings [mm]
MSizeRotBody =  10/2 ' Mesh size of rotor body [mm]
MSizeRimRotOut = 10/2 ' Mesh size of outside rotor rim [mm]
MSizeRimRotIn = 30 ' Mesh size of inside rotor rim [mm]
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
NumberSteps = 4
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