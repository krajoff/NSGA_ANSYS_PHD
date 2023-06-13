# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("LaEskaLosses")
oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
oModule = oDesign.GetModule("FieldsReporter")

vt = ["0s", "0.00083333333333333s", "0.00166666666666667s", "0.0025s", "0.00333333333333333s", "0.00416666666666666s", "0.005s", \
	"0.00583333333333333s", "0.00666666666666666s", "0.0075s", "0.00833333333333333s", "0.00916666666666666s", "0.01s", "0.01083333333333333s", \
	"0.01166666666666667s", "0.0125s", "0.01333333333333333s", "0.01416666666666667s", "0.015s", "0.01583333333333333s", "0.01666666666666667s"]
k = 1
oModule.CalcStack("clear")
for i in vt :
	oModule.CopyNamedExprToStack("B_Vector")
	oModule.CalcOp("ScalarY")
	oModule.EnterPoint("Point8")
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