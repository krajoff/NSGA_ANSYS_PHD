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
  Station = "HHP Saratovskya"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "E:\PhD.Calculation\Matlab_NSGAII_Ratio_07.07.2018\maxwell\"
ExternalCircuit = "CC_NoLoadSaratovskya.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 7720 ' Core diameter on gap side [mm]
DiaYoke = 8200 ' Core diameter on yoke side [mm]
LengthCore = 1780 ' Stator core length [mm]
LenghtTurn = 5331 ' One stator winding turn length [mm]
Z1 = 528 ' Numbers of slots [-]
Bs1 = 26.3 ' Slot wedge maximum width [mm] 
Bs2 = 20.1 ' Slot body width [mm]
Hs0 = 108.5 ' Slot opening height [mm] 
Hs1 = 8 ' Slot wedge height [mm] 
Hs2 = 0.8 ' Slot closed bridge height [mm] 
Hsw = 45 ' Stator winding height [mm]
Bsw = 13.5 ' Stator winding width [mm] 
Hsw_gap = 5.9 ' Distance between stator winding and slot bottom [mm] 
Hsw_between = 8.9 ' Distance between stator windings [mm] 
Alphas1 = PiConst/3 ' Angle base of wedge  [rad] 
AirGap = 8 ' Air gap [mm] 
Ns = 33 ' Air duct number of stator core [-]
Bs = 7 ' Air duct width of stator core  [mm]
Ksr = .95 ' Stacking factor of stator core [-]
Branches = 2 ' Numbers of branches [-]
CoilPitch = 6 ' Stator coil pitch [-] 'шаг переменный 1-7-14, в данный момент введено среднее значение
SVolt = 10500 ' Stator winding voltage [V]
SCurrent = 3030 ' Stator winding current [A] I=S/3Uф
Frequency = 50 ' Frequency [Hz]
ExValue = Array(600, 224700) ' 0.rotor current [A], 1.losses [W]
TypeCore = 0 ' 0 is without joins, 1 is with joins
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
'StYLoss(2) = Round(( ( 1.0*(1.20*(1-TypeCore) + 1.40*(TypeCore)) ) * 7800-50*StYLoss(0)-50^2*StYLoss(1))/(50^1.5), 2) ' 1.2 and 1.4 [W/kg] is empirical value
'StTLoss(2) = Round(( ( 1.0*(1.40*(1-TypeCore) + 1.65*(TypeCore)) ) * 7800-50*StTLoss(0)-50^2*StTLoss(1))/(50^1.5), 2)
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 80 ' Numbers of poles [-]
RadiusPole = 1087 ' Pole radius [mm]
DiaDamper = 16.4 ' Pole damper diameter [mm] 
LocusDamper = 1075 ' Locus damper radius [mm]
LengthDamper = 1977 ' Damper length [mm]
AlphaD = 2*PiConst/150.09 ' Angle between dampers [rad]
ShoeWidthMinor = 220 ' Minor pole shoe width [mm]
ShoeWidthMajor = 235 ' Major pole shoe width [mm]
ShoeHeight = 30 ' Pole shoe height [mm]
PoleWidth = 169 ' Pole body width [mm]
PoleHeight = 165.98 ' Pole body height [mm]
PoleLength = 1730 ' Pole body length [mm]
SlotPole = 5 ' Numbers of damper slots per pole [-]
SlotPoleOpen = 3 ' Numbers of damper slots per pole with opening width [-]
Bso = 4 ' Slot opening width [mm]
RadiusInRimRotor = 7200/3 ' Inner radius of rotor rim [mm] 'внешний радиус остова ротора
Brw = 49 ' Rotor winding width [mm] 
Hrw = 125.4' Rotor winding height [mm] 
Srw = 0.2+0.25+2.2+0.5 ' Distance between rotor winding and pole body [mm] 'сумма изол€ции с чертежа 5BS.631.384
Srh = 18.93 ' Distance between rotor winding and shoe bottom [mm]
Tsheet = 1.0 ' Sheet thickness [mm]
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 15 ' Rotor winding for winding parameters[-]
CalArea = 2 ' Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = 0 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 0 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .2343 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .00944 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 400 ' Rotor voltage [V]
CurrentRotor = 560 ' Rotor current [A]
' ---------------------------------------------
WindingTop =    Array ("a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "x", "x", "x")
WindingBottom = Array ("z", "z", "z", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c")
'WindingTop = Array ("a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c", "c", "c", "c", "y", "y", "y", "y", "a", "a", "a", "a", "a", "z", "z", "z", "z", "b", "b", "b", "b", "b", "x", "x", "x", "x", "c", "c", "c", "c", "y", "y", "y", "y", "y", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "x", "x", "x")
'WindingBottom = Array ("z", "z", "z", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c", "c", "c", "c", "y", "y", "y", "y", "y", "a", "a", "a", "a", "z", "z", "z", "z", "b", "b", "b", "b", "b", "x", "x", "x", "x", "c", "c", "c", "c", "c", "y", "y", "y", "y", "a", "a", "a", "a", "z", "z", "z", "z", "z", "b", "b", "b", "b", "x", "x", "x", "x", "x", "c")
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
'Include("MW_DamperSolid")
Include("MW_SolvedValues")
