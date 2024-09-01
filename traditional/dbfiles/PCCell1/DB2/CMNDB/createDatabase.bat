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
setlocal

set comandstr=db2cmd /c /w /i db2 -stf "./createDatabase.sql"
set outputFile="%TEMP%\%~n0.tmp"

if #%1 == # goto executecomand
set comandstr=db2cmd /c /w /i db2 -stf "%1/createDatabase.sql"

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
	  echo "The following error is ignored: SQL0554N  An authorization ID cannot grant a privilege or authority to itself"
  )
)

:end
@REM end

endlocal & exit /b %RC%
