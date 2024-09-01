@REM BEGIN COPYRIGHT
@REM *************************************************************************
@REM 
@REM  Licensed Materials - Property of IBM
@REM  5725-C94, 5725-C95, 5725-C96
@REM  (C) Copyright IBM Corporation 2013, 2023. All Rights Reserved.
@REM  US Government Users Restricted Rights- Use, duplication or disclosure
@REM  restricted by GSA ADP Schedule Contract with IBM Corp.
@REM 
@REM *************************************************************************
@REM END COPYRIGHT
@echo off
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\DOSSA\datafs1"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\DOSSA\datafs2"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\DOSSA\datafs3"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\DOSSA\indexfs1"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\DOSSA\indexfs2"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\DOSSA\lobfs1"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\TOSSA\datafs1"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\TOSSA\datafs2"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\TOSSA\datafs3"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\TOSSA\indexfs1"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\TOSSA\indexfs2"
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\TOSSA\lobfs1"	
md "/home/db2inst1/db2inst1/NODE0000\CPEDB\log"

setlocal

set comandstr=db2cmd /c /w /i db2 -stf "./createDatabase_ECM.sql"
set outputFile="%TEMP%\%~n0.tmp"

if #%1 == # goto executecomand
set comandstr=db2cmd /c /w /i db2 -stf "%1/createDatabase_ECM.sql"

:executecomand
%comandstr% > "%outputFile%" 2>&1 & type %outputFile%
set RC=%ERRORLEVEL%

if RC == 0 goto end
findstr /m "SQL0554N" %outputFile%
set RC1=%ERRORLEVEL%
findstr /m "SQLSTATE=42502" %outputFile%
set RC2=%ERRORLEVEL%
if %RC1% == 0 (
   if %RC2% == 0 (
@REM ignore the grant self error
      set RC=0
  )
)

:end
@REM end

endlocal & exit /b %RC%
