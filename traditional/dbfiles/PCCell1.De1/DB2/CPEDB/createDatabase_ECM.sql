-- BEGIN COPYRIGHT
-- *************************************************************************
--
--  Licensed Materials - Property of IBM
--  5725-C94, 5725-C95, 5725-C96
--  (C) Copyright IBM Corporation 2018, 2023. All Rights Reserved.
--  US Government Users Restricted Rights- Use, duplication or disclosure
--  restricted by GSA ADP Schedule Contract with IBM Corp.
--
-- *************************************************************************
-- END COPYRIGHT

-- Create the database:
CREATE DATABASE CPEDB AUTOMATIC STORAGE YES 
USING CODESET UTF-8 TERRITORY US COLLATE
USING SYSTEM PAGESIZE 32768;


-- Increase the application heap size
UPDATE DB CFG FOR CPEDB USING APPLHEAPSZ 2560;

-- Connect to db
CONNECT TO CPEDB;

-- Drop unnecessary default tablespaces
DROP TABLESPACE USERSPACE1;

UPDATE DB CFG FOR CPEDB USING LOGFILSIZ 16384 DEFERRED;
UPDATE DB CFG FOR CPEDB USING LOGSECOND 64 IMMEDIATE;

UPDATE DB CFG FOR CPEDB USING NEWLOGPATH '/home/db2inst1/db2inst1/NODE0000/CPEDB/log' DEFERRED;
ALTER BUFFERPOOL IBMDEFAULTBP IMMEDIATE SIZE 250 AUTOMATIC;

GRANT CREATETAB,CONNECT,DBADM ON DATABASE TO user db2admin;
GRANT SELECT ON SYSIBM.SYSVERSIONS TO user db2admin;
GRANT SELECT ON SYSCAT.DATATYPES TO user db2admin;
GRANT USAGE on WORKLOAD SYSDEFAULTUSERWORKLOAD TO user db2admin;

-- Close connection
CONNECT RESET;
