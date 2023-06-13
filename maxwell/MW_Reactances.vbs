' ---------------------------------------------
oDesign.SetSolutionType "Magnetostatic", "XY"
Set oModule = oDesign.GetModule("BoundarySetup")
' ----------------------------------------------
' Stator current a-x is Imax, b-y and c-z is Imax/2
' ----------------------------------------------
For j=0 to 1
  If j=0 Then 
    SWArray = WindingTop
	SWString = "StW_T_"
	SWCurrent = "CurrentT_"	
  Else 
    SWArray = WindingBottom
    SWString = "StW_B_"
	SWCurrent = "CurrentB_"
  End if
For i=0 to ubound(WindingTop)
  If SWArray(i) = "a" or SWArray(i) = "x" Then
	   If SWArray(i) = "a" Then
         oModule.AssignCurrent Array("NAME:" & SWCurrent & CStr(i), "Objects:=", _
           Array(SWString & CStr(i)), "Current:=", "$Imax", "IsPositive:=", true)	   
	   Else
         oModule.AssignCurrent Array("NAME:" & SWCurrent & CStr(i), "Objects:=", _
           Array(SWString & CStr(i)), "Current:=", "$Imax", "IsPositive:=", false)	   
	   End if
  ElseIf SWArray(i) = "b" or SWArray(i) = "y" Then
	   If SWArray(i) = "b" Then
         oModule.AssignCurrent Array("NAME:" & SWCurrent & CStr(i), "Objects:=", _
           Array(SWString & CStr(i)), "Current:=", "$Imax/2", "IsPositive:=", false)	   
	   Else
         oModule.AssignCurrent Array("NAME:" & SWCurrent & CStr(i), "Objects:=", _
           Array(SWString & CStr(i)), "Current:=", "$Imax/2", "IsPositive:=", true)	   
	   End if
  Else
	   If SWArray(i) = "c" Then
         oModule.AssignCurrent Array("NAME:" & SWCurrent & CStr(i), "Objects:=", _
           Array(SWString & CStr(i)), "Current:=", "$Imax/2", "IsPositive:=", false)	   
	   Else
         oModule.AssignCurrent Array("NAME:" & SWCurrent & CStr(i), "Objects:=", _
           Array(SWString & CStr(i)), "Current:=", "$Imax/2", "IsPositive:=", true)	   
	   End if 
   End If
Next
Next
' ----------------------------------------------
' Boundary settings: x'
' ----------------------------------------------  
If SolutionType > 0 Then
ReDim EdgeIdWR(4*CalArea*(1+CoilRotor)-1)
k = 0
Function PosWR(x, y, s, n)
  rrot = (x^2+y^2)^0.5
  arot = atn(x/y) - AngleR + 2*PiConst*n/Poles
  xn = rrot*sin(arot)
  yn = rrot*cos(arot)
  PosWR = oEditor.GetEdgeByPosition(Array("NAME:EdgeParameters", _
    "BodyName:=", "RotW" & s, _
    "XPosition:=", CDbl(xn) & "mm", _
    "YPosition:=", CDbl(yn) & "mm", _
    "ZPosition:=", "0mm"))
End Function
YPosWRNull = DiaGap/2-AirGap-ShoeHeight-Srh-Hrw/(2*CoilRotor)
XPosWR = PoleWidth/2+Srw
For i = 0 to CoilRotor-1 
  YPosWR = YPosWRNull-i*Hrw/CoilRotor
  EdgeIdWR(k) = PosWR(XPosWR, YPosWR, "R_" & CStr(i), 0)
  EdgeIdWR(k+1) = PosWR(XPosWR+Brw, YPosWR, "R_" & CStr(i), 0)
  EdgeIdWR(k+2) = PosWR(-XPosWR, YPosWR, "L_" & CStr(i), 0) 
  EdgeIdWR(k+3) = PosWR(-XPosWR-Brw, YPosWR, "L_" & CStr(i), 0) 
  k = k + 4
Next
YPosWR = DiaGap/2-AirGap-ShoeHeight-Srh
EdgeIdWR(k) = PosWR(XPosWR+Brw/2, YPosWR, "R_0", 0)
EdgeIdWR(k+1) = PosWR(XPosWR+Brw/2, YPosWR-Hrw, "R_" & CStr(CoilRotor-1), 0)
EdgeIdWR(k+2) = PosWR(-XPosWR-Brw/2, YPosWR, "L_0", 0)
EdgeIdWR(k+3) = PosWR(-XPosWR-Brw/2, YPosWR-Hrw, "L_" & CStr(CoilRotor-1), 0)
k = k + 4

