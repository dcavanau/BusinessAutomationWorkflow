
-- Connect to db
CONNECT TO CPEDB;

-- Create Schema
CREATE SCHEMA TOSSA;
SET SCHEMA TOSSA;

-- Create 256MB GCD buffer pool
CREATE Bufferpool TOSSA_DATA_BP IMMEDIATE SIZE AUTOMATIC PAGESIZE 32K;
CREATE Bufferpool TOSSA_INDX_BP IMMEDIATE SIZE AUTOMATIC PAGESIZE 32K;

-- Create additional buffer pools
CREATE Bufferpool TOSSA_LOB_BP IMMEDIATE SIZE AUTOMATIC PAGESIZE 32K;
CREATE Bufferpool TOSSA_TEMP_BP IMMEDIATE SIZE AUTOMATIC PAGESIZE 32K;
CREATE Bufferpool TOSSA_SYS_BP IMMEDIATE SIZE AUTOMATIC PAGESIZE 32K;

CREATE STOGROUP TOSSADATA_SG ON '/home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/datafs1', '/home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/datafs2', '/home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/datafs3';
CREATE STOGROUP TOSSAINDX_SG ON '/home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/indexfs1', '/home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/indexfs2';
CREATE STOGROUP TOSSALOB_SG ON '/home/db2inst1/db2inst1/NODE0000/CPEDB/TOSSA/lobfs1';

-- Create table spaces
CREATE LARGE TABLESPACE TOSSA_DATA_TS PAGESIZE 32 K
MANAGED BY AUTOMATIC STORAGE
USING STOGROUP TOSSADATA_SG
EXTENTSIZE 16 OVERHEAD 10.5 PREFETCHSIZE 16 TRANSFERRATE 0.14
BUFFERPOOL TOSSA_DATA_BP DROPPED TABLE RECOVERY ON;

CREATE LARGE TABLESPACE TOSSA_IDX_TS PAGESIZE 32 K
MANAGED BY AUTOMATIC STORAGE
USING STOGROUP TOSSAINDX_SG
EXTENTSIZE 16 OVERHEAD 10.5 PREFETCHSIZE 16 TRANSFERRATE 0.14
BUFFERPOOL TOSSA_INDX_BP DROPPED TABLE RECOVERY ON;

CREATE LARGE TABLESPACE TOSSA_LOB_TS PAGESIZE 32 K
MANAGED BY AUTOMATIC STORAGE
USING STOGROUP TOSSALOB_SG
EXTENTSIZE 16 OVERHEAD 10.5 PREFETCHSIZE 16 TRANSFERRATE 0.14
BUFFERPOOL TOSSA_LOB_BP DROPPED TABLE RECOVERY ON;

CREATE USER TEMPORARY TABLESPACE TOSSA_TEMP_TS PAGESIZE 32 K
MANAGED BY AUTOMATIC STORAGE
EXTENTSIZE 16 OVERHEAD 10.5 PREFETCHSIZE 16 TRANSFERRATE 0.14
BUFFERPOOL TOSSA_TEMP_BP;

CREATE SYSTEM TEMPORARY TABLESPACE TOSSA_SYSTMP_TS PAGESIZE 32 K
MANAGED BY AUTOMATIC STORAGE
EXTENTSIZE 16 OVERHEAD 10.5 PREFETCHSIZE 16 TRANSFERRATE 0.14
BUFFERPOOL TOSSA_SYS_BP;

GRANT USE OF TABLESPACE TOSSA_DATA_TS TO user bpmdbadm;
GRANT USE OF TABLESPACE TOSSA_IDX_TS TO user bpmdbadm;
GRANT USE OF TABLESPACE TOSSA_LOB_TS TO user bpmdbadm;
GRANT USE OF TABLESPACE TOSSA_TEMP_TS TO user bpmdbadm;

--GRANT IMPLICIT_SCHEMA ON DATABASE TO user db2admin;


-- Optionally, grant GROUP access to table spaces
-- GRANT CREATETAB,CONNECT ON DATABASE  TO GROUP DB2USERS;
-- GRANT USE OF TABLESPACE USERTEMP1 TO GROUP DB2USERS;
-- GRANT USE OF TABLESPACE USERSPACE1 TO GROUP DB2USERS;

-- Close connection
CONNECT RESET;