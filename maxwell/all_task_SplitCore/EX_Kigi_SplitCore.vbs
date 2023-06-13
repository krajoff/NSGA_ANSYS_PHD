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
  Station = "HHP Kigi"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "D:\PhD.Calculation\Matlab_NSGAII_ES_01.06.2020_All_Cases_v3\maxwell\"
ExternalCircuit = "CC_NoLoadBaksan.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 4000 ' Core diameter on gap side [mm]
DiaYoke = 4840 ' Core diameter on yoke side [mm]
LengthCore = 1300 ' Stator core length [mm]
LenghtTurn = 5562 ' One stator winding turn length [mm]
Z1 = 180 ' Numbers of slots [-]
Bs1 = 31.7 ' Slot wedge maximum width [mm] 
Bs2 = 25.5 ' Slot body width [mm]
Hs0 = 136.6 ' Slot opening height [mm] 
Hs1 = 8 ' Slot wedge height [mm] 
Hs2 = 0.8 ' Slot closed bridge height [mm] 
Hsw = 57.6 ' Stator winding height [mm]
Bsw = 17.9 ' Stator winding width [mm] 
Hsw_gap = 4.9 ' Distance between stator winding and slot bottom [mm] 
Hsw_between = 9.8 ' Distance between stator windings [mm] 
Alphas1 = PiConst/3 ' Angle base of wedge  [rad] 
AirGap = 21 ' Air gap [mm] 
Ns = 24 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 1 ' Numbers of branches [-]
CoilPitch = 11.5 ' Stator coil pitch [-]
SVolt = 13800 ' Stator winding voltage [V]
SCurrent = 2134 ' Stator winding current [A] I=S/3Uф
Frequency = 50 ' Frequency [Hz]
ExValue = Array(410, 263100) ' 0.rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
Nsuns = 7
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 16 ' Numbers of poles [-]
RadiusPole = 1326 ' Pole radius [mm]
DiaDamper = 18.3 ' Pole damper diameter [mm] 
LocusDamper = 1307 ' Locus damper radius [mm]
LengthDamper = 1444 ' Damper length [mm]
AlphaD = 2*PiConst/117.3 ' Angle between dampers [rad]
ShoeWidthMinor = 575 ' Minor pole shoe width [mm]
ShoeWidthMajor = 575 ' Major pole shoe width [mm] 
ShoeHeight = 80 ' Pole shoe height [mm]
PoleWidth = 445 ' Pole body width [mm]
PoleHeight = 285 ' Pole body height [mm]
PoleLength = 1310 ' Pole body length [mm]
SlotPole = 8 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 4 ' Numbers of damper slots per pole with opening width [-]
Bso = 4 ' Slot opening width [mm]
RadiusInRimRotor = 1205 ' Inner radius of rotor rim [mm] 'внешний радиус остова ротора
Brw = 60 ' Rotor winding width [mm] 
Hrw = 247.4' Rotor winding height [mm] 
Srw = 6 ' Distance between rotor winding and pole body [mm] 'сумма изоляции с чертежа 5BS.631.384
Srh = 14.88 ' Distance between rotor winding and shoe bottom [mm]
Tsheet = 2.0 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 46 ' Rotor winding for winding parameters[-]
CalArea = 4 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = 0 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 0 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .171 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .00835 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 400 ' Rotor voltage [V]
CurrentRotor = 425 ' Rotor current [A]
' ---------------------------------------------
WindingTop = Array ("x", "x", "c", "c", "c", "c", "y", "y", "y", "a", "a", "a", "a", "z", "z", "z", "z", "b", "b", "b", "b", "x", "x", "x", "c", "c", "c", "c", "y", "y", "y", "y", "a", "a", "a", "a", "z", "z", "z", "b", "b", "b", "b", "a", "a")
WindingBottom = Array ("x", "x", "x", "x", "c", "c", "c", "c", "y", "y", "y", "y", "a", "a", "a", "z", "z", "z", "z", "b", "b", "b", "b", "x", "x", "x", "x", "c", "c", "c", "y", "y", "y", "y", "a", "a", "a", "a", "z", "z", "z", "z", "b", "b", "b")
' ---------------------------------------------
' Mesh settings
' ---------------------------------------------
MSizeWSt =  10 ' Mesh size of stator windings, dampers, diaTooth, poleShoe, band, rotor windings [mm]
MSizeRotBody =  10 ' Mesh size of rotor body [mm]
MSizeRimRotOut = 10 ' Mesh size of outside rotor rim [mm]
MSizeRimRotIn = 30 ' Mesh size of inside rotor rim [mm]
MSizeDiaYoke = 20 ' Mesh size of yoke side [mm]
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