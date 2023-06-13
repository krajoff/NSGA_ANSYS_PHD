' -----------------------------------------------
' ANSYS Electronics Desktop script
' Sep 23, 2019 by Gulay Stanislav 
' -----------------------------------------------
Set oModule = oDesign.GetModule("FieldsReporter")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
' Return project values 
Function ProjectValue(value, lsi, nround)
  StrValue = oProject.GetVariableValue(value)
  ProjectValue = CStr(Round(CDbl(Left(StrValue, Len(StrValue)-lsi)), nround))
End Function 

' -----------------------------------------------
' Return stator core area/volume  
' -----------------------------------------------
oModule.CalcStack "clear"
oModule.EnterScalar 1
oModule.EnterVol "DiaTooth"
oModule.CalcOp "Integrate"
oModule.EnterScalar 1
oModule.EnterVol "DiaYoke"
oModule.CalcOp "Integrate"
oModule.CalcOp "+"
oModule.ClcEval "Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns")
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns"))
  StatorCoreVolume = CDbl(TopValue(0))*LengthCore*10^(-3)
oModule.CalcStack "clear"

' -----------------------------------------------  
' Return stator core losses
' -----------------------------------------------
If Solver = 0 then
	oModule.CopyNamedExprToStack "coreLoss"
Else 
	oModule.CopyNamedExprToStack "Core_Loss"
End If
oModule.EnterVol "DiaTooth"
oModule.CalcOp "Integrate"
If Solver = 0 then
	oModule.CopyNamedExprToStack "coreLoss"
Else 
	oModule.CopyNamedExprToStack "Core_Loss"
End If
oModule.EnterVol "DiaYoke"
oModule.CalcOp "Integrate"
oModule.CalcOp "+"
oModule.ClcEval "Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns")
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns"))
oModule.CalcStack "clear"
StatorCoreLosses = (Poles/CalArea)*(LengthCore-Ns*Bs)*10^(-3)*Ksr*CDbl(TopValue(0))
' -----------------------------------------------
If Solver = 0 then
	oModule.CopyNamedExprToStack "coreLoss"
Else 
	oModule.CopyNamedExprToStack "Core_Loss"
End If
oModule.EnterVol "DiaYoke"
oModule.CalcOp "Integrate"
oModule.ClcEval "Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns")
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns"))
oModule.CalcStack "clear"  
StatorCoreYoke = (Poles/CalArea)*(LengthCore-Ns*Bs)*10^(-3)*Ksr*CDbl(TopValue(0))
' -----------------------------------------------
If Solver = 0 then
	oModule.CopyNamedExprToStack "coreLoss"
Else 
	oModule.CopyNamedExprToStack "Core_Loss"
End If
oModule.EnterVol "DiaTooth"
oModule.CalcOp "Integrate"
oModule.ClcEval "Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns")
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns"))
oModule.CalcStack "clear"  
StatorCoreTooth = (Poles/CalArea)*(LengthCore-Ns*Bs)*10^(-3)*Ksr*CDbl(TopValue(0))

' -----------------------------------------------
' Return maximum value of Bm [T]
' -----------------------------------------------
oModule.CalcStack "clear"
oModule.CopyNamedExprToStack "Mag_B"
oModule.EnterSurf "Mover"
oModule.CalcOp "Maximum"
oModule.ClcEval "Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns")
TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns"))
Bmair = CDbl(TopValue(0))

' -----------------------------------------------  
' Return stator teeth area [m^2]
' -----------------------------------------------
oModule.CalcStack "clear"
oModule.EnterScalar 1
oModule.EnterSurf "DiaTooth"
oModule.CalcOp "Integrate"
oModule.ClcEval "Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns")
TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*RtFrq)) & "ns"))
StatorTeeth = CDbl(TopValue(0))

' -----------------------------------------------	
' Return full rotation of stator voltage [V]
' -----------------------------------------------	
If RtFrq <> 1 then
' Create ado-object
  Dim objStreamV
  Set objStreamV = CreateObject("ADODB.Stream")
  objStreamV.CharSet = "utf-8"
  objStreamV.Open
