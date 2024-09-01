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
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/DOSSA/datafs1
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/DOSSA/datafs2
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/DOSSA/datafs3
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/DOSSA/indexfs1
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/DOSSA/indexfs2
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/DOSSA/lobfs1
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/datafs1
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/datafs2
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/datafs3
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/indexfs1
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/indexfs2
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/lobfs1
mkdir -p /home/db2inst1/db2inst1/NODE0000/CPEDB/log

chmod -R 777 /home/db2inst1/db2inst1/NODE0000/CPEDB

output=$(db2 -stf "./createDatabase_ECM.sql")
sql_return_code=$?
# Ignore the DB2 grant self error
if [ -z "${output##*SQLSTATE=42502*}" ] && [ -z "${output##*SQL0554N*}" ]
then
    sql_return_code=0
fi
exit $sql_return_code
