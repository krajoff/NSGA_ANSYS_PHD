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
  Station = "HHP Sao Joao"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "D:\PhD.Calculation\Matlab_NSGAII_ES_01.06.2020_All_Cases_v3\maxwell\"
ExternalCircuit = "CC_NoLoadSaoJoao.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 7100 ' Core diameter on gap side [mm]
LengthCore = 1000 ' Stator core length [mm]
LenghtTurn = 3000 ' One stator winding turn length [mm]
Z1 = 384 ' Numbers of slots [-]
Bs1 = 28.6 ' Slot wedge maximum width [mm]
Bs2 = 22.2 ' Slot body width [mm]  
Hs1 = 6.5 ' Slot wedge height [mm]
Hs2 = .5 ' Slot closed bridge height [mm]
Bsw = Bs2-7.1 ' Stator winding width [mm]
Hsw = 57.4*15.1/Bsw ' Stator winding height [mm]
Hsw_gap = 4.0 ' Distance between stator winding and slot bottom [mm]
Hsw_between = 10.0 ' Distance between stator windings [mm]
Hs0 = 2*Hsw+Hsw_between+Hsw_gap+6.8 ' Slot opening height [mm]
DiaYoke = 7670 ' Core diameter on yoke side [mm]
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]
AirGap = 13 ' Air gap [mm]
Ns = 18 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 1 ' Numbers of branches [-]
CoilPitch = 6 ' Stator coil pitch [-] (1-7-16)
SVolt = 13800 ' Stator winding voltage [V]
SCurrent = 1845 ' Stator winding current [A]
Frequency = 60 ' Frequency [Hz]
ExValue = Array(560, 180000) ' 0.Rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
Nsuns = 8
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 52 ' Numbers of poles [-]
RadiusPole = 1190 ' Pole radius [mm]
DiaDamper = 16.4 ' Pole damper diameter [mm]
LocusDamper = 1177 ' Locus damper radius [mm]
LengthDamper = 1155 ' Damper length [mm]
AlphaD = 2*PiConst/119.27 ' Angle between dampers [rad]
ShoeWidthMinor = 305 ' Minor pole shoe width [mm]
ShoeWidthMajor = 305 ' Major pole shoe width [mm]
ShoeHeight = 40 ' Pole shoe height [mm]
PoleWidth = 235 ' Pole body width [mm]
PoleHeight = 225 ' Pole body height [mm]
PoleLength = 940 ' Pole body length [mm]
SlotPole = 5 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 3 ' Numbers of damper slots per pole with opening width [-]
Bso = 3 ' Slot opening width [mm]
RadiusInRimRotor = 2790 ' Inner radius of rotor rim [mm]
Srw = 5.4 ' Distance between rotor winding and pole body [mm]
Srh = 22.8 ' Distance between rotor winding and shoe bottom [mm]
Hrw = PoleHeight - Srh - 17.2' Rotor winding height [mm]
Brw = 47 ' Rotor winding width [mm]
Tsheet = 1.5 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 22 ' Rotor winding for winding parameters[-]
CalArea = 2 ' 13 is needed. Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = 0 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 2 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .150 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .016 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 110 ' Rotor voltage [V]
CurrentRotor = 535 ' Rotor current [A]
' ---------------------------------------------
WindingTop =    Array ("a", "a", "z", "z", "b", "b", "x", "x", "c", "c", "y", "y") 'fake
WindingBottom = Array ("a", "z", "z", "b", "b", "x", "x", "c", "c", "y", "y", "a") 'fake
' ---------------------------------------------
' Mesh settings
' ---------------------------------------------
MSizeWSt =  5 ' Mesh size of stator windings, dampers, diaTooth, poleShoe, band, rotor windings [mm]
MSizeRotBody =  10 ' Mesh size of rotor body [mm]
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
NumberSteps = 20
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