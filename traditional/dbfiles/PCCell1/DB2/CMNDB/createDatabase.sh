#!/bin/sh
#BEGIN COPYRIGHT
#*************************************************************************
#
# Licensed Materials - Property of IBM
# 5725-C94, 5725-C95, 5725-C96
# (C) Copyright IBM Corporation 2013, 2023. All Rights Reserved.
# US Government Users Restricted Rights- Use, duplication or disclosure
# restricted by GSA ADP Schedule Contract with IBM Corp.
#
#*************************************************************************
#END COPYRIGHT

output=$(db2 -stf "./createDatabase.sql")
sql_return_code=$?
# Ignore the DB2 grant self error
if [ -z "${output##*SQLSTATE=42502*}" ] && [ -z "${output##*SQL0554N*}" ]
then
    sql_return_code=0
fi
exit $sql_return_code
