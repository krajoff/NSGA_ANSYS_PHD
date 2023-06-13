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
  Station = "HHP Chirkeiskay"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "F:\Matlab_NSGAII_ES_26.06.2021_All_Cases_v5\maxwell\"
ExternalCircuit = "CC_NoLoadChirkeiskay.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry:
' ---------------------------------------------
DiaGap = 8960 ' Core diameter on gap side [mm]
LengthCore = 2330 ' Stator core length [mm]
LenghtTurn = 8440 ' One stator winding turn length [mm]
Z1 = 450 ' Numbers of slots [-]
Bs1 = 28.7 ' Slot wedge maximum width [mm] $Bs2+2*$Hs1*0.4330127019
Bs2 = 23.1 ' Slot body width [mm]
Hs1 = 13 ' Slot wedge height [mm]
Hs2 = 1.0 ' Slot closed bridge height [mm]
Bsw = Bs2 - 8.1 ' Stator winding width [mm]
Hsw = 10.9*72.6/Bsw' Stator winding height [mm]
Hsw_gap = 6' Distance between stator winding and slot bottom [mm]
Hsw_between = 11 ' Distance between stator windings [mm]
Hs0 = 2*Hsw+Hsw_between+Hsw_gap+5.5 ' Slot opening height [mm]
DiaYoke = 9950 ' Core diameter on yoke side [mm]
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]
AirGap = 21 ' Air gap [mm]
Ns = 43 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 5 ' Numbers of branches [-]
CoilPitch = 13 ' Stator coil pitch [-] (1-13)
SVolt = 15750 ' Stator winding voltage [V]
SCurrent = 11860 ' Stator winding current [A]
Frequency = 50 ' Frequency [Hz]
ExValue = Array(1000, 755635) ' 0.Rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
' ---------------------------------------------
' Rotor geometry 
' ---------------------------------------------
Poles = 30 ' Numbers of poles [-]
RadiusPole = 2453.5 ' Pole radius [mm]
DiaDamper = 20' Pole damper diameter [mm]
LocusDamper = RadiusPole - DiaDamper/2 - 8 ' Locus damper radius [mm]
LengthDamper = 2453.5 ' Damper length [mm]
BetweenDamper = 47 ' Distance between dampers [mm] 52
DamperRatio = BetweenDamper/(2*LocusDamper)
AlphaD = 2*atn(DamperRatio/sqr(-DamperRatio*DamperRatio+1)) ' Angle between dampers [rad]
ShoeWidthMinor = 675 ' Minor pole shoe width [mm]
ShoeWidthMajor = 675 ' Major pole shoe width [mm]
ShoeHeight = 90 ' Pole shoe height [mm]
PoleWidth = 540 ' Pole body width [mm]
PoleHeight = 270 ' Pole body height [mm]
PoleLength = 2180 ' Pole body length [mm]
SlotPole = 12 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 8 ' Numbers of damper slots per pole with opening width [-]
Bso = 3 ' Slot opening width [mm]
RadiusInRimRotor = 3600 ' Inner radius of rotor rim [mm]
Srw = 6 ' Distance between rotor winding and pole body [mm]
Srh = 20 ' Distance between rotor winding and shoe bottom [mm]
Hrw = 22*(5.9+4.0) ' Rotor winding height [mm]
Brw = 80 ' Rotor winding width [mm]
Tsheet = 1.5 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ' ---------------------------------------------
' ' Calculation setting. Boundary setting. Excitation setting
' ' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 22 ' Rotor winding for winding parameters[-]
CalArea = 1 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 1 ' Stator winding is in a clockwise direction [-]
AngleR = 1*(-PiConst/Z1) ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 2 ' Solution type. 0 is x, 1 is x', 2 is x" - initial type of boundary
ResistanceRotor_15C = .1065 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .00114 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 10 ' Rotor voltage [V]
CurrentRotor = 967 ' Rotor current [A]
' ---------------------------------------------
'WindingTop =    Array ("a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c", "c", "c", "c", "c", "y", "y", "y", "y", "y", "a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b")
'WindingBottom = Array ("y", "y", "a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c", "c", "c", "c", "c", "y", "y", "y", "y", "y", "a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b")
'WindingTop =    Array ("a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c", "c", "c", "c", "c", "y", "y", "y", "y", "y")
'WindingBottom = Array ("y", "y", "a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c", "c", "c", "c", "c", "y", "y", "y")
WindingTop =    Array ("a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "b")
WindingBottom = Array ("y", "y", "a", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b")
' ---------------------------------------------
' Mesh settings
' ---------------------------------------------
MSizeWSt = 10 ' Mesh size of stator windings, dampers, diaTooth, poleShoe, band, rotor windings [mm]
MSizeRotBody = 20 ' Mesh size of rotor body [mm]
MSizeRimRotOut = 20 ' Mesh size of outside rotor rim [mm]
MSizeRimRotIn = 40 ' Mesh size of inside rotor rim [mm]
MSizeDiaYoke = 20 ' Mesh size of yoke side [mm]
MSizeAirIn = 100 ' Mesh size of inside air [mm]
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
NumberSteps = 100
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
' Save solved values
Include("MW_SolvedValues")