' Create fso-object 
  Set oModule = oDesign.GetModule("ReportSetup")
  oModule.ExportToFile "StatorVoltage", MainFolder & "temp/" & "RP_HalfVS" & IncTitle & ".csv"
  HalfVSFolder = MainFolder & "temp/" & "RP_HalfVS" & IncTitle & ".csv"
  FullVSFolder = MainFolder & "temp/" & "RP_FullVS" & IncTitle & ".csv"
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set inputFile  = fso.OpenTextFile(HalfVSFolder)
' Return double array  
  nFluxPoints = NumberSteps+1
  Dim   outputArrV()
  Redim outputArrV(2*nFluxPoints + 1)  
  count = 1
  Do While inputFile.AtEndOfStream <> True
    arrStr = split(inputFile.ReadLine, ",")
	arrSub = array(arrStr(0), arrStr(1), arrStr(2), arrStr(3))	
	outputArrV(count) = Join(arrSub, ",")		
	If count > 2 Then
	  arrSub = array(CStr(10 + CDbl(arrStr(0))), CStr(-Round(CDbl(arrStr(1)),5)), CStr(-Round(CDbl(arrStr(2)),5)), CStr(-Round(CDbl(arrStr(3)),5)))	
	  outputArrV(nFluxPoints + count - 1) = Join(arrSub, ",")
	End If
  count = count + 1
  Loop
  inputFile.Close
' Write csv-file RP_FluxFullAirGap
  For i = 1 to 2*nFluxPoints + 1
    objStreamV.WriteText outputArrV(i) & Chr(13) & Chr(10) 
'   outputFile.WriteLine outputArr(i)   
  Next	
objStreamV.SaveToFile MainFolder & "temp/" & "RP_FullVS" & IncTitle & ".csv", 2    
oModule.DeleteTraces Array("StatorVoltage:=", Array("InducedVoltage(WindingStatorAX)-InducedVoltage(WindingStatorBY)"))
oModule.DeleteTraces Array("StatorVoltage:=", Array("InducedVoltage(WindingStatorBY)-InducedVoltage(WindingStatorCZ)")) 
oModule.DeleteTraces Array("StatorVoltage:=", Array("InducedVoltage(WindingStatorCZ)-InducedVoltage(WindingStatorAX)")) 
oModule.ImportIntoReport "StatorVoltage", MainFolder & "temp/" & "RP_FullVS" & IncTitle & ".csv"
End If

' -----------------------------------------------
' Return FFT and 1st harmonic of stator voltage [V]
' -----------------------------------------------
Set oModule = oDesign.GetModule("Solutions")
    oModule.FFTOnReport "StatorVoltage", "Rectangular", "mag"
Set oModule = oDesign.GetModule("ReportSetup")  
FFTStatorFolder = MainFolder & "temp/" & "RP_FFTStatorVoltage" & IncTitle & ".csv"
oModule.ExportToFile "FFT StatorVoltage", MainFolder & "temp/" & "RP_FFTStatorVoltage" & IncTitle & ".csv"
' Read csv-file RP_FFTStatorVoltage
Set objFSV = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSV.OpenTextFile(FFTStatorFolder)
Dim fftNh(2)
fftNh(0)=0
fftNh(1)=0
fftNh(2)=0
For i = 1 to Round(NumberSteps/2,0)+2
    str = objFile.ReadLine
	arrStr = split(str, ",")
	If i = 3 then
	  fft1hA = CDbl(arrStr(2))/sqr(2)	  
	  fft1hB = CDbl(arrStr(4))/sqr(2)	  
	  fft1hC = CDbl(arrStr(6))/sqr(2)	  
      fft1h = (fft1hA + fft1hB + fft1hC)/3
	End If
	If i > 3 then
	  For j = 0 to 2
	    fftNh(j) = fftNh(j) + (CDbl(arrStr((j+1)*2))/sqr(2))^2
	  Next	
	End If
Next
    THDCal = (sqr(fftNh(0))/fft1hA + sqr(fftNh(1))/fft1hB + sqr(fftNh(2))/fft1hC)*100/3
	
' -----------------------------------------------	
' Return air gap flux and its FFT
' Create flux air gap if CalArea = 1
' -----------------------------------------------	
If CalArea = 1 Then
' Create ado-object
  Dim objStream
  Set objStream = CreateObject("ADODB.Stream")
  objStream.CharSet = "utf-8"
  objStream.Open
