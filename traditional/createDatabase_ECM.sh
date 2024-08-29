#!/bin/sh
mkdir -p db2inst1/NODE0000/CPEDB/DOSSA/datafs1
mkdir -p db2inst1/NODE0000/CPEDB/DOSSA/datafs2
mkdir -p db2inst1/NODE0000/CPEDB/DOSSA/datafs3
mkdir -p db2inst1/NODE0000/CPEDB/DOSSA/indexfs1
mkdir -p db2inst1/NODE0000/CPEDB/DOSSA/indexfs2
mkdir -p db2inst1/NODE0000/CPEDB/DOSSA/lobfs1
mkdir -p db2inst1/NODE0000/CPEDB/TOSSA/datafs1
mkdir -p db2inst1/NODE0000/CPEDB/TOSSA/datafs2
mkdir -p db2inst1/NODE0000/CPEDB/TOSSA/datafs3
mkdir -p db2inst1/NODE0000/CPEDB/TOSSA/indexfs1
mkdir -p db2inst1/NODE0000/CPEDB/TOSSA/indexfs2
mkdir -p db2inst1/NODE0000/CPEDB/TOSSA/lobfs1
mkdir -p db2inst1/NODE0000/CPEDB/sys
mkdir -p db2inst1/NODE0000/CPEDB/systmp
mkdir -p db2inst1/NODE0000/CPEDB/usr
mkdir -p db2inst1/NODE0000/CPEDB/log

chmod -R 777 db2inst1/NODE0000/CPEDB

db2 -stf "./createDatabase_ECM.sql"
exit $?
