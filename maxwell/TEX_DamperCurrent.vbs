' ----------------------------------------------
' Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
' 12:30:32  июн 26, 2021
' ----------------------------------------------
Dim oAnsoftApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oAnsoftApp = CreateObject("Ansoft.ElectronicsDesktop")
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
Set oProject = oDesktop.SetActiveProject("Sayny")
Set oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
Set oModule = oDesign.GetModule("FieldsReporter")
Frequency = 50
RtFrq = 1
NumberDamper = 10
NumberSteps = 200
Redim DNumber(NumberSteps, NumberDamper-1)
str = ""

For i = 0 to NumberDamper-1
	For j = 0 to NumberSteps
		oModule.CalcStack "clear"
		oModule.CopyNamedExprToStack "Jz"
		oModule.EnterSurf "Damper_" & CStr(i)
		oModule.CalcOp "Integrate"
		oModule.ClcEval "Setup : Transient", Array("Time:=", CStr(1.0*10^9*j/(Frequency*NumberSteps*RtFrq)) & "ns")
		TopValue = oModule.GetTopEntryValue("Setup : Transient", Array("Time:=", CStr(1.0*10^9/(Frequency*NumberSteps*RtFrq)) & "ns"))
		DNumber(j,i) = CDbl(topvalue(0))
	Next
Next

For j = 0 to NumberSteps
	For i = 0 to NumberDamper-1
		str = str & CStr(DNumber(j,i)) & " "
	Next
	str = str & Chr(13) & Chr(10)
Next

oDesign.EditNotes str