' Create fso-object 
  oModule.ExportToFile "AirGapFlux", MainFolder & "temp/" & "RP_FluxHalfAirGap" & IncTitle & ".csv"
  FluxHalfFolder = MainFolder & "temp/" & "RP_FluxHalfAirGap" & IncTitle & ".csv"
  FluxFullFolder = MainFolder & "temp/" & "RP_FluxFullAirGap" & IncTitle & ".csv"
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set inputFile  = fso.OpenTextFile(FluxHalfFolder)
' Set outputFile = fso.CreateTextFile(FluxFullFolder, ForWriting, True)
' Return double array  
  nFluxPoints = 1001
  Dim   outputArr()
  Redim outputArr(2*nFluxPoints + 1)  
  count = 1
  Do While inputFile.AtEndOfStream <> True
    arrStr = split(inputFile.ReadLine, ",")
	arrSub = array(arrStr(1), arrStr(2))	
	If count = 1 Then
	  LenStr = Len(arrStr(2))
	  arrSub = array(arrStr(1), Mid(arrStr(2), 2, LenStr-2))
    End If	
	outputArr(count) = Join(arrSub, ",")	
	If count > 2 Then
	  arrSub = array(CStr(500/Frequency + CDbl(arrStr(1))), CStr(-Round(CDbl(arrStr(2)), 5)))		
	  outputArr(nFluxPoints + count - 1) = Join(arrSub, ",")
	End If
  count = count + 1
  Loop
  inputFile.Close
' Write csv-file RP_FluxFullAirGap
  For i = 1 to 2*nFluxPoints + 1
    objStream.WriteText outputArr(i) & Chr(13) & Chr(10) 
'   outputFile.WriteLine outputArr(i)   
  Next	
  objStream.SaveToFile MainFolder & "temp/" & "RP_FluxFullAirGap" & IncTitle & ".csv", 2  
  oModule.DeleteTraces Array("AirGapFlux:=", Array("Flux_Lines"))
  oModule.ImportIntoReport "AirGapFlux", MainFolder & "temp/" & "RP_FluxFullAirGap" & IncTitle & ".csv"
End If

' -----------------------------------------------	
' Return FFT air gap flux
' -----------------------------------------------	
Set oModule = oDesign.GetModule("Solutions")
    oModule.FFTOnReport "AirGapFlux", "Rectangular", "mag"
Set oModule = oDesign.GetModule("ReportSetup")  
    FFTFluxFolder = MainFolder & "temp/" & "RP_FFTFluxAirGap" & IncTitle & ".csv"
    oModule.ExportToFile "FFT AirGapFlux", MainFolder & "temp/" & "RP_FFTFluxAirGap" & IncTitle & ".csv"
' Read csv-file RP_FFTFluxAirGape
Set objFSV = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSV.OpenTextFile(FFTFluxFolder)
For i = 1 to 3
    str = objFile.ReadLine
	If i = 3 then
		arrStr = split(str, ",")
		If Solver = 0 then
			Flux1f = CDbl(arrStr(1))
		Else 
			Flux1f = CDbl(arrStr(2))
		End If
	End If
Next

' -----------------------------------------------	
' Additional calculation
' -----------------------------------------------		  
w1 = 2*Z1/(2*3*Branches)
Qzp = Z1/(3*Poles)
AlfaZone = PiConst*Poles*Qzp/Z1
BetaStep = (Poles/Z1)*CoilPitch
ky1 = sin(BetaStep*PiConst/2)
kp1 = sin(AlfaZone/2)/(Qzp*sin(AlfaZone/(2*Qzp)))
k1 = ky1*kp1
FluxStatorVoltage = 2*Flux1f*PiConst*3^.5*2^.5*Frequency*w1*GenLength*10^(-3)*k1
Wt = (PiConst*(DiaGap + Hs) - Z1*Bs2)*10^(-3)/Z1
Gt = Ksr*(LengthCore-Bs*Ns)*10^(-3)*(StatorTeeth*(Poles/CalArea))*7800
Lossesendpart = 0.142*1.8*10^6*(Bmair*0.05*Wt)^2*Gt

' -----------------------------------------------
' Damper and solid losses of rotor
' -----------------------------------------------
' Return rotor core losses
Set oModule = oDesign.GetModule("ReportSetup")
oModule.CreateReport "FFTpLosses", "Transient", "Data Table", "Setup : Transient", _
  Array("Domain:=", "Spectral", "StartTime:=", 0, "EndTime:=", 1.0*Frequency^(-1)/RtFrq, _
  "MaxHarmonic:=", 101, "NumSamples:=", NumberSteps/RtFrq+1, "WindowType:=", 0, "Normalize:=", 0, _
  "Periodic:=", 0, "FundementalFreq:=", Frequency, "CutoffFreq:=", 0), _
  Array("Freq:=", Array("All")), Array("X Component:=", "Freq", "Y Component:=", _
  Array("mag(CoreLoss(PoleShoe))")), Array()
