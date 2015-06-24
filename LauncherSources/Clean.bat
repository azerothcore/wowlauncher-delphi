FOR /R .\ %%I IN (.\) DO (
   del "%%~pdI"*.~*   
   del "%%~pdI"*.dcu
   del "%%~pdI"*.map
   del "%%~pdI"*.mps
   del "%%~pdI"*.mpt
   del "%%~pdI"*.dsk
   del "%%~pdI"*.drc
   del "%%~pdI"*.dof
 )
