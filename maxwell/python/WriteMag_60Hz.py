# ----------------------------------------------
# Script Recorded by ANSYS Electronics Desktop Version 2019.2.0
# ----------------------------------------------
import ScriptEnv
ScriptEnv.Initialize("Ansoft.ElectronicsDesktop")
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("LaEskaLosses")
oDesign = oProject.SetActiveDesign("Maxwell2DDesign1")
oModule = oDesign.GetModule("FieldsReporter")
k = 0
folder = "D:\\PhD.Calculation\\Matlab_NSGAII_ES_01.06.2020_All_Cases\\maxwell\\mag_"
vt = ["0s", "0.00083333333333333s", "0.00166666666666667s", "0.0025s", "0.00333333333333333s", "0.00416666666666666s", "0.005s", \
	"0.00583333333333333s", "0.00666666666666666s", "0.0075s", "0.00833333333333333s", "0.00916666666666666s", "0.01s", "0.01083333333333333s", \
	"0.01166666666666667s", "0.0125s", "0.01333333333333333s", "0.01416666666666667s", "0.015s", "0.01583333333333333s", "0.01666666666666667s"]
for i in vt :
	oModule.CalcStack("clear")
	oModule.CopyNamedExprToStack("Mag_B")
	fullpath = folder + str(k) + ".fld"
	oModule.CalculatorWrite(fullpath, 
	[
		"Solution:="		, "Setup : Transient"
	], 
	[
		
		"Time:="		, i
	])
	k += 1