oModule.ChangeProperty Array("NAME:AllTabs", Array("NAME:Data Filter", Array("NAME:PropServers",  _
  "FFTpLosses:mag(CoreLoss(PoleShoe)):Curve1"), Array("NAME:ChangedProps", Array("NAME:Units", "Value:=", "kW"))))
oModule.ChangeProperty Array("NAME:AllTabs", Array("NAME:Data Filter", Array("NAME:PropServers",  _
  "FFTpLosses:mag(CoreLoss(PoleShoe)):Curve1"), Array("NAME:ChangedProps", Array("NAME:Units", "Value:=", "W"))))  
Set objFSV = CreateObject("Scripting.FileSystemObject")
  FFTpLosses = MainFolder & "temp/" &  "RP_FFTpLosses" & IncTitle & ".csv"
  oModule.ExportToFile "FFTpLosses", MainFolder & "temp/" & "RP_FFTpLosses" & IncTitle & ".csv"  
' Read txt-file RP_FFTpLosses.csv
Set objFile = objFSV.OpenTextFile(FFTpLosses)
For i = 1 to 2
    str = objFile.ReadLine
	If i = 2 then
		arrStr = split(str, ",")
		pLosses = CStr(CDbl(arrStr(1)))
	End If
Next
  pLosses = pLosses*(PoleLength/GenLength)*(Poles/CalArea)

' Return damper solid losses / SolidLosses
oModule.CreateReport "FFTdLosses", "Transient", "Data Table", "Setup : Transient", _
  Array("Domain:=", "Spectral", "StartTime:=", 0, "EndTime:=", 1.0*Frequency^(-1)/RtFrq, _
  "MaxHarmonic:=", 101, "NumSamples:=", NumberSteps/RtFrq+1, "WindowType:=", 0, "Normalize:=", 0, _
  "Periodic:=", 0, "FundementalFreq:=", Frequency, "CutoffFreq:=", 0), _
  Array("Freq:=", Array("All")), Array("X Component:=", "Freq", "Y Component:=", _
  Array("mag(SolidLoss)")), Array()
oModule.ChangeProperty Array("NAME:AllTabs", Array("NAME:Data Filter", Array("NAME:PropServers",  _
  "FFTdLosses:mag(SolidLoss):Curve1"), Array("NAME:ChangedProps", Array("NAME:Units", "Value:=", "kW"))))
oModule.ChangeProperty Array("NAME:AllTabs", Array("NAME:Data Filter", Array("NAME:PropServers",  _
  "FFTdLosses:mag(SolidLoss):Curve1"), Array("NAME:ChangedProps", Array("NAME:Units", "Value:=", "W"))))    
Set objFSV = CreateObject("Scripting.FileSystemObject")
FFTdLosses = MainFolder & "temp/" & "RP_FFTdLosses" & IncTitle & ".csv"
oModule.ExportToFile "FFTdLosses", MainFolder & "temp/" & "RP_FFTdLosses" & IncTitle & ".csv"
' Read txt-file RP_FFTdLosses.csv
Set objFile = objFSV.OpenTextFile(FFTdLosses)
For i = 1 to 2
    str = objFile.ReadLine
	If i = 2 then
		arrStr = split(str, ",")
		dLosses = CStr(CDbl(arrStr(1)))
	End If
Next
  dLosses = dLosses*(LengthDamper/GenLength)*(Poles/CalArea)
  TotalLosses = Round(dLosses,0)+Round(pLosses,0)+Round(StatorCoreLosses,0) 

' -----------------------------------------------	
' Notes and "SolvedValues.txt"
' -----------------------------------------------	  
' StrText = "Date	DGap[mm]	DYoke[mm]	Bs2[mm]	Gap[mm]	SCore[m2]	Losses[W]	Voltage[V]	THD[-]" & vbCrLf
StrText = ""
StrText = StrText & Day(Date) & "." &  Month(Date) & "." & Year(Date) & " " & Hour(Time) & ":" & Minute(Time) & vbTab 
StrText = StrText & Station & vbTab
StrText = StrText & _
  ProjectValue("$DiaGap", 2, 2) & vbTab & _
  ProjectValue("$DiaYoke", 2, 2) & vbTab &  _
  ProjectValue("$Bs2", 2, 2) & vbTab &   _
  ProjectValue("$AirGap", 2, 2) & vbTab
