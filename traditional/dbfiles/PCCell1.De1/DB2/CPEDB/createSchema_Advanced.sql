-- ***************************************************************** 
--                                                                   
-- Licensed Materials - Property of IBM                              
--                                                                   
-- 5725-C94, 5725-C95, 5725-C96                                                          
--                                                                   
-- Copyright IBM Corp. 2018.  All Rights Reserved.                    
--                                                                   
-- US Government Users Restricted Rights - Use, duplication or       
-- disclosure restricted by GSA ADP Schedule Contract with           
-- IBM Corp.
-- ***************************************************************** 

--                                                                   
-- ***************************************************************** 
-- IBM Content Navigator configuration table creation script
-- for DB2 LUW
-- ***************************************************************** 

--  Create the configuration table for the application to use
SET CURRENT SQLID = ICNSA;

CREATE TABLE CONFIGURATION (
    	ID VARCHAR(256) NOT NULL,
    	ATTRIBUTES DBCLOB (100M) INLINE LENGTH 16384,
 	 PRIMARY KEY(ID)
	)
	DATA CAPTURE NONE IN WFICNTS;

	ALTER TABLE CONFIGURATION VOLATILE;
-- *****************************************************************
-- Grant privileges on the table to the JDBC connection user
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE CONFIGURATION TO USER db2admin WITH GRANT OPTION;
-- GRANT CONTROL ON TABLE CONFIGURATION TO USER db2admin;
-- *****************************************************************
--  Load the initial application configuration into the table
INSERT INTO ICNSA.CONFIGURATION VALUES ('application.navigator', 'locales=ar,he,en,zh_CN,zh_TW,cs,hr,da,nl,fi,fr,de,el,hu,it,ja,ko,nb,pl,pt,pt_BR,ru,sk,sl,es,sv,th,tr,ro,kk,ca,vi;threadSleepTime=5;themes=azurite,cordierite,malachite,obsidian,quartz;plugins=;menus=;repositories=;desktops=admin;viewers=default;servers=cm,od,p8,cmis;key=871bf66c911f811fd48a6cc97aea40a4;objectExpiration=10;desktop=default');
INSERT INTO ICNSA.CONFIGURATION VALUES ('settings.navigator.default', 'mobileAccess=true;logging.level=2;logging.excludes=com.ibm.ecm.configuration;iconStatus=docHold,docNotes,docMinorVersions,docDeclaredRecord,docBookmarks,docCheckedOut,workItemSuspended,workItemDeadlineImportance,workItemDeadlineReminderSent,workItemLocked,workItemCheckedOut;adminUsers=bpm_admin');
INSERT INTO ICNSA.CONFIGURATION VALUES ('desktop.navigator.admin', 'authenticationType=1;workflowNotification=false;fileIntoFolder=false;showSecurity=false;viewer=default;theme=;name=Admin Desktop;isDefault=Yes;menuPrefix=Default;applicationName=IBM Content Navigator;configInfo=;layout=ecm.widget.layout.NavigatorMainLayout;defaultFeature=ecmClientAdmin;actionHandler=ecm.widget.layout.CommonActionsHandler;servers=cm,od,ci,p8,cmis;repositories=');

-- *****************************************************************
--  Create the eventlog table for the application to use
CREATE TABLE ICNSA.EVENTLOG (
    ID BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE),
    ACTION VARCHAR(36),
    QUALIFIERS VARCHAR(128),
    DATA VARCHAR(1024) NOT NULL,
    MESSAGECLASS VARCHAR(128) NOT NULL,
    CREATETIME TIMESTAMP NOT NULL,
    NODEID VARCHAR(42) NOT NULL,
    PRIMARY KEY(ID)
)
DATA CAPTURE NONE IN WFICNTS;

ALTER TABLE ICNSA.EVENTLOG VOLATILE;
-- *****************************************************************
--  Grant privileges on the table to the JDBC connection user
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE ICNSA.EVENTLOG TO USER db2admin WITH GRANT OPTION;
-- GRANT CONTROL ON TABLE ICNSA.EVENTLOG TO USER db2admin;

-- Create extra indexes
CREATE INDEX ICNSA.NODEID_IDX ON ICNSA.EVENTLOG ( NODEID );
CREATE INDEX ICNSA.CREATETIME_IDX ON ICNSA.EVENTLOG ( CREATETIME );

