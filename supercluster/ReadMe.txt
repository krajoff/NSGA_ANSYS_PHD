-------------------------
 Matlab
-------------------------
1. Launch Matlab;

2. Run script distcomp.feature('LocalUseMpiexec', false) in command window;

3. Run setName.m in maxwell folder;

4. Run TP_maxwell.m.

Update 07.03.2018:
1. Add 10th value the stator core length [mm].
2. Add the stator core length in line 1363. Now StatorCoreArea is StatorCoreVolume

Update 13.03.2018:
1. Change "$Hrw", CStr(Hrw) & "mm*" & CStr(Brw) & "mm/$Brw" to "$Hrw", CStr(Hrw) & "mm*72mm/$Brw"
2. Add MW_Solution.Djerdap.NoLoad.Lin.Base.vbs

Update 20.03.2018:
1. Add Ns, Bs, Ksr
2. Stator core losses were altered

Update 15.07.2018:
1. Add ShoeWidthMinor and ShoeWidthMajor
