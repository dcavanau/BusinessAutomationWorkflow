-- BEGIN COPYRIGHT
-- *************************************************************************
--
--  Licensed Materials - Property of IBM
--  5725-C94, 5725-C95, 5725-C96
--  (C) Copyright IBM Corporation 2010, 2016. All Rights Reserved.
--  US Government Users Restricted Rights- Use, duplication or disclosure
--  restricted by GSA ADP Schedule Contract with IBM Corp.
--
-- *************************************************************************
-- END COPYRIGHT


CREATE TABLE db2admin.PS_WLSTORE (
"ID" DECIMAL(30, 0) NOT NULL ,
"TYPE" DECIMAL(30, 0) ,
"HANDLE" DECIMAL(30, 0) ,
"RECORD" BLOB(2G)
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;

CREATE TABLE db2admin.LSW_SYSTEM (
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"NAME" VARCHAR( 256) NOT NULL ,
"DESCRIPTION" CLOB(2G) ,
"ARCHIVED" TIMESTAMP ,
"VERSION" DECIMAL(31, 0) ,
"LAST_MODIFIED_BY_USER_ID" DECIMAL(31, 0) ,
"LAST_MODIFIED" TIMESTAMP
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_SYSTEM
 ADD CONSTRAINT "NAME" CHECK (CHARACTER_LENGTH("NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_TRACKING_GROUP (
"TRACKING_GROUP_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"EXTERNAL_UNIQUE_ID" VARCHAR( 256) ,
"NAME" VARCHAR( 256) NOT NULL ,
"DESCRIPTION" CLOB(2G) ,
"ARCHIVED" TIMESTAMP ,
"VERSION" DECIMAL(31, 0) ,
"LAST_MODIFIED_BY_USER_ID" DECIMAL(31, 0) ,
"LAST_MODIFIED" TIMESTAMP ,
"TABLE_ID" DECIMAL(31, 0) ,
"SNAPSHOT_ID" CHAR(36) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_TRACKING_GROUP
 ADD CONSTRAINT "EXTERNAL_UNIQUE_ID" CHECK (CHARACTER_LENGTH("EXTERNAL_UNIQUE_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TRACKING_GROUP
 ADD CONSTRAINT "NAME" CHECK (CHARACTER_LENGTH("NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_TRACKING_POINT (
"TRACKING_POINT_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_GROUP_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"EXTERNAL_UNIQUE_ID" VARCHAR( 256) ,
"NAME" VARCHAR( 2400) NOT NULL ,
"DESCRIPTION" CLOB(2G) ,
"ARCHIVED" TIMESTAMP ,
"VERSION" DECIMAL(31, 0) ,
"LAST_MODIFIED_BY_USER_ID" DECIMAL(31, 0) ,
"LAST_MODIFIED" TIMESTAMP ,
"TYPE" VARCHAR( 200) ,
"LOCAL_PROCESS_GUID" VARCHAR( 256) ,
"PROCESS_ITEM_ID" VARCHAR( 400) ,
"SNAPSHOT_ID" CHAR(36) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_TRACKING_POINT
 ADD CONSTRAINT "EXTERNAL_UNIQUE_ID" CHECK (CHARACTER_LENGTH("EXTERNAL_UNIQUE_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TRACKING_POINT
 ADD CONSTRAINT "NAME" CHECK (CHARACTER_LENGTH("NAME",CODEUNITS16) <= 600)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TRACKING_POINT
 ADD CONSTRAINT "TYPE" CHECK (CHARACTER_LENGTH("TYPE",CODEUNITS16) <= 50)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TRACKING_POINT
 ADD CONSTRAINT "LOCAL_PROCESS_GUID" CHECK (CHARACTER_LENGTH("LOCAL_PROCESS_GUID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TRACKING_POINT
 ADD CONSTRAINT "PROCESS_ITEM_ID" CHECK (CHARACTER_LENGTH("PROCESS_ITEM_ID",CODEUNITS16) <= 100)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_TRACKED_FIELD (
"TRACKED_FIELD_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_GROUP_ID" DECIMAL(31, 0) NOT NULL ,
"EXTERNAL_UNIQUE_ID" VARCHAR( 256) ,
"NAME" VARCHAR( 256) NOT NULL ,
"DESCRIPTION" CLOB(2G) ,
"FIELD_TYPE" DECIMAL(2, 0) NOT NULL ,
"ARCHIVED" TIMESTAMP ,
"COLUMN_ID" DECIMAL(31, 0) ,
"ALLOCATED" TIMESTAMP ,
"SNAPSHOT_ID" CHAR(36) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_TRACKED_FIELD
 ADD CONSTRAINT "EXTERNAL_UNIQUE_ID" CHECK (CHARACTER_LENGTH("EXTERNAL_UNIQUE_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TRACKED_FIELD
 ADD CONSTRAINT "NAME" CHECK (CHARACTER_LENGTH("NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_TRACKED_FIELD_USE (
"TRACKED_FIELD_USE_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_GROUP_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_POINT_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKED_FIELD_ID" DECIMAL(31, 0) NOT NULL ,
"ARCHIVED" TIMESTAMP ,
"SNAPSHOT_ID" CHAR(36) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;

CREATE TABLE db2admin.LSW_TIMING_INTERVAL (
"TIMING_INTERVAL_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"EXTERNAL_UNIQUE_ID" VARCHAR( 256) ,
"IS_AUTO" CHAR(1) DEFAULT 'T' NOT NULL ,
"NAME" VARCHAR( 3200) NOT NULL ,
"DESCRIPTION" CLOB(2G) ,
"START_BOUND" DECIMAL(2, 0) NOT NULL ,
"END_BOUND" DECIMAL(2, 0) NOT NULL ,
"ARCHIVED" TIMESTAMP ,
"VERSION" DECIMAL(31, 0) ,
"LAST_MODIFIED_BY_USER_ID" DECIMAL(31, 0) ,
"LAST_MODIFIED" TIMESTAMP
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL
 ADD CONSTRAINT "EXTERNAL_UNIQUE_ID" CHECK (CHARACTER_LENGTH("EXTERNAL_UNIQUE_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL
 ADD CONSTRAINT "NAME" CHECK (CHARACTER_LENGTH("NAME",CODEUNITS16) <= 800)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_TIMING_INTERVAL_BOUND (
"TIMING_INTERVAL_BOUND_ID" DECIMAL(31, 0) NOT NULL ,
"TIMING_INTERVAL_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_POINT_ID" DECIMAL(31, 0) NOT NULL ,
"BOUND" DECIMAL(2, 0) NOT NULL ,
"ARCHIVED" TIMESTAMP ,
"SNAPSHOT_ID" CHAR(36) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;

CREATE TABLE db2admin.LSW_TASK_PLAYBACK (
"TASK_ID" DECIMAL(31, 0) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;

CREATE TABLE db2admin.LSW_TASK (
"TASK_ID" DECIMAL(31, 0) NOT NULL ,
"FUNCTIONAL_TASK_ID" DECIMAL(31, 0) NOT NULL ,
"IS_INSTANCE" CHAR(1) DEFAULT 'F' NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_USER_ID" VARCHAR( 256) ,
"SYSTEM_TASK_ID" VARCHAR( 256) ,
"SYSTEM_FUNCTIONAL_TASK_ID" VARCHAR( 256) ,
"BPD_NAME" VARCHAR( 256) ,
"STARTING_PROCESS_ID" VARCHAR( 8000) ,
"STARTING_PROCESS_SNAPSHOT_ID" CHAR(36) ,
"ACTIVITY_NAME" VARCHAR( 2320) ,
"CREATED_BY_PROCESS_ITEM_ID" VARCHAR( 256) ,
"CREATION_TIME" TIMESTAMP ,
"START_TIME" TIMESTAMP ,
"END_TIME" TIMESTAMP ,
"STATUS" DECIMAL(31, 0) ,
"ASSIGNED_GROUP_ID" VARCHAR( 1044) ,
"SNAPSHOT_ID" CHAR(36) ,
"PROJECT_ID" CHAR(36) ,
"MAX_STEP" DECIMAL(31, 0) DEFAULT 0
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "SYSTEM_USER_ID" CHECK (CHARACTER_LENGTH("SYSTEM_USER_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "SYSTEM_TASK_ID" CHECK (CHARACTER_LENGTH("SYSTEM_TASK_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "SYSTEM_FUNCTIONAL_TASK_ID" CHECK (CHARACTER_LENGTH("SYSTEM_FUNCTIONAL_TASK_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "BPD_NAME" CHECK (CHARACTER_LENGTH("BPD_NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "STARTING_PROCESS_ID" CHECK (CHARACTER_LENGTH("STARTING_PROCESS_ID",CODEUNITS16) <= 2000)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "ACTIVITY_NAME" CHECK (CHARACTER_LENGTH("ACTIVITY_NAME",CODEUNITS16) <= 580)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "CREATED_BY_PROCESS_ITEM_ID" CHECK (CHARACTER_LENGTH("CREATED_BY_PROCESS_ITEM_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TASK
 ADD CONSTRAINT "ASSIGNED_GROUP_ID" CHECK (CHARACTER_LENGTH("ASSIGNED_GROUP_ID",CODEUNITS16) <= 261)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_TIMING_INTERVAL_VALUE (
"TIMING_INTERVAL_VALUE_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"TIMING_INTERVAL_ID" DECIMAL(31, 0) NOT NULL ,
"FUNCTIONAL_TASK_ID" DECIMAL(31, 0) NOT NULL ,
"START_TASK_ID" DECIMAL(31, 0) NOT NULL ,
"START_TRACKING_GROUP_ID" DECIMAL(31, 0) NOT NULL ,
"START_TRACKING_POINT_ID" DECIMAL(31, 0) NOT NULL ,
"START_TRACKING_POINT_VALUE_ID" DECIMAL(31, 0) NOT NULL ,
"START_TIME" TIMESTAMP ,
"END_TASK_ID" DECIMAL(31, 0) NOT NULL ,
"END_TRACKING_GROUP_ID" DECIMAL(31, 0) NOT NULL ,
"END_TRACKING_POINT_ID" DECIMAL(31, 0) NOT NULL ,
"END_TRACKING_POINT_VALUE_ID" DECIMAL(31, 0) NOT NULL ,
"END_TIME" TIMESTAMP ,
"DURATION" DECIMAL(16, 0) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;

CREATE TABLE db2admin.LSW_TRACKING_POINT_VALUE (
"TRACKING_POINT_VALUE_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_GROUP_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_POINT_ID" DECIMAL(31, 0) NOT NULL ,
"TASK_ID" DECIMAL(31, 0) NOT NULL ,
"FUNCTIONAL_TASK_ID" DECIMAL(31, 0) NOT NULL ,
"TIME_STAMP" TIMESTAMP ,
"STEP_NUMBER" DECIMAL(31, 0) ,
"SNAPSHOT_ID" CHAR(36)
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;

CREATE TABLE db2admin.LSW_PRI_KEY (
"TABLE_ID" VARCHAR( 256) NOT NULL ,
"HIGH_KEY" DECIMAL(31, 0) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_PRI_KEY
 ADD CONSTRAINT "TABLE_ID" CHECK (CHARACTER_LENGTH("TABLE_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_LOAD_TRACE (
"LOAD_TRACE_ID" DECIMAL(31, 0) NOT NULL ,
"SYNCHRONIZATION_EUID" VARCHAR( 256) NOT NULL ,
"LOAD_TYPE" DECIMAL(2, 0) NOT NULL ,
"TIME_RECEIVED" TIMESTAMP NOT NULL ,
"TIME_VALIDATED" TIMESTAMP ,
"TIME_LOADED" TIMESTAMP ,
"TIME_DELETED" TIMESTAMP ,
"TIME_REQUEUED" TIMESTAMP ,
"STATUS" DECIMAL(2, 0) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_LOAD_TRACE
 ADD CONSTRAINT "SYNCHRONIZATION_EUID" CHECK (CHARACTER_LENGTH("SYNCHRONIZATION_EUID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_VIEW (
"VIEW_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"TABLE_ID" DECIMAL(31, 0) ,
"VIEW_TYPE" DECIMAL(5, 0) ,
"NAME" VARCHAR( 400) ,
"CREATED_DATE" TIMESTAMP
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_VIEW
 ADD CONSTRAINT "NAME" CHECK (CHARACTER_LENGTH("NAME",CODEUNITS16) <= 100)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_USR_XREF (
"USER_ID" DECIMAL(12, 0) NOT NULL ,
"USER_NAME" VARCHAR( 256) NOT NULL ,
"PROVIDER" VARCHAR( 512)
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_USR_XREF
 ADD CONSTRAINT "USER_NAME" CHECK (CHARACTER_LENGTH("USER_NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_USR_XREF
 ADD CONSTRAINT "PROVIDER" CHECK (CHARACTER_LENGTH("PROVIDER",CODEUNITS16) <= 128)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_DATA_TRANSFER_ERRORS (
"DATA_TRANSFER_ERRORS_ID" VARCHAR( 256) NOT NULL ,
"TIME_CLAIMED" TIMESTAMP ,
"CLAIMED_BY" VARCHAR( 256) ,
"REPROCESS" CHAR(1) ,
"TIME_OF_ERROR" TIMESTAMP ,
"ERROR" CLOB(2G) ,
"DATA" BLOB(2G) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_DATA_TRANSFER_ERRORS
 ADD CONSTRAINT "DATA_TRANSFER_ERRORS_ID" CHECK (CHARACTER_LENGTH("DATA_TRANSFER_ERRORS_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_DATA_TRANSFER_ERRORS
 ADD CONSTRAINT "CLAIMED_BY" CHECK (CHARACTER_LENGTH("CLAIMED_BY",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_OPTIMIZER_DATA (
"TRACKING_POINT_VALUE_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKED_FIELD_ID" DECIMAL(31, 0) NOT NULL ,
"NUMBER_VALUE" DECIMAL(31, 6) ,
"DATE_VALUE" TIMESTAMP ,
"STRING_VALUE" VARCHAR( 1020)
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_OPTIMIZER_DATA
 ADD CONSTRAINT "STRING_VALUE" CHECK (CHARACTER_LENGTH("STRING_VALUE",CODEUNITS16) <= 255)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_USER_MAPPINGS (
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"USER_ID" DECIMAL(31, 0) NOT NULL ,
"USERNAME" VARCHAR( 256) NOT NULL
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_USER_MAPPINGS
 ADD CONSTRAINT "USERNAME" CHECK (CHARACTER_LENGTH("USERNAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_SYSTEM_SCHEMA (
"PROPNAME" VARCHAR( 200) NOT NULL ,
"PROPVALUE" VARCHAR( 200)
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_SYSTEM_SCHEMA
 ADD CONSTRAINT "PROPNAME" CHECK (CHARACTER_LENGTH("PROPNAME",CODEUNITS16) <= 50)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_SYSTEM_SCHEMA
 ADD CONSTRAINT "PROPVALUE" CHECK (CHARACTER_LENGTH("PROPVALUE",CODEUNITS16) <= 50)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_TABLE (
"TABLE_ID" DECIMAL(31, 0) NOT NULL ,
"SYSTEM_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKING_GROUP_NAME" VARCHAR( 256) NOT NULL ,
"EXTERNAL_UNIQUE_ID" VARCHAR( 256) ,
"ARCHIVED" TIMESTAMP ,
"VERSION" DECIMAL(31, 0) ,
"LAST_MODIFIED_BY_USER_ID" DECIMAL(31, 0) ,
"LAST_MODIFIED" TIMESTAMP ,
"TABLE_NAME" VARCHAR( 400) ,
"REP_STATUS" DECIMAL(2, 0) ,
"REP_ACTION" DECIMAL(2, 0) ,
"NEW_TABLE_NAME" VARCHAR( 400) ,
"NEW_CONSTR_PREFIX" VARCHAR( 56)
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_TABLE
 ADD CONSTRAINT "TRACKING_GROUP_NAME" CHECK (CHARACTER_LENGTH("TRACKING_GROUP_NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TABLE
 ADD CONSTRAINT "EXTERNAL_UNIQUE_ID" CHECK (CHARACTER_LENGTH("EXTERNAL_UNIQUE_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TABLE
 ADD CONSTRAINT "TABLE_NAME" CHECK (CHARACTER_LENGTH("TABLE_NAME",CODEUNITS16) <= 100)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TABLE
 ADD CONSTRAINT "NEW_TABLE_NAME" CHECK (CHARACTER_LENGTH("NEW_TABLE_NAME",CODEUNITS16) <= 100)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_TABLE
 ADD CONSTRAINT "NEW_CONSTR_PREFIX" CHECK (CHARACTER_LENGTH("NEW_CONSTR_PREFIX",CODEUNITS16) <= 14)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_COLUMN (
"COLUMN_ID" DECIMAL(31, 0) NOT NULL ,
"TABLE_ID" DECIMAL(31, 0) NOT NULL ,
"TRACKED_FIELD_NAME" VARCHAR( 256) NOT NULL ,
"EXTERNAL_UNIQUE_ID" VARCHAR( 256) ,
"FIELD_TYPE" DECIMAL(2, 0) NOT NULL ,
"ARCHIVED" TIMESTAMP ,
"COLUMN_NAME" VARCHAR( 400) ,
"ALLOCATED" TIMESTAMP ,
"NEW_COLUMN_NAME" VARCHAR( 400) ,
"NEW_FIELD_TYPE" DECIMAL(2, 0)
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_COLUMN
 ADD CONSTRAINT "TRACKED_FIELD_NAME" CHECK (CHARACTER_LENGTH("TRACKED_FIELD_NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_COLUMN
 ADD CONSTRAINT "EXTERNAL_UNIQUE_ID" CHECK (CHARACTER_LENGTH("EXTERNAL_UNIQUE_ID",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_COLUMN
 ADD CONSTRAINT "COLUMN_NAME" CHECK (CHARACTER_LENGTH("COLUMN_NAME",CODEUNITS16) <= 100)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_COLUMN
 ADD CONSTRAINT "NEW_COLUMN_NAME" CHECK (CHARACTER_LENGTH("NEW_COLUMN_NAME",CODEUNITS16) <= 100)  ENFORCED ENABLE QUERY OPTIMIZATION

;

CREATE TABLE db2admin.LSW_SNAPSHOT (
"SNAPSHOT_ID" CHAR(36) NOT NULL ,
"NAME" VARCHAR( 256) ,
"DESCRIPTION" CLOB(2G) ,
"SHORT_NAME" VARCHAR( 256) ,
"ARCHIVED" TIMESTAMP
)
--IN @TAB_TS@ INDEX IN @IDX_TS@ LONG IN @LOB_TS@

;


ALTER TABLE db2admin.LSW_SNAPSHOT
 ADD CONSTRAINT "NAME" CHECK (CHARACTER_LENGTH("NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.LSW_SNAPSHOT
 ADD CONSTRAINT "SHORT_NAME" CHECK (CHARACTER_LENGTH("SHORT_NAME",CODEUNITS16) <= 64)  ENFORCED ENABLE QUERY OPTIMIZATION

;


ALTER TABLE db2admin.PS_WLSTORE ADD CONSTRAINT WLC_WLSTORE_PK
    PRIMARY KEY("ID")

;


ALTER TABLE db2admin.LSW_SYSTEM ADD CONSTRAINT LSWC_SYSTEM_PK
    PRIMARY KEY("SYSTEM_ID")

;


ALTER TABLE db2admin.LSW_TRACKING_GROUP ADD CONSTRAINT LSWC_TRCKNGGRP_PK
    PRIMARY KEY("TRACKING_GROUP_ID")

;


ALTER TABLE db2admin.LSW_TRACKING_POINT ADD CONSTRAINT LSWC_TRCKNGPNT_PK
    PRIMARY KEY("TRACKING_POINT_ID")

;


ALTER TABLE db2admin.LSW_TRACKED_FIELD ADD CONSTRAINT LSWC_TRCKDFELD_PK
    PRIMARY KEY("TRACKED_FIELD_ID")

;


ALTER TABLE db2admin.LSW_TRACKED_FIELD_USE ADD CONSTRAINT LSWC_TRCKFLDUS_PK
    PRIMARY KEY("TRACKED_FIELD_USE_ID")

;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL ADD CONSTRAINT LSWC_TMNGNTRVL_PK
    PRIMARY KEY("TIMING_INTERVAL_ID")

;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL_BOUND ADD CONSTRAINT LSWC_TMNGNTRVBD_PK
    PRIMARY KEY("TIMING_INTERVAL_BOUND_ID")

;


ALTER TABLE db2admin.LSW_TASK_PLAYBACK ADD CONSTRAINT LSWC_PLAYBACK_TASK_PK
    PRIMARY KEY("TASK_ID")

;


ALTER TABLE db2admin.LSW_TASK ADD CONSTRAINT LSWC_TASK_PK
    PRIMARY KEY("TASK_ID")

;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL_VALUE ADD CONSTRAINT LSWC_TMNGNTRVLL_PK
    PRIMARY KEY("TIMING_INTERVAL_VALUE_ID")

;


ALTER TABLE db2admin.LSW_TRACKING_POINT_VALUE ADD CONSTRAINT LSWC_TRCKNGPNTL_PK
    PRIMARY KEY("TRACKING_POINT_VALUE_ID")

;


ALTER TABLE db2admin.LSW_PRI_KEY ADD CONSTRAINT LSWC_PRI_KEY_PK
    PRIMARY KEY("TABLE_ID")

;


ALTER TABLE db2admin.LSW_LOAD_TRACE ADD CONSTRAINT LSWC_LOADTRACE_PK
    PRIMARY KEY("LOAD_TRACE_ID")

;


ALTER TABLE db2admin.LSW_VIEW ADD CONSTRAINT LSWC_VIEW_PK
    PRIMARY KEY("VIEW_ID")

;


ALTER TABLE db2admin.LSW_USR_XREF ADD CONSTRAINT LSWC_UXREF_PK
    PRIMARY KEY("USER_ID")

;


ALTER TABLE db2admin.LSW_DATA_TRANSFER_ERRORS ADD CONSTRAINT LSWC_DT_ERR_PK
    PRIMARY KEY("DATA_TRANSFER_ERRORS_ID")

;


ALTER TABLE db2admin.LSW_OPTIMIZER_DATA ADD CONSTRAINT LSWC_OPTDATA_PK
    PRIMARY KEY("TRACKING_POINT_VALUE_ID","TRACKED_FIELD_ID")

;


ALTER TABLE db2admin.LSW_USER_MAPPINGS ADD CONSTRAINT LSWC_USERMAP_PK
    PRIMARY KEY("USER_ID","SYSTEM_ID")

;


ALTER TABLE db2admin.LSW_SYSTEM_SCHEMA ADD CONSTRAINT LSWC_SYSSCHEMA_PK
    PRIMARY KEY("PROPNAME")

;


ALTER TABLE db2admin.LSW_TABLE ADD CONSTRAINT LSWC_TABLE_PK
    PRIMARY KEY("TABLE_ID")

;


ALTER TABLE db2admin.LSW_COLUMN ADD CONSTRAINT LSWC_COLUMN_PK
    PRIMARY KEY("COLUMN_ID")

;


ALTER TABLE db2admin.LSW_SNAPSHOT ADD CONSTRAINT LSWC_SNAPSHOT_PK
    PRIMARY KEY("SNAPSHOT_ID")

;


CREATE UNIQUE INDEX db2admin.LSWC_SYSTEM_UQ0
    ON db2admin.LSW_SYSTEM(
        "NAME")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGGRP_PK4
    ON db2admin.LSW_TRACKING_GROUP("NAME")
    
;


ALTER TABLE db2admin.LSW_TRACKING_GROUP
    ADD CONSTRAINT LSWC_TRCKNGGRP_FK1
	FOREIGN KEY("SYSTEM_ID")
	REFERENCES db2admin.LSW_SYSTEM("SYSTEM_ID")
	
;


CREATE UNIQUE INDEX db2admin.LSWC_TRCKNGGRP_UQ1
    ON db2admin.LSW_TRACKING_GROUP(
        "SYSTEM_ID",
        "EXTERNAL_UNIQUE_ID",
        "SNAPSHOT_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGGRP_NQ1 
    ON db2admin.LSW_TRACKING_GROUP(
    "SYSTEM_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGPNT_PK4
    ON db2admin.LSW_TRACKING_POINT("NAME")
    
;


ALTER TABLE db2admin.LSW_TRACKING_POINT
    ADD CONSTRAINT LSWC_TRCKNGPNT_FK0
	FOREIGN KEY("TRACKING_GROUP_ID")
	REFERENCES db2admin.LSW_TRACKING_GROUP("TRACKING_GROUP_ID")
	
;


CREATE UNIQUE INDEX db2admin.LSWC_TRCKNGPNT_UQ1
    ON db2admin.LSW_TRACKING_POINT(
        "SYSTEM_ID",
        "EXTERNAL_UNIQUE_ID",
        "SNAPSHOT_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGPNT_NQ0 
    ON db2admin.LSW_TRACKING_POINT(
    "TRACKING_GROUP_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKDFELD_PK4
    ON db2admin.LSW_TRACKED_FIELD("NAME")
    
;


ALTER TABLE db2admin.LSW_TRACKED_FIELD
    ADD CONSTRAINT LSWC_TRCKDFELD_FK0
	FOREIGN KEY("TRACKING_GROUP_ID")
	REFERENCES db2admin.LSW_TRACKING_GROUP("TRACKING_GROUP_ID")
	
;


CREATE UNIQUE INDEX db2admin.LSWC_TRCKDFELD_UQ0
    ON db2admin.LSW_TRACKED_FIELD(
        "TRACKING_GROUP_ID",
        "EXTERNAL_UNIQUE_ID",
        "SNAPSHOT_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKDFELD_NQ0 
    ON db2admin.LSW_TRACKED_FIELD(
    "TRACKING_GROUP_ID")
    
;


ALTER TABLE db2admin.LSW_TRACKED_FIELD_USE
    ADD CONSTRAINT LSWC_TRCKFLDUS_FK0
	FOREIGN KEY("TRACKED_FIELD_ID")
	REFERENCES db2admin.LSW_TRACKED_FIELD("TRACKED_FIELD_ID")
	
;


ALTER TABLE db2admin.LSW_TRACKED_FIELD_USE
    ADD CONSTRAINT LSWC_TRCKFLDUS_FK1
	FOREIGN KEY("TRACKING_POINT_ID")
	REFERENCES db2admin.LSW_TRACKING_POINT("TRACKING_POINT_ID")
	
;


CREATE INDEX db2admin.LSWC_TRCKFLDUS_NQ0 
    ON db2admin.LSW_TRACKED_FIELD_USE(
    "TRACKED_FIELD_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKFLDUS_NQ1 
    ON db2admin.LSW_TRACKED_FIELD_USE(
    "TRACKING_POINT_ID")
    
;


CREATE INDEX db2admin.LSWC_TMNGNTRVL_PK4
    ON db2admin.LSW_TIMING_INTERVAL("NAME")
    
;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL
    ADD CONSTRAINT LSWC_TMNGNTRVL_FK1
	FOREIGN KEY("SYSTEM_ID")
	REFERENCES db2admin.LSW_SYSTEM("SYSTEM_ID")
	
;


CREATE UNIQUE INDEX db2admin.LSWC_TMNGNTRVL_UQ1
    ON db2admin.LSW_TIMING_INTERVAL(
        "SYSTEM_ID",
        "EXTERNAL_UNIQUE_ID")
    
;


CREATE INDEX db2admin.LSWC_TMNGNTRVL_NQ1 
    ON db2admin.LSW_TIMING_INTERVAL(
    "SYSTEM_ID")
    
;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL_BOUND
    ADD CONSTRAINT LSWC_TMNGNTVBD_FK0
	FOREIGN KEY("TIMING_INTERVAL_ID")
	REFERENCES db2admin.LSW_TIMING_INTERVAL("TIMING_INTERVAL_ID")
	
;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL_BOUND
    ADD CONSTRAINT LSWC_TMNGNTVBD_FK1
	FOREIGN KEY("TRACKING_POINT_ID")
	REFERENCES db2admin.LSW_TRACKING_POINT("TRACKING_POINT_ID")
	
;


CREATE INDEX db2admin.LSWC_TMNGNTVBD_NQ0 
    ON db2admin.LSW_TIMING_INTERVAL_BOUND(
    "TIMING_INTERVAL_ID")
    
;


CREATE INDEX db2admin.LSWC_TMNGNTVBD_NQ1 
    ON db2admin.LSW_TIMING_INTERVAL_BOUND(
    "TRACKING_POINT_ID")
    
;


ALTER TABLE db2admin.LSW_TASK_PLAYBACK
    ADD CONSTRAINT LSWC_PLAYBACK_TASK_FK
	FOREIGN KEY("TASK_ID")
	REFERENCES db2admin.LSW_TASK("TASK_ID")
	ON DELETE CASCADE
;


ALTER TABLE db2admin.LSW_TASK
    ADD CONSTRAINT LSWC_TASK_FK0
	FOREIGN KEY("SYSTEM_ID")
	REFERENCES db2admin.LSW_SYSTEM("SYSTEM_ID")
	
;


CREATE UNIQUE INDEX db2admin.LSWC_TASK_UQ0
    ON db2admin.LSW_TASK(
        "SYSTEM_TASK_ID",
        "SYSTEM_ID")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ0 
    ON db2admin.LSW_TASK(
    "SYSTEM_ID")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ1 
    ON db2admin.LSW_TASK(
    "IS_INSTANCE")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ2 
    ON db2admin.LSW_TASK(
    "FUNCTIONAL_TASK_ID")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ3 
    ON db2admin.LSW_TASK(
    "MAX_STEP")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ4 
    ON db2admin.LSW_TASK(
    "CREATION_TIME",
    "TASK_ID")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ5 
    ON db2admin.LSW_TASK(
    "START_TIME",
    "TASK_ID")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ6 
    ON db2admin.LSW_TASK(
    "END_TIME",
    "TASK_ID")
    
;


CREATE INDEX db2admin.LSWC_TASK_NQ7 
    ON db2admin.LSW_TASK(
    "SYSTEM_USER_ID")
    
;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL_VALUE
    ADD CONSTRAINT LSWC_TMNGNTRLL_FK0
	FOREIGN KEY("TIMING_INTERVAL_ID")
	REFERENCES db2admin.LSW_TIMING_INTERVAL("TIMING_INTERVAL_ID")
	
;


ALTER TABLE db2admin.LSW_TIMING_INTERVAL_VALUE
    ADD CONSTRAINT LSWC_TMNGNTRLL_FK1
	FOREIGN KEY("FUNCTIONAL_TASK_ID")
	REFERENCES db2admin.LSW_TASK("TASK_ID")
	
;


CREATE INDEX db2admin.LSWC_TMNGNTRLL_NQ0 
    ON db2admin.LSW_TIMING_INTERVAL_VALUE(
    "TIMING_INTERVAL_ID")
    
;


CREATE INDEX db2admin.LSWC_TMNGNTRLL_NQ1 
    ON db2admin.LSW_TIMING_INTERVAL_VALUE(
    "FUNCTIONAL_TASK_ID")
    
;


CREATE INDEX db2admin.LSWC_TMNGNTRLL_UQ0 
    ON db2admin.LSW_TIMING_INTERVAL_VALUE(
    "TIMING_INTERVAL_ID",
    "START_TRACKING_POINT_VALUE_ID",
    "END_TRACKING_POINT_VALUE_ID")
    
;


ALTER TABLE db2admin.LSW_TRACKING_POINT_VALUE
    ADD CONSTRAINT LSWC_TRCKNGPTL_FK0
	FOREIGN KEY("TRACKING_POINT_ID")
	REFERENCES db2admin.LSW_TRACKING_POINT("TRACKING_POINT_ID")
	
;


ALTER TABLE db2admin.LSW_TRACKING_POINT_VALUE
    ADD CONSTRAINT LSWC_TRCKNGPTL_FK1
	FOREIGN KEY("TASK_ID")
	REFERENCES db2admin.LSW_TASK("TASK_ID")
	
;


ALTER TABLE db2admin.LSW_TRACKING_POINT_VALUE
    ADD CONSTRAINT LSWC_TRCKNGPTL_FK2
	FOREIGN KEY("FUNCTIONAL_TASK_ID")
	REFERENCES db2admin.LSW_TASK("TASK_ID")
	
;


ALTER TABLE db2admin.LSW_TRACKING_POINT_VALUE
    ADD CONSTRAINT LSWC_TRCKNGPTL_FK3
	FOREIGN KEY("TRACKING_GROUP_ID")
	REFERENCES db2admin.LSW_TRACKING_GROUP("TRACKING_GROUP_ID")
	
;


CREATE INDEX db2admin.LSWC_TRCKNGPTL_NQ0 
    ON db2admin.LSW_TRACKING_POINT_VALUE(
    "TRACKING_POINT_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGPTL_NQ1 
    ON db2admin.LSW_TRACKING_POINT_VALUE(
    "TASK_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGPTL_NQ2 
    ON db2admin.LSW_TRACKING_POINT_VALUE(
    "FUNCTIONAL_TASK_ID")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGPTL_NQ3 
    ON db2admin.LSW_TRACKING_POINT_VALUE(
    "TRACKING_GROUP_ID",
    "TRACKING_POINT_ID",
    "TRACKING_POINT_VALUE_ID",
    "TIME_STAMP")
    
;


CREATE INDEX db2admin.LSWC_TRCKNGPTL_NQ4 
    ON db2admin.LSW_TRACKING_POINT_VALUE(
    "TIME_STAMP",
    "TRACKING_POINT_VALUE_ID")
    
;


CREATE INDEX db2admin.LSWC_LDTRACE_NUQ 
    ON db2admin.LSW_LOAD_TRACE(
    "SYNCHRONIZATION_EUID")
    
;


CREATE INDEX db2admin.LSWC_LDTRACE_NUQ1 
    ON db2admin.LSW_LOAD_TRACE(
    "LOAD_TRACE_ID",
    "SYNCHRONIZATION_EUID",
    "LOAD_TYPE",
    "TIME_RECEIVED",
    "TIME_VALIDATED",
    "TIME_LOADED",
    "TIME_DELETED",
    "TIME_REQUEUED",
    "STATUS")
    
;


ALTER TABLE db2admin.LSW_VIEW
    ADD CONSTRAINT LSWC_VIEW_FK1
	FOREIGN KEY("TABLE_ID")
	REFERENCES db2admin.LSW_TABLE("TABLE_ID")
	
;


CREATE UNIQUE INDEX db2admin.LSWC_VIEW_NAME_UQ
    ON db2admin.LSW_VIEW(
        "NAME")
    
;


CREATE UNIQUE INDEX db2admin.LSWC_UXREF_UQ
    ON db2admin.LSW_USR_XREF(
        "USER_NAME",
        "PROVIDER")
    
;


CREATE INDEX db2admin.LSWC_DT_ERR_NUQ 
    ON db2admin.LSW_DATA_TRANSFER_ERRORS(
    "CLAIMED_BY",
    "REPROCESS")
    
;


ALTER TABLE db2admin.LSW_COLUMN
    ADD CONSTRAINT LSWC_COLUMN_FK1
	FOREIGN KEY("TABLE_ID")
	REFERENCES db2admin.LSW_TABLE("TABLE_ID")
	
;


CREATE INDEX db2admin.LSWC_SNAPSHOT_PK4
    ON db2admin.LSW_SNAPSHOT("NAME")
    
;

INSERT INTO 
    db2admin.LSW_SYSTEM_SCHEMA("PROPNAME",
 "PROPVALUE") 
VALUES ('DatabaseSchemaVersion' ,
 '1.12.0')
;

INSERT INTO 
    db2admin.LSW_SYSTEM_SCHEMA("PROPNAME",
 "PROPVALUE") 
VALUES ('DatabaseSchemaFormat' ,
 'DatabaseVersionOnly')
;