-- *****************************************************************
-- ***************************************************************** 
-- Short Links
-- *****************************************************************
-- ***************************************************************** 
CREATE TABLE ICNSA.SHORTLINKS ( SHORTURL VARCHAR(36) NOT NULL, REPOSID VARCHAR (256)  NOT NULL , REPOSTYPE VARCHAR (36)  NOT NULL , ITEMID VARCHAR (256)  NOT NULL , MIMETYPE VARCHAR (256) , CLASSNAME VARCHAR (256) , VERS VARCHAR (36) , VSID VARCHAR (128), ELEMENT VARCHAR(36), PROXY VARCHAR(256), LASTACCESS TIMESTAMP , PRIMARY KEY ( SHORTURL ) ) IN WFICNTS ;
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE ICNSA.SHORTLINKS TO USER db2admin;
-- GRANT CONTROL ON TABLE ICNSA.SHORTLINKS TO USER db2admin;
CREATE INDEX ICNSA.I_SHORTLINKS_PARAMS ON ICNSA.SHORTLINKS ( REPOSID, ITEMID, VERS, VSID, ELEMENT );
CREATE INDEX ICNSA.I_SHORTLINKS_REPOSID ON ICNSA.SHORTLINKS ( REPOSID );
CREATE INDEX ICNSA.I_SHORTLINKS_ITEMID ON ICNSA.SHORTLINKS ( ITEMID );
CREATE INDEX ICNSA.I_SHORTLINKS_LASTACCESS ON ICNSA.SHORTLINKS ( LASTACCESS );
-- *****************************************************************
-- ***************************************************************** 
-- ECM TaskManager
-- *****************************************************************
-- ***************************************************************** 

