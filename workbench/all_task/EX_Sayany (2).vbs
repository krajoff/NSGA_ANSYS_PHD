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
  Station = "HHP Sayany"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "C:\Matlab_NSGAII_parallel_20.08.2018\maxwell\"
ExternalCircuit = "CC_NoLoadSayany.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
Solver = 1 ' If 0 then Maxwell else ANSYS R19.1
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 11850 ' Core diameter on gap side [mm]
DiaYoke = 12850 ' Core diameter on yoke side [mm]
LengthCore = 2750 ' Stator core length [mm]
LenghtTurn = 9290 ' One stator winding turn length [mm]
Z1 = 504 ' Numbers of slots [-]
Bs1 = 40 ' Slot wedge maximum width [mm]
Bs2 = 30.2 ' Slot body width [mm]
Hs1 = 15.0 ' Slot wedge height [mm]
Hs2 = 1.0 ' Slot closed bridge height [mm]
Bsw = Bs2 - 13.3 ' Stator winding width [mm]
Hsw = 74.6*16.9/Bsw' Stator winding height [mm]
Hsw_gap = 6.3 ' Distance between stator winding and slot bottom [mm]
Hsw_between = 14.6 ' Distance between stator windings [mm]
Hs0 = 2*Hsw+Hsw_between+Hsw_gap+9.1 ' Slot opening height [mm]
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]
AirGap = 30 ' Air gap [mm]
Ns = 43 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 6 ' Numbers of branches [-]
CoilPitch = 10 ' Stator coil pitch [-] (1-11-25)
SVolt = 15750 ' Stator winding voltage [V]
SCurrent = 26063 ' Stator winding current [A]
Frequency = 50 ' Frequency [Hz]
ExValue = Array(1520, 1103200) ' 0.Rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 42 ' Numbers of poles [-]
RadiusPole = 2079.2 ' Pole radius [mm]
DiaDamper = 30.4 ' Pole damper diameter [mm]
LocusDamper = 2056.2 ' Locus damper radius [mm]
LengthDamper = 2950 ' Damper length [mm]
AlphaD = 2*PiConst/218.97 ' Angle between dampers [rad]
ShoeWidthMinor = 620 ' Minor pole shoe width [mm]
ShoeWidthMajor = 650 ' Major pole shoe width [mm]
ShoeHeight = 75 ' Pole shoe height [mm]
PoleWidth = 490 ' Pole body width [mm]
PoleHeight = 255 ' Pole body height [mm]
PoleLength = 2540 ' Pole body length [mm]
SlotPole = 10 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 8 ' Numbers of damper slots per pole with opening width [-]
Bso = 5 ' Slot opening width [mm]
RadiusInRimRotor = 4820 ' Inner radius of rotor rim [mm]
Srw = (538-490)/2 ' Distance between rotor winding and pole body [mm]
Srh = 22 ' Distance between rotor winding and shoe bottom [mm]
Hrw = PoleHeight - Srh - 28 ' Rotor winding height [mm]
Brw = 205*105/Hrw ' Rotor winding width [mm]
Tsheet = 1.5 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 20 ' Rotor winding for winding parameters[-]
CalArea = 1 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = 0 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 0 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .122 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .00096 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 10 ' Rotor voltage [V]
CurrentRotor = 1550 ' Rotor current [A]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
WindingTop =    Array ("b", "x", "x", "x", "x", "c", "c", "c", "c", "y", "y", "y") ' small
WindingBottom = Array ("b", "b", "b", "x", "x", "x", "x", "c", "c", "c", "c", "y") ' small
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
' Include sub
' ---------------------------------------------
Sub Include(strScriptName)
  Dim objFSO, objFile
  Set objFSO = CreateObject("Scripting.FileSystemObject")
  Set objFile = objFSO.OpenTextFile(MainFolder & strScriptName & ".vbs")
  ExecuteGlobal objFile.ReadAll()
  objFile.Close
End Sub  

Include("MW_MainPart")
Include("MW_FieldReport")
Include("MW_DamperSolid")
Include("MW_SolvedValues")
