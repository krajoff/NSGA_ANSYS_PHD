' ---------------------------------------------
' Script Recorded by Ansoft Maxwell Version 14.0.0
' 10:14:35  Dec 08, 2016 by Gulay Stanislav
' ---------------------------------------------
' Return solution type and generator length
' ---------------------------------------------
Set oModule = oDesign.GetModule("BoundarySetup")
BoundaryArray = oModule.GetBoundaries()
Select Case ubound(BoundaryArray)
  Case 9
    SolutionType = 2
	GenLength = ((LengthCore-Bs*Ns*0)+LengthDamper)/2+2*(AirGap+(AirGapMax-AirGap)/3)  
  Case 7
  	SolutionType = 1	
	GenLength = ((LengthCore-Bs*Ns*0)+PoleLength)/2+2*(AirGap+(AirGapMax-AirGap)/3) 
  Case 5
  	SolutionType = 0
	GenLength = ((LengthCore-Bs*Ns*0)+PoleLength)/2+2*(AirGap+(AirGapMax-AirGap)/3) 
End Select
' ---------------------------------------------
' Magnetic vector potential
' ---------------------------------------------
Set oModule = oDesign.GetModule("FieldsReporter")
s = s & Chr(13) & Chr(10) & "RESULTS MVP " 
s = s & "(CalArea=" & CStr(CalArea) & ", " 
s = s & "SolutionType=" & CStr(SolutionType) & ", " 
s = s & "GenLength=" & CStr(round(GenLength,0)) & "mm)" & Chr(13) & Chr(10)
's = s & "AxS of stator winding top [Wb*m]" & Chr(13) & Chr(10)
rgt = Ubound(WindingBottom)
Redim WNumber(rgt,1)
For i = 0 to Ubound(WindingTop) 
  oModule.CopyNamedExprToStack "Flux_Lines"
  oModule.EnterVol  "StW_T_" & CStr(i)
  oModule.CalcOp "Integrate"
  oModule.ClcEval "Setup : LastAdaptive", Array()
  topvalue = oModule.GetTopEntryValue("Setup: LastAdaptive", Array())
  WNumber(i,0) = CDbl(topvalue(0))
' s = s & topvalue(0) & Chr(13) & Chr(10)
Next
' ---------------------------------------------
's = s & Chr(13) & Chr(10) & "AxS of stator winding bottom [Wb*m]" & Chr(13) & Chr(10)
For i = 0 to Ubound(WindingBottom) 
  oModule.CopyNamedExprToStack "Flux_Lines"
  oModule.EnterVol  "StW_B_" & CStr(i)
  oModule.CalcOp "Integrate"
  oModule.ClcEval "Setup : LastAdaptive", Array()
  topvalue = oModule.GetTopEntryValue("Setup: LastAdaptive", Array())
  WNumber(i,1) = CDbl(topvalue(0))
' s = s & "T" & CStr(i) & "." & topvalue(0) & Chr(13) & Chr(10)
' s = s & topvalue(0) & Chr(13) & Chr(10)
Next
' ---------------------------------------------
' Return the sum of MPV.sumMPV = (A-X, B-Y, C-Z)
' ---------------------------------------------
Redim sumMPV(2,1)
For i = 0 to 2
  For j = 0 to 1
    sumMPV(i,j) = 0  
  Next
Next
For i = 0 to rgt
  For j = 0 to 1
    Select Case SwArrayM(i,j)
      Case "a"
        sumMPV(0,0) = sumMPV(0,0) + WNumber(i,j)
      Case "x"
        sumMPV(0,1) = sumMPV(0,1) + WNumber(i,j) 
	  Case "b"
        sumMPV(1,0) = sumMPV(1,0) + WNumber(i,j) 
      Case "y"
        sumMPV(1,1) = sumMPV(1,1) + WNumber(i,j) 
	  Case "c"
        sumMPV(2,0) = sumMPV(2,0) + WNumber(i,j) 
      Case "z"
        sumMPV(2,1) = sumMPV(2,1) + WNumber(i,j) 
    End Select
  Next
Next
' ---------------------------------------------
s = s & Chr(13) & Chr(10) & "AxS of A..Z [Wb*m]" & Chr(13) & Chr(10) &_
	"A  " & CStr(sumMPV(0,0)) & Chr(13) & Chr(10) & _
    "X  " & CStr(sumMPV(0,1)) & Chr(13) & Chr(10) & _
    "B  " & CStr(sumMPV(1,0)) & Chr(13) & Chr(10) & _
    "Y  " & CStr(sumMPV(1,1)) & Chr(13) & Chr(10) & _
    "C  " & CStr(sumMPV(2,0)) & Chr(13) & Chr(10) & _
    "Z  " & CStr(sumMPV(2,1)) & Chr(13) & Chr(10)		
Redim sumABC(2)
s = s & Chr(13) & Chr(10) & "Sum of AxS, BxS, CxS: 1.A 2.B 3.C [Wb*m]" & Chr(13) & Chr(10)
For i = 0 to 2
  sumABC(i) = sumMPV(i,0) - sumMPV(i,1)
  s = s & CStr(sumABC(i)) & Chr(13) & Chr(10)
Next
' ---------------------------------------------
' Magnetic vector potential
' ---------------------------------------------
AxS = 2/3*(sumABC(0)+sumABC(1)*cos(2*PiConst/3)+sumABC(2)*cos(-2*PiConst/3)) ' [Wb*m]
A = AxS/(Hsw*Bsw*10^-6) ' [Wb/m]
x = (A/Imax)*GenLength*10^-3*2*PiConst*Frequency*(Poles/CalArea)/(SVolt/(SCurrent*3^0.5)*Branches^2)
s = s & Chr(13) & Chr(10) & "AxS [Wb*m]" & Chr(13) & Chr(10) & CStr(AxS) & Chr(13) & Chr(10)
s = s & Chr(13) & Chr(10) & "Inductive reactance [pu]" & Chr(13) & Chr(10) & CStr(Round(x, 4)) & Chr(13) & Chr(10) & Chr(13) & Chr(10)
oDesign.EditNotes s
' ---------------------------------------------
If SolutionType = 2 then
  StrText = StrText & CStr(Round(x, 4)) & vbTab 
Else
  StrText = StrText & CStr(Round(x, 4))
End If  