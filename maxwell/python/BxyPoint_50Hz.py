# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("Project61")
oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
oModule = oDesign.GetModule("FieldsReporter")
vt = ["0s", "0.001s", "0.002s", "0.003s", "0.004s", "0.005s", "0.006s", "0.007s", "0.008s", "0.009s", "0.01s", \
	"0.011s", "0.012s", "0.013s", "0.014s", "0.015s", "0.016s", "0.017s", "0.018s", "0.019s", "0.02s"]
k = 1
oModule.CalcStack("clear")
for i in vt :
	oModule.CopyNamedExprToStack("B_Vector")
	oModule.CalcOp("ScalarY")
	oModule.EnterPoint("Point4")
	oModule.CalcOp("Value")
	oModule.ClcEval("Setup : Transient", 
	[
		"Time:="		, i
	])
	cnt = 0
	while cnt < k:
		cnt += 1
		oModule.CalcStack("rldn")
	oModule.CalcStack("pop")
	k += 1