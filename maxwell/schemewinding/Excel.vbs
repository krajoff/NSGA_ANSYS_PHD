' Variables for applications processing 
Dim app, wb, rng, FSO, File, Txt
Set app = createobject("Excel.Application")
app.Visible = true
' Add a new workbook
Set wb = app.workbooks.add
' Variables used for calculations
Dim n, Phase, ph, Q, Q1(1000), Q2, Sym, Y, y1, y2, Z, z1
Phase = Array ("a", "z", "b", "x", "c", "y", "a", "z", "b")
Q = Array (3,2,2,3,2,2,3,2,3,2,2,3,2,2,3,2,2) 			' Coil group sequence Plyvna
Y = Array (1,9,15)
Q = Array (3,3,3,3,3,2,3,3,3,3,3,3,2,3,3,3,3,3,3,2,3,3) ' Coil group sequence Volzhsky
Y = Array (1,11,18)
Q = Array (5,5,5) 										' Coil group sequence Chirkeisky
Y = Array (1,14,27)
Q = Array (4,3,4,3,4,3)									' Coil group sequence Votkinsk
Y = Array (1,10,22)
y1 = Y(1) - Y(0) ' Primary winding step
y2 = Y(2) - Y(1) ' Secondary winding step
Dim arr(2,3000) ' Note: VBScript is zero-based
arr (1,0) = "top"
arr (2,0) = "bottom"
n = 0
Q2 = Q
For i = ubound(Q) to 3 Step -1
	If (ubound(Q) + 1) mod i = 0 Then
		For j = 1 to (ubound(Q) + 1) \ i - 1
			For k = 0 to i - 1
				If Q(k) = Q(k+i*j) Then 
					Q1(k) = Q(k)
					Else 
						Q1(0) = 0
						Exit For
				End If
			Next
		Next
	End If
	If Q1(0) <> 0 Then
		Q2 = Q1
	End If
	Erase Q1
Next
Sym = 0
For i = 0 to ubound(Q2)
	Sym = Sym + 3*Q2(i)
Next
For i = 1 to Sym
    arr(0,i) = i
Next
z1 = 0
ph = 0
n = 0
Do 
 For i = 1 to Q(n)
	z1 = z1 + 1
	arr (1,z1) = Phase(ph)
	If z1 - y1 < 1 Then
		arr (2, Sym + (z1 - y1)) = Phase (ph + 3)
	Else
		arr (2, z1 - y1) = Phase (ph + 3)
	End If
 Next
 If n = ubound(Q) Then 
	n = -1
 End If
 If ph = ubound(Phase) - 3 Then 
	ph = -1
 End If
 ph = ph + 1
 n = n + 1
Loop Until z1 = Sym*2
' Declare a range object to hold our data
Set rng = wb.Activesheet.Range("A1").Resize(3,Sym + 1)
' Now assign them all in one shot...
rng.value = arr
'Colouring cells
rng.Interior.Pattern = xlNone ' убираем заливку
For i = 1 To rng.Columns.Count ' цикл по столбцам диапазона
    If rng(2, i).Value = "a" or rng(2, i).Value = "x" Then
		rng(2, i).Interior.Color = RGB(255, 255, 200)
		ElseIf rng(2, i).Value = "b" or rng(2, i).Value = "y" Then
			rng(2, i).Interior.Color = RGB(200, 255, 200)
			ElseIf rng(2, i).Value = "c" or rng(2, i).Value = "z" Then
				rng(2, i).Interior.Color = RGB(255, 200, 200)
				End If
	If rng(3, i).Value = "a" or rng(3, i).Value = "x" Then
		rng(3, i).Interior.Color = RGB(255, 255, 200)
		ElseIf rng(3, i).Value = "b" or rng(3, i).Value = "y" Then
			rng(3, i).Interior.Color = RGB(200, 255, 200)
			ElseIf rng(3, i).Value = "c" or rng(3, i).Value = "z" Then
				rng(3, i).Interior.Color = RGB(255, 200, 200)
				End If			
Next
Set FSO = CreateObject("Scripting.FileSystemObject")
Set Txt = FSO.CreateTextFile("Phases.txt", True)
For i = 2 To rng.Columns.Count
	Txt.Write(Chr(34) & rng(2, i).Value & Chr(34) & ", ")
Next
Txt.Write(vbCrlf)
For i = 2 To rng.Columns.Count
	Txt.Write(Chr(34) & rng(3, i).Value & Chr(34) & ", ")
Next