CREATE TABLE APP_LOCK (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, category VARCHAR(30) NOT NULL, LOCK_STATUS BIGINT, objectID BIGINT, version INTEGER, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE TaskAudit (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, EVT_ACTION VARCHAR(128), EVT_TS TIMESTAMP, EVT_INFO CLOB(1M), EVT_TYPE VARCHAR(128), originator VARCHAR(380), status VARCHAR(128), TASK_ID BIGINT, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE Batches (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, BATCH_DATA BLOB, CREATED_BY VARCHAR(128), SEQ_ID BIGINT, START_TIME TIMESTAMP, status BIGINT, STOP_TIME TIMESTAMP, SUCCESS_CNT BIGINT, TASK_ID BIGINT, TOTAL_CNT BIGINT, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE Server (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, ACCESS_TIME TIMESTAMP, name VARCHAR(80) NOT NULL, serverURL VARCHAR(256), port BIGINT, PROC_ID BIGINT, protocol VARCHAR(10), status BIGINT, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE Task (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, AUTO_RESUME BIGINT, CREATED_BY VARCHAR(128), description VARCHAR(1024), END_TIME TIMESTAMP, HANDLER_NAME VARCHAR(256) NOT NULL, LOCAL_STATE BIGINT, LOG_LEV VARCHAR(8), name VARCHAR(256) NOT NULL, NOTIFY_INFO CLOB(1M), parent VARCHAR(256), REPEAT_PERIOD BIGINT, SERVER_ID BIGINT, START_TIME TIMESTAMP, status BIGINT, STOP_TIME TIMESTAMP, SUCCESS_CNT BIGINT, TASK_INFO CLOB(1M), TASK_MODE BIGINT, TIMER_HANDLE VARCHAR(512), TOTAL_CNT BIGINT, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE TASK_ERROR (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, CREATE_TIME TIMESTAMP, ERROR_CODE BIGINT, ERROR_MSG VARCHAR(1024), TASK_ID BIGINT, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE TASK_EXREC (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, SERVER_ID BIGINT, START_TIME TIMESTAMP, status BIGINT, STOP_TIME TIMESTAMP, SUCCESS_CNT BIGINT, EXEC_INFO CLOB(1M), TASK_ID BIGINT, TOTAL_CNT BIGINT, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE TASK_QUEUE (id BIGINT NOT NULL GENERATED BY DEFAULT AS IDENTITY, CREATED_BY VARCHAR(128), EXEC_TIME TIMESTAMP, status BIGINT, TASK_ID BIGINT NOT NULL, version INTEGER, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
CREATE TABLE TASK_SEQ_TABLE (id VARCHAR(254) NOT NULL, SEQUENCE_VALUE BIGINT default NULL, PRIMARY KEY (id)) DATA CAPTURE NONE IN WFICNTS;
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('APP_LOCK', 4999);
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('Server', 4999);
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('TaskAudit', 4999);
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('TASK_ERROR', 4999);
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('TASK_QUEUE', 4999);
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('Batches', 4999);
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('Task', 4999);
INSERT INTO ICNSA.TASK_SEQ_TABLE VALUES ('TASK_EXREC', 4999);

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE APP_LOCK TO USER db2admin;
-- GRANT CONTROL ON TABLE APP_LOCK TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE TaskAudit TO USER db2admin;
-- GRANT CONTROL ON TABLE TaskAudit TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE Batches TO USER db2admin;
-- GRANT CONTROL ON TABLE Batches TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE Server TO USER db2admin;
-- GRANT CONTROL ON TABLE Server TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE Task TO USER db2admin;
-- GRANT CONTROL ON TABLE Task TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE TASK_ERROR TO USER db2admin;
-- GRANT CONTROL ON TABLE TASK_ERROR TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE TASK_EXREC TO USER db2admin;
-- GRANT CONTROL ON TABLE TASK_EXREC TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE TASK_QUEUE TO USER db2admin;
-- GRANT CONTROL ON TABLE TASK_QUEUE TO USER db2admin;

-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE TASK_SEQ_TABLE TO USER db2admin;
-- GRANT CONTROL ON TABLE TASK_SEQ_TABLE TO USER db2admin;


-- *****************************************************************
-- ***************************************************************** 
-- SYNC Services
-- *****************************************************************
-- *****************************************************************

-- *****************************************************************
--  Create the static tables required for sync and grant privileges
CREATE TABLE SYNCREPOSMAPPING ( ID BIGINT  NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , TABLENAMEPREFIX VARCHAR (16)  NOT NULL , REPOSID1 VARCHAR (36)  NOT NULL , REPOSID2 VARCHAR (36)  NOT NULL , CONNECTIONINFO VARCHAR (256) , EVENTID VARCHAR (36)  NOT NULL , REPOSTYPE SMALLINT  NOT NULL  WITH DEFAULT 0 , LASTUPDATEID BIGINT  NOT NULL WITH DEFAULT 0 , LASTMODRECEIVED TIMESTAMP , MARKDELETED SMALLINT  NOT NULL  WITH DEFAULT 0 , CODEMODULEREV SMALLINT, ICNKEY VARCHAR (512), CONSTRAINT CC1392679913540 PRIMARY KEY ( ID) , CONSTRAINT CC1392679924904 UNIQUE ( TABLENAMEPREFIX) ) IN WFICNTS ;
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE SYNCREPOSMAPPING TO USER db2admin;

CREATE TABLE SYNCITEMS ( ID BIGINT  NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , NAME VARCHAR (256)  NOT NULL , OBJECTID VARCHAR (36)  NOT NULL , USERID VARCHAR (64)  NOT NULL , DESKTOPID VARCHAR (64)  NOT NULL , REPOSID BIGINT  NOT NULL , LASTUPDATETS TIMESTAMP NOT NULL WITH DEFAULT , MARKDELETED SMALLINT  NOT NULL  WITH DEFAULT 0  , CONSTRAINT CC1392680242650 PRIMARY KEY ( ID) , CONSTRAINT CC1392680358320 FOREIGN KEY (REPOSID) REFERENCES SYNCREPOSMAPPING (ID)  ON DELETE NO ACTION ON UPDATE NO ACTION ENFORCED  ENABLE QUERY OPTIMIZATION  ) IN WFICNTS ;
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE SYNCITEMS TO USER db2admin;

CREATE TABLE DEVICEREGISTRY ( ID BIGINT  NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , DEVICEID VARCHAR (36)  NOT NULL , LASTPING TIMESTAMP , MARKDELETED SMALLINT  NOT NULL  WITH DEFAULT 0  , CONSTRAINT CC1392680754897 PRIMARY KEY ( ID) , CONSTRAINT CC1392680759037 UNIQUE ( DEVICEID)  ) IN WFICNTS ;
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE DEVICEREGISTRY TO USER db2admin;

CREATE TABLE DEVICESYNCMAP ( ID BIGINT  NOT NULL  GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE ) , DEVREGID BIGINT  NOT NULL , SYNCITEMID BIGINT  NOT NULL , MARKDELETED SMALLINT  NOT NULL  WITH DEFAULT 0  , CONSTRAINT CC1392681213562 PRIMARY KEY ( ID) , CONSTRAINT CC1392681269094 FOREIGN KEY (DEVREGID) REFERENCES DEVICEREGISTRY (ID)  ON DELETE NO ACTION ON UPDATE NO ACTION ENFORCED  ENABLE QUERY OPTIMIZATION , CONSTRAINT CC1392681292746 FOREIGN KEY (SYNCITEMID) REFERENCES SYNCITEMS (ID)  ON DELETE NO ACTION ON UPDATE NO ACTION ENFORCED  ENABLE QUERY OPTIMIZATION  ) IN WFICNTS ;
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE DEVICESYNCMAP TO USER db2admin;

CREATE TABLE SYNCCONFIGURATION ( ID VARCHAR(256) NOT NULL, ATTRIBUTES DBCLOB INLINE LENGTH 32412, PRIMARY KEY(ID) ) IN WFICNTS;
ALTER TABLE SYNCCONFIGURATION VOLATILE;
-- GRANT INSERT, DELETE, UPDATE, SELECT, INDEX ON TABLE SYNCCONFIGURATION TO USER db2admin;

-- *****************************************************************
-- Create extra indexes
CREATE INDEX I_DR_LASTPING_MARKDELETED ON DEVICEREGISTRY ( LASTPING , MARKDELETED );
CREATE INDEX I_DSM_SYNCITEMID ON DEVICESYNCMAP ( SYNCITEMID );
CREATE INDEX I_DSM_DEVREGID ON DEVICESYNCMAP ( DEVREGID );	
CREATE INDEX I_DSM_MARKDELETED ON DEVICESYNCMAP ( MARKDELETED );	
CREATE INDEX I_SI_REPOSID ON SYNCITEMS ( REPOSID );
CREATE INDEX I_SI_UID ON SYNCITEMS ( USERID );
CREATE INDEX I_SI_OID_UID ON SYNCITEMS ( OBJECTID, USERID );
CREATE INDEX I_SRM_REP1_REP2_MARKDELETED ON SYNCREPOSMAPPING ( REPOSID1 , REPOSID2 , MARKDELETED );

-- *****************************************************************
--  Load the initial application configuration into the table
INSERT INTO SYNCREPOSMAPPING (TABLENAMEPREFIX, REPOSID1, REPOSID2, CONNECTIONINFO, EVENTID, LASTUPDATEID) VALUES ('NULL', 'NULL', 'NULL', 'NULL', 'NULL', 0);
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('sync.task.states', '{}');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_Property_SyncServerUrl', 'name=IcnSyncServerUrl;descr=sync server URL name;attributes=IcnSyncServerUrl');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventAction_DisplayName', 'name=Sync Event Action;descr=Sync Event Action display name;attributes=Sync Event Action');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventActionClass_ID', 'name=Action class P8 ID;descr=Filenet P8 action class ID;attributes={A8239821-CD3F-499D-8FAE-F2DA54AC5A99}');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventAction_FullyQualifiedClass', 'name=Event action class name;descr=Fully qualified event action handler class name;attributes=com.ibm.ecm.sync.core.store.p8.P8SyncEventActionHandler');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncEventActionClass_Name', 'name=IcnSyncEventAction;descr=Sync Event class name;attributes=IcnSyncEventAction');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncInstanceSubscriptionClass_ID', 'name=Sync instance subscription ID;descr=Filenet P8 instance subscription ID;attributes=DA09A1F1-65C4-4044-8ACA-5AF043BD61B4}');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncInstanceSubscriptionClass_Name', 'name=IcnSyncInstanceSubscription;descr=Instance subscription name;attributes=IcnSyncInstanceSubscription');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncCodeModule_ID', 'name=Sync Code module ID;descr=Filenet P8 Sync code module ID;attributes={9cf33dbe-600d-40c7-a8bb-351fa38ab5a6}');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.Constants.P8_SyncCodeModule_Name', 'name=Sync code module name;descr=Sync code module name;attributes=Sync Code Module');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.api.RepositoryController.publicSyncUrl', 'name=Public sync URL;descr=Public sync URL;attributes=http://localhost:9082/sync/notify');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.WebAppListener.poolSize','name=Internal task pool size;descr=Internal task pool size;attributes=3');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.WebAppListener.deviceCleanupInitialDelay', 'name=Initial deplay for the database clean up task;descr=Initial deplay for the database clean up task (in days);attributes=1');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.WebAppListener.deviceCleanupPeriod', 'name=Device clean up cycle time;descr=Device clean up cycle time (in days);attributes=7');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('com.ibm.ecm.sync.tools.cleanup.CleanupTask.deviceExpiration','name=Device expiration;descr=device expiration (in days);attributes=90');
INSERT INTO SYNCCONFIGURATION ( ID, ATTRIBUTES ) VALUES ('synchdb.version','500');
