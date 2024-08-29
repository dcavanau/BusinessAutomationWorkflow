-- user bpmdbadm has been created with a password of Think4me
db2 create database BPMDB automatic storage yes using codeset UTF-8 territory US pagesize 32768;
db2 connect to BPMDB;
-- A user temporary table space is required to support stored procedures in BPM
db2 ncreate user temporary tablespace usrtmpspc1;
db2 grant dbadm on database to user bpmdbadm;
db2 UPDATE DB CFG FOR BPMDB USING LOGFILSIZ 16384 DEFERRED;
db2 UPDATE DB CFG FOR BPMDB USING LOGSECOND 64 IMMEDIATE;
db2 connect reset;

db2 create database PDWDB automatic storage yes using codeset UTF-8 territory US pagesize 32768;
db2 connect to PDWDB;
-- A user temporary table space is required to support stored procedures in BPM
db2 create user temporary tablespace usrtmpspc1;
db2 grant dbadm on database to user bpmdbadm;
db2 UPDATE DB CFG FOR PDWDB USING LOGFILSIZ 16384 DEFERRED;
db2 UPDATE DB CFG FOR PDWDB USING LOGSECOND 64 IMMEDIATE;
db2 connect reset;

db2 create database CMNDB automatic storage yes using codeset UTF-8 territory US pagesize 32768;
db2 connect to CMNDB;
-- A user temporary table space is required to support stored procedures in BPM
db2 create user temporary tablespace usrtmpspc1;
db2 grant dbadm on database to user bpmdbadm;
db2 UPDATE DB CFG FOR CMNDB USING LOGFILSIZ 16384 DEFERRED;
db2 UPDATE DB CFG FOR CMNDB USING LOGSECOND 64 IMMEDIATE;
db2 connect reset;