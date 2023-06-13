' -----------------------------------------------
' Analysis problem
' -----------------------------------------------
Set oModule = oDesign.GetModule("AnalysisSetup")
If oDesign.GetSolutionType = "Transient" then
  oModule.ResetSetupToTimeZero "Setup"
End If
oProject.Save
oDesign.AnalyzeAll