StrText = StrText & CStr(Round(StatorCoreVolume, 6)) & vbTab
StrText = StrText & CStr(Round(StatorCoreYoke, 0)) & vbTab  
StrText = StrText & CStr(Round(StatorCoreTooth, 0)) & vbTab  
StrText = StrText & CStr(Round(StatorCoreLosses, 0)) & vbTab  
StrText = StrText & CStr(Round(fft1h, 0)) & vbTab  
StrText = StrText & CStr(Round(pLosses, 0)) & vbTab 
StrText = StrText & CStr(Round(dLosses, 0)) & vbTab 
StrText = StrText & CStr(Round(THDCal, 4)) & vbTab 

' -----------------------------------------------	 
s = s & "RESULTS" & " (CalArea=" & CStr(CalArea) & ", ["& CStr(StYLoss(0)) & "; " & CStr(Round(StYLoss(1),2)) & "; " & CStr(StYLoss(2)) & "]):" & Chr(13) & Chr(10)
s = s & "1. Calculated stator core volume is " & CStr(Round(StatorCoreVolume, 3)) & " [m^3]" & Chr(13) & Chr(10)
s = s & "2. Stator core losses (Y+T) is " & CStr(Round(StatorCoreYoke, 0)) & " + " & CStr(Round(StatorCoreTooth, 0)) _
& " = " & CStr(Round(StatorCoreLosses, 0)) & " [W]"  & Chr(13) & Chr(10)
's = s & "3. Stator voltage is" & CStr(Round(3^0.5*StatorVoltage/3,0)) & " [V]"  & Chr(13) & Chr(10)    
s = s & "3. Stator voltage is " & CStr(Round(fft1h, 0)) & " [V]." & _
        " Error is " & CStr(Round((1-Round(fft1h, 0)/SVolt)*100, 1)) & "%" & Chr(13) & Chr(10)  
s = s & "4. Flux stator voltage (flux=" & CStr(Round(Flux1f, 3)) & "Bb/m with ky1=" & CStr(Round(ky1, 3)) & _
", kp1=" & CStr(Round(kp1, 3)) & ") is " & CStr(Round(FluxStatorVoltage, 0)) & " [V]." & _
          " Error is " & CStr(Round((1-Round(FluxStatorVoltage, 0)/SVolt)*100, 1)) & "%" & Chr(13) & Chr(10)  
s = s & "5. Used rotor current is " & CStr(Round(CurrentRotor,0)) & " [A]." & _
        " Error is " & CStr(Round((1-CurrentRotor/ExValue(0))*100, 1)) & "%" & Chr(13) & Chr(10)
s = s & "6. Expected rotor current is " & CStr(Round(CurrentRotor*SVolt/Round(fft1h, 0),0)) & " [A]"  & Chr(13) & Chr(10)
s = s & "7. Bm in air gap is " & CStr(Round(Bmair, 2)) & " [T]"  & Chr(13) & Chr(10)
s = s & "8.1 End part losses (0.142p(Bm*Wt)^2*Gt) is " & CStr(Round(Lossesendpart, 0)) & " [W]"  & Chr(13) & Chr(10)
s = s & "8.2 Rotor core losses is " & CStr(Round(pLosses, 0)) & " [W]"  & Chr(13) & Chr(10) 
s = s & "8.3 Damper solid losses is " & CStr(Round(dLosses, 0)) & " [W]"  & Chr(13) & Chr(10)   
s = s & "8.4 Total losses is " & CStr(TotalLosses) & " [W]"  & _
  " Error total losses is " & CStr(Round((1-TotalLosses/ExValue(1))*100, 1)) & "%"  & Chr(13) & Chr(10) 
s = s & "8.5 Total losses plus end part losses is " & CStr(TotalLosses+Round(Lossesendpart, 0)) & " [W]"  & _ 
  " Error total losses plus end part losses is " & CStr(Round((1-(TotalLosses+Round(Lossesendpart, 0))/ExValue(1))*100, 1)) & "%"  & Chr(13) & Chr(10) 
s = s & "9. THD is " & CStr(Round(THDCal, 4)) & " [%]"  &  Chr(13) & Chr(10)   
oDesign.EditNotes s