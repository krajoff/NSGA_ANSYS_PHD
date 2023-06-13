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
MainFolder = "F:\PhD.Calculation\Matlab_NSGAII_Ratio_17.05.2018\maxwell\"
ExternalCircuit = "CC_NoLoadNiznekamskaya.sph"
IncTitle = "" ' "example" & IncTitle & ".csv"
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
CoilPitch = 6 ' Stator coil pitch [-] 'шаг переменный 1-6-13, в данный момент введено среднее значение		????
SVolt = 13800 ' Stator winding voltage [V]																	OK
SCurrent = 3841 ' Stator winding current [A] I=S/3Uф														OK
Frequency = 50 ' Frequency [Hz]																				OK
'ExValue = Array(1185, 408825) ' 0.rotor current [A], 1.losses [W] Losses=if*uf ? uf=345V					????
'klosses = Array(109.73, .75, 4.39) ' losses ratio for 1.07[W/kg]											????
'klosses(2) = Round((1.27*1.70*7800-50*klosses(0)-50^2*klosses(1))/(50^1.5), 2) ' 1.27[W/kg] is empirical value
' ---------------------------------------------
' Rotor geometry
' ---------------------------------------------
Poles = 104 ' Numbers of poles [-]																			OK
RadiusPole = 1171.2 ' Pole radius [mm]																		OK		
DiaDamper = 20 ' Pole damper diameter [mm] 																OK
LocusDamper = 1167 ' Locus damper radius [mm]																OK
LengthDamper = 1662 ' Damper length [mm]																	OK
AlphaD = 2*PiConst/146.64 ' Angle between dampers [rad]													OK
ShoeWidth = 309 ' Pole shoe width [mm] 																	OK
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
Tsheet = 1.5 ' Sheet thickness [mm]																		--??--
' ---------------------------------------------
' Calculation setting. Boundary setting. Excitation setting
' ---------------------------------------------
CoilRotor = 1 ' Rotor winding for drawing[-]
CoilRotorPr = 19 ' Rotor winding for winding parameters[-]													OK
CalArea = 2 ' Rotor poles for calculation [-]																OK
AngleD = Z1/Poles/2-.5 ' Rotation angle of stator slot is in a counter-clockwise direction. Share of 2*pi()/Z1. 
' If AngleD mod 2 is 0 then D-axis slot, .5 is tooth. The value is about Z1/2/Poles [-]
NNull = 0 ' Stator winding is in a clockwise direction [-]
AngleR = 0 ' Rotation angle of rotor is in a counter-clockwise direction [rad]
Imax = 60 ' Maximum stator current [A]
SolutionType = 0 ' Solution type. 0 is x, 1 is x', 2 is x"
ResistanceRotor_15C = .2180 ' Calculated rotor active resistance 15 C [ohm]								OK
ResistanceStator_15C = .00619 ' Calculated phase stator active resistance 15 C [ohm]						OK
TestTime = 10 ' Test time [s]
NoLoadTime = 1 ' Initial time of no-load running [s] 
VoltageRotor = 345 ' Rotor voltage [V]																		OK
CurrentRotor = 1185 ' Rotor current [A]																	OK
' ---------------------------------------------
WindingTop = Array ("a", "a", "z", "z", "b", "b", "x", "x", "c", "c", "y", "y")							
WindingBottom = Array ("a", "z", "z", "b", "b", "x", "x", "c", "c", "y", "y", "a")							
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

' ---------------------------------------------
' Material
' ---------------------------------------------
Material_stator = "m 270-50A" ' Material of stator core [T = f (A/m)]
Material_rotor = "rotor steel" ' Material of rotor core [T = f (A/m)]
Material_winding = "copper-75C" ' Material of winding [T = f (A/m)]
' ---------------------------------------------
' Additional or automatic settings
' ---------------------------------------------
axColor = array (225, 225, 0) ' Colour of stator winding ax [-]
byColor = array (0, 128, 128) ' Colour of stator winding by [-]
czColor = array (128, 0, 0) ' Colour of stator winding cz [-]
DiaCal1 = DiaGap+2*(Hs0+2*Hs1+Hs2) '[mm]
PoleCenter = DiaGap/2-AirGap-RadiusPole ' Additional calculation for AirGapMax [mm]
AirGapMax = DiaGap/2-((PoleCenter+(RadiusPole^2-ShoeWidth^2/4)^0.5)^2+ShoeWidth^2/4)^0.5 ' Maximum of air gap [mm]
'GenLength = (LengthCore+PoleLength)/2+2*(AirGap+(AirGapMax-AirGap)/3) ' Calculated length of generator [mm]
GenLength = (Ksr*(LengthCore-Bs*Ns)+PoleLength)/2+2*(AirGap+(AirGapMax-AirGap)/3) ' Calculated length of generator [mm]
Hs = Hs0+Hs1+Hs2 ' Slot height [mm]
EndRotorWidth = PoleWidth+2*(Srw+Brw)
ActiveResistanceRotor = ResistanceRotor_15C*(1+.004*(75-15))*(GenLength/PoleLength)*(EndRotorWidth/(EndRotorWidth+PoleLength)) ' Rotor active resistance reduced to 75 Celsius degree and length for calculation [ohm]
ActiveResistanceStator = ResistanceStator_15C*(1+.004*(75-15))*(GenLength/LengthCore)*(1-2*LengthCore/LenghtTurn) ' Stator active resistance to 75 Celsius degree and length for calculation [ohm]
RadiusOutRimRotor = ((DiaGap/2-AirGap-ShoeHeight-PoleHeight)^2+PoleWidth^2/4)^0.5 '[mm]
NumberWSE = ubound(WindingTop)+1 ' Number stator winding with excitation [-]
MaxAngleR = PiConst/Poles-atn((PoleWidth/2+Srw+Brw)/(DiaGap/2-AirGap-ShoeHeight-Srh-Hrw)) ' Maximum of rotation angle of rotor [rad]
RatioStator = (Round(Ksr*(LengthCore-Bs*Ns)/LengthCore, 2))*0 + 1
' ---------------------------------------------
' Program start
' ---------------------------------------------
Set oAnsoftApp = CreateObject("AnsoftMaxCir.MaxCirScript")
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
Set oProject = oDesktop.GetActiveProject()
Set oDesign = oProject.GetActiveDesign()
Set oEditor = oDesign.SetActiveEditor("SchematicEditor")
' ---------------------------------------------
' Change properties
' ---------------------------------------------
ChPrArray = array ( _
"$ActiveResistanceStator", CStr(ActiveResistanceStator) & "Ohm", "Stator active resistance", _
"$TestTime", CStr(TestTime) & "s", "Test time", _
"$NoLoadTime", CStr(NoLoadTime) & "s", "Initial time of no-load running")
' --------------------------------------------
' Subroutine of change properties 
' --------------------------------------------
Sub ChPrValue(counter)
  oProject.ChangeProperty Array("NAME:AllTabs", _
  Array("NAME:ProjectVariableTab", _
  Array("NAME:PropServers", "ProjectVariables"), _
  Array("NAME:ChangedProps", _
  Array("NAME:" & ChPrArray(counter), _
  "PropType:=", "VariableProp", _
  "UserDef:=", true, _
  "Value:=", ChPrArray(counter+1), _
  "Description:=", ChPrArray(counter+2)))))
End Sub
For i = 0 to ubound(ChPrArray) step 3 
  ChPrValue(i)
Next

MsgBox CStr(GenLength)

