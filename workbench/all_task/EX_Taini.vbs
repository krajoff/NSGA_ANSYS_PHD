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
  Station = "HHP Tainionkosky"
' ---------------------------------------------
PiConst = 4*atn(1)
MainFolder = "G:\PhD.Calculation\Matlab_NSGAII_Ratio_17.05.2018\maxwell\"
ExternalCircuit = "CC_NoLoadTaini.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
' ---------------------------------------------
' Stator geometry
' ---------------------------------------------
DiaGap = 7900 ' Core diameter on gap side [mm]								OK
DiaYoke = 8380 ' Core diameter on yoke side [mm]							OK
LengthCore = 914 ' Stator core length [mm]									OK
LenghtTurn = 3760 ' One stator winding turn length [mm]						OK
Z1 = 576 ' Numbers of slots [-]												OK
Bs1 = 21.4 ' Slot wedge maximum width [mm]									OK
Bs2 = 16.9 ' Slot body width [mm]											OK
Hs0 = 121.7 ' Slot opening height [mm]										OK
Hs1 = 5.5 ' Slot wedge height [mm]											OK
Hs2 = .8 ' Slot closed bridge height [mm]									OK
Hsw = 50.1 ' Stator winding height [mm]										OK
Bsw = 11.3 ' Stator winding width [mm]										OK
Hsw_gap = 4.5 ' Distance between stator winding and slot bottom [mm]		OK
Hsw_between = 11 ' Distance between stator windings [mm]					OK
Alphas1 = PiConst/3 ' Angle base of wedge  [rad]							OK
AirGap = 9.1 ' Air gap [mm]													OK
Ns = 17 ' Air duct number of stator core [-]								OK
Bs = 7 ' Air duct width of stator core  [mm]								OK
Ksr = .95 ' Stacking factor of stator core [-]								OK 
Branches = 1 ' Numbers of branches [-]										OK
CoilPitch = 6 ' Stator coil pitch [-] (1 - 9 - 15)
SVolt = 10500 ' Stator winding voltage [V]									OK
SCurrent = 1182 ' Stator winding current [A]								OK
Frequency = 50 ' Frequency [Hz]												OK
ExValue = Array(310, 54900) ' 0.rotor current [A], 1.losses [W] 			OK
TypeCore = 0 ' 0 is without joins, 1 is with joins
'StYLoss = Array(134.8,  Round(2.99*0.5^2, 2),  .93) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
'StTLoss = Array(146.2,  Round(2.99*0.5^2, 2), 4.58) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
StYLoss = Array(221,  Round(2.99*0.5^2, 2),  .27) ' B50/1.0=1.1[W/kg] losses ratio for d Yoke
StTLoss = Array(273,  Round(2.99*0.5^2, 2), .27) ' B50/1.0=1.36[W/kg] losses ratio for q Tooth
'StYLoss(2) = Round(( ( 1.0*(1.20*(1-TypeCore) + 1.40*(TypeCore)) ) * 7800-50*StYLoss(0)-50^2*StYLoss(1))/(50^1.5), 2) ' 1.2 and 1.4 [W/kg] is empirical value
'StTLoss(2) = Round(( ( 1.0*(1.40*(1-TypeCore) + 1.65*(TypeCore)) ) * 7800-50*StTLoss(0)-50^2*StTLoss(1))/(50^1.5), 2)
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 80 ' Numbers of poles [-]											OK
RadiusPole = 975 ' Pole radius [mm]											So-so
DiaDamper = 11.4 ' Pole damper diameter [mm]								So-so
LocusDamper = 968 ' Locus damper radius [mm]								So-so	
LengthDamper = 1042.4 ' Damper length [mm]									OK
AlphaD = 2*PiConst/146.413' Angle between dampers [rad]						So-so 268.66
ShoeWidthMinor = 218 ' Minor pole shoe width [mm]
ShoeWidthMajor = 244 ' Major pole shoe width [mm]
ShoeHeight = 35.77 ' Pole shoe height [mm]									So-so								
PoleWidth = 162.56 ' Pole body width [mm]									OK
PoleHeight = 218.44 ' Pole body height [mm]									OK
PoleLength = 780.54 ' Pole body length [mm]									OK
SlotPole = 5 ' Numbers of damper slots per pole [-]							OK
SlotPoleOpen = 0 ' Numbers of damper slots per pole with opening width [-]	OK
Bso = 3 ' Slot opening width [mm]											OK ???
RadiusInRimRotor = 3238.5 ' Inner radius of rotor rim [mm]					So-so
Brw = 41.22 ' Rotor winding width [mm]										So-so
Hrw = 199' Rotor winding height [mm]										So-so
Srw = 3.81 ' Distance between rotor winding and pole body [mm]				So-so
Srh = 7.75 ' Distance between rotor winding and shoe bottom [mm]			So-so
Tsheet = 1 ' Sheet thickness [mm]											2 ???
RotLoss = Array(4500, Round(2.99*Tsheet^2, 2), 0)
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 28 ' Rotor winding for winding parameters[-]					
CalArea = 2 ' 5 is not needed. Rotor poles for calculation [-]
AngleD = Z1/Poles/2-.5-.1*0 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = 0 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 0 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .09 ' Calculated rotor active resistance 15 C [ohm]
ResistanceStator_15C = .01 ' Calculated phase stator active resistance 15 C [ohm]
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 10 ' Rotor voltage [V]
CurrentRotor = 300 ' Rotor current [A]
' ---------------------------------------------
WindingTop =    Array ("a", "x", "b", "y", "c", "z", "z")
WindingBottom = Array ("y", "a", "a", "z", "z", "z", "z")
'                        1    2    3    4    5    6    7    8    9    0    1    2    3    4    5    6    7    8    9    0    1    2    3    4    5    6    7    8    9    0    1    2    3    4    5    6
'WindingTop =    Array ("z", "z", "b", "b", "x", "x", "x", "c", "c", "y", "y", "y", "a", "a", "z", "z", "b", "b", "b", "x", "x", "c", "c", "c", "y", "y", "a", "a", "z", "z", "z", "b", "b", "x", "x", "x")
'WindingBottom = Array ("z", "b", "b", "b", "x", "x", "c", "c", "y", "y", "y", "a", "a", "z", "z", "z", "b", "b", "x", "x", "c", "c", "c", "y", "y", "a", "a", "a", "z", "z", "b", "b", "x", "x", "x", "z")
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
