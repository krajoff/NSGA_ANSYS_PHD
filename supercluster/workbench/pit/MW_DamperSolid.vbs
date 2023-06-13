' -----------------------------------------------
' MW_DamperSolid.vbs. New setup with new step 1e-4. 
' Edit setup: StartTime = .0001s, EndTime = .007s, TimeStep = .0001s
' -----------------------------------------------
Set oModule = oDesign.GetModule("BoundarySetup")
ReDim pShoeLosses(CalArea-1)
k = 0
pShoeLosses(k) = "PoleShoe" 
k = k + 1
If CalArea >= 2 Then
  For i = 1 to CalArea-1
    pShoeLosses(k) = "PoleShoe_" & CStr(i)
    k = k + 1
  Next
End If
oModule.SetCoreLoss pShoeLosses, false
Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.EditSetup "Setup", Array("NAME:Setup", "Enabled:=", true, _
  "NonlinearSolverResidual:=", "0.0001", _
  "TimeIntegrationMethod:=", 0, _
  "StopTime:=", CStr(7*Frequency^(-1)/20) & "s", _
  "TimeStep:=", CStr(Frequency^(-1)/200) & "s", _ 
  "OutputError:=", false, "UseControlProgram:=", false, _
  "ControlProgramName:=", " ", "ControlProgramArg:=", " ", _
  "CallCtrlProgAfterLastStep:=", false, _
  "HasSweepSetup:=", false, _
  "TransientComputeHc:=", false, _
  "ThermalFeedback:=", false, _
  Array("NAME:HcOption", _
  "TransientHcNonLinearBH:=", true, _
  "TransientComputeHc:=", false), _
  "UseAdaptiveTimeStep:=", false, _
  "InitialTimeStep:=", "0.0001s", _
  "MinTimeStep:=", "0.00005s", _
  "MaxTimeStep:=", "0.0003s", _
  "TimeStepErrTolerance:=", 0.0001)
oModule.ResetSetupToTimeZero "Setup"
oProject.Save
oDesign.AnalyzeAll

' Return rotor core losses
Set oModule = oDesign.GetModule("ReportSetup")
oModule.CreateReport "FFTpLosses", "Transient", "Data Table", "Setup : Transient", _
  Array("Domain:=", "Spectral", "StartTime:=", 0, "EndTime:=", 7*Frequency^(-1)/20, _
  "MaxHarmonic:=", 101, "NumSamples:=", 71, "WindowType:=", 0, "Normalize:=", 0, _
  "Periodic:=", 0, "FundementalFreq:=", 142.857142857143, "CutoffFreq:=", 0), _
  Array("Freq:=", Array("All")), Array("X Component:=", "Freq", "Y Component:=", _
  Array("mag(CoreLoss)")), Array()
oModule.ChangeProperty Array("NAME:AllTabs", Array("NAME:Data Filter", Array("NAME:PropServers",  _
  "FFTpLosses:mag(CoreLoss):Curve1"), Array("NAME:ChangedProps", Array("NAME:Units", "Value:=", "kW"))))
oModule.ChangeProperty Array("NAME:AllTabs", Array("NAME:Data Filter", Array("NAME:PropServers",  _
  "FFTpLosses:mag(CoreLoss):Curve1"), Array("NAME:ChangedProps", Array("NAME:Units", "Value:=", "W"))))  
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
  pLosses = pLosses*(PoleLength/GenLength)
  s = s & "5. Rotor core losses is " & CStr(Round(pLosses, 0)) & " [W]"  & Chr(13) & Chr(10) 
  
' Return damper solid losses / SolidLosses
oModule.CreateReport "FFTdLosses", "Transient", "Data Table", "Setup : Transient", _
  Array("Domain:=", "Spectral", "StartTime:=", 0, "EndTime:=", 7*Frequency^(-1)/20, _
  "MaxHarmonic:=", 101, "NumSamples:=", 71, "WindowType:=", 0, "Normalize:=", 0, _
  "Periodic:=", 0, "FundementalFreq:=", 142.857142857143, "CutoffFreq:=", 0), _
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
  dLosses = dLosses*(LengthDamper/GenLength)
  s = s & "6. Damper solid losses is " & CStr(Round(dLosses, 0)) & " [W]"  & Chr(13) & Chr(10)   
  TotalLosses = Round(dLosses, 0)+Round(pLosses, 0)+Round(StatorCoreLosses, 0)
  s = s & "7.1. Total losses is " & CStr(TotalLosses) & " [W]"  & _
  " Error total losses is " & CStr(Round((1-TotalLosses/ExValue(1))*100, 1)) & "%"  & Chr(13) & Chr(10) 
  s = s & "7.2. Total losses plus end part losses is " & CStr(TotalLosses+Round(Lossesendpart, 0)) & " [W]"  & _ 
  " Error total losses plus end part losses is " & CStr(Round((1-(TotalLosses+Round(Lossesendpart, 0))/ExValue(1))*100, 1)) & "%"  & Chr(13) & Chr(10) & Chr(13) & Chr(10) 
  oDesign.EditNotes s
 
' -----------------------------------------------	
' Notes and "SolvedValues.txt"
' -----------------------------------------------	  
StrText = StrText & CStr(Round(pLosses, 0)) & vbTab 
StrText = StrText & CStr(Round(dLosses, 0))