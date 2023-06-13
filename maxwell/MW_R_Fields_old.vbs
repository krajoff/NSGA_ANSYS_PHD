' -----------------------------------------------
' Calculated R field coefficient 
' -----------------------------------------------
timeClc = CStr(1.0*10^9/(Frequency*NumberSteps)) & "ns"
Set oModule = oDesign.GetModule("FieldsReporter")
Dim outputR()
Redim outputR(Nsuns-1)  
oModule.CalcStack "clear"
oModule.CopyNamedExprToStack "Mag_B"
oModule.EnterSurf "DiaYoke_1_Slot"
oModule.CalcOp "Mean"
oModule.CopyNamedExprToStack "Mag_B"
oModule.EnterSurf "DiaYoke_1_Slot"
oModule.CalcOp "Std"
oModule.CalcOp "/"
oModule.EnterScalar 0.5
oModule.CalcOp "*"
oModule.EnterScalar 1
oModule.CalcOp "-"
oModule.CalcOp "Abs"
oModule.ClcEval "Setup : Transient", Array("Time:=", timeClc)
TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", timeClc))
outputR(0) = CDbl(TopValue(0))
oModule.CalcStack "clear"
For i = 1 to Nsuns-1
  oModule.CopyNamedExprToStack "Mag_B"
  oModule.EnterSurf "DiaYoke_" & CStr(i)
  oModule.CalcOp "Mean"
  oModule.CopyNamedExprToStack "Mag_B"
  oModule.EnterSurf "DiaYoke_" & CStr(i)
  oModule.CalcOp "Std"
  oModule.CalcOp "/"
  oModule.EnterScalar 0.5
  oModule.CalcOp "*"
  oModule.EnterScalar 1
  oModule.CalcOp "-"
  oModule.CalcOp "Abs"
  oModule.ClcEval "Setup : Transient", Array("Time:=", timeClc)
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", timeClc))
  If CDbl(TopValue(0))>1 then
    outputR(i) = ABS(2 - CDbl(TopValue(0))) 
  Else 
    outputR(i) = CDbl(TopValue(0))
  End If
  oModule.CalcStack "clear"
Next
' -----------------------------------------------
' Apply R coefficient 
' -----------------------------------------------
Set oDefinitionManager = oProject.GetDefinitionManager()
For i = 1 to Nsuns
oDefinitionManager.EditMaterial Material_stator_yoke & "_" & CStr(i), Array("NAME:" & Material_stator_yoke & "_" & CStr(i), _ 
  "CoordinateSystemType:=", "Cartesian", "BulkOrSurfaceType:=", 1, _
  Array("NAME:PhysicsTypes", "set:=",  Array("Electromagnetic")), _
  Array("NAME:permeability", "property_type:=", "nonlinear", "BTypeForSingleCurve:=", "normal", _
  "HUnit:=", "A_per_meter", "BUnit:=", "tesla", "IsTemperatureDependent:=", false, BHStatorYoke, _
  Array("NAME:Temperatures")), "conductivity:=", "1818100", _
  Array("NAME:magnetic_coercivity", "property_type:=", "VectorProperty", _
  "Magnitude:=", "0A_per_meter", "DirComp1:=", "1", "DirComp2:=", "0", "DirComp3:=", "0"), _
  Array("NAME:core_loss_type", "property_type:=", "ChoiceProperty", "Choice:=", "Electrical Steel"), _
  "core_loss_kh:=", CStr(StYLoss(0)*(2-outputR(i-1))), "core_loss_kc:=",  CStr(StYLoss(1)), _
  "core_loss_ke:=", CStr(StYLoss(2)), "core_loss_kdc:=", "0", "mass_density:=",  "7800")
Next
' -----------------------------------------------
' Analysis problem
' -----------------------------------------------
Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.EditSetup "Setup", Array("NAME:Setup", "Enabled:=", true, _
  "StopTime:=", CStr(1.0/Frequency/RtFrq) & "s")
If oDesign.GetSolutionType = "Transient" then
  oModule.ResetSetupToTimeZero "Setup"
End If
oProject.Save
oDesign.AnalyzeAll