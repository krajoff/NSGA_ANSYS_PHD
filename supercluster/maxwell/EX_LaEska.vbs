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
  Station = "LaEska"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder      = "C:\Matlab_NSGAII_ES_21.05.2020\maxwell\"
ExternalCircuit = "CC_NoLoadLaEska.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 10840 ' Core diameter on gap side [mm]
LengthCore = 3000 ' Stator core length [mm]
LenghtTurn = 9114 ' One stator winding turn length [mm]
Z1 = 648 ' Numbers of slots [-]
Bs1 = 29.2 ' Slot wedge maximum width [mm] $Bs2+2*$Hs1*0.4330127019
Bs2 = 19 ' Slot body width [mm]
Hs1 = 12 ' Slot wedge height [mm]
Hs2 = 1 ' Slot closed bridge height [mm]
Bsw = Bs2-8.1 ' Stator winding width [mm]
Hsw = 10.9*72.6/Bsw ' Stator winding height [mm]
Hsw_gap = 6.45 ' Distance between stator winding and slot bottom [mm]
Hsw_between = 12.9 ' Distance between stator windings [mm]
Hs0 = 2*Hsw+Hsw_between+Hsw_gap+5.75 ' Slot opening height [mm]
DiaYoke = 11820 ' Core diameter on yoke side [mm]
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]
AirGap = 25 ' Air gap [mm]
Ns = 57 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 8 ' Numbers of branches [-]
CoilPitch = 11 ' Stator coil pitch [-] (1 - 12 - 28)
SVolt = 17000 ' Stator winding voltage [V]
SCurrent = 13406 ' Stator winding current [A]
Frequency = 60 ' Frequency [Hz]
ExValue = Array(972, 1526800) ' 0.Rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 48 ' Numbers of poles [-]
RadiusPole = 1780.8 ' Pole radius [mm]
DiaDamper = 16.4 ' Pole damper diameter [mm]
LocusDamper = 1764.6 ' Locus damper radius [mm]
LengthDamper = 3232 ' Damper length [mm]
AlphaD = 2*PiConst/230.99 ' Angle between dampers [rad]
ShoeWidthMinor = 515 ' Minor pole shoe width [mm]
ShoeWidthMajor = 515 ' Major pole shoe width [mm]
ShoeHeight = 70 ' Pole shoe height [mm]
PoleWidth = 390 ' Pole body width [mm]
PoleHeight = 280 ' Pole body height [mm]
PoleLength = 2860 ' Pole body length [mm]
SlotPole = 10 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 6 ' Numbers of damper slots per pole with opening width [-]
Bso = 4 ' Slot opening width [mm]
RadiusInRimRotor = 4470 ' Inner radius of rotor rim [mm]
Srw = (402-390)/2 ' Distance between rotor winding and pole body [mm]
Srh = 20 ' Distance between rotor winding and shoe bottom [mm]
Hrw = PoleHeight-Srh-21 ' Rotor winding height [mm]
Brw = 100 ' Rotor winding width [mm]
Tsheet = 2 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 27 ' Rotor winding for winding parameters[-]
CalArea = 2 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 3 ' Stator winding is in a clockwise direction [-]
AngleR = -11.29*0/5407 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 2 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .2010 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .00093 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 20 ' Rotor voltage [V]
CurrentRotor = 1027  ' Rotor current [A]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
WindingTop =    Array ("b","b", "x","x","x","x","x", "c","c","c","c", "y","y","y","y","y", "a","a","a","a", "z","z","z","z","z", "b","b")
WindingBottom = Array ("x","x","x","x", "c","c","c","c","c", "y","y","y","y", "a","a","a","a","a", "z","z","z","z", "b","b","b","b","b")
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
NumberSteps = 150
RtFrq = 1 ' 1 is 20ms; 2 is 10ms
If RtFrq = 1 Then
  TimeStopStr = "20ms"
ElseIf RtFrq = 2 Then
  TimeStopStr = "10ms"    
End If
' ---------------------------------------------
' Included files
' ---------------------------------------------
' Return THD, losses, mass and rotor current.
Include("MW_MainPart")   	  ' Update 22.05.2020 
Include("MW_Analyze")
Include("MW_FieldReport")
' ---------------------------------------------
' Return X'' or X'
' ---------------------------------------------
Include("MW_Reactances") 	  ' Update 22.05.2020 
Include("MW_Analyze")
Include("MW_FieldReport_MVP") ' Kr, Ns, Bs = 0
' ---------------------------------------------
' Return X
Include("MW_NullBoundary")
Include("MW_Analyze")
Include("MW_FieldReport_MVP") ' Kr, Ns, Bs = 0
' ---------------------------------------------
' Save solved values
Include("MW_SolvedValues")