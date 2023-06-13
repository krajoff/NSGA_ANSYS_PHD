' -----------------------------------------------
' Create a container for txt-file
' -----------------------------------------------
Set objFSO=CreateObject("Scripting.FileSystemObject")
' Read txt-file
OutFile = MainFolder & "temp/" & "SolvedValues" & IncTitle & ".txt"
StrParag = ""
Set objFile = objFSO.OpenTextFile(OutFile)
Do Until objFile.AtEndOfStream
    StrLine = objFile.ReadLine
	StrParag = StrParag & StrLine & vbCrLf
Loop
' Write txt-file
Set objFile = objFSO.CreateTextFile(OutFile,True)
objFile.Write StrParag & StrText & vbCrLf
objFile.Close
' -----------------------------------------------