If CalArea >= 2 Then
  For j = 1 to CalArea-1
    For i = 0 to CoilRotor-1
	  YPosWR = YPosWRNull-i*Hrw/CoilRotor
      EdgeIdWR(k) = PosWR(XPosWR, YPosWR, "R_" & CStr(i) & "_" & CStr(j), j)
      EdgeIdWR(k+1) = PosWR(XPosWR+Brw, YPosWR, "R_" & CStr(i) & "_" & CStr(j), j)
      EdgeIdWR(k+2) = PosWR(-XPosWR, YPosWR, "L_" & CStr(i) & "_" & CStr(j), j) 
      EdgeIdWR(k+3) = PosWR(-XPosWR-Brw, YPosWR, "L_" & CStr(i) & "_" & CStr(j), j) 
	  k = k + 4
   Next
      YPosWR = DiaGap/2-AirGap-ShoeHeight-Srh
      EdgeIdWR(k) = PosWR(XPosWR+Brw/2, YPosWR, "R_0_" & CStr(j), j)
	  EdgeIdWR(k+1) = PosWR(XPosWR+Brw/2, YPosWR-Hrw, "R_" & CStr(CoilRotor-1) & "_" & CStr(j), j)
	  EdgeIdWR(k+2) = PosWR(-XPosWR-Brw/2, YPosWR, "L_0_" & CStr(j), j)
	  EdgeIdWR(k+3) = PosWR(-XPosWR-Brw/2, YPosWR-Hrw, "L_" & CStr(CoilRotor-1) & "_" & CStr(j), j)
	  k = k + 4
  Next
End If
oModule.AssignVectorPotential Array("NAME:WindingRotor", _
  "Edges:=", EdgeIdWR, _
  "Value:=", "0", "CoordinateSystem:=", "")
End If  
' ----------------------------------------------
' Boundary settings: x"
' ----------------------------------------------  
If SolutionType = 2 Then
ReDim EdgeIdDamper(CalArea*SlotPole-1)
k = 0
Function PosDamper(x, y, s, n)
  rrot = (x^2+y^2)^0.5 - DiaDamper/2
  arot = atn(x/y) - AngleR + 2*PiConst*n/Poles
  xn = rrot*sin(arot)
  yn = rrot*cos(arot)
  PosDamper = oEditor.GetEdgeByPosition(Array("NAME:EdgeParameters", _
    "BodyName:=", "Damper_" & s, _
    "XPosition:=", CDbl(xn) & "mm", _
    "YPosition:=", CDbl(yn) & "mm", _
    "ZPosition:=", "0mm"))
End Function
For i = 0 to SlotPole-1
  XPosDamper = -LocusDamper*sin(((SlotPole-1)/2-i)*AlphaD)
  YPosDamper = LocusDamper*cos(((SlotPole-1)/2-i)*AlphaD)+DiaGap/2-AirGap-RadiusPole 
  EdgeIdDamper(k) = PosDamper(XPosDamper, YPosDamper, CStr(i), 0)
  k = k + 1
Next
If CalArea >= 2 Then
  For j = 2 to CalArea
    For i = 0 to SlotPole-1
      XPosDamper = -LocusDamper*sin(((SlotPole-1)/2-i)*AlphaD)
      YPosDamper = LocusDamper*cos(((SlotPole-1)/2-i)*AlphaD)+DiaGap/2-AirGap-RadiusPole 
      EdgeIdDamper(k) = PosDamper(XPosDamper, YPosDamper, CStr(i) & "_" & CStr(j), j-1)
	  k = k + 1
    Next
  Next
End If
oModule.AssignVectorPotential Array("NAME:WindingDamper", _
  "Edges:=", EdgeIdDamper, _
  "Value:=", "0", "CoordinateSystem:=", "")
End If
' ----------------------------------------------
' Create setup. Apply mesh operations
' ----------------------------------------------
Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "Magnetostatic", _
  Array("NAME:Setup", "Enabled:=", true, _
  "MaximumPasses:=", 1, "MinimumPasses:=", 1, _
  "MinimumConvergedPasses:=", 1, _
  "PercentRefinement:=", 30, _
  "SolveFieldOnly:=", false, _
  "PercentError:=", 1, _
  "SolveMatrixAtLast:=", true, _
  "PercentError:=", 1, _
  "ThermalFeedback:=", false, _
  "NonLinearResidual:=", 0.0001, _
  Array("NAME:MuHcOption", "MuNonLinearBH:=", true, _
  "HcNonLinearBH:=", true, "ComputeHc:=", false))