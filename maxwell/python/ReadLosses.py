# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("LaEskaSecond")
oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
oModule = oDesign.GetModule("FieldsReporter")
cnt = 0
folder = "D:\\PhD.Calculation\\Matlab_NSGAII_ES_01.06.2020_All_Cases\\maxwell\\solved_task_LaEska\\Field_Core_Loss\\CoreLossSecond_"
oModule.CalcStack("clear")
while cnt < 21:
	cnt += 1
	fullpath = folder + str(cnt) + ".fld"
	oModule.CalculatorRead(fullpath, "Setup : Transient", "Fields", 
	[
		"Time:="		, "0s"
	])
