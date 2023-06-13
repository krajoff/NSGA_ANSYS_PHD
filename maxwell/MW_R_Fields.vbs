' -----------------------------------------------
' Calculated R field coefficient 
' -----------------------------------------------
timeClc = CStr(1.0*10^9/(Frequency*NumberSteps)) & "ns"
Set oModule = oDesign.GetModule("FieldsReporter")

' Tooth setting losses coefficients
oModule.CalcStack "clear"
oModule.CopyNamedExprToStack "Mag_B"
oModule.EnterSurf "DiaYoke_0"
oModule.CalcOp "Mean"
oModule.ClcEval "Setup : Transient", Array("Time:=", timeClc)
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", timeClc))
  meanValue = CDbl(TopValue(0))
oModule.CalcStack "clear"
oModule.CopyNamedExprToStack "Mag_B"
oModule.EnterSurf "DiaYoke_0"
oModule.CalcOp "Std"
oModule.ClcEval "Setup : Transient", Array("Time:=", timeClc)
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", timeClc))
  stdValue = CDbl(TopValue(0))
  oModule.CalcStack "clear"
RTooth = ABS(1-2*(stdValue/meanValue))

' Yoke setting losses coefficients
Dim outputR()
Redim outputR(Nsuns) 
NameDiaYoke = Array("DiaYoke_1_Slot", "DiaYoke_1") 
For i = 0 to 1
  oModule.CalcStack "clear"
  oModule.CopyNamedExprToStack "Mag_B"
  oModule.EnterSurf NameDiaYoke(i)
  oModule.CalcOp "Mean"
  oModule.ClcEval "Setup : Transient", Array("Time:=", timeClc)
    TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", timeClc))
    meanValue = CDbl(TopValue(0))
    oModule.CalcStack "clear"
  oModule.CopyNamedExprToStack "Mag_B"
  oModule.EnterSurf NameDiaYoke(i)
  oModule.CalcOp "Std"
  oModule.ClcEval "Setup : Transient", Array("Time:=", timeClc)
    TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", timeClc))
    stdValue = CDbl(TopValue(0))
    oModule.CalcStack "clear"
  outputR(i) = ABS(1-2*(stdValue/meanValue))
Next  
For i = 2 to Nsuns
  oModule.CopyNamedExprToStack "Mag_B"
  oModule.EnterLine "PolyYokes_" & CStr(i-1)
  oModule.CalcOp "Minimum"
  oModule.CopyNamedExprToStack "Mag_B"
  oModule.EnterLine "PolyYokes_" & CStr(i-1)
  oModule.CalcOp "Maximum"
  oModule.CalcOp "/"
  oModule.CalcOp "Abs"
  oModule.ClcEval "Setup : Transient", Array("Time:=", timeClc)
  TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", timeClc))
  outputR(i) = CDbl(TopValue(0))
  oModule.CalcStack "clear"
Next
' -----------------------------------------------
' Apply R coefficient 
' -----------------------------------------------
Set oDefinitionManager = oProject.GetDefinitionManager()
For i = 0 to Nsuns
oDefinitionManager.EditMaterial Material_stator_yoke & "_" & CStr(i), Array("NAME:" & Material_stator_yoke & "_" & CStr(i), _ 
  "CoordinateSystemType:=", "Cartesian", "BulkOrSurfaceType:=", 1, _
  Array("NAME:PhysicsTypes", "set:=",  Array("Electromagnetic")), _
  Array("NAME:permeability", "property_type:=", "nonlinear", "BTypeForSingleCurve:=", "normal", _
  "HUnit:=", "A_per_meter", "BUnit:=", "tesla", "IsTemperatureDependent:=", false, BHStatorYoke, _
  Array("NAME:Temperatures")), "conductivity:=", "1818100", _
  Array("NAME:magnetic_coercivity", "property_type:=", "VectorProperty", _
  "Magnitude:=", "0A_per_meter", "DirComp1:=", "1", "DirComp2:=", "0", "DirComp3:=", "0"), _
  Array("NAME:core_loss_type", "property_type:=", "ChoiceProperty", "Choice:=", "Electrical Steel"), _
  "core_loss_kh:=", CStr(StYLoss(0)*(1+outputR(i))), "core_loss_kc:=",  CStr(StYLoss(1)), _
  "core_loss_ke:=", CStr(StYLoss(2)), "core_loss_kdc:=", "0", "mass_density:=",  "7800")
Next
oDefinitionManager.EditMaterial Material_stator_tooth, Array("NAME:" & Material_stator_tooth, _ 
  "CoordinateSystemType:=", "Cartesian", "BulkOrSurfaceType:=", 1, _
  Array("NAME:PhysicsTypes", "set:=",  Array("Electromagnetic")), _
  Array("NAME:permeability", "property_type:=", "nonlinear", "BTypeForSingleCurve:=", "normal", _
  "HUnit:=", "A_per_meter", "BUnit:=", "tesla", "IsTemperatureDependent:=", false, BHStatorTooth, _
  Array("NAME:Temperatures")), "conductivity:=", "1818100", _
  Array("NAME:magnetic_coercivity", "property_type:=", "VectorProperty", _
  "Magnitude:=", "0A_per_meter", "DirComp1:=", "1", "DirComp2:=", "0", "DirComp3:=", "0"), _
  Array("NAME:core_loss_type", "property_type:=", "ChoiceProperty", "Choice:=", "Electrical Steel"), _
  "core_loss_kh:=", CStr(StTLoss(0)*(1+RTooth)), "core_loss_kc:=",  CStr(StTLoss(1)), _
  "core_loss_ke:=", CStr(StTLoss(2)), "core_loss_kdc:=", "0", "mass_density:=",  "7800")
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