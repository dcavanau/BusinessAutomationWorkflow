-- *****************************************************************
--
-- Licensed Materials - Property of IBM
--                                      
-- 5724-U69                             
--                                      
-- Copyright IBM Corp. 2001, 2006  All Rights Reserved.
--
-- US Government Users Restricted Rights - Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with
-- IBM Corp.
--
-- *****************************************************************

-- Mashup DB2 Script for creating tables, keys, indexes

-- *****************************************************************
--
-- SCHEMA VERSION (100)
--
-- *****************************************************************
CREATE TABLE db2admin.VERSION_INFO(
    OID VARCHAR(64)    NOT NULL,
    VERSION_MAJOR   INTEGER,
    VERSION_MINOR   INTEGER,
    VERSION_RELEASE INTEGER,
    VERSION_DEV     INTEGER,
    VERSION_TIME    BIGINT,
    DESCRIPTION     VARCHAR(254),
    CONSTRAINT PK100 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- ACCOUNT (200)
--
-- *****************************************************************
CREATE TABLE db2admin.ACCOUNT (
    OID         VARCHAR(64)        NOT NULL,
    EXTERNAL_ID VARCHAR(1024)      NOT NULL,
    CREATED     BIGINT             NOT NULL,
    MODIFIED    BIGINT             NOT NULL,
    STATE       INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK200 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- CATALOG (300)
--
-- *****************************************************************
CREATE TABLE db2admin.CATALOG (
    OID         VARCHAR(64)       NOT NULL,
    ACCOUNT_OID VARCHAR(64)       NOT NULL,
    UNIQUE_NAME VARCHAR(255)      NOT NULL,
    CREATED     BIGINT            NOT NULL,
    MODIFIED    BIGINT            NOT NULL,
    STATE       INTEGER DEFAULT 1 NOT NULL,
    CONSTRAINT PK300 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.CATALOG_LOD (
    RESOURCE_OID VARCHAR(64)       NOT NULL,
    LOCALE       VARCHAR(64)    NOT NULL,
    TITLE        VARCHAR(255)   NOT NULL,
    DESCRIPTION  VARCHAR(1024)  ,
    CONSTRAINT PK301 PRIMARY KEY (RESOURCE_OID, LOCALE),
    CONSTRAINT FK302 FOREIGN KEY (RESOURCE_OID) REFERENCES db2admin.CATALOG (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- CATALOG ENTRY (310)
--
-- *****************************************************************
CREATE TABLE db2admin.CATALOG_ENTRY (
    OID            			VARCHAR(64)        NOT NULL,
    CATALOG_OID    			VARCHAR(64)        NOT NULL,
    CATEGORY_OID   			VARCHAR(64)        NOT NULL,
    DEFINITION_URL 			VARCHAR(2500)      NOT NULL,
    CONTENT_URL    			VARCHAR(2500)      ,
    PREVIEW_URL    			VARCHAR(2500)      ,
    PREVIEW_THUMBNAIL_URL	VARCHAR(2500)      ,
    HELP_URL       			VARCHAR(2500)      ,
    ICON_URL       			VARCHAR(2500)      ,
    HUB_ENTRY_URL  			VARCHAR(2500)      ,
    DEF_URL_TYPE   			INTEGER            ,
    ICON_URL_TYPE  			INTEGER            ,
    CREATED        			BIGINT             NOT NULL,
    MODIFIED       			BIGINT             NOT NULL,
    STATE          			INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK310 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.CATALOG_ENTRY_LOD (
    RESOURCE_OID  		VARCHAR(64)    NOT NULL,
    LOCALE        		VARCHAR(64)    NOT NULL,
    TITLE         		VARCHAR(255)   NOT NULL,
    DESCRIPTION   		VARCHAR(1024)  ,
    SHORT_DESCRIPTION   VARCHAR(255)   ,
    CONSTRAINT PK311 PRIMARY KEY (RESOURCE_OID, LOCALE),
    CONSTRAINT FK311 FOREIGN KEY (RESOURCE_OID) REFERENCES db2admin.CATALOG_ENTRY (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.CATALOG_ENTRY_DD (
    RESOURCE_OID  VARCHAR(64)    NOT NULL,
    NAME          VARCHAR(255)   NOT NULL,
    VALUE         VARCHAR(3000)  NOT NULL,
    CONSTRAINT PK312 PRIMARY KEY (RESOURCE_OID, NAME),
    CONSTRAINT FK312 FOREIGN KEY (RESOURCE_OID) REFERENCES db2admin.CATALOG_ENTRY (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- CATALOG CATEGORY (320)
--
-- *****************************************************************
CREATE TABLE db2admin.CATALOG_CATEGORY (
    OID         VARCHAR(64)         NOT NULL,
    CATALOG_OID VARCHAR(64)         NOT NULL,
    NAME        VARCHAR(255)        ,
    CREATED     BIGINT              NOT NULL,
    MODIFIED    BIGINT              NOT NULL,
    STATE       INTEGER DEFAULT 1   NOT NULL,
    CONSTRAINT PK320 PRIMARY KEY (OID),
    CONSTRAINT FK320 FOREIGN KEY (CATALOG_OID) REFERENCES db2admin.CATALOG (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.CATALOG_CATEGORY_LOD (
    RESOURCE_OID VARCHAR(64)    NOT NULL,
    LOCALE       VARCHAR(64)    NOT NULL,
    TITLE        VARCHAR(255)   NOT NULL,
    DESCRIPTION  VARCHAR(1024)  ,
    CONSTRAINT PK321 PRIMARY KEY (RESOURCE_OID, LOCALE),
    CONSTRAINT FK321 FOREIGN KEY (RESOURCE_OID) REFERENCES db2admin.CATALOG_CATEGORY (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- CATALOG CATEGORY INCLUDES (330)
--
-- *****************************************************************
CREATE TABLE db2admin.CATALOG_CATEGORY_INC (
    OID          		VARCHAR(64)       NOT NULL,
    CATALOG_OID  		VARCHAR(64)       NOT NULL,
    CATEGORY_OID 		VARCHAR(64)       NOT NULL,
    INCLUDE_CAT  		VARCHAR(255)  	  NOT NULL,
    INCLUDE_CATEGORY	VARCHAR(255)      NOT NULL,
    CONSTRAINT PK330 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- CATALOG INCLUDES (340)
--
-- *****************************************************************
CREATE TABLE db2admin.CATALOG_INC (
    OID          		VARCHAR(64)       NOT NULL,
    CATALOG_OID  		VARCHAR(64)       NOT NULL,
    INCLUDE_CAT  		VARCHAR(255)  	  NOT NULL,
    CONSTRAINT PK340 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- NAVIGATION NODE (500)
--
-- *****************************************************************
CREATE TABLE db2admin.NAVNODE (
    OID            VARCHAR(64)        NOT NULL,
    OWNER_OID      VARCHAR(64)        NOT NULL,
    THEME_ID       VARCHAR(255)       NOT NULL,
    THEME_NAME     VARCHAR(255)       NOT NULL,
    CONTENT        BLOB(1M)           ,
    BYTE_COUNT     INTEGER            ,
    IS_ZIPPED      INTEGER DEFAULT 0  NOT NULL,
    COMMUNITY_OID  VARCHAR(64)        ,
    SPACE_OID      VARCHAR(64)        ,
    CREATED        BIGINT             NOT NULL,
    MODIFIED       BIGINT             NOT NULL,
    STATE          INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK500 PRIMARY KEY (OID, OWNER_OID)
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.NAVNODE_LOD (
    RESOURCE_OID  VARCHAR(64)    NOT NULL,
    OWNER_OID     VARCHAR(64)    NOT NULL,
    LOCALE        VARCHAR(64)    NOT NULL,
    TITLE         VARCHAR(255)   NOT NULL,
    DESCRIPTION   VARCHAR(1024)          ,
    CONSTRAINT FK500 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES db2admin.NAVNODE (OID,OWNER_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.NAVNODE_DD (
    RESOURCE_OID  VARCHAR(64)    NOT NULL,
    OWNER_OID     VARCHAR(64)    NOT NULL,
    NAME          VARCHAR(255)   NOT NULL,
    VALUE         VARCHAR(3000)  NOT NULL,
    CONSTRAINT PK502 PRIMARY KEY (RESOURCE_OID,OWNER_OID,NAME),
    CONSTRAINT FK502 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES db2admin.NAVNODE (OID,OWNER_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- NAVIGATION TREE (510)
--
-- *****************************************************************
CREATE TABLE db2admin.NAV_TREE (
    OWNER_OID    VARCHAR(64)         NOT NULL,
    PAGE_OID     VARCHAR(64)         NOT NULL,
    PARENT_OID   VARCHAR(64)         NOT NULL,
    ORDINAL      INTEGER  DEFAULT 1  ,
    IS_VIRTUAL   INTEGER  DEFAULT 0  ,
    CONSTRAINT PK510 PRIMARY KEY (OWNER_OID, PAGE_OID)
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- ACCESS CONTROL (600)
--
-- *****************************************************************
CREATE TABLE db2admin.COMMUNITY_DEF (
    OID            VARCHAR(64)        NOT NULL,
    OWNER_UID      VARCHAR(64)        NOT NULL,
    RESOURCE_OID   VARCHAR(64)        NOT NULL,
    RESOURCE_TYPE  VARCHAR(32)        NOT NULL,
    CREATED        BIGINT             NOT NULL,
    MODIFIED       BIGINT             NOT NULL,
    STATE          INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK600 PRIMARY KEY( OID )
)
-- IN BSPREGTP
;

-- UNIQUE CONSTRAINT
ALTER TABLE db2admin.COMMUNITY_DEF ADD CONSTRAINT UQ600 UNIQUE (OID,RESOURCE_OID);

CREATE TABLE db2admin.ACL (
    COMMUNITY_OID     VARCHAR(64)        NOT NULL,
    PARTICIPANT_UID   VARCHAR(64)        NOT NULL,
    PARTICIPANT_TYPE  INTEGER            NOT NULL,
    PERMISSIONS       VARCHAR(255)       NOT NULL,
    CREATED           BIGINT             NOT NULL,
    MODIFIED          BIGINT             NOT NULL,
    STATE             INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK610 PRIMARY KEY (COMMUNITY_OID,PARTICIPANT_UID),
    CONSTRAINT FK611 FOREIGN KEY (COMMUNITY_OID) REFERENCES db2admin.COMMUNITY_DEF (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- SPACES (700)
--
-- *****************************************************************
CREATE TABLE db2admin.SPACENODE (
    OID            VARCHAR(64)        NOT NULL,
    OWNER_OID      VARCHAR(64)        NOT NULL,
    ROOTNAV_OID    VARCHAR(64)        ,
    TEMPLATE_OID   VARCHAR(64)        ,
    CREATED        BIGINT             NOT NULL,
    MODIFIED       BIGINT             NOT NULL,
    STATE          INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK700 PRIMARY KEY (OID, OWNER_OID)
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.SPACENODE_LOD (
    RESOURCE_OID  VARCHAR(64)    NOT NULL,
    OWNER_OID     VARCHAR(64)    NOT NULL,
    LOCALE        VARCHAR(64)    NOT NULL,
    TITLE         VARCHAR(255)   NOT NULL,
    DESCRIPTION   VARCHAR(1024)          ,
    CONSTRAINT PK701 PRIMARY KEY (RESOURCE_OID,OWNER_OID,LOCALE),
    CONSTRAINT FK701 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES db2admin.SPACENODE (OID,OWNER_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.SPACENODE_DD (
    RESOURCE_OID  VARCHAR(64)    NOT NULL,
    OWNER_OID     VARCHAR(64)    NOT NULL,
    NAME          VARCHAR(255)   NOT NULL,
    VALUE         VARCHAR(3000)  NOT NULL,
    CONSTRAINT PK702 PRIMARY KEY (RESOURCE_OID,OWNER_OID,NAME),
    CONSTRAINT FK702 FOREIGN KEY (RESOURCE_OID,OWNER_OID) REFERENCES db2admin.SPACENODE (OID,OWNER_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- TEMPLATES (800)
--
-- *****************************************************************
CREATE TABLE db2admin.TEMPLATENODE (
    OID            VARCHAR(64)        NOT NULL,
    OWNER_OID      VARCHAR(64)        ,
    CONTENT        BLOB(1M)           ,
    BYTE_COUNT     INTEGER            ,
    TEMPLATE_TYPE  VARCHAR(64)        ,
    CREATED        BIGINT             NOT NULL,
    MODIFIED       BIGINT             NOT NULL,
    STATE          INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK800 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.TEMPLATENODE_LOD (
    RESOURCE_OID  VARCHAR(64)    NOT NULL,
    LOCALE        VARCHAR(64)    NOT NULL,
    TITLE         VARCHAR(255)   NOT NULL,
    DESCRIPTION   VARCHAR(1024)          ,
    CONSTRAINT PK801 PRIMARY KEY (RESOURCE_OID,LOCALE),
    CONSTRAINT FK801 FOREIGN KEY (RESOURCE_OID) REFERENCES db2admin.TEMPLATENODE (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- ACCESS CONTROL RESOURCES (900)
--
-- *****************************************************************
CREATE TABLE db2admin.AC_RESOURCE (
    OID            VARCHAR(64)        NOT NULL,
    OWNER_UID      VARCHAR(64)        NOT NULL,
    RESOURCE_OID   VARCHAR(64)        NOT NULL,
    RESOURCE_TYPE  VARCHAR(32)        NOT NULL,
    ROLE_BLOCKS    VARCHAR(1024)              ,
    CREATED        BIGINT             NOT NULL,
    MODIFIED       BIGINT             NOT NULL,
    STATE          INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK900 PRIMARY KEY( RESOURCE_OID )
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.AC_ROLE (
    AC_RESOURCE_OID   VARCHAR(64)        NOT NULL,
    ROLE_OID          VARCHAR(64)        NOT NULL,
    ROLE_NAME         VARCHAR(1024)      NOT NULL,
    ROLE_TYPE         VARCHAR(1024)              ,
    CREATED           BIGINT             NOT NULL,
    MODIFIED          BIGINT             NOT NULL,
    STATE             INTEGER DEFAULT 1  NOT NULL,
    CONSTRAINT PK910 PRIMARY KEY( ROLE_OID ),
    CONSTRAINT FK911 FOREIGN KEY (AC_RESOURCE_OID) REFERENCES db2admin.AC_RESOURCE (RESOURCE_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.AC_MEMBER (
    ROLE_OID          VARCHAR(64)        NOT NULL,
    MEMBER_UID        VARCHAR(64)        NOT NULL,
    MEMBER_TYPE       INTEGER            NOT NULL,
    CONSTRAINT PK920 PRIMARY KEY (ROLE_OID,MEMBER_UID),
    CONSTRAINT FK921 FOREIGN KEY (ROLE_OID) REFERENCES db2admin.AC_ROLE (ROLE_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- FILESTORE (1000)
--
-- *****************************************************************
CREATE TABLE db2admin.FILESTORE_PATH (
    OID         VARCHAR(64)           NOT NULL,
    PARENT_OID  VARCHAR(64)           NOT NULL,
    NAME        VARCHAR(255)          NOT NULL,
    PATH        VARCHAR(255)          NOT NULL,
    LOCKED      VARCHAR(64)           , 
    OWNER       VARCHAR(64)           ,             
    CREATED     BIGINT                NOT NULL,
    MODIFIED    BIGINT                NOT NULL,
    COLL_TYPE   INTEGER DEFAULT 1     NOT NULL,
    CONSTRAINT PK1010 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.FILESTORE_FILE (
    OID         VARCHAR(64)           NOT NULL,
    F_SIZE      INTEGER               NOT NULL,
    CONTENT     BLOB(1G)           ,
    CONSTRAINT PK1000 PRIMARY KEY (OID),
    CONSTRAINT FK1001 FOREIGN KEY (OID) REFERENCES db2admin.FILESTORE_PATH (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- LAYOUT NODE (1200)
--
-- *****************************************************************
CREATE TABLE db2admin.LAYOUTNODE (
    OID                VARCHAR(64)        NOT NULL,
    PAGE_OID           VARCHAR(64)        NOT NULL,
    SKIN_OID           VARCHAR(255)               ,
    NODE_TYPE          INTEGER DEFAULT 1  NOT NULL,
    CREATED            BIGINT             NOT NULL,
    MODIFIED           BIGINT             NOT NULL,
    CONSTRAINT PK1200 PRIMARY KEY (OID, PAGE_OID)
)
-- IN BSPREGTP
;

CREATE TABLE db2admin.LAYOUTNODE_DD (
    PAGE_OID      VARCHAR(64)    NOT NULL,
    RESOURCE_OID  VARCHAR(64)    NOT NULL,
    NAME          VARCHAR(255)   NOT NULL,
    VALUE         VARCHAR(3000)  NOT NULL,
    CONSTRAINT PK1202 PRIMARY KEY (RESOURCE_OID,PAGE_OID,NAME),
    CONSTRAINT FK1202 FOREIGN KEY (RESOURCE_OID,PAGE_OID) REFERENCES db2admin.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- LAYOUT TREE (1210)
--
-- *****************************************************************
CREATE TABLE db2admin.LAYOUT_TREE (
    LAYOUTNODE_OID VARCHAR(64)         NOT NULL,
    PAGE_OID       VARCHAR(64)         NOT NULL,
    PARENT_OID     VARCHAR(64)         NOT NULL,
    ORDINAL        INTEGER  DEFAULT 1  ,
    CONSTRAINT PK1210 PRIMARY KEY (LAYOUTNODE_OID,PAGE_OID),
    CONSTRAINT FK1210 FOREIGN KEY (LAYOUTNODE_OID,PAGE_OID) REFERENCES db2admin.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- WIDGET RELATION (1300)
--
-- *****************************************************************
CREATE TABLE db2admin.WIDGET_RELATION (
  OID             VARCHAR(64)          NOT NULL,
  CONSTRAINT PK1300 PRIMARY KEY (OID)
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- WIDGET DEFINITION (1310)
--
-- *****************************************************************
CREATE TABLE db2admin.WIDGET_DEFINITION (
  OID             VARCHAR(64)          NOT NULL,
  DEFINITION_URL  VARCHAR(2048)        NOT NULL,
  WIDGET_ID       VARCHAR(255)         NOT NULL,
  WIDGET_TYPE     VARCHAR(20)          NOT NULL,
  CREATED         BIGINT               NOT NULL,
  MODIFIED        BIGINT               NOT NULL,
  CONSTRAINT PK1310 PRIMARY KEY (OID),
  CONSTRAINT FK1310 FOREIGN KEY (OID) REFERENCES db2admin.WIDGET_RELATION (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- WIDGET INSTANCE (1320)
--
-- *****************************************************************
CREATE TABLE db2admin.WIDGET_INSTANCE (
  OID        VARCHAR(64)        NOT NULL,
  OWNER_OID  VARCHAR(64)        ,
  PARENT_OID VARCHAR(64)        ,
  SANDBOX    INTEGER DEFAULT 0  NOT NULL,
  CREATED    BIGINT             NOT NULL,
  MODIFIED   BIGINT             NOT NULL,
  CONSTRAINT PK1320 PRIMARY KEY (OID),
  CONSTRAINT FK1320 FOREIGN KEY (PARENT_OID) REFERENCES db2admin.WIDGET_INSTANCE (OID) ON DELETE CASCADE,
  CONSTRAINT FK1321 FOREIGN KEY (OID) REFERENCES db2admin.WIDGET_RELATION (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- WIDGET WINDOW (1330)
--
-- *****************************************************************
CREATE TABLE db2admin.WIDGET_WINDOW (
  OID            VARCHAR(64)        NOT NULL,
  PAGE_OID       VARCHAR(64)        NOT NULL,
  DEFINITION_OID VARCHAR(64)        NOT NULL,
  INSTANCE_OID   VARCHAR(64)        NOT NULL,
  CREATED        BIGINT             NOT NULL,
  MODIFIED       BIGINT             NOT NULL,
  CONSTRAINT PK1330 PRIMARY KEY (OID),
  CONSTRAINT FK1330 FOREIGN KEY (OID, PAGE_OID) REFERENCES db2admin.LAYOUTNODE (OID, PAGE_OID) ON DELETE CASCADE,
  CONSTRAINT FK1331 FOREIGN KEY (DEFINITION_OID) REFERENCES db2admin.WIDGET_DEFINITION (OID) ON DELETE CASCADE,
  CONSTRAINT FK1332 FOREIGN KEY (INSTANCE_OID) REFERENCES db2admin.WIDGET_INSTANCE (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- WIDGET BLOB (1340)
--
-- *****************************************************************
CREATE TABLE db2admin.WIDGET_WIDGETBLOB (
  PARENT_OID       VARCHAR(64)  NOT NULL,
  CONTENT          BLOB(1M),
  CONSTRAINT PK1340 PRIMARY KEY (PARENT_OID),
  CONSTRAINT FK1340 FOREIGN KEY (PARENT_OID) REFERENCES db2admin.WIDGET_RELATION (OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- WIRE (1400)
--
-- *****************************************************************
CREATE TABLE db2admin.WIREITEM (
    OID         VARCHAR(64)           NOT NULL,
    PAGE_OID    VARCHAR(64)           NOT NULL,
    CREATED     BIGINT                NOT NULL,
    MODIFIED    BIGINT                NOT NULL,
    S_WIDGET    VARCHAR(64)           NOT NULL,
    S_EVENT     VARCHAR(255)          NOT NULL,
    S_EVENTNAME VARCHAR(255)                  ,
    S_PAGE      VARCHAR(64)           NOT NULL,
    T_WIDGET    VARCHAR(64)           NOT NULL,
    T_EVENT     VARCHAR(255)          NOT NULL,
    T_EVENTNAME VARCHAR(255)                  ,
    T_PAGE      VARCHAR(64)           NOT NULL,
    CONSTRAINT PK1400 PRIMARY KEY (OID),
    CONSTRAINT FK1400 FOREIGN KEY (S_WIDGET,PAGE_OID) REFERENCES db2admin.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE,
    CONSTRAINT FK1401 FOREIGN KEY (T_WIDGET,PAGE_OID) REFERENCES db2admin.LAYOUTNODE (OID,PAGE_OID) ON DELETE CASCADE
)
-- IN BSPREGTP
;

-- *****************************************************************
--
-- LAYOUT_MARKUP_NODE (1500)
--
-- *****************************************************************
CREATE TABLE db2admin.LAYOUT_MARKUP_NODE (
	PAGE_OID    VARCHAR(64)           NOT NULL,
	CREATED     BIGINT                NOT NULL,
	MODIFIED    BIGINT                NOT NULL,
	CONTENT     BLOB(3M),
 	CONSTRAINT PK1500 PRIMARY KEY (PAGE_OID)
)
-- IN BSPREGTP
;

--
-- Indexing
--
--*****************************************************************
-- Catalog
CREATE INDEX db2admin.CATACCT      ON db2admin.CATALOG(ACCOUNT_OID);
CREATE INDEX db2admin.ENTRYCATGOID ON db2admin.CATALOG_ENTRY(CATALOG_OID, CATEGORY_OID);
CREATE INDEX db2admin.CATGCATOID   ON db2admin.CATALOG_CATEGORY(CATALOG_OID);
CREATE INDEX db2admin.CATINTCATOID ON db2admin.CATALOG_INC(CATALOG_OID);

-- Navigation
CREATE INDEX db2admin.PAGECOMM     ON db2admin.NAVNODE(COMMUNITY_OID);
CREATE INDEX db2admin.PAGELODOWNRS ON db2admin.NAVNODE_LOD(OWNER_OID,RESOURCE_OID);
CREATE INDEX db2admin.TREEOWPAR    ON db2admin.NAV_TREE(OWNER_OID,PARENT_OID);

-- Acl
CREATE INDEX db2admin.COMMOWNPAR ON db2admin.COMMUNITY_DEF(OWNER_UID);
CREATE INDEX db2admin.PRTTYUID   ON db2admin.ACL(PARTICIPANT_TYPE,PARTICIPANT_UID);
CREATE INDEX db2admin.PRTUID     ON db2admin.ACL(PARTICIPANT_UID);

-- AC
CREATE INDEX db2admin.AC_ROLE_RESOURCE ON db2admin.AC_ROLE(AC_RESOURCE_OID);
CREATE INDEX db2admin.AC_MEMBER_UID ON db2admin.AC_MEMBER(MEMBER_UID);
CREATE INDEX db2admin.AC_MEMBER_MEMBERTYPE ON db2admin.AC_MEMBER(MEMBER_TYPE ASC);
CREATE INDEX db2admin.AC_RESOURCE_OWNER ON db2admin.AC_RESOURCE(OWNER_UID,RESOURCE_OID);

-- FILESTORE_PATH
CREATE INDEX db2admin.FILESTORE_PATH_1 ON db2admin.FILESTORE_PATH( PATH );
CREATE INDEX db2admin.FILESTORE_PATH_2 ON db2admin.FILESTORE_PATH( PARENT_OID);

-- Layout
CREATE INDEX db2admin.LAYOUT_TREE_1 ON db2admin.LAYOUT_TREE(PAGE_OID ASC, PARENT_OID DESC) ALLOW REVERSE SCANS;

-- Account
CREATE INDEX db2admin.ACCOUNT_1 ON db2admin.ACCOUNT(EXTERNAL_ID);

-- Widget & Wire
CREATE INDEX db2admin.WIREITEM_PAGEOID ON db2admin.WIREITEM(PAGE_OID);
CREATE INDEX db2admin.WIREITEM_SEVENT ON db2admin.WIREITEM(S_EVENT);
CREATE INDEX db2admin.WIREITEM_TEVENT ON db2admin.WIREITEM(T_EVENT);
CREATE INDEX db2admin.WIDGETDEFINITION_DEFINITIONURL ON db2admin.WIDGET_DEFINITION(DEFINITION_URL);
CREATE INDEX db2admin.WIDGETDEFINITION_WIDGETID ON db2admin.WIDGET_DEFINITION(WIDGET_ID);
CREATE INDEX db2admin.WIDGETINSTANCE_PARENTOID ON db2admin.WIDGET_INSTANCE(PARENT_OID);
CREATE INDEX db2admin.WIDGETINSTANCE_OWNEROID ON db2admin.WIDGET_INSTANCE(OWNER_OID);
CREATE INDEX db2admin.WIDGETWINDOW_INSTANCEOID ON db2admin.WIDGET_WINDOW(INSTANCE_OID);

--*****************************************************************
--
-- Initialization
--
--*****************************************************************
-- Schema version (leave this here to faciliate version checking)

INSERT INTO db2admin.VERSION_INFO (OID,VERSION_MAJOR,VERSION_MINOR,VERSION_RELEASE,VERSION_DEV,VERSION_TIME,DESCRIPTION)
VALUES ('458202233263219661970198300000000000',1,0,0,15,0,'Initialization from install script');


--------------------create table for business space-------------------------------------------------------
CREATE TABLE db2admin.BSP_USER_DATA_T (
	  USER_DN                 VARCHAR(1000) NOT NULL ,
	  EXTENSION               BLOB(10K) ,
	  PRIMARY KEY ( USER_DN )
) 
--IN BSPBSPACE
;

-- *****************************************************************
--
-- Licensed Materials - Property of IBM
-- 5725-C94, 5725-C95, 5725-C96
-- (C) Copyright IBM Corporation 2006, 2013. All Rights Reserved.
-- US Government Users Restricted Rights- Use, duplication or
-- disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
--
-- *****************************************************************
-- Scriptfile to create schema for DB2 UDB
----------------------------------------------------------------------


-------------------
-- Create tables --
-------------------

CREATE TABLE db2admin.SCHEMA_VERSION
(
  SCHEMA_VERSION                     INTEGER                           NOT NULL ,
  DATA_MIGRATION                     SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SCHEMA_VERSION )
);

CREATE TABLE db2admin.PROCESS_TEMPLATE_B_T
(
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  DEFINITION_NAME                    VARCHAR(220)                               ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  APPLICATION_NAME                   VARCHAR(220)                               ,
  DISPLAY_ID                         INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  DESCRIPTION                        VARCHAR(254)                               ,
  DOCUMENTATION                      CLOB(4096)                                 ,
  EXECUTION_MODE                     INTEGER                           NOT NULL ,
  IS_SHARED                          SMALLINT                          NOT NULL ,
  IS_AD_HOC                          SMALLINT                          NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  VALID_FROM                         TIMESTAMP                         NOT NULL ,
  TARGET_NAMESPACE                   VARCHAR(250)                               ,
  CREATED                            TIMESTAMP                         NOT NULL ,
  AUTO_DELETE                        SMALLINT                          NOT NULL ,
  EXTENDED_AUTO_DELETE               INTEGER                           NOT NULL ,
  VERSION                            VARCHAR(32)                                ,
  SCHEMA_VERSION                     INTEGER                           NOT NULL ,
  ABSTRACT_BASE_NAME                 VARCHAR(254)                               ,
  S_BEAN_LOOKUP_NAME                 VARCHAR(254)                               ,
  S_BEAN60_LOOKUP_NAME               VARCHAR(254)                               ,
  E_BEAN_LOOKUP_NAME                 VARCHAR(254)                               ,
  PROCESS_BASE_NAME                  VARCHAR(254)                               ,
  S_BEAN_HOME_NAME                   VARCHAR(254)                               ,
  E_BEAN_HOME_NAME                   VARCHAR(254)                               ,
  BPEWS_UTID                         CHAR(16)            FOR BIT DATA           ,
  WPC_UTID                           CHAR(16)            FOR BIT DATA           ,
  BPMN_UTID                          CHAR(16)            FOR BIT DATA           ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  ADMINISTRATOR_QTID                 CHAR(16)            FOR BIT DATA           ,
  READER_QTID                        CHAR(16)            FOR BIT DATA           ,
  A_TKTID                            CHAR(16)            FOR BIT DATA           ,
  A_TKTIDFOR_ACTS                    CHAR(16)            FOR BIT DATA           ,
  COMPENSATION_SPHERE                INTEGER                           NOT NULL ,
  AUTONOMY                           INTEGER                           NOT NULL ,
  CAN_CALL                           SMALLINT                          NOT NULL ,
  CAN_INITIATE                       SMALLINT                          NOT NULL ,
  CONTINUE_ON_ERROR                  SMALLINT                          NOT NULL ,
  IGNORE_MISSING_DATA                INTEGER                           NOT NULL ,
  EAR_VERSION                        INTEGER                           NOT NULL ,
  LANGUAGE_TYPE                      INTEGER                           NOT NULL ,
  DEPLOY_TYPE                        INTEGER                           NOT NULL ,
  MESSAGE_DIGEST                     VARCHAR(20)         FOR BIT DATA           ,
  CUSTOM_TEXT1                       VARCHAR(64)                                ,
  CUSTOM_TEXT2                       VARCHAR(64)                                ,
  CUSTOM_TEXT3                       VARCHAR(64)                                ,
  CUSTOM_TEXT4                       VARCHAR(64)                                ,
  CUSTOM_TEXT5                       VARCHAR(64)                                ,
  CUSTOM_TEXT6                       VARCHAR(64)                                ,
  CUSTOM_TEXT7                       VARCHAR(64)                                ,
  CUSTOM_TEXT8                       VARCHAR(64)                                ,
  PRIMARY KEY ( PTID )
);

ALTER TABLE db2admin.PROCESS_TEMPLATE_B_T VOLATILE;

CREATE UNIQUE INDEX db2admin.PTB_NAME_VALID ON db2admin.PROCESS_TEMPLATE_B_T
(   
  NAME, VALID_FROM
);

CREATE INDEX db2admin.PTB_NAME_VF_STATE ON db2admin.PROCESS_TEMPLATE_B_T
(   
  NAME, VALID_FROM, STATE, PTID
);

CREATE INDEX db2admin.PTB_TOP_APP ON db2admin.PROCESS_TEMPLATE_B_T
(   
  APPLICATION_NAME
);

CREATE INDEX db2admin.PTB_STATE_PTID ON db2admin.PROCESS_TEMPLATE_B_T
(   
  STATE, PTID
);

CREATE INDEX db2admin.PTB_NAME ON db2admin.PROCESS_TEMPLATE_B_T
(   
  PTID, NAME
);

CREATE INDEX db2admin.PTB_SBLKN ON db2admin.PROCESS_TEMPLATE_B_T
(   
  S_BEAN60_LOOKUP_NAME
);

CREATE TABLE db2admin.PC_VERSION_TEMPLATE_T
(
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  SNAPSHOT_ID                        VARCHAR(254)                      NOT NULL ,
  SNAPSHOT_NAME                      VARCHAR(254)                               ,
  TOP_LEVEL_TOOLKIT_ACRONYM          VARCHAR(7)                                 ,
  TOP_LEVEL_TOOLKIT_NAME             VARCHAR(254)                               ,
  TRACK_NAME                         VARCHAR(254)                               ,
  PROCESS_APP_NAME                   VARCHAR(254)                               ,
  PROCESS_APP_ACRONYM                VARCHAR(7)                                 ,
  TOOLKIT_SNAPSHOT_ID                VARCHAR(254)                               ,
  TOOLKIT_SNAPSHOT_NAME              VARCHAR(254)                               ,
  TOOLKIT_NAME                       VARCHAR(254)                               ,
  TOOLKIT_ACRONYM                    VARCHAR(7)                                 ,
  IS_TIP                             SMALLINT                          NOT NULL ,
  PRIMARY KEY ( CONTAINMENT_CONTEXT_ID )
);

ALTER TABLE db2admin.PC_VERSION_TEMPLATE_T VOLATILE;

CREATE INDEX db2admin.PCV_SPID ON db2admin.PC_VERSION_TEMPLATE_T
(   
  SNAPSHOT_ID
);

CREATE INDEX db2admin.PCV_PAN ON db2admin.PC_VERSION_TEMPLATE_T
(   
  PROCESS_APP_NAME
);

CREATE INDEX db2admin.PCV_PAA ON db2admin.PC_VERSION_TEMPLATE_T
(   
  PROCESS_APP_ACRONYM
);

CREATE INDEX db2admin.PCV_TLTA ON db2admin.PC_VERSION_TEMPLATE_T
(   
  TOP_LEVEL_TOOLKIT_ACRONYM
);

CREATE TABLE db2admin.PROCESS_TEMPLATE_ATTRIBUTE_B_T
(
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATTR_KEY                           VARCHAR(220)                      NOT NULL ,
  VALUE                              VARCHAR(254)                               ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( PTID, ATTR_KEY )
);

ALTER TABLE db2admin.PROCESS_TEMPLATE_ATTRIBUTE_B_T VOLATILE;

CREATE INDEX db2admin.PTAB_PTID ON db2admin.PROCESS_TEMPLATE_ATTRIBUTE_B_T
(   
  PTID
);

CREATE TABLE db2admin.SCOPE_TEMPLATE_B_T
(
  STID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_STID                        CHAR(16)            FOR BIT DATA           ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COMP_HANDLER_ATID                  CHAR(16)            FOR BIT DATA           ,
  IMPLEMENTS_EHTID                   CHAR(16)            FOR BIT DATA           ,
  FOR_EACH_ATID                      CHAR(16)            FOR BIT DATA           ,
  DISPLAY_ID                         INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  ISOLATED                           SMALLINT                          NOT NULL ,
  IS_COMPENSABLE                     SMALLINT                          NOT NULL ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  A_TKTID                            CHAR(16)            FOR BIT DATA           ,
  IS_IMPLICIT                        SMALLINT                          NOT NULL ,
  HAS_COMPENSATION_HANDLER           SMALLINT                          NOT NULL ,
  PRIMARY KEY ( STID )
);

CREATE INDEX db2admin.ST_PTID ON db2admin.SCOPE_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.SERVICE_TEMPLATE_B_T
(
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PORT_TYPE_NAME                     VARCHAR(254)                      NOT NULL ,
  PORT_TYPE_UTID                     CHAR(16)            FOR BIT DATA  NOT NULL ,
  OPERATION_NAME                     VARCHAR(254)                      NOT NULL ,
  NAME                               VARCHAR(254)                               ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  TRANSACTION_BEHAVIOR               INTEGER                           NOT NULL ,
  IS_TWO_WAY                         SMALLINT                          NOT NULL ,
  NUMBER_OF_RECEIVE_ACTS             INTEGER                           NOT NULL ,
  PRIMARY KEY ( VTID )
);

CREATE INDEX db2admin.VT_VTID_PTUTID ON db2admin.SERVICE_TEMPLATE_B_T
(   
  VTID, PORT_TYPE_UTID
);

CREATE INDEX db2admin.VT_PTID ON db2admin.SERVICE_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.ACTIVITY_SERVICE_TEMPLATE_B_T
(
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARTNER_LINK_NAME                  VARCHAR(220)                               ,
  INPUT_CTID                         CHAR(16)            FOR BIT DATA           ,
  OUTPUT_CTID                        CHAR(16)            FOR BIT DATA           ,
  LINK_ORDER_NUMBER                  INTEGER                                    ,
  POTENTIAL_OWNER_QTID               CHAR(16)            FOR BIT DATA           ,
  READER_QTID                        CHAR(16)            FOR BIT DATA           ,
  EDITOR_QTID                        CHAR(16)            FOR BIT DATA           ,
  TKTID                              CHAR(16)            FOR BIT DATA           ,
  UNDO_MSG_TEMPLATE                  BLOB(1073741823)                           ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( ATID, VTID, KIND )
);

CREATE INDEX db2admin.AST_PTID ON db2admin.ACTIVITY_SERVICE_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.SERVICE_LOCATION_TEMPLATE_B_T
(
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  MODULE_NAME                        VARCHAR(220)                      NOT NULL ,
  EXPORT_NAME                        CLOB(4096)                                 ,
  COMPONENT_NAME                     CLOB(4096)                        NOT NULL ,
  PRIMARY KEY ( PTID, VTID )
);

CREATE INDEX db2admin.SLT_PTID ON db2admin.SERVICE_LOCATION_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.SERVICE_FAULT_TEMPLATE_B_T
(
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  FAULT_NAME                         VARCHAR(220)                      NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  MESSAGE_DEFINITION                 BLOB(3900K)                       NOT NULL ,
  PRIMARY KEY ( VTID, FAULT_NAME )
);

CREATE INDEX db2admin.SFT_PTID ON db2admin.SERVICE_FAULT_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.ACTIVITY_TEMPLATE_B_T
(
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_STID                        CHAR(16)            FOR BIT DATA           ,
  IMPLEMENTS_STID                    CHAR(16)            FOR BIT DATA           ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  IMPLEMENTS_EHTID                   CHAR(16)            FOR BIT DATA           ,
  ENCLOSING_FOR_EACH_ATID            CHAR(16)            FOR BIT DATA           ,
  IS_EVENT_HANDLER_END_ACTIVITY      SMALLINT                          NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  NAME                               VARCHAR(220)                               ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  JOIN_CONDITION                     INTEGER                           NOT NULL ,
  JOIN_CONDITION_NAME                VARCHAR(254)                               ,
  EXIT_CONDITION                     INTEGER                           NOT NULL ,
  EXIT_CONDITION_NAME                VARCHAR(254)                               ,
  EXIT_CONDITION_EXECUTE_AT          INTEGER                           NOT NULL ,
  NUMBER_OF_LINKS                    INTEGER                           NOT NULL ,
  SUPPRESS_JOIN_FAILURE              SMALLINT                          NOT NULL ,
  SOURCES_TYPE                       INTEGER                           NOT NULL ,
  TARGETS_TYPE                       INTEGER                           NOT NULL ,
  CREATE_INSTANCE                    SMALLINT                                   ,
  IS_END_ACTIVITY                    SMALLINT                          NOT NULL ,
  FAULT_NAME                         VARCHAR(254)                               ,
  HAS_OWN_FAULT_HANDLER              SMALLINT                          NOT NULL ,
  COMPLEX_BEGIN_ATID                 CHAR(16)            FOR BIT DATA           ,
  CORRESPONDING_END_ATID             CHAR(16)            FOR BIT DATA           ,
  PARENT_ATID                        CHAR(16)            FOR BIT DATA           ,
  HAS_CROSSING_LINK                  SMALLINT                                   ,
  SCRIPT_NAME                        VARCHAR(254)                               ,
  AFFILIATION                        INTEGER                           NOT NULL ,
  TRANSACTION_BEHAVIOR               INTEGER                           NOT NULL ,
  DESCRIPTION                        VARCHAR(254)                               ,
  DOCUMENTATION                      CLOB(4096)                                 ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  FAULT_NAME_UTID                    CHAR(16)            FOR BIT DATA           ,
  FAULT_VARIABLE_CTID                CHAR(16)            FOR BIT DATA           ,
  DISPLAY_ID                         INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  IS_TRANSACTIONAL                   SMALLINT                          NOT NULL ,
  CONTINUE_ON_ERROR                  SMALLINT                          NOT NULL ,
  ENCLOSED_FTID                      CHAR(16)            FOR BIT DATA           ,
  EXPRESSION                         CLOB(3900K)                                ,
  EXIT_EXPRESSION                    CLOB(3900K)                                ,
  HAS_INBOUND_LINK                   SMALLINT                          NOT NULL ,
  COMPENSATION_STID                  CHAR(16)            FOR BIT DATA           ,
  COMPENSATION_ATID                  CHAR(16)            FOR BIT DATA           ,
  A_TKTID                            CHAR(16)            FOR BIT DATA           ,
  IS_IN_GFLOW                        SMALLINT                          NOT NULL ,
  IS_REGION_BEGIN                    SMALLINT                          NOT NULL ,
  CORRESPONDING_IORATID              CHAR(16)            FOR BIT DATA           ,
  IS_GFLOW                           SMALLINT                          NOT NULL ,
  CUSTOM_IMPLEMENTATION              BLOB(3900K)                                ,
  EXPRESSION_MAP                     BLOB(3900K)                                ,
  EXIT_EXPRESSION_MAP                BLOB(3900K)                                ,
  GENERATED_BY                       VARCHAR(220)                               ,
  GATEWAY_DIRECTION                  INTEGER                           NOT NULL ,
  IS_INTERRUPTING                    SMALLINT                          NOT NULL ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  PRIMARY KEY ( ATID )
);

CREATE INDEX db2admin.ATB_PTID ON db2admin.ACTIVITY_TEMPLATE_B_T
(   
  PTID
);

CREATE INDEX db2admin.ATB_NAME ON db2admin.ACTIVITY_TEMPLATE_B_T
(   
  NAME
);

CREATE INDEX db2admin.ATB_KIND_BR_NAME ON db2admin.ACTIVITY_TEMPLATE_B_T
(   
  KIND, BUSINESS_RELEVANCE, NAME
);

CREATE TABLE db2admin.ALARM_TEMPLATE_B_T
(
  XTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EXPRESSION                         BLOB(3900K)                                ,
  EXPRESSION_NAME                    VARCHAR(254)                               ,
  DURATION                           VARCHAR(254)                               ,
  CALENDAR                           VARCHAR(254)                               ,
  CALENDAR_JNDI_NAME                 VARCHAR(254)                               ,
  REPEAT_KIND                        INTEGER                           NOT NULL ,
  REPEAT_EXPRESSION                  BLOB(3900K)                                ,
  REPEAT_EXP_NAME                    VARCHAR(254)                               ,
  ON_ALARM_ORDER_NUMBER              INTEGER                                    ,
  EXPRESSION_MAP                     BLOB(3900K)                                ,
  REPEAT_EXPRESSION_MAP              BLOB(3900K)                                ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( XTID )
);

CREATE INDEX db2admin.XT_PTID ON db2admin.ALARM_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.FAULT_HANDLER_TEMPLATE_B_T
(
  FTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  FAULT_NAME                         VARCHAR(254)                               ,
  CTID                               CHAR(16)            FOR BIT DATA           ,
  STID                               CHAR(16)            FOR BIT DATA           ,
  ATID                               CHAR(16)            FOR BIT DATA           ,
  FAULT_LINK_SOURCE_ATID             CHAR(16)            FOR BIT DATA           ,
  FAULT_LINK_TARGET_ATID             CHAR(16)            FOR BIT DATA           ,
  IMPLEMENTATION_ATID                CHAR(16)            FOR BIT DATA  NOT NULL ,
  FAULT_NAME_UTID                    CHAR(16)            FOR BIT DATA           ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( FTID )
);

CREATE INDEX db2admin.FT_PTID ON db2admin.FAULT_HANDLER_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.LINK_TEMPLATE_B_T
(
  SOURCE_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  FLOW_BEGIN_ATID                    CHAR(16)            FOR BIT DATA           ,
  ENCLOSING_FOR_EACH_ATID            CHAR(16)            FOR BIT DATA           ,
  DISPLAY_ID                         INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  NAME                               VARCHAR(254)                               ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  LIFETIME                           INTEGER                           NOT NULL ,
  TRANSITION_CONDITION               INTEGER                           NOT NULL ,
  TRANSITION_CONDITION_NAME          VARCHAR(254)                               ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  SEQUENCE_NUMBER                    INTEGER                           NOT NULL ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  DESCRIPTION                        VARCHAR(254)                               ,
  DOCUMENTATION                      CLOB(4096)                                 ,
  EXPRESSION                         CLOB(3900K)                                ,
  IS_INBOUND_LINK                    SMALLINT                          NOT NULL ,
  OUTBOUND_ATID                      CHAR(16)            FOR BIT DATA           ,
  EXPRESSION_MAP                     BLOB(3900K)                                ,
  GENERATED_BY                       VARCHAR(220)                               ,
  RTID                               CHAR(16)            FOR BIT DATA           ,
  PRIMARY KEY ( SOURCE_ATID, TARGET_ATID )
);

CREATE INDEX db2admin.LNK_PTID ON db2admin.LINK_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.LINK_BOUNDARY_TEMPLATE_B_T
(
  SOURCE_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  BOUNDARY_STID                      CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  IS_OUTMOST_BOUNDARY                SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SOURCE_ATID, TARGET_ATID, BOUNDARY_STID )
);

CREATE INDEX db2admin.BND_PTID ON db2admin.LINK_BOUNDARY_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.RESET_TEMPLATE_B_T
(
  LOOP_ENTRY_ATID                    CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOOP_BODY_ATID                     CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  PRIMARY KEY ( LOOP_ENTRY_ATID, LOOP_BODY_ATID )
);

CREATE INDEX db2admin.RST_PTID ON db2admin.RESET_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.VARIABLE_MAPPING_TEMPLATE_B_T
(
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_CTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_CTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARAMETER                          VARCHAR(254)                      NOT NULL ,
  PRIMARY KEY ( PTID, ATID, VTID, SOURCE_CTID, TARGET_CTID )
);

CREATE INDEX db2admin.VMT_TCTID ON db2admin.VARIABLE_MAPPING_TEMPLATE_B_T
(   
  PTID, ATID, VTID, TARGET_CTID
);

CREATE TABLE db2admin.VARIABLE_TEMPLATE_B_T
(
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHTID                              CHAR(16)            FOR BIT DATA           ,
  STID                               CHAR(16)            FOR BIT DATA           ,
  FTID                               CHAR(16)            FOR BIT DATA           ,
  DERIVED                            SMALLINT                          NOT NULL ,
  DISPLAY_ID                         INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  FROM_SPEC                          INTEGER                           NOT NULL ,
  NAME                               VARCHAR(254)                      NOT NULL ,
  MESSAGE_TEMPLATE                   BLOB(3900K)                                ,
  IS_QUERYABLE                       SMALLINT                          NOT NULL ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  GENERATED_BY                       VARCHAR(220)                               ,
  SEQUENCE_NUMBER                    INTEGER                           NOT NULL ,
  FROM_VARIABLE_CTID                 CHAR(16)            FOR BIT DATA           ,
  FROM_PARAMETER2                    VARCHAR(254)                               ,
  FROM_PARAMETER3                    BLOB(3900K)                                ,
  FROM_PARAMETER3_LANGUAGE           INTEGER                           NOT NULL ,
  FROM_EXPRESSION_MAP                BLOB(3900K)                                ,
  ATID                               CHAR(16)            FOR BIT DATA           ,
  PRIMARY KEY ( CTID )
);

CREATE INDEX db2admin.CT_PTID ON db2admin.VARIABLE_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.VARIABLE_STACK_TEMPLATE_B_T
(
  VSID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  STID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  FTID                               CHAR(16)            FOR BIT DATA           ,
  EHTID                              CHAR(16)            FOR BIT DATA           ,
  NAME                               VARCHAR(255)                      NOT NULL ,
  PRIMARY KEY ( VSID )
);

CREATE INDEX db2admin.VS_PTID ON db2admin.VARIABLE_STACK_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.ACTIVITY_FAULT_TEMPLATE_B_T
(
  AFID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  FAULT_NAME                         VARCHAR(254)                      NOT NULL ,
  FAULT_UTID                         CHAR(16)            FOR BIT DATA           ,
  MESSAGE                            BLOB(3900K)                       NOT NULL ,
  PRIMARY KEY ( AFID )
);

CREATE INDEX db2admin.AF_PTID ON db2admin.ACTIVITY_FAULT_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.PARTNER_LINK_TEMPLATE_B_T
(
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARTNER_LINK_NAME                  VARCHAR(220)                      NOT NULL ,
  PROCESS_NAME                       VARCHAR(220)                               ,
  TARGET_NAMESPACE                   VARCHAR(250)                               ,
  RESOLUTION_SCOPE                   INTEGER                           NOT NULL ,
  MY_ROLE                            SMALLINT                          NOT NULL ,
  MY_ROLE_IMPL                       BLOB(3900K)                                ,
  MY_ROLE_LOCALNAME                  VARCHAR(220)                               ,
  MY_ROLE_NAMESPACE                  VARCHAR(220)                               ,
  THEIR_ROLE                         SMALLINT                          NOT NULL ,
  THEIR_ROLE_IMPL                    BLOB(3900K)                                ,
  THEIR_ROLE_LOCALNAME               VARCHAR(220)                               ,
  THEIR_ROLE_NAMESPACE               VARCHAR(220)                               ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( PTID, PARTNER_LINK_NAME )
);

CREATE TABLE db2admin.URI_TEMPLATE_B_T
(
  UTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  URI                                VARCHAR(220)                      NOT NULL ,
  PRIMARY KEY ( UTID )
);

CREATE UNIQUE INDEX db2admin.UT_PTID_URI ON db2admin.URI_TEMPLATE_B_T
(   
  PTID, URI
);

CREATE INDEX db2admin.UT_UTID_URI ON db2admin.URI_TEMPLATE_B_T
(   
  UTID, URI
);

CREATE TABLE db2admin.CLIENT_SETTING_TEMPLATE_B_T
(
  CSID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA           ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA           ,
  SETTINGS                           BLOB(3900K)                                ,
  PRIMARY KEY ( CSID )
);

CREATE INDEX db2admin.CS_PTID ON db2admin.CLIENT_SETTING_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.ASSIGN_TEMPLATE_B_T
(
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  FROM_SPEC                          INTEGER                           NOT NULL ,
  FROM_VARIABLE_CTID                 CHAR(16)            FOR BIT DATA           ,
  FROM_PARAMETER2                    VARCHAR(254)                               ,
  FROM_PARAMETER3                    BLOB(1073741823)                           ,
  FROM_PARAMETER3_LANGUAGE           INTEGER                           NOT NULL ,
  TO_SPEC                            INTEGER                           NOT NULL ,
  TO_VARIABLE_CTID                   CHAR(16)            FOR BIT DATA           ,
  TO_PARAMETER2                      VARCHAR(254)                               ,
  TO_PARAMETER3                      BLOB(3900K)                                ,
  TO_PARAMETER3_LANGUAGE             INTEGER                           NOT NULL ,
  FROM_EXPRESSION_MAP                BLOB(3900K)                                ,
  TO_EXPRESSION_MAP                  BLOB(3900K)                                ,
  PRIMARY KEY ( ATID, ORDER_NUMBER )
);

CREATE INDEX db2admin.ASTB_PTID ON db2admin.ASSIGN_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.CORRELATION_SET_TEMPLATE_B_T
(
  COID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  STID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(255)                      NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( COID )
);

CREATE INDEX db2admin.CSTB_PTID ON db2admin.CORRELATION_SET_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.CORRELATION_TEMPLATE_B_T
(
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  IS_FOR_EVENT_HANDLER               SMALLINT                          NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  INITIATE                           INTEGER                           NOT NULL ,
  PATTERN                            INTEGER                           NOT NULL ,
  PRIMARY KEY ( ATID, VTID, COID, IS_FOR_EVENT_HANDLER )
);

CREATE INDEX db2admin.COID_PTID ON db2admin.CORRELATION_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.PROPERTY_ALIAS_TEMPLATE_B_T
(
  PAID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SEQUENCE_NUMBER                    INTEGER                           NOT NULL ,
  PROPERTY_UTID                      CHAR(16)            FOR BIT DATA  NOT NULL ,
  PROPERTY_NAME                      VARCHAR(255)                      NOT NULL ,
  JAVA_TYPE                          VARCHAR(255)                      NOT NULL ,
  MSG_TYPE_UTID                      CHAR(16)            FOR BIT DATA  NOT NULL ,
  MSG_TYPE_NAME                      VARCHAR(255)                      NOT NULL ,
  MSG_TYPE_KIND                      INTEGER                           NOT NULL ,
  PROPERTY_TYPE_UTID                 CHAR(16)            FOR BIT DATA           ,
  PROPERTY_TYPE_NAME                 VARCHAR(255)                               ,
  PART                               VARCHAR(255)                               ,
  QUERY                              VARCHAR(255)                               ,
  QUERY_LANGUAGE                     INTEGER                           NOT NULL ,
  IS_DEFINED_INLINE                  SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PAID )
);

CREATE INDEX db2admin.PATB_COID_UTID ON db2admin.PROPERTY_ALIAS_TEMPLATE_B_T
(   
  COID, MSG_TYPE_UTID
);

CREATE INDEX db2admin.PATB_PTID_UTIDS ON db2admin.PROPERTY_ALIAS_TEMPLATE_B_T
(   
  PTID, MSG_TYPE_UTID, PROPERTY_UTID
);

CREATE TABLE db2admin.EVENT_HANDLER_TEMPLATE_B_T
(
  EHTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  STID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  IMPL_ATID                          CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA           ,
  INPUT_CTID                         CHAR(16)            FOR BIT DATA           ,
  TKTID                              CHAR(16)            FOR BIT DATA           ,
  KIND                               INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( EHTID )
);

CREATE INDEX db2admin.EHT_PTID ON db2admin.EVENT_HANDLER_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.EHALARM_TEMPLATE_B_T
(
  EHTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  EXPRESSION                         BLOB(3900K)                                ,
  EXPRESSION_NAME                    VARCHAR(254)                               ,
  DURATION                           VARCHAR(254)                               ,
  CALENDAR                           VARCHAR(254)                               ,
  CALENDAR_JNDI_NAME                 VARCHAR(254)                               ,
  REPEAT_KIND                        INTEGER                           NOT NULL ,
  REPEAT_EXPRESSION                  BLOB(3900K)                                ,
  REPEAT_EXP_NAME                    VARCHAR(254)                               ,
  REPEAT_DURATION                    VARCHAR(254)                               ,
  REPEAT_CALENDAR                    VARCHAR(254)                               ,
  REPEAT_CALENDAR_JNDI_NAME          VARCHAR(254)                               ,
  EXPRESSION_MAP                     BLOB(3900K)                                ,
  REPEAT_EXPRESSION_MAP              BLOB(3900K)                                ,
  PRIMARY KEY ( EHTID )
);

CREATE INDEX db2admin.EXT_PTID ON db2admin.EHALARM_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.CUSTOM_EXT_TEMPLATE_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAMESPACE                          VARCHAR(220)                      NOT NULL ,
  LOCALNAME                          VARCHAR(220)                      NOT NULL ,
  TEMPLATE_INFO                      BLOB(3900K)                                ,
  INSTANCE_INFO                      BLOB(3900K)                                ,
  PRIMARY KEY ( PKID )
);

CREATE INDEX db2admin.CETB_PTID ON db2admin.CUSTOM_EXT_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.CUSTOM_STMT_TEMPLATE_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAMESPACE                          VARCHAR(220)                      NOT NULL ,
  LOCALNAME                          VARCHAR(220)                      NOT NULL ,
  PURPOSE                            VARCHAR(220)                      NOT NULL ,
  STATEMENT                          BLOB(3900K)                                ,
  PRIMARY KEY ( PKID )
);

CREATE INDEX db2admin.CST_PTID_NS_LN_P ON db2admin.CUSTOM_STMT_TEMPLATE_B_T
(   
  PTID, NAMESPACE, LOCALNAME, PURPOSE
);

CREATE TABLE db2admin.PROCESS_CELL_MAP_T
(
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  CELL                               VARCHAR(220)                      NOT NULL ,
  PRIMARY KEY ( PTID, CELL )
);

CREATE TABLE db2admin.ACTIVITY_TEMPLATE_ATTR_B_T
(
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATTR_KEY                           VARCHAR(192)                      NOT NULL ,
  ATTR_VALUE                         VARCHAR(254)                               ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  PRIMARY KEY ( ATID, ATTR_KEY )
);

CREATE INDEX db2admin.ATAB_PTID ON db2admin.ACTIVITY_TEMPLATE_ATTR_B_T
(   
  PTID
);

CREATE INDEX db2admin.ATAB_VALUE ON db2admin.ACTIVITY_TEMPLATE_ATTR_B_T
(   
  ATTR_VALUE
);

CREATE TABLE db2admin.FOR_EACH_TEMPLATE_B_T
(
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COUNTER_CTID                       CHAR(16)            FOR BIT DATA  NOT NULL ,
  SUCCESSFUL_BRANCHES_ONLY           SMALLINT                          NOT NULL ,
  START_COUNTER_LANGUAGE             INTEGER                           NOT NULL ,
  FINAL_COUNTER_LANGUAGE             INTEGER                           NOT NULL ,
  COMPLETION_CONDITION_LANGUAGE      INTEGER                           NOT NULL ,
  START_COUNTER_EXPRESSION           BLOB(3900K)                                ,
  FINAL_COUNTER_EXPRESSION           BLOB(3900K)                                ,
  COMPLETION_COND_EXPRESSION         BLOB(3900K)                                ,
  FOR_EACH_METHOD                    VARCHAR(254)                               ,
  START_COUNTER_EXPRESSION_MAP       BLOB(3900K)                                ,
  FINAL_COUNTER_EXPRESSION_MAP       BLOB(3900K)                                ,
  COMPLETION_COND_EXPRESSION_MAP     BLOB(3900K)                                ,
  PRIMARY KEY ( ATID )
);

CREATE INDEX db2admin.FET_PTID ON db2admin.FOR_EACH_TEMPLATE_B_T
(   
  PTID
);

CREATE TABLE db2admin.GRAPHICAL_PROCESS_MODEL_T
(
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE                             VARCHAR(100)                      NOT NULL ,
  KIND                               VARCHAR(100)                      NOT NULL ,
  GRAPHICAL_DATA                     BLOB(10000K)                               ,
  ID_MAPPING                         BLOB(10000K)                               ,
  PRIMARY KEY ( PTID, SOURCE, KIND )
);

CREATE TABLE db2admin.QUERYABLE_VARIABLE_TEMPLATE_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PAID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  QUERY_TYPE                         INTEGER                           NOT NULL ,
  PRIMARY KEY ( PKID )
);

CREATE INDEX db2admin.QVT_PTID ON db2admin.QUERYABLE_VARIABLE_TEMPLATE_T
(   
  PTID
);

CREATE TABLE db2admin.MIGRATION_PLAN_TEMPLATE_T
(
  MPTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_PTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_PTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TYPE                               INTEGER                           NOT NULL ,
  PRIMARY KEY ( MPTID )
);

CREATE UNIQUE INDEX db2admin.MPT_PTIDS ON db2admin.MIGRATION_PLAN_TEMPLATE_T
(   
  SOURCE_PTID, TARGET_PTID
);

CREATE INDEX db2admin.MPT_TPTID ON db2admin.MIGRATION_PLAN_TEMPLATE_T
(   
  TARGET_PTID
);

CREATE TABLE db2admin.IDMAPPING_TEMPLATE_T
(
  MPTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_OID                         CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_OID                         CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_PTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  PRIMARY KEY ( MPTID, SOURCE_OID )
);

CREATE INDEX db2admin.IDMT_PTID ON db2admin.IDMAPPING_TEMPLATE_T
(   
  SOURCE_PTID
);

CREATE TABLE db2admin.CHANGE_GROUP_TEMPLATE_T
(
  CGTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  MPTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_PTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  MANDATORY                          SMALLINT                          NOT NULL ,
  CHANGES                            CLOB(3900K)                       NOT NULL ,
  PRIMARY KEY ( CGTID )
);

CREATE INDEX db2admin.CGT_MT ON db2admin.CHANGE_GROUP_TEMPLATE_T
(   
  MPTID
);

CREATE INDEX db2admin.CGT_PT ON db2admin.CHANGE_GROUP_TEMPLATE_T
(   
  SOURCE_PTID
);

CREATE TABLE db2admin.CHANGE_GROUP_IMPACT_TEMPLATE_T
(
  CGTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  MPTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_PTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  RELATIONSHIP                       INTEGER                           NOT NULL ,
  PRIMARY KEY ( CGTID, SOURCE_ATID )
);

CREATE INDEX db2admin.CGIT_MT ON db2admin.CHANGE_GROUP_IMPACT_TEMPLATE_T
(   
  MPTID
);

CREATE INDEX db2admin.CGIT_PT ON db2admin.CHANGE_GROUP_IMPACT_TEMPLATE_T
(   
  SOURCE_PTID
);

CREATE TABLE db2admin.MIGRATION_PLAN_VAR_TEMPLATE_T
(
  MPTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_CTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_STID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_PTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  PRIMARY KEY ( MPTID, TARGET_CTID )
);

CREATE INDEX db2admin.MPVT_PT ON db2admin.MIGRATION_PLAN_VAR_TEMPLATE_T
(   
  SOURCE_PTID
);

CREATE TABLE db2admin.REGION_TEMPLATE_T
(
  RTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  BEGIN_ATID                         CHAR(16)            FOR BIT DATA           ,
  END_ATID                           CHAR(16)            FOR BIT DATA           ,
  REGION_TYPE                        INTEGER                           NOT NULL ,
  BEGIN_ORDER_NUMBER                 INTEGER                           NOT NULL ,
  PARENT_RTID                        CHAR(16)            FOR BIT DATA           ,
  PRIMARY KEY ( RTID )
);

CREATE INDEX db2admin.RGT_PTID ON db2admin.REGION_TEMPLATE_T
(   
  PTID
);

CREATE TABLE db2admin.REGION_CONTENT_TEMPLATE_T
(
  RTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINED_ATID                     CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PRIMARY KEY ( RTID, CONTAINED_ATID )
);

CREATE INDEX db2admin.RCT_PTID ON db2admin.REGION_CONTENT_TEMPLATE_T
(   
  PTID
);

CREATE TABLE db2admin.CHANGE_TEMPLATE_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  MPTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  PROPERTY                           INTEGER                           NOT NULL ,
  DISPLAY_ID_EXT                     VARCHAR(32)                       NOT NULL ,
  CHANGE_TYPE                        INTEGER                           NOT NULL ,
  SOURCE_PTID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  PRIMARY KEY ( PKID )
);

CREATE UNIQUE INDEX db2admin.CT_MTPDIS ON db2admin.CHANGE_TEMPLATE_T
(   
  MPTID, PROPERTY, DISPLAY_ID_EXT
);

CREATE INDEX db2admin.CGT_PTID ON db2admin.CHANGE_TEMPLATE_T
(   
  SOURCE_PTID
);

CREATE TABLE db2admin.DATA_ASSIGNMENT_TEMPLATE_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA_ASSOCIATION_TYPE              INTEGER                           NOT NULL ,
  SOURCE_REF_CTID                    CHAR(16)            FOR BIT DATA           ,
  TARGET_REF_CTID                    CHAR(16)            FOR BIT DATA           ,
  FROM_EXPRESSION                    BLOB(1073741823)                           ,
  FROM_EXPRESSION_MAP                BLOB(1073741823)                           ,
  TO_EXPRESSION                      BLOB(1073741823)                           ,
  TO_EXPRESSION_MAP                  BLOB(1073741823)                           ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.DATA_ASSIGNMENT_TEMPLATE_T VOLATILE;

CREATE INDEX db2admin.DATB_PTID ON db2admin.DATA_ASSIGNMENT_TEMPLATE_T
(   
  PTID
);

CREATE INDEX db2admin.DATB_ATID_DATA ON db2admin.DATA_ASSIGNMENT_TEMPLATE_T
(   
  ATID, DATA_ASSOCIATION_TYPE
);

CREATE TABLE db2admin.DATA_VISIBILITY_TEMPLATE_T
(
  VSID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(255)                      NOT NULL ,
  PRIMARY KEY ( VSID )
);

CREATE INDEX db2admin.DVT_PTID ON db2admin.DATA_VISIBILITY_TEMPLATE_T
(   
  PTID
);

CREATE TABLE db2admin.LOOP_CHAR_TEMPLATE_T
(
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOOP_TYPE                          INTEGER                           NOT NULL ,
  CONDITION                          BLOB(1073741823)                           ,
  CONDITION_PREFIX_MAP               BLOB(1073741823)                           ,
  LOOP_MAXIMUM                       INTEGER                                    ,
  PRIMARY KEY ( ATID )
);

CREATE TABLE db2admin.IORCOUNTER_TEMPLATE_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  GATEWAY_ATID                       CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COUNTER_ID                         CLOB(3900K)                       NOT NULL ,
  PRIMARY KEY ( PKID )
);

CREATE INDEX db2admin.IOR_CNT_SRC_TRGT ON db2admin.IORCOUNTER_TEMPLATE_T
(   
  SOURCE_ATID, TARGET_ATID
);

CREATE INDEX db2admin.IOR_CNT_PTID ON db2admin.IORCOUNTER_TEMPLATE_T
(   
  PTID
);

CREATE TABLE db2admin.ERROR_EVENT_TEMPLATE_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ERROR_NAME                         VARCHAR(254)                               ,
  ERROR_NAME_UTID                    CHAR(16)            FOR BIT DATA           ,
  ERROR_MESSAGE_DEFINITION           BLOB(3900K)                                ,
  CTID                               CHAR(16)            FOR BIT DATA           ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  PRIMARY KEY ( PKID )
);

CREATE TABLE db2admin.STAFF_QUERY_TEMPLATE_T
(
  QTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ASSOCIATED_OBJECT_TYPE             INTEGER                           NOT NULL ,
  ASSOCIATED_OID                     CHAR(16)            FOR BIT DATA  NOT NULL ,
  T_QUERY                            VARCHAR(32)                       NOT NULL ,
  QUERY                              BLOB(3900K)                       NOT NULL ,
  HASH_CODE                          INTEGER                           NOT NULL ,
  SUBSTITUTION_POLICY                INTEGER                           NOT NULL ,
  STAFF_VERB                         BLOB(3900K)                                ,
  PRIMARY KEY ( QTID )
);

CREATE INDEX db2admin.SQT_HASH ON db2admin.STAFF_QUERY_TEMPLATE_T
(   
  ASSOCIATED_OID, HASH_CODE, T_QUERY, ASSOCIATED_OBJECT_TYPE
);

CREATE TABLE db2admin.PROCESS_INSTANCE_B_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SHARED_PC_ID                       CHAR(16)            FOR BIT DATA           ,
  STATE                              INTEGER                           NOT NULL ,
  PENDING_REQUEST                    INTEGER                           NOT NULL ,
  CREATED                            TIMESTAMP                                  ,
  STARTED                            TIMESTAMP                                  ,
  COMPLETED                          TIMESTAMP                                  ,
  LAST_STATE_CHANGE                  TIMESTAMP                                  ,
  LAST_MODIFIED                      TIMESTAMP                                  ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  PARENT_NAME                        VARCHAR(220)                               ,
  TOP_LEVEL_NAME                     VARCHAR(220)                      NOT NULL ,
  COMPENSATION_SPHERE_NAME           VARCHAR(100)                               ,
  STARTER                            VARCHAR(128)                               ,
  DESCRIPTION                        VARCHAR(254)                               ,
  INPUT_SNID                         CHAR(16)            FOR BIT DATA           ,
  INPUT_ATID                         CHAR(16)            FOR BIT DATA           ,
  INPUT_VTID                         CHAR(16)            FOR BIT DATA           ,
  OUTPUT_SNID                        CHAR(16)            FOR BIT DATA           ,
  OUTPUT_ATID                        CHAR(16)            FOR BIT DATA           ,
  OUTPUT_VTID                        CHAR(16)            FOR BIT DATA           ,
  FAULT_NAME                         VARCHAR(254)                               ,
  TOP_LEVEL_PIID                     CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_PIID                        CHAR(16)            FOR BIT DATA           ,
  PARENT_AIID                        CHAR(16)            FOR BIT DATA           ,
  TKIID                              CHAR(16)            FOR BIT DATA           ,
  TERMIN_ON_REC                      SMALLINT                          NOT NULL ,
  AWAITED_SUB_PROC                   SMALLINT                          NOT NULL ,
  IS_CREATING                        SMALLINT                          NOT NULL ,
  PREVIOUS_STATE                     INTEGER                                    ,
  EXECUTING_ISOLATED_SCOPE           SMALLINT                          NOT NULL ,
  SCHEDULER_TASK_ID                  VARCHAR(254)                               ,
  RESUMES                            TIMESTAMP                                  ,
  PENDING_SKIP_REQUEST               SMALLINT                          NOT NULL ,
  IS_MIGRATED                        SMALLINT                          NOT NULL ,
  UNHANDLED_EXCEPTION                BLOB(1073741823)                           ,
  ERROR_EVENT_ATID                   CHAR(16)            FOR BIT DATA           ,
  CREATED_WITH_VERSION               INTEGER                           NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  CUSTOM_TEXT1                       VARCHAR(64)                                ,
  CUSTOM_TEXT2                       VARCHAR(64)                                ,
  CUSTOM_TEXT3                       VARCHAR(64)                                ,
  CUSTOM_TEXT4                       VARCHAR(64)                                ,
  CUSTOM_TEXT5                       VARCHAR(64)                                ,
  CUSTOM_TEXT6                       VARCHAR(64)                                ,
  CUSTOM_TEXT7                       VARCHAR(64)                                ,
  CUSTOM_TEXT8                       VARCHAR(64)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID )
);

ALTER TABLE db2admin.PROCESS_INSTANCE_B_T VOLATILE;

CREATE UNIQUE INDEX db2admin.PIB_NAME ON db2admin.PROCESS_INSTANCE_B_T
(   
  NAME
);

CREATE INDEX db2admin.PIB_TOP ON db2admin.PROCESS_INSTANCE_B_T
(   
  TOP_LEVEL_PIID
);

CREATE INDEX db2admin.PIB_PAP ON db2admin.PROCESS_INSTANCE_B_T
(   
  PARENT_PIID
);

CREATE INDEX db2admin.PIB_PAR ON db2admin.PROCESS_INSTANCE_B_T
(   
  PARENT_AIID
);

CREATE INDEX db2admin.PIB_PTID ON db2admin.PROCESS_INSTANCE_B_T
(   
  PTID
);

CREATE INDEX db2admin.PIB_WSID1 ON db2admin.PROCESS_INSTANCE_B_T
(   
  WSID_1, STATE
);

CREATE INDEX db2admin.PIB_WSID2 ON db2admin.PROCESS_INSTANCE_B_T
(   
  WSID_2, STATE
);

CREATE INDEX db2admin.PIB_STA_PT_ST2_PI ON db2admin.PROCESS_INSTANCE_B_T
(   
  STATE, PTID, STARTER, STARTED, PIID
);

CREATE TABLE db2admin.SCOPE_INSTANCE_B_T
(
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_SIID                        CHAR(16)            FOR BIT DATA           ,
  STID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHIID                              CHAR(16)            FOR BIT DATA           ,
  ENCLOSING_FEIID                    CHAR(16)            FOR BIT DATA           ,
  ENCLOSING_FOR_EACH_END_AIID        CHAR(16)            FOR BIT DATA           ,
  COMPENSATE_AIID                    CHAR(16)            FOR BIT DATA           ,
  PARENT_COMP_SIID                   CHAR(16)            FOR BIT DATA           ,
  LAST_COMP_SIID                     CHAR(16)            FOR BIT DATA           ,
  RUNNING_EVENT_HANDLERS             INTEGER                           NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  NOTIFY_PARENT                      SMALLINT                          NOT NULL ,
  AWAITED_SCOPES                     INTEGER                           NOT NULL ,
  AWAITED_SUB_PROCESSES              INTEGER                           NOT NULL ,
  BPEL_EXCEPTION                     BLOB(1073741823)                           ,
  IS_ACTIVE                          SMALLINT                          NOT NULL ,
  INITIATED_COMP                     SMALLINT                          NOT NULL ,
  IS_TERMINATION_FROM_FOR_EACH       SMALLINT                          NOT NULL ,
  TOTAL_COMPL_NUMBER                 BIGINT                            NOT NULL ,
  SCOPE_COMPL_NUMBER                 BIGINT                            NOT NULL ,
  A_TKIID                            CHAR(16)            FOR BIT DATA           ,
  HAS_COMPENSATION_WORK              SMALLINT                          NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SIID )
);

ALTER TABLE db2admin.SCOPE_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.SI_PI_ST_EH_ACT_FE ON db2admin.SCOPE_INSTANCE_B_T
(   
  PIID, STID, IS_ACTIVE, EHIID, ENCLOSING_FEIID
);

CREATE INDEX db2admin.SI_PIID_PARSI ON db2admin.SCOPE_INSTANCE_B_T
(   
  PIID, PARENT_SIID, IS_ACTIVE
);

CREATE INDEX db2admin.SI_PARCOMP_STA_ST ON db2admin.SCOPE_INSTANCE_B_T
(   
  PARENT_COMP_SIID, STATE, STID
);

CREATE INDEX db2admin.SI_PIID_STATE ON db2admin.SCOPE_INSTANCE_B_T
(   
  PIID, STATE
);

CREATE INDEX db2admin.SI_LAST_COMPSIID ON db2admin.SCOPE_INSTANCE_B_T
(   
  LAST_COMP_SIID
);

CREATE INDEX db2admin.SI_PI_ST_EH_FE_STA ON db2admin.SCOPE_INSTANCE_B_T
(   
  PIID, STID, EHIID, ENCLOSING_FEIID, STATE
);

CREATE INDEX db2admin.SI_PARCOMP_STA_SCN ON db2admin.SCOPE_INSTANCE_B_T
(   
  PARENT_COMP_SIID, STATE, SCOPE_COMPL_NUMBER
);

CREATE TABLE db2admin.ACTIVITY_INSTANCE_B_T
(
  AIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SIID                               CHAR(16)            FOR BIT DATA           ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHIID                              CHAR(16)            FOR BIT DATA           ,
  ENCLOSING_FEIID                    CHAR(16)            FOR BIT DATA           ,
  ICIID                              CHAR(16)            FOR BIT DATA           ,
  PARENT_AIID                        CHAR(16)            FOR BIT DATA           ,
  ERROR_EVENT_ATID                   CHAR(16)            FOR BIT DATA           ,
  P_TKIID                            CHAR(16)            FOR BIT DATA           ,
  A_TKIID                            CHAR(16)            FOR BIT DATA           ,
  INVOKED_INSTANCE_ID                CHAR(16)            FOR BIT DATA           ,
  INVOKED_INSTANCE_TYPE              INTEGER                           NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  BPMN_STATE                         INTEGER                           NOT NULL ,
  TRANS_COND_VALUES                  VARCHAR(66)         FOR BIT DATA  NOT NULL ,
  NUMBER_LINKS_EVALUATED             INTEGER                           NOT NULL ,
  FINISHED                           TIMESTAMP                                  ,
  ACTIVATED                          TIMESTAMP                                  ,
  FIRST_ACTIVATED                    TIMESTAMP                                  ,
  STARTED                            TIMESTAMP                                  ,
  LAST_MODIFIED                      TIMESTAMP                                  ,
  LAST_STATE_CHANGE                  TIMESTAMP                                  ,
  OWNER                              VARCHAR(128)                               ,
  DESCRIPTION                        VARCHAR(254)                               ,
  LINK_ORDER_NUMBER                  INTEGER                                    ,
  SCHEDULER_TASK_ID                  VARCHAR(254)                               ,
  EXPIRES                            TIMESTAMP                                  ,
  CONTINUE_ON_ERROR                  SMALLINT                          NOT NULL ,
  UNHANDLED_EXCEPTION                BLOB(1073741823)                           ,
  STOP_REASON                        INTEGER                           NOT NULL ,
  PREVIOUS_STATE                     INTEGER                                    ,
  INVOCATION_COUNTER                 INTEGER                           NOT NULL ,
  FOR_EACH_START_COUNTER_VALUE       BIGINT                                     ,
  FOR_EACH_FINAL_COUNTER_VALUE       BIGINT                                     ,
  FOR_EACH_CURRENT_COUNTER_VALUE     BIGINT                                     ,
  FOR_EACH_COMPLETED_BRANCHES        BIGINT                                     ,
  FOR_EACH_FAILED_BRANCHES           BIGINT                                     ,
  FOR_EACH_MAX_COMPL_BRANCHES        BIGINT                                     ,
  FOR_EACH_AWAITED_BRANCHES          BIGINT                                     ,
  IS51_ACTIVITY                      SMALLINT                          NOT NULL ,
  MAY_HAVE_SUBPROCESS                SMALLINT                                   ,
  SKIP_REQUESTED                     SMALLINT                          NOT NULL ,
  JUMP_TARGET_ATID                   CHAR(16)            FOR BIT DATA           ,
  SUB_STATE                          INTEGER                           NOT NULL ,
  PENDING_REQUEST_DATA               BLOB(1073741823)                           ,
  XTID                               CHAR(16)            FOR BIT DATA           ,
  EXPIRATION_COUNTER                 INTEGER                                    ,
  PREVIOUS_EXPIRATION_DATE           TIMESTAMP                                  ,
  TARGET_IORAIID                     CHAR(16)            FOR BIT DATA           ,
  DISPLAY_ID_EXT                     VARCHAR(32)                                ,
  MAX_COMPENSATION_NUMBER            BIGINT                                     ,
  HAS_WORK_ITEM                      SMALLINT                                   ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  LOOP_COUNTER                       INTEGER                                    ,
  AWAITED_ACTIVITIES                 INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( AIID )
);

ALTER TABLE db2admin.ACTIVITY_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.AIB_PI_EH_FE_AT ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  PIID, EHIID, ENCLOSING_FEIID, ATID
);

CREATE INDEX db2admin.AIB_PI_EH_EF_DIS ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  PIID, EHIID, ENCLOSING_FEIID, DISPLAY_ID_EXT
);

CREATE INDEX db2admin.AIB_IC_PI_AT ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  ICIID, PIID, ATID
);

CREATE INDEX db2admin.AIB_PTID ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  PTID
);

CREATE INDEX db2admin.AIB_PI_STA_AI ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  PIID, STATE, AIID
);

CREATE INDEX db2admin.AIB_SIID ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  SIID
);

CREATE INDEX db2admin.AIB_ATID_STAT ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  ATID, STATE
);

CREATE INDEX db2admin.AIB_PI_AT ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  PIID, ATID
);

CREATE INDEX db2admin.AIB_WSID1 ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  WSID_1, STATE
);

CREATE INDEX db2admin.AIB_WSID2 ON db2admin.ACTIVITY_INSTANCE_B_T
(   
  WSID_2, STATE
);

CREATE TABLE db2admin.VARIABLE_INSTANCE_B_T
(
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA                               BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( CTID, PIID )
);

ALTER TABLE db2admin.VARIABLE_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.CI_PIID ON db2admin.VARIABLE_INSTANCE_B_T
(   
  PIID
);

CREATE TABLE db2admin.SCOPED_VARIABLE_INSTANCE_B_T
(
  SVIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHIID                              CHAR(16)            FOR BIT DATA           ,
  FEIID                              CHAR(16)            FOR BIT DATA           ,
  DATA                               BLOB(1073741823)                           ,
  DATA_IL                            VARCHAR(3000)       FOR BIT DATA           ,
  IS_ACTIVE                          SMALLINT                          NOT NULL ,
  IS_INITIALIZED                     SMALLINT                          NOT NULL ,
  IS_QUERYABLE                       SMALLINT                          NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SVIID )
);

ALTER TABLE db2admin.SCOPED_VARIABLE_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.SVI_PI_CT_EH_FE ON db2admin.SCOPED_VARIABLE_INSTANCE_B_T
(   
  PIID, CTID, IS_ACTIVE, EHIID, FEIID
);

CREATE INDEX db2admin.SVI_CT_SI_EH_AC ON db2admin.SCOPED_VARIABLE_INSTANCE_B_T
(   
  SIID, CTID, IS_ACTIVE, EHIID
);

CREATE TABLE db2admin.STAFF_MESSAGE_INSTANCE_B_T
(
  AIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA                               BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( AIID, KIND )
);

ALTER TABLE db2admin.STAFF_MESSAGE_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.SMI_PIID ON db2admin.STAFF_MESSAGE_INSTANCE_B_T
(   
  PIID
);

CREATE TABLE db2admin.EVENT_INSTANCE_B_T
(
  EIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  IS_TWO_WAY                         SMALLINT                          NOT NULL ,
  IS_PRIMARY_EVENT_INSTANCE          SMALLINT                          NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  AIID                               CHAR(16)            FOR BIT DATA           ,
  EHTID                              CHAR(16)            FOR BIT DATA           ,
  SIID                               CHAR(16)            FOR BIT DATA           ,
  TKIID                              CHAR(16)            FOR BIT DATA           ,
  NEXT_POSTED_EVENT                  CHAR(16)            FOR BIT DATA           ,
  LAST_POSTED_EVENT                  CHAR(16)            FOR BIT DATA           ,
  POST_COUNT                         INTEGER                           NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  MESSAGE                            BLOB(1073741823)                           ,
  REPLY_CONTEXT                      BLOB(3900k)                                ,
  POST_TIME                          TIMESTAMP                                  ,
  MAX_NUMBER_OF_POSTS                INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( EIID )
);

ALTER TABLE db2admin.EVENT_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.EI_WSID1 ON db2admin.EVENT_INSTANCE_B_T
(   
  WSID_1
);

CREATE INDEX db2admin.EI_WSID2 ON db2admin.EVENT_INSTANCE_B_T
(   
  WSID_2
);

CREATE INDEX db2admin.EI_PI_PRIM_VTID ON db2admin.EVENT_INSTANCE_B_T
(   
  PIID, IS_PRIMARY_EVENT_INSTANCE, VTID
);

CREATE TABLE db2admin.REQUEST_INSTANCE_B_T
(
  RIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHIID                              CHAR(16)            FOR BIT DATA           ,
  TKIID                              CHAR(16)            FOR BIT DATA           ,
  FEIID                              CHAR(16)            FOR BIT DATA           ,
  INSTANTIATING                      SMALLINT                          NOT NULL ,
  REPLY_CONTEXT                      BLOB(3900k)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( RIID )
);

ALTER TABLE db2admin.REQUEST_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.RI_PIID_VTID_EHIID ON db2admin.REQUEST_INSTANCE_B_T
(   
  PIID, VTID
);

CREATE TABLE db2admin.PARTNER_LINK_INSTANCE_B_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  ENDPOINT_REFERENCE                 BLOB(3900k)                                ,
  SERVICE_DEFINITION                 BLOB(3900k)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID, NAME )
);

ALTER TABLE db2admin.PARTNER_LINK_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.PA_PIID ON db2admin.PARTNER_LINK_INSTANCE_B_T
(   
  PIID
);

CREATE TABLE db2admin.VARIABLE_SNAPSHOT_B_T
(
  SNID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA                               BLOB(1073741823)                           ,
  COPY_VERSION                       SMALLINT                          NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SNID )
);

ALTER TABLE db2admin.VARIABLE_SNAPSHOT_B_T VOLATILE;

CREATE INDEX db2admin.SN_PIID_CTID ON db2admin.VARIABLE_SNAPSHOT_B_T
(   
  PIID, CTID
);

CREATE TABLE db2admin.SUSPENDED_MESSAGE_INSTANCE_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ENGINE_MESSAGE                     BLOB(1073741823)                  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.SUSPENDED_MESSAGE_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.PIID ON db2admin.SUSPENDED_MESSAGE_INSTANCE_B_T
(   
  PIID
);

CREATE TABLE db2admin.CROSSING_LINK_INSTANCE_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SOURCE_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHIID                              CHAR(16)            FOR BIT DATA           ,
  FEIID                              CHAR(16)            FOR BIT DATA           ,
  CONDITION_VALUE                    INTEGER                           NOT NULL ,
  DESCRIPTION                        VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.CROSSING_LINK_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.CL_PI_TAT_EH_FE_SA ON db2admin.CROSSING_LINK_INSTANCE_B_T
(   
  PIID, TARGET_ATID, EHIID, FEIID, SOURCE_ATID
);

CREATE TABLE db2admin.INVOKE_RESULT_B_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  INVOKE_RESULT                      BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID, ATID )
);

ALTER TABLE db2admin.INVOKE_RESULT_B_T VOLATILE;

CREATE TABLE db2admin.INVOKE_RESULT2_B_T
(
  IRID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHIID                              CHAR(16)            FOR BIT DATA           ,
  FEIID                              CHAR(16)            FOR BIT DATA           ,
  STATE                              INTEGER                           NOT NULL ,
  INVOKE_RESULT                      BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( IRID )
);

ALTER TABLE db2admin.INVOKE_RESULT2_B_T VOLATILE;

CREATE INDEX db2admin.IR2_PI_AT_EH_FE ON db2admin.INVOKE_RESULT2_B_T
(   
  PIID, ATID, EHIID, FEIID
);

CREATE TABLE db2admin.EVENT_HANDLER_INSTANCE_B_T
(
  EHIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_EHIID                       CHAR(16)            FOR BIT DATA           ,
  FEIID                              CHAR(16)            FOR BIT DATA           ,
  SCHEDULER_TASK_ID                  VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( EHIID )
);

ALTER TABLE db2admin.EVENT_HANDLER_INSTANCE_B_T VOLATILE;

CREATE INDEX db2admin.EHI_PIID_EHTID ON db2admin.EVENT_HANDLER_INSTANCE_B_T
(   
  PIID, EHTID
);

CREATE INDEX db2admin.EHI_SIID_EHTID ON db2admin.EVENT_HANDLER_INSTANCE_B_T
(   
  SIID, EHTID
);

CREATE TABLE db2admin.CORRELATION_SET_INSTANCE_B_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PROCESS_NAME                       VARCHAR(220)                      NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  STATUS                             INTEGER                           NOT NULL ,
  HASH_CODE                          CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA                               VARCHAR(3072)                              ,
  DATA_LONG                          CLOB(3900K)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID, COID, SIID )
);

ALTER TABLE db2admin.CORRELATION_SET_INSTANCE_B_T VOLATILE;

CREATE UNIQUE INDEX db2admin.CSIB_HASH_PN ON db2admin.CORRELATION_SET_INSTANCE_B_T
(   
  HASH_CODE, PROCESS_NAME
);

CREATE INDEX db2admin.CSIB_PIID ON db2admin.CORRELATION_SET_INSTANCE_B_T
(   
  PIID
);

CREATE TABLE db2admin.CORRELATION_SET_PROPERTIES_B_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA                               BLOB(3900K)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID, COID, SIID )
);

ALTER TABLE db2admin.CORRELATION_SET_PROPERTIES_B_T VOLATILE;

CREATE TABLE db2admin.UNDO_ACTION_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_ATID                        CHAR(16)            FOR BIT DATA           ,
  PARENT_PIID                        CHAR(16)            FOR BIT DATA           ,
  PARENT_AIID                        CHAR(16)            FOR BIT DATA           ,
  PARENT_EHIID                       CHAR(16)            FOR BIT DATA           ,
  PARENT_FEIID                       CHAR(16)            FOR BIT DATA           ,
  PROCESS_NAME                       VARCHAR(220)                      NOT NULL ,
  CSCOPE_ID                          VARCHAR(100)                      NOT NULL ,
  UUID                               VARCHAR(100)                      NOT NULL ,
  COMP_CREATION_TIME                 TIMESTAMP                         NOT NULL ,
  DO_OP_WAS_TXNAL                    SMALLINT                          NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  INPUT_DATA                         BLOB(1073741823)                  NOT NULL ,
  FAULT_DATA                         BLOB(1073741823)                           ,
  CREATED                            INTEGER                           NOT NULL ,
  PROCESS_ADMIN                      VARCHAR(128)                      NOT NULL ,
  IS_VISIBLE                         SMALLINT                          NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.UNDO_ACTION_B_T VOLATILE;

CREATE INDEX db2admin.UA_CSID_DOOP_UUID ON db2admin.UNDO_ACTION_B_T
(   
  CSCOPE_ID, DO_OP_WAS_TXNAL, UUID
);

CREATE INDEX db2admin.UA_CSID_STATE_CCT ON db2admin.UNDO_ACTION_B_T
(   
  CSCOPE_ID, STATE, UUID
);

CREATE INDEX db2admin.UA_STATE_ISV ON db2admin.UNDO_ACTION_B_T
(   
  STATE, IS_VISIBLE
);

CREATE INDEX db2admin.UA_AIID_STATE_UUID ON db2admin.UNDO_ACTION_B_T
(   
  PARENT_AIID, STATE, UUID
);

CREATE INDEX db2admin.UA_PIID ON db2admin.UNDO_ACTION_B_T
(   
  PARENT_PIID
);

CREATE INDEX db2admin.UA_PT_AT_CS_UU_CCT ON db2admin.UNDO_ACTION_B_T
(   
  PTID, ATID, CSCOPE_ID, UUID, COMP_CREATION_TIME
);

CREATE TABLE db2admin.CUSTOM_STMT_INSTANCE_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SVIID                              CHAR(16)            FOR BIT DATA           ,
  NAMESPACE                          VARCHAR(220)                      NOT NULL ,
  LOCALNAME                          VARCHAR(220)                      NOT NULL ,
  PURPOSE                            VARCHAR(220)                      NOT NULL ,
  STATEMENT                          BLOB(3900K)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

CREATE INDEX db2admin.CSI_PIID_NS_LN_P ON db2admin.CUSTOM_STMT_INSTANCE_B_T
(   
  PIID, NAMESPACE, LOCALNAME, PURPOSE
);

CREATE INDEX db2admin.CSI_SVIID_NS_LN_P ON db2admin.CUSTOM_STMT_INSTANCE_B_T
(   
  SVIID, NAMESPACE, LOCALNAME, PURPOSE
);

CREATE TABLE db2admin.COMP_WORK_PENDING_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_PIID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_EHIID                       CHAR(16)            FOR BIT DATA           ,
  PARENT_FEIID                       CHAR(16)            FOR BIT DATA           ,
  STATE                              INTEGER                           NOT NULL ,
  CSCOPE_ID                          VARCHAR(100)                      NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.COMP_WORK_PENDING_B_T VOLATILE;

CREATE INDEX db2admin.CWP_PI_AT_CS_EH_FE ON db2admin.COMP_WORK_PENDING_B_T
(   
  PARENT_PIID, PARENT_ATID, CSCOPE_ID, PARENT_EHIID, PARENT_FEIID
);

CREATE INDEX db2admin.CWP_PI_AT_EHI ON db2admin.COMP_WORK_PENDING_B_T
(   
  PARENT_PIID, PARENT_ATID, PARENT_EHIID
);

CREATE TABLE db2admin.COMP_PARENT_ACTIVITY_INST_B_T
(
  AIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA           ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COMPLETION_NUMBER                  BIGINT                            NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  COMPENSATE_AIID                    CHAR(16)            FOR BIT DATA           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( AIID )
);

ALTER TABLE db2admin.COMP_PARENT_ACTIVITY_INST_B_T VOLATILE;

CREATE INDEX db2admin.CPAI_SI_S_CN_AI_PI ON db2admin.COMP_PARENT_ACTIVITY_INST_B_T
(   
  SIID, STATE, COMPLETION_NUMBER, AIID, PIID
);

CREATE INDEX db2admin.CPAI_PIID ON db2admin.COMP_PARENT_ACTIVITY_INST_B_T
(   
  PIID
);

CREATE TABLE db2admin.RESTART_EVENT_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PORT_TYPE                          VARCHAR(254)                      NOT NULL ,
  OPERATION                          VARCHAR(254)                      NOT NULL ,
  NAMESPACE                          VARCHAR(254)                      NOT NULL ,
  INPUT_MESSAGE                      BLOB(1073741823)                           ,
  REPLY_CTX                          BLOB(3900k)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.RESTART_EVENT_B_T VOLATILE;

CREATE INDEX db2admin.REB_PIID ON db2admin.RESTART_EVENT_B_T
(   
  PIID
);

CREATE TABLE db2admin.PROGRESS_COUNTER_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COUNTER                            BIGINT                            NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID )
);

ALTER TABLE db2admin.PROGRESS_COUNTER_T VOLATILE;

CREATE TABLE db2admin.RELEVANT_SCOPE_ATASK_T
(
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SIID, TKIID )
);

ALTER TABLE db2admin.RELEVANT_SCOPE_ATASK_T VOLATILE;

CREATE INDEX db2admin.RSAT_PIID ON db2admin.RELEVANT_SCOPE_ATASK_T
(   
  PIID
);

CREATE TABLE db2admin.CONFIG_INFO_T
(
  IDENTIFIER                         VARCHAR(64)                       NOT NULL ,
  DESCRIPTION                        VARCHAR(128)                               ,
  PROPERTY                           INTEGER                                    ,
  COUNTER                            BIGINT                                     ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( IDENTIFIER )
);

ALTER TABLE db2admin.CONFIG_INFO_T VOLATILE;

CREATE TABLE db2admin.PROCESS_INSTANCE_ATTRIBUTE_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATTR_KEY                           VARCHAR(220)                      NOT NULL ,
  VALUE                              VARCHAR(254)                               ,
  DATA_TYPE                          VARCHAR(254)                               ,
  DATA                               BLOB(1073741823)                           ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID, ATTR_KEY )
);

ALTER TABLE db2admin.PROCESS_INSTANCE_ATTRIBUTE_T VOLATILE;

CREATE INDEX db2admin.PIA_VALUE ON db2admin.PROCESS_INSTANCE_ATTRIBUTE_T
(   
  VALUE
);

CREATE INDEX db2admin.PIA_DATY ON db2admin.PROCESS_INSTANCE_ATTRIBUTE_T
(   
  DATA_TYPE
);

CREATE TABLE db2admin.PROCESS_CONTEXT_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SHARED                             SMALLINT                                   ,
  REPLY_CONTEXT                      BLOB(3900K)                                ,
  SERVICE_CONTEXT                    BLOB(3900K)                                ,
  STARTER_EXPIRES                    TIMESTAMP                                  ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID )
);

ALTER TABLE db2admin.PROCESS_CONTEXT_T VOLATILE;

CREATE TABLE db2admin.ACTIVITY_INSTANCE_ATTR_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  ATID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EHIID                              CHAR(16)            FOR BIT DATA           ,
  FEIID                              CHAR(16)            FOR BIT DATA           ,
  AIID                               CHAR(16)            FOR BIT DATA           ,
  ATTR_KEY                           VARCHAR(189)                      NOT NULL ,
  ATTR_VALUE                         VARCHAR(254)                               ,
  DATA_TYPE                          VARCHAR(254)                               ,
  DATA                               BLOB(1073741823)                           ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.ACTIVITY_INSTANCE_ATTR_B_T VOLATILE;

CREATE UNIQUE INDEX db2admin.AIA_UNIQUE ON db2admin.ACTIVITY_INSTANCE_ATTR_B_T
(   
  PIID, ATID, EHIID, FEIID, ATTR_KEY
);

CREATE INDEX db2admin.AIA_FEEIATPI ON db2admin.ACTIVITY_INSTANCE_ATTR_B_T
(   
  FEIID, EHIID, ATID, PIID
);

CREATE INDEX db2admin.AIA_AIID ON db2admin.ACTIVITY_INSTANCE_ATTR_B_T
(   
  AIID
);

CREATE INDEX db2admin.AIA_VALUE ON db2admin.ACTIVITY_INSTANCE_ATTR_B_T
(   
  ATTR_VALUE
);

CREATE INDEX db2admin.AIA_DATY ON db2admin.ACTIVITY_INSTANCE_ATTR_B_T
(   
  DATA_TYPE
);

CREATE TABLE db2admin.NAVIGATION_EXCEPTION_T
(
  CORRELATION_ID                     VARCHAR(220)        FOR BIT DATA  NOT NULL ,
  EXCEPTION_TYPE                     INTEGER                           NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA           ,
  OUTPUT_MESSAGE                     BLOB(1073741823)                           ,
  TYPE_SYSTEM                        VARCHAR(32)                                ,
  PROCESS_EXCEPTION                  BLOB(3900K)                       NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( CORRELATION_ID, EXCEPTION_TYPE )
);

CREATE INDEX db2admin.NE_PIID ON db2admin.NAVIGATION_EXCEPTION_T
(   
  PIID
);

CREATE TABLE db2admin.AWAITED_INVOCATION_T
(
  CORRELATION_ID                     VARCHAR(254)        FOR BIT DATA  NOT NULL ,
  CORRELATION_INFO                   BLOB(3900K)                       NOT NULL ,
  AIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( CORRELATION_ID )
);

CREATE INDEX db2admin.AWI_PIID ON db2admin.AWAITED_INVOCATION_T
(   
  PIID
);

CREATE INDEX db2admin.AWI_AIID ON db2admin.AWAITED_INVOCATION_T
(   
  AIID
);

CREATE TABLE db2admin.STORED_QUERY_T
(
  SQID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  NAME                               VARCHAR(64)                       NOT NULL ,
  OWNER_ID                           VARCHAR(128)                      NOT NULL ,
  SELECT_CLAUSE                      CLOB(20K)                         NOT NULL ,
  WHERE_CLAUSE                       CLOB(20K)                                  ,
  ORDER_CLAUSE                       VARCHAR(254)                               ,
  THRESHOLD                          INTEGER                                    ,
  TIMEZONE                           VARCHAR(63)                                ,
  CREATOR                            VARCHAR(128)                               ,
  TYPE                               VARCHAR(128)                               ,
  PROPERTY                           BLOB(3900K)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SQID )
);

CREATE UNIQUE INDEX db2admin.SQ_NAME ON db2admin.STORED_QUERY_T
(   
  KIND, OWNER_ID, NAME
);

CREATE TABLE db2admin.FOR_EACH_INSTANCE_B_T
(
  FEIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_FEIID                       CHAR(16)            FOR BIT DATA           ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( FEIID )
);

CREATE INDEX db2admin.FEI_PIID ON db2admin.FOR_EACH_INSTANCE_B_T
(   
  PIID
);

CREATE TABLE db2admin.QUERYABLE_VARIABLE_INSTANCE_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  CTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PAID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  VARIABLE_NAME                      VARCHAR(254)                      NOT NULL ,
  PROPERTY_NAME                      VARCHAR(255)                      NOT NULL ,
  PROPERTY_NAMESPACE                 VARCHAR(254)                      NOT NULL ,
  TYPE                               INTEGER                           NOT NULL ,
  GENERIC_VALUE                      VARCHAR(512)                               ,
  STRING_VALUE                       VARCHAR(512)                               ,
  NUMBER_VALUE                       BIGINT                                     ,
  DECIMAL_VALUE                      DOUBLE                                     ,
  TIMESTAMP_VALUE                    TIMESTAMP                                  ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.QUERYABLE_VARIABLE_INSTANCE_T VOLATILE;

CREATE INDEX db2admin.QVI_PI_CT_PA ON db2admin.QUERYABLE_VARIABLE_INSTANCE_T
(   
  PIID, CTID, PAID
);

CREATE INDEX db2admin.QVI_PI_PROPNAME ON db2admin.QUERYABLE_VARIABLE_INSTANCE_T
(   
  PIID, PROPERTY_NAME
);

CREATE TABLE db2admin.SYNC_T
(
  IDENTIFIER                         VARCHAR(254)                      NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( IDENTIFIER )
);

CREATE TABLE db2admin.MV_CTR_T
(
  ID                                 INTEGER                           NOT NULL ,
  SELECT_CLAUSE                      VARCHAR(1024)                     NOT NULL ,
  WHERE_CLAUSE                       VARCHAR(1024)                              ,
  ORDER_CLAUSE                       VARCHAR(512)                               ,
  TBL_SPACE                          VARCHAR(32)                       NOT NULL ,
  UPDATED                            TIMESTAMP                         NOT NULL ,
  UPD_STARTED                        TIMESTAMP                                  ,
  AVG_UPD_TIME                       BIGINT                                     ,
  UPD_INTERVAL                       BIGINT                            NOT NULL ,
  IS_UPDATING                        SMALLINT                          NOT NULL ,
  ACTIVE_MV                          SMALLINT                          NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ID )
);

CREATE TABLE db2admin.SAVED_ENGINE_MESSAGE_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA           ,
  CREATION_TIME                      TIMESTAMP                         NOT NULL ,
  REASON                             INTEGER                           NOT NULL ,
  ENGINE_MESSAGE_S                   VARCHAR(2000)       FOR BIT DATA           ,
  ENGINE_MESSAGE_L                   BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.SAVED_ENGINE_MESSAGE_B_T VOLATILE;

CREATE INDEX db2admin.SEM_PIID ON db2admin.SAVED_ENGINE_MESSAGE_B_T
(   
  PIID
);

CREATE INDEX db2admin.SEM_REAS ON db2admin.SAVED_ENGINE_MESSAGE_B_T
(   
  REASON, CREATION_TIME
);

CREATE TABLE db2admin.NAVIGATION_CLEANUP_TIMER_B_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  SCHEDULED_TIME                     TIMESTAMP                         NOT NULL ,
  SCHEDULER_ID                       VARCHAR(254)                      NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.NAVIGATION_CLEANUP_TIMER_B_T VOLATILE;

CREATE TABLE db2admin.SCHEDULER_ACTION_T
(
  SCHEDULER_ID                       VARCHAR(254)                      NOT NULL ,
  OID                                CHAR(16)            FOR BIT DATA  NOT NULL ,
  ACTION_OBJECT                      BLOB(3900k)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SCHEDULER_ID )
);

ALTER TABLE db2admin.SCHEDULER_ACTION_T VOLATILE;

CREATE INDEX db2admin.SCEACT_OID ON db2admin.SCHEDULER_ACTION_T
(   
  OID
);

CREATE TABLE db2admin.QUERY_TABLE_T
(
  NAME                               VARCHAR(32)                       NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  TYPE                               INTEGER                           NOT NULL ,
  VERSION                            INTEGER                           NOT NULL ,
  LAST_UPDATED                       TIMESTAMP                         NOT NULL ,
  PRIMARY_VIEW                       VARCHAR(32)                                ,
  DEFINITION                         BLOB(1073741823)                  NOT NULL ,
  VV_CFG                             BLOB(1073741823)                           ,
  DV_CFG                             BLOB(1073741823)                           ,
  MV_CFG                             BLOB(1073741823)                           ,
  MT_CFG                             BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( NAME )
);

ALTER TABLE db2admin.QUERY_TABLE_T VOLATILE;

CREATE INDEX db2admin.QT_KI ON db2admin.QUERY_TABLE_T
(   
  KIND
);

CREATE INDEX db2admin.QT_TY ON db2admin.QUERY_TABLE_T
(   
  TYPE
);

CREATE TABLE db2admin.QUERY_TABLE_REF_T
(
  REFEREE                            VARCHAR(32)                       NOT NULL ,
  SOURCE                             VARCHAR(32)                       NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( REFEREE, SOURCE )
);

ALTER TABLE db2admin.QUERY_TABLE_REF_T VOLATILE;

CREATE INDEX db2admin.QTR_SRC ON db2admin.QUERY_TABLE_REF_T
(   
  SOURCE
);

CREATE TABLE db2admin.MIGRATION_FRONT_T
(
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  MPTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  AIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  SUB_STATE                          INTEGER                           NOT NULL ,
  STOP_REASON                        INTEGER                           NOT NULL ,
  SOURCE_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_ATID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  MIGRATION_TIME                     TIMESTAMP                         NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PIID, MPTID, AIID )
);

ALTER TABLE db2admin.MIGRATION_FRONT_T VOLATILE;

CREATE INDEX db2admin.MGF_MPTID ON db2admin.MIGRATION_FRONT_T
(   
  MPTID
);

CREATE TABLE db2admin.SCOPE_COMPLETION_COUNTER_T
(
  SIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COUNTER                            BIGINT                                     ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SIID )
);

CREATE INDEX db2admin.SCC_PIID ON db2admin.SCOPE_COMPLETION_COUNTER_T
(   
  PIID
);

CREATE TABLE db2admin.ITERATION_COUNTER_INSTANCE_T
(
  ICIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  STARTED_WITH_AIID                  CHAR(16)            FOR BIT DATA           ,
  PARENT_ICIID                       CHAR(16)            FOR BIT DATA  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ICIID )
);

CREATE INDEX db2admin.ICI_PIID ON db2admin.ITERATION_COUNTER_INSTANCE_T
(   
  PIID
);

CREATE TABLE db2admin.IORCOUNTER_T
(
  GATEWAY_AIID                       CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  COUNTER                            CLOB(3900)                        NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( GATEWAY_AIID )
);

CREATE INDEX db2admin.IOC_PIID ON db2admin.IORCOUNTER_T
(   
  PIID
);

CREATE TABLE db2admin.AUDIT_LOG_T
(
  ALID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EVENT_TIME                         TIMESTAMP                         NOT NULL ,
  EVENT_TIME_UTC                     TIMESTAMP                                  ,
  AUDIT_EVENT                        INTEGER                           NOT NULL ,
  PTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PIID                               CHAR(16)            FOR BIT DATA           ,
  AIID                               CHAR(16)            FOR BIT DATA           ,
  SIID                               CHAR(16)            FOR BIT DATA           ,
  VARIABLE_NAME                      VARCHAR(254)                               ,
  PROCESS_TEMPL_NAME                 VARCHAR(254)                      NOT NULL ,
  PROCESS_INST_NAME                  VARCHAR(254)                               ,
  TOP_LEVEL_PI_NAME                  VARCHAR(254)                               ,
  TOP_LEVEL_PIID                     CHAR(16)            FOR BIT DATA           ,
  PARENT_PI_NAME                     VARCHAR(254)                               ,
  PARENT_PIID                        CHAR(16)            FOR BIT DATA           ,
  VALID_FROM                         TIMESTAMP                                  ,
  VALID_FROM_UTC                     TIMESTAMP                                  ,
  ATID                               CHAR(16)            FOR BIT DATA           ,
  ACTIVITY_NAME                      VARCHAR(254)                               ,
  ACTIVITY_KIND                      INTEGER                                    ,
  ACTIVITY_STATE                     INTEGER                                    ,
  CONTROL_LINK_NAME                  VARCHAR(254)                               ,
  IMPL_NAME                          VARCHAR(254)                               ,
  PRINCIPAL                          VARCHAR(128)                               ,
  TERMINAL_NAME                      VARCHAR(254)                               ,
  VARIABLE_DATA                      BLOB(1073741823)                           ,
  EXCEPTION_TEXT                     CLOB(4096)                                 ,
  DESCRIPTION                        VARCHAR(254)                               ,
  CORR_SET_INFO                      CLOB(4096)                                 ,
  USER_NAME                          VARCHAR(128)                               ,
  ADDITIONAL_INFO                    CLOB(4096)                                 ,
  OBJECT_META_TYPE                   INTEGER                                    ,
  SNAPSHOT_ID                        VARCHAR(254)                               ,
  PROCESS_APP_ACRONYM                VARCHAR(7)                                 ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ALID )
);

CREATE TABLE db2admin.WORK_ITEM_T
(
  WIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_WIID                        CHAR(16)            FOR BIT DATA           ,
  OWNER_ID                           VARCHAR(128)                               ,
  GROUP_NAME                         VARCHAR(128)                               ,
  EVERYBODY                          SMALLINT                          NOT NULL ,
  EXCLUDE                            SMALLINT                          NOT NULL ,
  QIID                               CHAR(16)            FOR BIT DATA           ,
  OBJECT_TYPE                        INTEGER                           NOT NULL ,
  OBJECT_ID                          CHAR(16)            FOR BIT DATA  NOT NULL ,
  ASSOCIATED_OBJECT_TYPE             INTEGER                           NOT NULL ,
  ASSOCIATED_OID                     CHAR(16)            FOR BIT DATA           ,
  REASON                             INTEGER                           NOT NULL ,
  CREATION_TIME                      TIMESTAMP                         NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  AUTH_INFO                          INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( WIID )
);

ALTER TABLE db2admin.WORK_ITEM_T VOLATILE;

CREATE INDEX db2admin.WI_ASSOBJ_REASON ON db2admin.WORK_ITEM_T
(   
  ASSOCIATED_OID, ASSOCIATED_OBJECT_TYPE, REASON, PARENT_WIID
);

CREATE INDEX db2admin.WI_OBJID_TYPE_QIID ON db2admin.WORK_ITEM_T
(   
  OBJECT_ID, OBJECT_TYPE, QIID
);

CREATE INDEX db2admin.WI_GROUP_NAME ON db2admin.WORK_ITEM_T
(   
  GROUP_NAME
);

CREATE INDEX db2admin.WI_AUTH_L ON db2admin.WORK_ITEM_T
(   
  EVERYBODY, GROUP_NAME, OWNER_ID, QIID
);

CREATE INDEX db2admin.WI_AUTH_U ON db2admin.WORK_ITEM_T
(   
  AUTH_INFO, QIID
);

CREATE INDEX db2admin.WI_AUTH_O ON db2admin.WORK_ITEM_T
(   
  AUTH_INFO, OWNER_ID DESC
);

CREATE INDEX db2admin.WI_AUTH_G ON db2admin.WORK_ITEM_T
(   
  AUTH_INFO, GROUP_NAME
);

CREATE INDEX db2admin.WI_AUTH_E ON db2admin.WORK_ITEM_T
(   
  AUTH_INFO, EVERYBODY
);

CREATE INDEX db2admin.WI_AUTH_R ON db2admin.WORK_ITEM_T
(   
  AUTH_INFO, REASON DESC
);

CREATE INDEX db2admin.WI_REASON ON db2admin.WORK_ITEM_T
(   
  REASON
);

CREATE INDEX db2admin.WI_OWNER ON db2admin.WORK_ITEM_T
(   
  OWNER_ID, OBJECT_ID, REASON, OBJECT_TYPE
);

CREATE INDEX db2admin.WI_QIID ON db2admin.WORK_ITEM_T
(   
  QIID
);

CREATE INDEX db2admin.WI_QRY ON db2admin.WORK_ITEM_T
(   
  OBJECT_ID, REASON, EVERYBODY, OWNER_ID
);

CREATE INDEX db2admin.WI_QI_OID_RS_OWN ON db2admin.WORK_ITEM_T
(   
  QIID, OBJECT_ID, REASON, OWNER_ID
);

CREATE INDEX db2admin.WI_QI_OID_OWN ON db2admin.WORK_ITEM_T
(   
  QIID, OBJECT_ID, OWNER_ID
);

CREATE INDEX db2admin.WI_OT_OID_RS ON db2admin.WORK_ITEM_T
(   
  OBJECT_TYPE, OBJECT_ID, REASON
);

CREATE INDEX db2admin.WI_WI_QI ON db2admin.WORK_ITEM_T
(   
  WIID, QIID
);

CREATE INDEX db2admin.WI_PWIID_OID ON db2admin.WORK_ITEM_T
(   
  PARENT_WIID, OBJECT_ID
);

CREATE INDEX db2admin.WI_PWIID_QIID ON db2admin.WORK_ITEM_T
(   
  PARENT_WIID, QIID
);

CREATE INDEX db2admin.WI_AUTH_GR_O_E ON db2admin.WORK_ITEM_T
(   
  AUTH_INFO, GROUP_NAME, OWNER_ID, EVERYBODY
);

CREATE INDEX db2admin.WI_PD1 ON db2admin.WORK_ITEM_T
(   
  OWNER_ID, AUTH_INFO, OBJECT_TYPE, REASON, OBJECT_ID
);

CREATE INDEX db2admin.WI_PD2 ON db2admin.WORK_ITEM_T
(   
  AUTH_INFO, OBJECT_TYPE, REASON, OBJECT_ID, QIID
);

CREATE TABLE db2admin.RETRIEVED_USER_T
(
  QIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  OWNER_ID                           VARCHAR(128)                      NOT NULL ,
  REASON                             INTEGER                           NOT NULL ,
  ASSOCIATED_OID                     CHAR(16)            FOR BIT DATA           ,
  KIND                               INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( QIID, OWNER_ID )
);

ALTER TABLE db2admin.RETRIEVED_USER_T VOLATILE;

CREATE INDEX db2admin.RUT_OWN_QIID ON db2admin.RETRIEVED_USER_T
(   
  OWNER_ID, QIID
);

CREATE INDEX db2admin.RUT_ASSOC ON db2admin.RETRIEVED_USER_T
(   
  ASSOCIATED_OID
);

CREATE INDEX db2admin.RUT_QIID ON db2admin.RETRIEVED_USER_T
(   
  QIID
);

CREATE INDEX db2admin.RUT_OWN_QIDESC ON db2admin.RETRIEVED_USER_T
(   
  OWNER_ID, QIID DESC
);

CREATE TABLE db2admin.RETRIEVED_GROUP_T
(
  QIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  GROUP_NAME                         VARCHAR(128)                      NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( QIID, GROUP_NAME )
);

ALTER TABLE db2admin.RETRIEVED_GROUP_T VOLATILE;

CREATE INDEX db2admin.RGR_GN ON db2admin.RETRIEVED_GROUP_T
(   
  GROUP_NAME
);

CREATE TABLE db2admin.WIS_META_DATA_T
(
  WSID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  HASH_CODE                          INTEGER                           NOT NULL ,
  OBJECT_TYPE                        INTEGER                           NOT NULL ,
  LAST_CHECK                         TIMESTAMP                         NOT NULL ,
  UNUSED                             SMALLINT                          NOT NULL ,
  AUTH_INFO_RETRIEVED_USER           SMALLINT                          NOT NULL ,
  AUTH_INFO_OWNER_ID                 SMALLINT                          NOT NULL ,
  AUTH_INFO_EVERYBODY                SMALLINT                          NOT NULL ,
  AUTH_INFO_GROUP                    SMALLINT                          NOT NULL ,
  AUTH_INFO_RETRIEVED_GROUP          SMALLINT                          NOT NULL ,
  AUTH_INFO_EMPTY                    SMALLINT                          NOT NULL ,
  SHARING_PATTERN                    INTEGER                           NOT NULL ,
  REASONS                            CHAR(32)            FOR BIT DATA  NOT NULL ,
  PARAMETER_A                        INTEGER                                    ,
  PARAMETER_B                        INTEGER                                    ,
  PARAMETER_C                        INTEGER                                    ,
  PARAMETER_D                        CHAR(16)            FOR BIT DATA           ,
  PARAMETER_E                        TIMESTAMP                                  ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( WSID )
);

ALTER TABLE db2admin.WIS_META_DATA_T VOLATILE;

CREATE INDEX db2admin.WMD_HC ON db2admin.WIS_META_DATA_T
(   
  HASH_CODE
);

CREATE TABLE db2admin.E_SWI_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  WIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  HASH_CODE                          INTEGER                           NOT NULL ,
  WIS_HASH_CODE                      INTEGER                                    ,
  PARENT_WIID                        CHAR(16)            FOR BIT DATA           ,
  REASON                             INTEGER                           NOT NULL ,
  INHERITED                          SMALLINT                                   ,
  QIID                               CHAR(16)            FOR BIT DATA           ,
  OBJECT_TYPE                        INTEGER                           NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  SHARING_PATTERN                    INTEGER                           NOT NULL ,
  ACCESS_KEY                         INTEGER                           NOT NULL ,
  TEMPLATE_ID                        CHAR(16)            FOR BIT DATA           ,
  PARAMETER_A                        INTEGER                                    ,
  PARAMETER_B                        INTEGER                                    ,
  PARAMETER_C                        INTEGER                                    ,
  PARAMETER_D                        CHAR(16)            FOR BIT DATA           ,
  PARAMETER_E                        TIMESTAMP                                  ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.E_SWI_T VOLATILE;

CREATE INDEX db2admin.WE_WSID ON db2admin.E_SWI_T
(   
  WSID
);

CREATE INDEX db2admin.WE_HASHCODE ON db2admin.E_SWI_T
(   
  HASH_CODE
);

CREATE INDEX db2admin.WE_HASH_TID ON db2admin.E_SWI_T
(   
  HASH_CODE, TEMPLATE_ID
);

CREATE INDEX db2admin.WE_WIID ON db2admin.E_SWI_T
(   
  WIID
);

CREATE INDEX db2admin.WE_QIID ON db2admin.E_SWI_T
(   
  QIID
);

CREATE TABLE db2admin.SWI_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  WIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_WIID                        CHAR(16)            FOR BIT DATA           ,
  OWNER_ID                           VARCHAR(128)                               ,
  GROUP_NAME                         VARCHAR(128)                               ,
  EVERYBODY                          SMALLINT                          NOT NULL ,
  QIID                               CHAR(16)            FOR BIT DATA           ,
  OBJECT_TYPE                        INTEGER                           NOT NULL ,
  REASON                             INTEGER                           NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  AUTH_INFO                          INTEGER                           NOT NULL ,
  SHARING_PATTERN                    INTEGER                           NOT NULL ,
  ACCESS_KEY                         INTEGER                           NOT NULL ,
  WSID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  HASH_CODE                          INTEGER                           NOT NULL ,
  WIS_HASH_CODE                      INTEGER                                    ,
  INHERITED                          SMALLINT                                   ,
  TEMPLATE_ID                        CHAR(16)            FOR BIT DATA           ,
  PARAMETER_A                        INTEGER                                    ,
  PARAMETER_B                        INTEGER                                    ,
  PARAMETER_C                        INTEGER                                    ,
  PARAMETER_D                        CHAR(16)            FOR BIT DATA           ,
  PARAMETER_E                        TIMESTAMP                                  ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.SWI_T VOLATILE;

CREATE INDEX db2admin.SWI_WSID ON db2admin.SWI_T
(   
  WSID
);

CREATE INDEX db2admin.SWI_HASHCODE ON db2admin.SWI_T
(   
  HASH_CODE
);

CREATE INDEX db2admin.SWI_OTRPD ON db2admin.SWI_T
(   
  OBJECT_TYPE, REASON, TEMPLATE_ID
);

CREATE INDEX db2admin.SWI_WIID ON db2admin.SWI_T
(   
  WIID
);

CREATE INDEX db2admin.SWI_QIID ON db2admin.SWI_T
(   
  QIID
);

CREATE INDEX db2admin.SWI_OWN ON db2admin.SWI_T
(   
  OWNER_ID, ACCESS_KEY, WSID, REASON
);

CREATE INDEX db2admin.SWI_GRP ON db2admin.SWI_T
(   
  GROUP_NAME, ACCESS_KEY, WSID, REASON
);

CREATE INDEX db2admin.SWI_ACCK1 ON db2admin.SWI_T
(   
  ACCESS_KEY, REASON, WSID, QIID
);

CREATE INDEX db2admin.SWI_ACCK2 ON db2admin.SWI_T
(   
  ACCESS_KEY, REASON, QIID, WSID
);

CREATE INDEX db2admin.SWI_ACCK3 ON db2admin.SWI_T
(   
  ACCESS_KEY, REASON, OWNER_ID, WSID
);

CREATE INDEX db2admin.SWI_ACCK4 ON db2admin.SWI_T
(   
  ACCESS_KEY, REASON, WSID
);

CREATE INDEX db2admin.SWI_ACCK5 ON db2admin.SWI_T
(   
  ACCESS_KEY, OWNER_ID, REASON, WSID
);

CREATE INDEX db2admin.SWI_ACCK6 ON db2admin.SWI_T
(   
  ACCESS_KEY, GROUP_NAME, REASON, WSID
);

CREATE TABLE db2admin.STAFF_QUERY_INSTANCE_T
(
  QIID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  QTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EVERYBODY                          SMALLINT                          NOT NULL ,
  NOBODY                             SMALLINT                          NOT NULL ,
  IS_SHAREABLE                       SMALLINT                          NOT NULL ,
  IS_TRANSFERRED                     SMALLINT                          NOT NULL ,
  SR_HASH_CODE                       INTEGER                                    ,
  GROUP_NAME                         VARCHAR(128)                               ,
  CONTEXT_VALUES                     VARCHAR(3072)                              ,
  CONTEXT_VALUES_LONG                CLOB(3096K)                                ,
  HASH_CODE                          INTEGER                                    ,
  EXPIRES                            TIMESTAMP                                  ,
  ASSOCIATED_OBJECT_TYPE             INTEGER                           NOT NULL ,
  ASSOCIATED_OID                     CHAR(16)            FOR BIT DATA  NOT NULL ,
  NORMALIZED                         SMALLINT                                   ,
  DENORMALIZED                       SMALLINT                                   ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( QIID )
);

CREATE INDEX db2admin.SQI_QTID ON db2admin.STAFF_QUERY_INSTANCE_T
(   
  QTID, HASH_CODE
);

CREATE INDEX db2admin.SQI_ASSOCID ON db2admin.STAFF_QUERY_INSTANCE_T
(   
  ASSOCIATED_OID, ASSOCIATED_OBJECT_TYPE
);

CREATE INDEX db2admin.SQI_QIIDGN ON db2admin.STAFF_QUERY_INSTANCE_T
(   
  QIID, GROUP_NAME
);

CREATE INDEX db2admin.SQI_QIIDTREX ON db2admin.STAFF_QUERY_INSTANCE_T
(   
  QIID, IS_TRANSFERRED, EXPIRES
);

CREATE INDEX db2admin.SQI_ISSH ON db2admin.STAFF_QUERY_INSTANCE_T
(   
  IS_SHAREABLE, QIID
);

CREATE INDEX db2admin.SQI_GRP ON db2admin.STAFF_QUERY_INSTANCE_T
(   
  GROUP_NAME
);

CREATE TABLE db2admin.STAFF_LOCK_T
(
  QTID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  HASH_CODE                          INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( QTID, HASH_CODE )
);

CREATE TABLE db2admin.APPLICATION_COMPONENT_T
(
  ACOID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(64)                       NOT NULL ,
  CALENDAR_NAME                      VARCHAR(254)                               ,
  JNDI_NAME_CALENDAR                 VARCHAR(254)                               ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR(254)                      NOT NULL ,
  DURATION_UNTIL_DELETED             VARCHAR(254)                               ,
  EVENT_HANDLER_NAME                 VARCHAR(64)                                ,
  INSTANCE_CREATOR_QTID              CHAR(16)            FOR BIT DATA           ,
  SUPPORTS_AUTO_CLAIM                SMALLINT                          NOT NULL ,
  SUPPORTS_FOLLOW_ON_TASK            SMALLINT                          NOT NULL ,
  SUPPORTS_CLAIM_SUSPENDED           SMALLINT                          NOT NULL ,
  SUPPORTS_DELEGATION                SMALLINT                          NOT NULL ,
  SUPPORTS_SUB_TASK                  SMALLINT                          NOT NULL ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  SUBSTITUTION_POLICY                INTEGER                           NOT NULL ,
  PRIMARY KEY ( ACOID )
);

CREATE UNIQUE INDEX db2admin.ACO_NAME ON db2admin.APPLICATION_COMPONENT_T
(   
  NAME
);

CREATE TABLE db2admin.ESCALATION_TEMPLATE_T
(
  ESTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  FIRST_ESTID                        CHAR(16)            FOR BIT DATA           ,
  PREVIOUS_ESTID                     CHAR(16)            FOR BIT DATA           ,
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  MNTID                              CHAR(16)            FOR BIT DATA           ,
  NAME                               VARCHAR(220)                               ,
  ACTIVATION_STATE                   INTEGER                           NOT NULL ,
  AT_LEAST_EXPECTED_STATE            INTEGER                           NOT NULL ,
  DURATION_UNTIL_ESCALATION          VARCHAR(254)                               ,
  DURATION_UNTIL_REPEATS             VARCHAR(254)                               ,
  INCREASE_PRIORITY                  INTEGER                           NOT NULL ,
  ACTION                             INTEGER                           NOT NULL ,
  ESCALATION_RECEIVER_QTID           CHAR(16)            FOR BIT DATA           ,
  RECEIVER_EMAIL_QTID                CHAR(16)            FOR BIT DATA           ,
  PRIMARY KEY ( ESTID )
);

ALTER TABLE db2admin.ESCALATION_TEMPLATE_T VOLATILE;

CREATE INDEX db2admin.ET_TKTID ON db2admin.ESCALATION_TEMPLATE_T
(   
  TKTID
);

CREATE INDEX db2admin.ET_CCID ON db2admin.ESCALATION_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.ESC_TEMPL_CPROP_T
(
  ESTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  STRING_VALUE                       VARCHAR(254)                               ,
  DATA_TYPE                          VARCHAR(254)                               ,
  DATA                               BLOB(1073741823)                           ,
  PRIMARY KEY ( ESTID, NAME )
);

ALTER TABLE db2admin.ESC_TEMPL_CPROP_T VOLATILE;

CREATE INDEX db2admin.ETCP_TKTID ON db2admin.ESC_TEMPL_CPROP_T
(   
  TKTID
);

CREATE INDEX db2admin.ETCP_CCID ON db2admin.ESC_TEMPL_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.ESC_TEMPL_LDESC_T
(
  ESTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  DESCRIPTION                        VARCHAR(254)                               ,
  DOCUMENTATION                      CLOB(4096)                                 ,
  PRIMARY KEY ( ESTID, LOCALE )
);

ALTER TABLE db2admin.ESC_TEMPL_LDESC_T VOLATILE;

CREATE INDEX db2admin.ETLD_TKTID ON db2admin.ESC_TEMPL_LDESC_T
(   
  TKTID
);

CREATE INDEX db2admin.ETLD_CCID ON db2admin.ESC_TEMPL_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TTASK_MESSAGE_DEFINITION_T
(
  TMTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TKTID                              CHAR(16)            FOR BIT DATA           ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  FAULT_NAME                         VARCHAR(254)                               ,
  MESSAGE_TYPE_NS                    VARCHAR(220)                      NOT NULL ,
  MESSAGE_TYPE_NAME                  VARCHAR(220)                      NOT NULL ,
  MESSAGE_DEFINITION                 BLOB(3900K)                                ,
  PRIMARY KEY ( TMTID )
);

CREATE INDEX db2admin.TTMD_TKTID ON db2admin.TTASK_MESSAGE_DEFINITION_T
(   
  TKTID
);

CREATE INDEX db2admin.TTMD_CCID ON db2admin.TTASK_MESSAGE_DEFINITION_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_TEMPLATE_T
(
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  DEFINITION_NAME                    VARCHAR(220)                      NOT NULL ,
  NAMESPACE                          VARCHAR(254)                      NOT NULL ,
  TARGET_NAMESPACE                   VARCHAR(254)                      NOT NULL ,
  VALID_FROM                         TIMESTAMP                         NOT NULL ,
  APPLICATION_NAME                   VARCHAR(220)                               ,
  APPLICATION_DEFAULTS_ID            CHAR(16)            FOR BIT DATA           ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA           ,
  SVTID                              CHAR(16)            FOR BIT DATA           ,
  KIND                               INTEGER                           NOT NULL ,
  STATE                              INTEGER                           NOT NULL ,
  AUTO_DELETE_MODE                   INTEGER                           NOT NULL ,
  IS_AD_HOC                          SMALLINT                          NOT NULL ,
  IS_INLINE                          SMALLINT                          NOT NULL ,
  IS_SHARED                          SMALLINT                          NOT NULL ,
  SUPPORTS_CLAIM_SUSPENDED           SMALLINT                          NOT NULL ,
  SUPPORTS_AUTO_CLAIM                SMALLINT                          NOT NULL ,
  SUPPORTS_FOLLOW_ON_TASK            SMALLINT                          NOT NULL ,
  SUPPORTS_DELEGATION                SMALLINT                          NOT NULL ,
  SUPPORTS_SUB_TASK                  SMALLINT                          NOT NULL ,
  CONTEXT_AUTHORIZATION              INTEGER                           NOT NULL ,
  AUTONOMY                           INTEGER                           NOT NULL ,
  ADMIN_QTID                         CHAR(16)            FOR BIT DATA           ,
  EDITOR_QTID                        CHAR(16)            FOR BIT DATA           ,
  INSTANCE_CREATOR_QTID              CHAR(16)            FOR BIT DATA           ,
  POTENTIAL_STARTER_QTID             CHAR(16)            FOR BIT DATA           ,
  POTENTIAL_OWNER_QTID               CHAR(16)            FOR BIT DATA           ,
  READER_QTID                        CHAR(16)            FOR BIT DATA           ,
  DEFAULT_LOCALE                     VARCHAR(32)                                ,
  CALENDAR_NAME                      VARCHAR(254)                               ,
  DURATION_UNTIL_DELETED             VARCHAR(254)                               ,
  DURATION_UNTIL_DUE                 VARCHAR(254)                               ,
  DURATION_UNTIL_EXPIRES             VARCHAR(254)                               ,
  JNDI_NAME_CALENDAR                 VARCHAR(254)                               ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR(254)                      NOT NULL ,
  TYPE                               VARCHAR(254)                               ,
  EVENT_HANDLER_NAME                 VARCHAR(64)                                ,
  PRIORITY                           INTEGER                                    ,
  PRIORITY_DEFINITION                VARCHAR(254)                               ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  SUBSTITUTION_POLICY                INTEGER                           NOT NULL ,
  CONTACTS_QTIDS                     BLOB(3900k)                                ,
  UI_SETTINGS                        BLOB(3900k)                                ,
  ASSIGNMENT_TYPE                    INTEGER                           NOT NULL ,
  INHERITED_AUTH                     INTEGER                           NOT NULL ,
  PARALLEL_INHERITED_AUTH            INTEGER                           NOT NULL ,
  NATIVE_LOOKUP_NAME                 VARCHAR(254)                               ,
  WORK_BASKET                        VARCHAR(254)                               ,
  EAR_VERSION                        INTEGER                           NOT NULL ,
  SCHEMA_VERSION                     INTEGER                           NOT NULL ,
  LANGUAGE_TYPE                      INTEGER                           NOT NULL ,
  DEPLOY_TYPE                        INTEGER                           NOT NULL ,
  CUSTOM_TEXT1                       VARCHAR(64)                                ,
  CUSTOM_TEXT2                       VARCHAR(64)                                ,
  CUSTOM_TEXT3                       VARCHAR(64)                                ,
  CUSTOM_TEXT4                       VARCHAR(64)                                ,
  CUSTOM_TEXT5                       VARCHAR(64)                                ,
  CUSTOM_TEXT6                       VARCHAR(64)                                ,
  CUSTOM_TEXT7                       VARCHAR(64)                                ,
  CUSTOM_TEXT8                       VARCHAR(64)                                ,
  PRIMARY KEY ( TKTID )
);

ALTER TABLE db2admin.TASK_TEMPLATE_T VOLATILE;

CREATE UNIQUE INDEX db2admin.TT_NAME_VF_NS ON db2admin.TASK_TEMPLATE_T
(   
  NAME, VALID_FROM, NAMESPACE
);

CREATE INDEX db2admin.TT_CCID_STATE ON db2admin.TASK_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID, STATE
);

CREATE INDEX db2admin.TT_KND_INLN_VAL ON db2admin.TASK_TEMPLATE_T
(   
  KIND, IS_INLINE, VALID_FROM
);

CREATE INDEX db2admin.TT_NATLOOK_ADHOC ON db2admin.TASK_TEMPLATE_T
(   
  NATIVE_LOOKUP_NAME, IS_AD_HOC
);

CREATE TABLE db2admin.TASK_TEMPL_CPROP_T
(
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA_TYPE                          VARCHAR(254)                               ,
  STRING_VALUE                       VARCHAR(254)                               ,
  DATA                               BLOB(1073741823)                           ,
  PRIMARY KEY ( TKTID, NAME )
);

ALTER TABLE db2admin.TASK_TEMPL_CPROP_T VOLATILE;

CREATE INDEX db2admin.TTCP_TKTID ON db2admin.TASK_TEMPL_CPROP_T
(   
  TKTID
);

CREATE INDEX db2admin.TTCP_CCID ON db2admin.TASK_TEMPL_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_TEMPL_LDESC_T
(
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  DESCRIPTION                        VARCHAR(254)                               ,
  DOCUMENTATION                      CLOB(4096)                                 ,
  PRIMARY KEY ( TKTID, LOCALE )
);

ALTER TABLE db2admin.TASK_TEMPL_LDESC_T VOLATILE;

CREATE INDEX db2admin.TTLD_TKTID ON db2admin.TASK_TEMPL_LDESC_T
(   
  TKTID
);

CREATE INDEX db2admin.TTLD_CCID ON db2admin.TASK_TEMPL_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE INDEX db2admin.TTLD_TT_LOC ON db2admin.TASK_TEMPL_LDESC_T
(   
  TKTID, LOCALE DESC
);

CREATE TABLE db2admin.TSERVICE_DESCRIPTION_T
(
  SVTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  IS_ONE_WAY                         SMALLINT                          NOT NULL ,
  SERVICE_REF_NAME                   VARCHAR(254)                               ,
  OPERATION                          VARCHAR(254)                      NOT NULL ,
  PORT                               VARCHAR(254)                               ,
  PORT_TYPE_NS                       VARCHAR(254)                      NOT NULL ,
  PORT_TYPE_NAME                     VARCHAR(254)                      NOT NULL ,
  S_BEAN_JNDI_NAME                   VARCHAR(254)                               ,
  SERVICE                            VARCHAR(254)                               ,
  PRIMARY KEY ( SVTID )
);

CREATE INDEX db2admin.TSD_TKTID ON db2admin.TSERVICE_DESCRIPTION_T
(   
  TKTID
);

CREATE INDEX db2admin.TSD_CCID ON db2admin.TSERVICE_DESCRIPTION_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_CELL_MAP_T
(
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CELL                               VARCHAR(220)                      NOT NULL ,
  PRIMARY KEY ( TKTID, CELL )
);

CREATE TABLE db2admin.TMAIL_T
(
  MNTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  FROM_STATE                         INTEGER                           NOT NULL ,
  TO_STATE                           INTEGER                           NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  HASH_CODE                          INTEGER                           NOT NULL ,
  SUBJECT                            VARCHAR(254)                      NOT NULL ,
  BODY_TEXT                          CLOB(4096)                                 ,
  PRIMARY KEY ( MNTID, FROM_STATE, TO_STATE, LOCALE )
);

CREATE INDEX db2admin.EMT_HC ON db2admin.TMAIL_T
(   
  HASH_CODE
);

CREATE TABLE db2admin.COMPLETION_TEMPLATE_T
(
  CMTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  COMPL_CONDITION                    BLOB(3900K)                                ,
  CRITERION_FOR                      VARCHAR(254)                               ,
  COMPLETION_NAME                    VARCHAR(220)                               ,
  IS_DEFAULT_COMPLETION              SMALLINT                          NOT NULL ,
  PREFIX_MAP                         BLOB(3900K)                                ,
  USE_DEFAULT_RESULT_CONSTRUCT       SMALLINT                          NOT NULL ,
  PRIMARY KEY ( CMTID )
);

CREATE INDEX db2admin.CMPT_TKTID_ORDER ON db2admin.COMPLETION_TEMPLATE_T
(   
  TKTID, ORDER_NUMBER
);

CREATE INDEX db2admin.CMPT_CCID ON db2admin.COMPLETION_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.RESULT_AGGREGATION_TEMPLATE_T
(
  RATID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  CMTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TKTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  AGGR_PART                          VARCHAR(254)                               ,
  AGGR_LOCATION                      BLOB(3900K)                                ,
  AGGR_FUNCTION                      VARCHAR(254)                      NOT NULL ,
  AGGR_CONDITION                     BLOB(3900K)                                ,
  PREFIX_MAP                         BLOB(3900K)                                ,
  PRIMARY KEY ( RATID )
);

CREATE INDEX db2admin.RAGT_CMTID_ORD_TT ON db2admin.RESULT_AGGREGATION_TEMPLATE_T
(   
  CMTID, ORDER_NUMBER, TKTID
);

CREATE INDEX db2admin.RAGT_CCID ON db2admin.RESULT_AGGREGATION_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.PEOPLE_RESOURCE_REF_TEMPLATE_T
(
  PRRTID                             CHAR(16)            FOR BIT DATA  NOT NULL ,
  TEMPLATE_OID                       CHAR(16)            FOR BIT DATA  NOT NULL ,
  REASON                             INTEGER                           NOT NULL ,
  PRID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARAMETER_BINDINGS                 BLOB(3900K)                                ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  PRIMARY KEY ( PRRTID )
);

CREATE INDEX db2admin.PRRT_PRID ON db2admin.PEOPLE_RESOURCE_REF_TEMPLATE_T
(   
  PRID
);

CREATE INDEX db2admin.PRRT_ccID ON db2admin.PEOPLE_RESOURCE_REF_TEMPLATE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.ESCALATION_INSTANCE_T
(
  ESIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  ESTID                              CHAR(16)            FOR BIT DATA           ,
  FIRST_ESIID                        CHAR(16)            FOR BIT DATA           ,
  PREVIOUS_ESIID                     CHAR(16)            FOR BIT DATA           ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  MNTID                              CHAR(16)            FOR BIT DATA           ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  NAME                               VARCHAR(220)                               ,
  STATE                              INTEGER                           NOT NULL ,
  ACTIVATION_STATE                   INTEGER                           NOT NULL ,
  AT_LEAST_EXPECTED_STATE            INTEGER                           NOT NULL ,
  ACTIVATION_TIME                    TIMESTAMP                                  ,
  ESCALATION_TIME                    TIMESTAMP                                  ,
  DURATION_UNTIL_ESCALATION          VARCHAR(254)                               ,
  DURATION_UNTIL_REPEATS             VARCHAR(254)                               ,
  INCREASE_PRIORITY                  INTEGER                           NOT NULL ,
  ACTION                             INTEGER                           NOT NULL ,
  ESCALATION_RECEIVER_QTID           CHAR(16)            FOR BIT DATA           ,
  RECEIVER_EMAIL_QTID                CHAR(16)            FOR BIT DATA           ,
  SCHEDULER_ID                       VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ESIID )
);

ALTER TABLE db2admin.ESCALATION_INSTANCE_T VOLATILE;

CREATE INDEX db2admin.ESI_FIRST ON db2admin.ESCALATION_INSTANCE_T
(   
  FIRST_ESIID
);

CREATE INDEX db2admin.ESI_TKIID_ASTATE ON db2admin.ESCALATION_INSTANCE_T
(   
  TKIID, ACTIVATION_STATE, STATE
);

CREATE INDEX db2admin.ESI_TKIID_STATE ON db2admin.ESCALATION_INSTANCE_T
(   
  TKIID, STATE
);

CREATE INDEX db2admin.ESI_PREV ON db2admin.ESCALATION_INSTANCE_T
(   
  PREVIOUS_ESIID
);

CREATE INDEX db2admin.ESI_ESTID ON db2admin.ESCALATION_INSTANCE_T
(   
  ESTID
);

CREATE INDEX db2admin.ESI_CCID ON db2admin.ESCALATION_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE INDEX db2admin.ESI_EST_ESI ON db2admin.ESCALATION_INSTANCE_T
(   
  ESTID, ESIID
);

CREATE INDEX db2admin.ESI_WSID1 ON db2admin.ESCALATION_INSTANCE_T
(   
  WSID_1
);

CREATE INDEX db2admin.ESI_WSID2 ON db2admin.ESCALATION_INSTANCE_T
(   
  WSID_2
);

CREATE TABLE db2admin.ESC_INST_CPROP_T
(
  ESIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  STRING_VALUE                       VARCHAR(254)                               ,
  DATA_TYPE                          VARCHAR(254)                               ,
  DATA                               BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ESIID, NAME )
);

ALTER TABLE db2admin.ESC_INST_CPROP_T VOLATILE;

CREATE INDEX db2admin.EICP_CCID ON db2admin.ESC_INST_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.ESC_INST_LDESC_T
(
  ESIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  DESCRIPTION                        VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ESIID, LOCALE )
);

ALTER TABLE db2admin.ESC_INST_LDESC_T VOLATILE;

CREATE INDEX db2admin.EILD_CCID ON db2admin.ESC_INST_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.EIDOCUMENTATION_T
(
  ESIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  DOCUMENTATION                      CLOB(4096)                                 ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ESIID, LOCALE )
);

ALTER TABLE db2admin.EIDOCUMENTATION_T VOLATILE;

CREATE INDEX db2admin.EIDOC_CCID ON db2admin.EIDOCUMENTATION_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.ISERVICE_DESCRIPTION_T
(
  SVTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  IS_ONE_WAY                         SMALLINT                          NOT NULL ,
  SERVICE_REF_NAME                   VARCHAR(254)                               ,
  OPERATION                          VARCHAR(254)                      NOT NULL ,
  PORT                               VARCHAR(254)                               ,
  PORT_TYPE_NS                       VARCHAR(254)                      NOT NULL ,
  PORT_TYPE_NAME                     VARCHAR(254)                      NOT NULL ,
  S_BEAN_JNDI_NAME                   VARCHAR(254)                               ,
  SERVICE                            VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SVTID )
);

ALTER TABLE db2admin.ISERVICE_DESCRIPTION_T VOLATILE;

CREATE INDEX db2admin.ISD_TKIID ON db2admin.ISERVICE_DESCRIPTION_T
(   
  TKIID
);

CREATE INDEX db2admin.ISD_CCID ON db2admin.ISERVICE_DESCRIPTION_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_INSTANCE_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  NAMESPACE                          VARCHAR(254)                      NOT NULL ,
  TKTID                              CHAR(16)            FOR BIT DATA           ,
  TOP_TKIID                          CHAR(16)            FOR BIT DATA  NOT NULL ,
  FOLLOW_ON_TKIID                    CHAR(16)            FOR BIT DATA           ,
  APPLICATION_NAME                   VARCHAR(220)                               ,
  APPLICATION_DEFAULTS_ID            CHAR(16)            FOR BIT DATA           ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA           ,
  PARENT_CONTEXT_ID                  CHAR(16)            FOR BIT DATA           ,
  STATE                              INTEGER                           NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  AUTO_DELETE_MODE                   INTEGER                           NOT NULL ,
  HIERARCHY_POSITION                 INTEGER                           NOT NULL ,
  TYPE                               VARCHAR(254)                               ,
  SVTID                              CHAR(16)            FOR BIT DATA           ,
  SUPPORTS_CLAIM_SUSPENDED           SMALLINT                          NOT NULL ,
  SUPPORTS_AUTO_CLAIM                SMALLINT                          NOT NULL ,
  SUPPORTS_FOLLOW_ON_TASK            SMALLINT                          NOT NULL ,
  IS_AD_HOC                          SMALLINT                          NOT NULL ,
  IS_ESCALATED                       SMALLINT                          NOT NULL ,
  IS_INLINE                          SMALLINT                          NOT NULL ,
  IS_SUSPENDED                       SMALLINT                          NOT NULL ,
  IS_WAITING_FOR_SUBTASK             SMALLINT                          NOT NULL ,
  SUPPORTS_DELEGATION                SMALLINT                          NOT NULL ,
  SUPPORTS_SUB_TASK                  SMALLINT                          NOT NULL ,
  IS_CHILD                           SMALLINT                          NOT NULL ,
  HAS_ESCALATIONS                    SMALLINT                                   ,
  START_TIME                         TIMESTAMP                                  ,
  ACTIVATION_TIME                    TIMESTAMP                                  ,
  LAST_MODIFICATION_TIME             TIMESTAMP                                  ,
  LAST_STATE_CHANGE_TIME             TIMESTAMP                                  ,
  COMPLETION_TIME                    TIMESTAMP                                  ,
  DUE_TIME                           TIMESTAMP                                  ,
  EXPIRATION_TIME                    TIMESTAMP                                  ,
  FIRST_ACTIVATION_TIME              TIMESTAMP                                  ,
  DEFAULT_LOCALE                     VARCHAR(32)                                ,
  DURATION_UNTIL_DELETED             VARCHAR(254)                               ,
  DURATION_UNTIL_DUE                 VARCHAR(254)                               ,
  DURATION_UNTIL_EXPIRES             VARCHAR(254)                               ,
  CALENDAR_NAME                      VARCHAR(254)                               ,
  JNDI_NAME_CALENDAR                 VARCHAR(254)                               ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR(254)                               ,
  CONTEXT_AUTHORIZATION              INTEGER                           NOT NULL ,
  ORIGINATOR                         VARCHAR(128)                               ,
  STARTER                            VARCHAR(128)                               ,
  OWNER                              VARCHAR(128)                               ,
  ADMIN_QTID                         CHAR(16)            FOR BIT DATA           ,
  EDITOR_QTID                        CHAR(16)            FOR BIT DATA           ,
  POTENTIAL_OWNER_QTID               CHAR(16)            FOR BIT DATA           ,
  POTENTIAL_STARTER_QTID             CHAR(16)            FOR BIT DATA           ,
  READER_QTID                        CHAR(16)            FOR BIT DATA           ,
  PRIORITY                           INTEGER                                    ,
  SCHEDULER_ID                       VARCHAR(254)                               ,
  SERVICE_TICKET                     VARCHAR(254)                               ,
  EVENT_HANDLER_NAME                 VARCHAR(64)                                ,
  BUSINESS_RELEVANCE                 SMALLINT                          NOT NULL ,
  RESUMES                            TIMESTAMP                                  ,
  SUBSTITUTION_POLICY                INTEGER                           NOT NULL ,
  DELETION_TIME                      TIMESTAMP                                  ,
  ASSIGNMENT_TYPE                    INTEGER                           NOT NULL ,
  INHERITED_AUTH                     INTEGER                           NOT NULL ,
  PARALLEL_INHERITED_AUTH            INTEGER                           NOT NULL ,
  INVOKED_INSTANCE_ID                CHAR(16)            FOR BIT DATA           ,
  INVOKED_INSTANCE_TYPE              INTEGER                           NOT NULL ,
  WORK_BASKET                        VARCHAR(254)                               ,
  IS_READ                            SMALLINT                          NOT NULL ,
  IS_TRANSFERRED_TO_WORK_BASKET      SMALLINT                          NOT NULL ,
  CREATED_WITH_VERSION               INTEGER                           NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  CUSTOM_TEXT1                       VARCHAR(64)                                ,
  CUSTOM_TEXT2                       VARCHAR(64)                                ,
  CUSTOM_TEXT3                       VARCHAR(64)                                ,
  CUSTOM_TEXT4                       VARCHAR(64)                                ,
  CUSTOM_TEXT5                       VARCHAR(64)                                ,
  CUSTOM_TEXT6                       VARCHAR(64)                                ,
  CUSTOM_TEXT7                       VARCHAR(64)                                ,
  CUSTOM_TEXT8                       VARCHAR(64)                                ,
  EXT_ATTR                           INTEGER                                    ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID )
);

ALTER TABLE db2admin.TASK_INSTANCE_T VOLATILE;

CREATE INDEX db2admin.TI_PARENT ON db2admin.TASK_INSTANCE_T
(   
  PARENT_CONTEXT_ID
);

CREATE INDEX db2admin.TI_SERVICET ON db2admin.TASK_INSTANCE_T
(   
  SERVICE_TICKET
);

CREATE INDEX db2admin.TI_CCID ON db2admin.TASK_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE INDEX db2admin.TI_TK_TOPTK ON db2admin.TASK_INSTANCE_T
(   
  TKTID, TKIID, TOP_TKIID
);

CREATE INDEX db2admin.TI_TOPTKIID ON db2admin.TASK_INSTANCE_T
(   
  TOP_TKIID
);

CREATE INDEX db2admin.TI_TI_KND_ST ON db2admin.TASK_INSTANCE_T
(   
  TKIID, KIND, STATE
);

CREATE INDEX db2admin.TI_WOBA ON db2admin.TASK_INSTANCE_T
(   
  WORK_BASKET
);

CREATE INDEX db2admin.TI_TYPE ON db2admin.TASK_INSTANCE_T
(   
  TYPE
);

CREATE INDEX db2admin.TI_WSID1 ON db2admin.TASK_INSTANCE_T
(   
  WSID_1, KIND
);

CREATE INDEX db2admin.TI_WSID2 ON db2admin.TASK_INSTANCE_T
(   
  WSID_2, KIND
);

CREATE INDEX db2admin.TI_WSID1S ON db2admin.TASK_INSTANCE_T
(   
  WSID_1, KIND, STATE
);

CREATE INDEX db2admin.TI_WSID2S ON db2admin.TASK_INSTANCE_T
(   
  WSID_2, KIND, STATE
);

CREATE INDEX db2admin.TI_Q1 ON db2admin.TASK_INSTANCE_T
(   
  KIND, PRIORITY, OWNER, STARTER, ORIGINATOR
);

CREATE TABLE db2admin.TASK_INSTANCE_EXT_ATTR_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  VALUE                              VARCHAR(254)                               ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID, KIND )
);

ALTER TABLE db2admin.TASK_INSTANCE_EXT_ATTR_T VOLATILE;

CREATE INDEX db2admin.TIEA_CTXID ON db2admin.TASK_INSTANCE_EXT_ATTR_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_CONTEXT_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  SERVICE_CONTEXT                    BLOB(3900K)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID )
);

CREATE INDEX db2admin.TC_CCID ON db2admin.TASK_CONTEXT_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.CONTACT_QUERIES_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTACTS_QTIDS                     BLOB(3900k)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID )
);

ALTER TABLE db2admin.CONTACT_QUERIES_T VOLATILE;

CREATE INDEX db2admin.CQ_CCID ON db2admin.CONTACT_QUERIES_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.UISETTINGS_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  UI_SETTINGS                        BLOB(3900k)                       NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID )
);

ALTER TABLE db2admin.UISETTINGS_T VOLATILE;

CREATE INDEX db2admin.UIS_CCID ON db2admin.UISETTINGS_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.REPLY_HANDLER_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  REPLY_HANDLER                      BLOB(3900k)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID )
);

ALTER TABLE db2admin.REPLY_HANDLER_T VOLATILE;

CREATE INDEX db2admin.RH_CCID ON db2admin.REPLY_HANDLER_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_TIMER_T
(
  OID                                CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  SCHEDULER_ID                       VARCHAR(254)                      NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( OID, KIND )
);

ALTER TABLE db2admin.TASK_TIMER_T VOLATILE;

CREATE TABLE db2admin.TASK_INST_CPROP_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  NAME                               VARCHAR(220)                      NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  DATA_TYPE                          VARCHAR(254)                               ,
  STRING_VALUE                       VARCHAR(254)                               ,
  DATA                               BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID, NAME )
);

ALTER TABLE db2admin.TASK_INST_CPROP_T VOLATILE;

CREATE INDEX db2admin.TICP_CCID ON db2admin.TASK_INST_CPROP_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_INST_LDESC_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  DESCRIPTION                        VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID, LOCALE )
);

ALTER TABLE db2admin.TASK_INST_LDESC_T VOLATILE;

CREATE INDEX db2admin.TILD_CCID ON db2admin.TASK_INST_LDESC_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE INDEX db2admin.TILD_PD1 ON db2admin.TASK_INST_LDESC_T
(   
  LOCALE, TKIID, DESCRIPTION
);

CREATE INDEX db2admin.TILD_PD2 ON db2admin.TASK_INST_LDESC_T
(   
  LOCALE, TKIID, DISPLAY_NAME
);

CREATE TABLE db2admin.TIDOCUMENTATION_T
(
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  DOCUMENTATION                      CLOB(4096)                                 ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TKIID, LOCALE )
);

ALTER TABLE db2admin.TIDOCUMENTATION_T VOLATILE;

CREATE INDEX db2admin.TIDOC_CCID ON db2admin.TIDOCUMENTATION_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.ITASK_MESSAGE_DEFINITION_T
(
  TMTID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA           ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  FAULT_NAME                         VARCHAR(254)                               ,
  KIND                               INTEGER                           NOT NULL ,
  MESSAGE_TYPE_NS                    VARCHAR(220)                      NOT NULL ,
  MESSAGE_TYPE_NAME                  VARCHAR(220)                      NOT NULL ,
  MESSAGE_DEFINITION                 BLOB(3900K)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TMTID )
);

ALTER TABLE db2admin.ITASK_MESSAGE_DEFINITION_T VOLATILE;

CREATE INDEX db2admin.ITMD_IDKINSTYPE ON db2admin.ITASK_MESSAGE_DEFINITION_T
(   
  TKIID, MESSAGE_TYPE_NS, MESSAGE_TYPE_NAME, KIND
);

CREATE INDEX db2admin.ITMD_TKIIDKINDFN ON db2admin.ITASK_MESSAGE_DEFINITION_T
(   
  TKIID, KIND, FAULT_NAME
);

CREATE INDEX db2admin.ITMD_CCID ON db2admin.ITASK_MESSAGE_DEFINITION_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_MESSAGE_INSTANCE_T
(
  TMIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TMTID                              CHAR(16)            FOR BIT DATA           ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  FAULT_NAME                         VARCHAR(254)                               ,
  KIND                               INTEGER                           NOT NULL ,
  MESSAGE_TYPE_NS                    VARCHAR(220)                      NOT NULL ,
  MESSAGE_TYPE_NAME                  VARCHAR(220)                      NOT NULL ,
  DATA                               BLOB(1073741823)                           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( TMIID )
);

ALTER TABLE db2admin.TASK_MESSAGE_INSTANCE_T VOLATILE;

CREATE INDEX db2admin.TMI_TI_K ON db2admin.TASK_MESSAGE_INSTANCE_T
(   
  TKIID, KIND
);

CREATE INDEX db2admin.TMI_TMTID ON db2admin.TASK_MESSAGE_INSTANCE_T
(   
  TMTID
);

CREATE INDEX db2admin.TMI_CCID ON db2admin.TASK_MESSAGE_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_AUDIT_LOG_T
(
  ALID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  AUDIT_EVENT                        INTEGER                           NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA           ,
  TKTID                              CHAR(16)            FOR BIT DATA           ,
  ESIID                              CHAR(16)            FOR BIT DATA           ,
  ESTID                              CHAR(16)            FOR BIT DATA           ,
  TOP_TKIID                          CHAR(16)            FOR BIT DATA           ,
  FOLLOW_ON_TKIID                    CHAR(16)            FOR BIT DATA           ,
  PARENT_TKIID                       CHAR(16)            FOR BIT DATA           ,
  PARENT_CONTEXT_ID                  CHAR(16)            FOR BIT DATA           ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA           ,
  WI_REASON                          INTEGER                                    ,
  NAME                               VARCHAR(254)                               ,
  NAMESPACE                          VARCHAR(254)                               ,
  VALID_FROM_UTC                     TIMESTAMP                                  ,
  EVENT_TIME_UTC                     TIMESTAMP                                  ,
  PARENT_TASK_NAME                   VARCHAR(254)                               ,
  PARENT_TASK_NAMESPACE              VARCHAR(254)                               ,
  TASK_KIND                          INTEGER                                    ,
  TASK_STATE                         INTEGER                                    ,
  FAULT_TYPE_NAME                    VARCHAR(220)                               ,
  FAULT_NAMESPACE                    VARCHAR(220)                               ,
  FAULT_NAME                         VARCHAR(220)                               ,
  NEW_USER                           VARCHAR(128)                               ,
  OLD_USER                           VARCHAR(128)                               ,
  PRINCIPAL                          VARCHAR(128)                               ,
  USERS                              CLOB(8192)                                 ,
  DESCRIPTION                        CLOB(8192)                                 ,
  MESSAGE_DATA                       BLOB(1073741823)                           ,
  SNAPSHOT_ID                        VARCHAR(254)                               ,
  SNAPSHOT_NAME                      VARCHAR(254)                               ,
  PROCESS_APP_ACRONYM                VARCHAR(7)                                 ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( ALID )
);

CREATE TABLE db2admin.IMAIL_T
(
  OBJECT_ID                          CHAR(16)            FOR BIT DATA  NOT NULL ,
  FROM_STATE                         INTEGER                           NOT NULL ,
  TO_STATE                           INTEGER                           NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  SUBJECT                            VARCHAR(254)                      NOT NULL ,
  URI                                VARCHAR(254)                               ,
  BODY_TEXT                          CLOB(4096)                                 ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( OBJECT_ID, FROM_STATE, TO_STATE, LOCALE )
);

ALTER TABLE db2admin.IMAIL_T VOLATILE;

CREATE INDEX db2admin.IMN_CTX ON db2admin.IMAIL_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.TASK_HISTORY_T
(
  PKID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  EVENT                              INTEGER                           NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_TKIID                       CHAR(16)            FOR BIT DATA           ,
  ESIID                              CHAR(16)            FOR BIT DATA           ,
  REASON                             INTEGER                           NOT NULL ,
  EVENT_TIME                         TIMESTAMP                         NOT NULL ,
  NEXT_TIME                          TIMESTAMP                                  ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  PRINCIPAL                          VARCHAR(128)                      NOT NULL ,
  WORK_ITEM_KIND                     INTEGER                           NOT NULL ,
  FROM_ID                            VARCHAR(128)                               ,
  TO_ID                              VARCHAR(128)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PKID )
);

ALTER TABLE db2admin.TASK_HISTORY_T VOLATILE;

CREATE INDEX db2admin.TH_TKIID ON db2admin.TASK_HISTORY_T
(   
  TKIID
);

CREATE INDEX db2admin.TH_CTXID ON db2admin.TASK_HISTORY_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.COMPLETION_INSTANCE_T
(
  CMIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  COMPL_CONDITION                    BLOB(3900K)                                ,
  CRITERION_FOR                      VARCHAR(254)                               ,
  CRITERION_FOR_TIME                 TIMESTAMP                                  ,
  COMPLETION_NAME                    VARCHAR(220)                               ,
  IS_DEFAULT_COMPLETION              SMALLINT                          NOT NULL ,
  PREFIX_MAP                         BLOB(3900K)                                ,
  USE_DEFAULT_RESULT_CONSTRUCT       SMALLINT                          NOT NULL ,
  SCHEDULER_ID                       VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( CMIID )
);

CREATE INDEX db2admin.CMPI_TKIID_ORDER ON db2admin.COMPLETION_INSTANCE_T
(   
  TKIID, ORDER_NUMBER
);

CREATE INDEX db2admin.CMPI_CCID ON db2admin.COMPLETION_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.RESULT_AGGREGATION_INSTANCE_T
(
  RAIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  ORDER_NUMBER                       INTEGER                           NOT NULL ,
  CMIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  TKIID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  AGGR_PART                          VARCHAR(254)                               ,
  AGGR_LOCATION                      BLOB(3900K)                                ,
  AGGR_FUNCTION                      VARCHAR(254)                      NOT NULL ,
  AGGR_CONDITION                     BLOB(3900K)                                ,
  PREFIX_MAP                         BLOB(3900K)                                ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( RAIID )
);

CREATE INDEX db2admin.RAGI_CMIID_ORDER ON db2admin.RESULT_AGGREGATION_INSTANCE_T
(   
  CMIID, ORDER_NUMBER
);

CREATE INDEX db2admin.RAGI_CCID ON db2admin.RESULT_AGGREGATION_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.SAVED_TASK_MESSAGE_T
(
  STMID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  RELATED_OID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  KIND                               INTEGER                           NOT NULL ,
  SCHEDULER_ID                       VARCHAR(254)                               ,
  CREATION_TIME                      TIMESTAMP                         NOT NULL ,
  EXPECTED_ARRIVAL_TIME              TIMESTAMP                         NOT NULL ,
  MESSAGE                            BLOB(1073741823)                           ,
  MESSAGE_IL                         VARCHAR(3000)       FOR BIT DATA           ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( STMID )
);

ALTER TABLE db2admin.SAVED_TASK_MESSAGE_T VOLATILE;

CREATE INDEX db2admin.STM_ROIDKIND ON db2admin.SAVED_TASK_MESSAGE_T
(   
  RELATED_OID, KIND
);

CREATE INDEX db2admin.STM_SID ON db2admin.SAVED_TASK_MESSAGE_T
(   
  SCHEDULER_ID
);

CREATE INDEX db2admin.STM_CTXID ON db2admin.SAVED_TASK_MESSAGE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.PEOPLE_RESOURCE_REF_INSTANCE_T
(
  PRRIID                             CHAR(16)            FOR BIT DATA  NOT NULL ,
  PRRTID                             CHAR(16)            FOR BIT DATA  NOT NULL ,
  INSTANCE_OID                       CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARAMETER_VALUES                   BLOB(3900K)                                ,
  CONTAINMENT_CONTEXT_ID             CHAR(16)            FOR BIT DATA  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PRRIID )
);

ALTER TABLE db2admin.PEOPLE_RESOURCE_REF_INSTANCE_T VOLATILE;

CREATE INDEX db2admin.PRRI_INSTOID ON db2admin.PEOPLE_RESOURCE_REF_INSTANCE_T
(   
  INSTANCE_OID
);

CREATE INDEX db2admin.PRRI_ccID ON db2admin.PEOPLE_RESOURCE_REF_INSTANCE_T
(   
  CONTAINMENT_CONTEXT_ID
);

CREATE TABLE db2admin.PEOPLE_RESOURCE_T
(
  PRID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAMESPACE                          VARCHAR(254)                      NOT NULL ,
  NAME                               VARCHAR(254)                      NOT NULL ,
  PARAMETERS                         BLOB(3900K)                                ,
  BINDING_TYPE                       INTEGER                           NOT NULL ,
  BINDING_OID                        CHAR(16)            FOR BIT DATA           ,
  BINDING_DETAILS                    BLOB(3900K)                                ,
  APPLICATION_NAME                   VARCHAR(220)                               ,
  LAST_MODIFICATION_TIME             TIMESTAMP                         NOT NULL ,
  EAR_VERSION                        INTEGER                           NOT NULL ,
  SCHEMA_VERSION                     INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PRID )
);

ALTER TABLE db2admin.PEOPLE_RESOURCE_T VOLATILE;

CREATE INDEX db2admin.PR_BOID ON db2admin.PEOPLE_RESOURCE_T
(   
  BINDING_OID
);

CREATE INDEX db2admin.PR_APPNAME_NS_NAME ON db2admin.PEOPLE_RESOURCE_T
(   
  APPLICATION_NAME, NAMESPACE, NAME
);

CREATE TABLE db2admin.PEOPLE_QUERY_T
(
  PQID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  NAME                               VARCHAR(254)                      NOT NULL ,
  NAMESPACE                          VARCHAR(254)                      NOT NULL ,
  TYPE                               INTEGER                           NOT NULL ,
  QUERY_DEFINITION                   BLOB(3900K)                                ,
  APPLICATION_NAME                   VARCHAR(220)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PQID )
);

ALTER TABLE db2admin.PEOPLE_QUERY_T VOLATILE;

CREATE INDEX db2admin.PQ_APPNAME ON db2admin.PEOPLE_QUERY_T
(   
  APPLICATION_NAME
);

CREATE TABLE db2admin.PEOPLE_RESOLUTION_RESULT_T
(
  PRRID                              CHAR(16)            FOR BIT DATA  NOT NULL ,
  RELATED_OID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  RELATED_TYPE                       INTEGER                           NOT NULL ,
  CONTEXT_DATA                       BLOB(1073741823)                           ,
  CONTEXT_DATA_IL                    VARCHAR(1000)       FOR BIT DATA           ,
  CONTEXT_HASH_CODE                  INTEGER                                    ,
  PARENT_PRRID                       CHAR(16)            FOR BIT DATA           ,
  EXPIRATION_TIME                    TIMESTAMP                                  ,
  QIID4_UG                           CHAR(16)            FOR BIT DATA  NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( PRRID )
);

ALTER TABLE db2admin.PEOPLE_RESOLUTION_RESULT_T VOLATILE;

CREATE INDEX db2admin.PRR_RE_HC ON db2admin.PEOPLE_RESOLUTION_RESULT_T
(   
  RELATED_OID, CONTEXT_HASH_CODE
);

CREATE INDEX db2admin.PRR_QIID4UG ON db2admin.PEOPLE_RESOLUTION_RESULT_T
(   
  QIID4_UG
);

CREATE TABLE db2admin.WORK_BASKET_T
(
  WBID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  NAME                               VARCHAR(254)                      NOT NULL ,
  TYPE                               INTEGER                           NOT NULL ,
  OWNER                              VARCHAR(128)                               ,
  SUBSTITUTION_POLICY                INTEGER                           NOT NULL ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR(254)                      NOT NULL ,
  DEFAULT_QUERY_TABLE                VARCHAR(32)                                ,
  CUSTOM_TEXT1                       VARCHAR(254)                               ,
  CUSTOM_TEXT2                       VARCHAR(254)                               ,
  CUSTOM_TEXT3                       VARCHAR(254)                               ,
  CUSTOM_TEXT4                       VARCHAR(254)                               ,
  CUSTOM_TEXT5                       VARCHAR(254)                               ,
  CUSTOM_TEXT6                       VARCHAR(254)                               ,
  CUSTOM_TEXT7                       VARCHAR(254)                               ,
  CUSTOM_TEXT8                       VARCHAR(254)                               ,
  EXTENDED_DATA                      BLOB(3900K)                                ,
  CREATION_TIME                      TIMESTAMP                         NOT NULL ,
  LAST_MODIFICATION_TIME             TIMESTAMP                         NOT NULL ,
  CREATED_WITH_VERSION               INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( WBID )
);

ALTER TABLE db2admin.WORK_BASKET_T VOLATILE;

CREATE INDEX db2admin.WBK_NAME ON db2admin.WORK_BASKET_T
(   
  NAME
);

CREATE INDEX db2admin.WBK_TYPE ON db2admin.WORK_BASKET_T
(   
  TYPE
);

CREATE INDEX db2admin.WBK_WSID1 ON db2admin.WORK_BASKET_T
(   
  WSID_1
);

CREATE INDEX db2admin.WBK_WSID2 ON db2admin.WORK_BASKET_T
(   
  WSID_2
);

CREATE TABLE db2admin.WORK_BASKET_LDESC_T
(
  WBID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  DESCRIPTION                        VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( WBID, LOCALE )
);

ALTER TABLE db2admin.WORK_BASKET_LDESC_T VOLATILE;

CREATE TABLE db2admin.WORK_BASKET_DIST_TARGET_T
(
  SOURCE_WBID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  TARGET_WBID                        CHAR(16)            FOR BIT DATA  NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( SOURCE_WBID, TARGET_WBID )
);

ALTER TABLE db2admin.WORK_BASKET_DIST_TARGET_T VOLATILE;

CREATE INDEX db2admin.WBDT_TWB ON db2admin.WORK_BASKET_DIST_TARGET_T
(   
  TARGET_WBID
);

CREATE TABLE db2admin.BUSINESS_CATEGORY_T
(
  BCID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  PARENT_BCID                        CHAR(16)            FOR BIT DATA           ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  NAME                               VARCHAR(254)                      NOT NULL ,
  PRIORITY                           INTEGER                                    ,
  SUBSTITUTION_POLICY                INTEGER                           NOT NULL ,
  JNDI_NAME_STAFF_PROVIDER           VARCHAR(254)                      NOT NULL ,
  DEFAULT_QUERY_TABLE                VARCHAR(32)                                ,
  CUSTOM_TEXT1                       VARCHAR(254)                               ,
  CUSTOM_TEXT2                       VARCHAR(254)                               ,
  CUSTOM_TEXT3                       VARCHAR(254)                               ,
  CUSTOM_TEXT4                       VARCHAR(254)                               ,
  CUSTOM_TEXT5                       VARCHAR(254)                               ,
  CUSTOM_TEXT6                       VARCHAR(254)                               ,
  CUSTOM_TEXT7                       VARCHAR(254)                               ,
  CUSTOM_TEXT8                       VARCHAR(254)                               ,
  EXTENDED_DATA                      BLOB(3900K)                                ,
  CREATION_TIME                      TIMESTAMP                         NOT NULL ,
  LAST_MODIFICATION_TIME             TIMESTAMP                         NOT NULL ,
  CREATED_WITH_VERSION               INTEGER                           NOT NULL ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( BCID )
);

ALTER TABLE db2admin.BUSINESS_CATEGORY_T VOLATILE;

CREATE INDEX db2admin.BCG_PARENTBCID ON db2admin.BUSINESS_CATEGORY_T
(   
  PARENT_BCID
);

CREATE INDEX db2admin.BCG_NAME ON db2admin.BUSINESS_CATEGORY_T
(   
  NAME
);

CREATE INDEX db2admin.BCG_WSID1 ON db2admin.BUSINESS_CATEGORY_T
(   
  WSID_1
);

CREATE INDEX db2admin.BCG_WSID2 ON db2admin.BUSINESS_CATEGORY_T
(   
  WSID_2
);

CREATE TABLE db2admin.BUSINESS_CATEGORY_LDESC_T
(
  BCID                               CHAR(16)            FOR BIT DATA  NOT NULL ,
  LOCALE                             VARCHAR(32)                       NOT NULL ,
  WSID_1                             CHAR(16)            FOR BIT DATA           ,
  WSID_1_HC                          INTEGER                                    ,
  WSID_2                             CHAR(16)            FOR BIT DATA           ,
  WSID_2_HC                          INTEGER                                    ,
  DISPLAY_NAME                       VARCHAR(64)                                ,
  DESCRIPTION                        VARCHAR(254)                               ,
  VERSION_ID                         SMALLINT                          NOT NULL ,
  PRIMARY KEY ( BCID, LOCALE )
);

ALTER TABLE db2admin.BUSINESS_CATEGORY_LDESC_T VOLATILE;
-- set schema version to: 8550
INSERT INTO db2admin.SCHEMA_VERSION (SCHEMA_VERSION, DATA_MIGRATION) VALUES( 8550, 0 );


-- View: ProcessTemplate
CREATE VIEW db2admin.PROCESS_TEMPLATE(PTID, NAME, DISPLAY_NAME, VALID_FROM, TARGET_NAMESPACE, APPLICATION_NAME, VERSION, CREATED, STATE, EXECUTION_MODE, DESCRIPTION, CAN_RUN_SYNC, CAN_RUN_INTERRUP, COMP_SPHERE, CONTINUE_ON_ERROR, SNAPSHOT_ID, SNAPSHOT_NAME, TOP_LEVEL_TOOLKIT_ACRONYM, TOP_LEVEL_TOOLKIT_NAME, TRACK_NAME, PROCESS_APP_NAME, PROCESS_APP_ACRONYM, TOOLKIT_SNAPSHOT_ID, TOOLKIT_SNAPSHOT_NAME, TOOLKIT_NAME, TOOLKIT_ACRONYM, IS_TIP, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT db2admin.PROCESS_TEMPLATE_B_T.PTID, db2admin.PROCESS_TEMPLATE_B_T.NAME, db2admin.PROCESS_TEMPLATE_B_T.DISPLAY_NAME, db2admin.PROCESS_TEMPLATE_B_T.VALID_FROM, db2admin.PROCESS_TEMPLATE_B_T.TARGET_NAMESPACE, db2admin.PROCESS_TEMPLATE_B_T.APPLICATION_NAME, db2admin.PROCESS_TEMPLATE_B_T.VERSION, db2admin.PROCESS_TEMPLATE_B_T.CREATED, db2admin.PROCESS_TEMPLATE_B_T.STATE, db2admin.PROCESS_TEMPLATE_B_T.EXECUTION_MODE, db2admin.PROCESS_TEMPLATE_B_T.DESCRIPTION, db2admin.PROCESS_TEMPLATE_B_T.CAN_CALL, db2admin.PROCESS_TEMPLATE_B_T.CAN_INITIATE, db2admin.PROCESS_TEMPLATE_B_T.COMPENSATION_SPHERE, db2admin.PROCESS_TEMPLATE_B_T.CONTINUE_ON_ERROR, db2admin.PC_VERSION_TEMPLATE_T.SNAPSHOT_ID, db2admin.PC_VERSION_TEMPLATE_T.SNAPSHOT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_ACRONYM, db2admin.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TRACK_NAME, db2admin.PC_VERSION_TEMPLATE_T.PROCESS_APP_NAME, db2admin.PC_VERSION_TEMPLATE_T.PROCESS_APP_ACRONYM, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_ID, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_ACRONYM, db2admin.PC_VERSION_TEMPLATE_T.IS_TIP, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT1, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT2, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT3, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT4, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT5, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT6, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT7, db2admin.PROCESS_TEMPLATE_B_T.CUSTOM_TEXT8
 FROM db2admin.PROCESS_TEMPLATE_B_T LEFT JOIN db2admin.PC_VERSION_TEMPLATE_T ON (db2admin.PC_VERSION_TEMPLATE_T.CONTAINMENT_CONTEXT_ID = db2admin.PROCESS_TEMPLATE_B_T.PTID);

-- View: ProcessTemplAttr
CREATE VIEW db2admin.PROCESS_TEMPL_ATTR(PTID, NAME, VALUE ) AS
 SELECT db2admin.PROCESS_TEMPLATE_ATTRIBUTE_B_T.PTID, db2admin.PROCESS_TEMPLATE_ATTRIBUTE_B_T.ATTR_KEY, db2admin.PROCESS_TEMPLATE_ATTRIBUTE_B_T.VALUE
 FROM db2admin.PROCESS_TEMPLATE_ATTRIBUTE_B_T;

-- View: ProcessInstance
CREATE VIEW db2admin.PROCESS_INSTANCE(PTID, PIID, NAME, STATE, CREATED, STARTED, COMPLETED, PARENT_NAME, TOP_LEVEL_NAME, PARENT_PIID, TOP_LEVEL_PIID, STARTER, DESCRIPTION, TEMPLATE_NAME, TEMPLATE_DESCR, RESUMES, CONTINUE_ON_ERROR, IS_MIGRATED, WSID_1, WSID_2, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT db2admin.PROCESS_INSTANCE_B_T.PTID, db2admin.PROCESS_INSTANCE_B_T.PIID, db2admin.PROCESS_INSTANCE_B_T.NAME, db2admin.PROCESS_INSTANCE_B_T.STATE, db2admin.PROCESS_INSTANCE_B_T.CREATED, db2admin.PROCESS_INSTANCE_B_T.STARTED, db2admin.PROCESS_INSTANCE_B_T.COMPLETED, db2admin.PROCESS_INSTANCE_B_T.PARENT_NAME, db2admin.PROCESS_INSTANCE_B_T.TOP_LEVEL_NAME, db2admin.PROCESS_INSTANCE_B_T.PARENT_PIID, db2admin.PROCESS_INSTANCE_B_T.TOP_LEVEL_PIID, db2admin.PROCESS_INSTANCE_B_T.STARTER, db2admin.PROCESS_INSTANCE_B_T.DESCRIPTION, db2admin.PROCESS_TEMPLATE_B_T.NAME, db2admin.PROCESS_TEMPLATE_B_T.DESCRIPTION, db2admin.PROCESS_INSTANCE_B_T.RESUMES, db2admin.PROCESS_TEMPLATE_B_T.CONTINUE_ON_ERROR, db2admin.PROCESS_INSTANCE_B_T.IS_MIGRATED, db2admin.PROCESS_INSTANCE_B_T.WSID_1, db2admin.PROCESS_INSTANCE_B_T.WSID_2, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT1, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT2, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT3, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT4, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT5, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT6, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT7, db2admin.PROCESS_INSTANCE_B_T.CUSTOM_TEXT8
 FROM db2admin.PROCESS_INSTANCE_B_T, db2admin.PROCESS_TEMPLATE_B_T
 WHERE db2admin.PROCESS_INSTANCE_B_T.PTID = db2admin.PROCESS_TEMPLATE_B_T.PTID;

-- View: ProcessAttribute
CREATE VIEW db2admin.PROCESS_ATTRIBUTE(PIID, NAME, VALUE, DATA_TYPE, WSID_1, WSID_2 ) AS
 SELECT db2admin.PROCESS_INSTANCE_ATTRIBUTE_T.PIID, db2admin.PROCESS_INSTANCE_ATTRIBUTE_T.ATTR_KEY, db2admin.PROCESS_INSTANCE_ATTRIBUTE_T.VALUE, db2admin.PROCESS_INSTANCE_ATTRIBUTE_T.DATA_TYPE, db2admin.PROCESS_INSTANCE_ATTRIBUTE_T.WSID_1, db2admin.PROCESS_INSTANCE_ATTRIBUTE_T.WSID_2
 FROM db2admin.PROCESS_INSTANCE_ATTRIBUTE_T;

-- View: Activity
CREATE VIEW db2admin.ACTIVITY(PIID, AIID, PTID, ATID, SIID, STID, EHIID, ENCLOSING_FEIID, KIND, COMPLETED, ACTIVATED, FIRST_ACTIVATED, STARTED, STATE, SUB_STATE, STOP_REASON, OWNER, DESCRIPTION, EXPIRES, TEMPLATE_NAME, TEMPLATE_DESCR, BUSINESS_RELEVANCE, SKIP_REQUESTED, CONTINUE_ON_ERROR, INVOKED_INST_ID, INVOKED_INST_TYPE, PREVIOUS_EXPIRATION_TIME, HAS_WORK_ITEM, WSID_1, WSID_2 ) AS
 SELECT db2admin.ACTIVITY_INSTANCE_B_T.PIID, db2admin.ACTIVITY_INSTANCE_B_T.AIID, db2admin.ACTIVITY_INSTANCE_B_T.PTID, db2admin.ACTIVITY_INSTANCE_B_T.ATID, db2admin.ACTIVITY_INSTANCE_B_T.SIID, db2admin.ACTIVITY_TEMPLATE_B_T.PARENT_STID, db2admin.ACTIVITY_INSTANCE_B_T.EHIID, db2admin.ACTIVITY_INSTANCE_B_T.ENCLOSING_FEIID, db2admin.ACTIVITY_TEMPLATE_B_T.KIND, db2admin.ACTIVITY_INSTANCE_B_T.FINISHED, db2admin.ACTIVITY_INSTANCE_B_T.ACTIVATED, db2admin.ACTIVITY_INSTANCE_B_T.FIRST_ACTIVATED, db2admin.ACTIVITY_INSTANCE_B_T.STARTED, db2admin.ACTIVITY_INSTANCE_B_T.STATE, db2admin.ACTIVITY_INSTANCE_B_T.SUB_STATE, db2admin.ACTIVITY_INSTANCE_B_T.STOP_REASON, db2admin.ACTIVITY_INSTANCE_B_T.OWNER, db2admin.ACTIVITY_INSTANCE_B_T.DESCRIPTION, db2admin.ACTIVITY_INSTANCE_B_T.EXPIRES, db2admin.ACTIVITY_TEMPLATE_B_T.NAME, db2admin.ACTIVITY_TEMPLATE_B_T.DESCRIPTION, db2admin.ACTIVITY_TEMPLATE_B_T.BUSINESS_RELEVANCE, db2admin.ACTIVITY_INSTANCE_B_T.SKIP_REQUESTED, db2admin.ACTIVITY_INSTANCE_B_T.CONTINUE_ON_ERROR, db2admin.ACTIVITY_INSTANCE_B_T.INVOKED_INSTANCE_ID, db2admin.ACTIVITY_INSTANCE_B_T.INVOKED_INSTANCE_TYPE, db2admin.ACTIVITY_INSTANCE_B_T.PREVIOUS_EXPIRATION_DATE, db2admin.ACTIVITY_INSTANCE_B_T.HAS_WORK_ITEM, db2admin.ACTIVITY_INSTANCE_B_T.WSID_1, db2admin.ACTIVITY_INSTANCE_B_T.WSID_2
 FROM db2admin.ACTIVITY_INSTANCE_B_T, db2admin.ACTIVITY_TEMPLATE_B_T
 WHERE db2admin.ACTIVITY_INSTANCE_B_T.ATID = db2admin.ACTIVITY_TEMPLATE_B_T.ATID;

-- View: ActivityAttribute
CREATE VIEW db2admin.ACTIVITY_ATTRIBUTE(AIID, NAME, VALUE, DATA_TYPE, WSID_1, WSID_2 ) AS
 SELECT db2admin.ACTIVITY_INSTANCE_ATTR_B_T.AIID, db2admin.ACTIVITY_INSTANCE_ATTR_B_T.ATTR_KEY, db2admin.ACTIVITY_INSTANCE_ATTR_B_T.ATTR_VALUE, db2admin.ACTIVITY_INSTANCE_ATTR_B_T.DATA_TYPE, db2admin.ACTIVITY_INSTANCE_ATTR_B_T.WSID_1, db2admin.ACTIVITY_INSTANCE_ATTR_B_T.WSID_2
 FROM db2admin.ACTIVITY_INSTANCE_ATTR_B_T;

-- View: Event
CREATE VIEW db2admin.EVENT(EIID, AIID, PIID, EHTID, SIID, NAME, WSID_1, WSID_2 ) AS
 SELECT db2admin.EVENT_INSTANCE_B_T.EIID, db2admin.EVENT_INSTANCE_B_T.AIID, db2admin.EVENT_INSTANCE_B_T.PIID, db2admin.EVENT_INSTANCE_B_T.EHTID, db2admin.EVENT_INSTANCE_B_T.SIID, db2admin.SERVICE_TEMPLATE_B_T.NAME, db2admin.EVENT_INSTANCE_B_T.WSID_1, db2admin.EVENT_INSTANCE_B_T.WSID_2
 FROM db2admin.EVENT_INSTANCE_B_T, db2admin.SERVICE_TEMPLATE_B_T
 WHERE db2admin.EVENT_INSTANCE_B_T.STATE = 2 AND db2admin.EVENT_INSTANCE_B_T.VTID = db2admin.SERVICE_TEMPLATE_B_T.VTID;

-- View: WorkItem
CREATE VIEW db2admin.WORK_ITEM(WIID, OWNER_ID, GROUP_NAME, EVERYBODY, OBJECT_TYPE, OBJECT_ID, ASSOC_OBJECT_TYPE, ASSOC_OID, REASON, CREATION_TIME, QIID, KIND ) AS
 SELECT db2admin.WORK_ITEM_T.WIID, db2admin.WORK_ITEM_T.OWNER_ID, db2admin.WORK_ITEM_T.GROUP_NAME, db2admin.WORK_ITEM_T.EVERYBODY, db2admin.WORK_ITEM_T.OBJECT_TYPE, db2admin.WORK_ITEM_T.OBJECT_ID, db2admin.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, db2admin.WORK_ITEM_T.ASSOCIATED_OID, db2admin.WORK_ITEM_T.REASON, db2admin.WORK_ITEM_T.CREATION_TIME, db2admin.WORK_ITEM_T.QIID, db2admin.WORK_ITEM_T.KIND
 FROM db2admin.WORK_ITEM_T
 WHERE db2admin.WORK_ITEM_T.AUTH_INFO = 1
 UNION ALL SELECT db2admin.WORK_ITEM_T.WIID, db2admin.WORK_ITEM_T.OWNER_ID, db2admin.WORK_ITEM_T.GROUP_NAME, db2admin.WORK_ITEM_T.EVERYBODY, db2admin.WORK_ITEM_T.OBJECT_TYPE, db2admin.WORK_ITEM_T.OBJECT_ID, db2admin.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, db2admin.WORK_ITEM_T.ASSOCIATED_OID, db2admin.WORK_ITEM_T.REASON, db2admin.WORK_ITEM_T.CREATION_TIME, db2admin.WORK_ITEM_T.QIID, db2admin.WORK_ITEM_T.KIND
 FROM db2admin.WORK_ITEM_T
 WHERE db2admin.WORK_ITEM_T.AUTH_INFO = 2
 UNION ALL SELECT db2admin.WORK_ITEM_T.WIID, db2admin.WORK_ITEM_T.OWNER_ID, db2admin.WORK_ITEM_T.GROUP_NAME, db2admin.WORK_ITEM_T.EVERYBODY, db2admin.WORK_ITEM_T.OBJECT_TYPE, db2admin.WORK_ITEM_T.OBJECT_ID, db2admin.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, db2admin.WORK_ITEM_T.ASSOCIATED_OID, db2admin.WORK_ITEM_T.REASON, db2admin.WORK_ITEM_T.CREATION_TIME, db2admin.WORK_ITEM_T.QIID, db2admin.WORK_ITEM_T.KIND
 FROM db2admin.WORK_ITEM_T
 WHERE db2admin.WORK_ITEM_T.AUTH_INFO = 3
 UNION ALL SELECT db2admin.WORK_ITEM_T.WIID, db2admin.RETRIEVED_USER_T.OWNER_ID, db2admin.WORK_ITEM_T.GROUP_NAME, db2admin.WORK_ITEM_T.EVERYBODY, db2admin.WORK_ITEM_T.OBJECT_TYPE, db2admin.WORK_ITEM_T.OBJECT_ID, db2admin.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, db2admin.WORK_ITEM_T.ASSOCIATED_OID, db2admin.WORK_ITEM_T.REASON, db2admin.WORK_ITEM_T.CREATION_TIME, db2admin.WORK_ITEM_T.QIID, db2admin.WORK_ITEM_T.KIND
 FROM db2admin.WORK_ITEM_T, db2admin.RETRIEVED_USER_T
 WHERE db2admin.WORK_ITEM_T.AUTH_INFO = 0 AND db2admin.WORK_ITEM_T.QIID = db2admin.RETRIEVED_USER_T.QIID
 UNION ALL SELECT db2admin.WORK_ITEM_T.WIID, db2admin.WORK_ITEM_T.OWNER_ID, db2admin.RETRIEVED_GROUP_T.GROUP_NAME, db2admin.WORK_ITEM_T.EVERYBODY, db2admin.WORK_ITEM_T.OBJECT_TYPE, db2admin.WORK_ITEM_T.OBJECT_ID, db2admin.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, db2admin.WORK_ITEM_T.ASSOCIATED_OID, db2admin.WORK_ITEM_T.REASON, db2admin.WORK_ITEM_T.CREATION_TIME, db2admin.WORK_ITEM_T.QIID, db2admin.WORK_ITEM_T.KIND
 FROM db2admin.WORK_ITEM_T, db2admin.RETRIEVED_GROUP_T
 WHERE db2admin.WORK_ITEM_T.AUTH_INFO = 4 AND db2admin.WORK_ITEM_T.QIID = db2admin.RETRIEVED_GROUP_T.QIID
 UNION ALL SELECT db2admin.WORK_ITEM_T.WIID, db2admin.RETRIEVED_USER_T.OWNER_ID, db2admin.WORK_ITEM_T.GROUP_NAME, db2admin.WORK_ITEM_T.EVERYBODY, db2admin.WORK_ITEM_T.OBJECT_TYPE, db2admin.WORK_ITEM_T.OBJECT_ID, db2admin.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, db2admin.WORK_ITEM_T.ASSOCIATED_OID, db2admin.WORK_ITEM_T.REASON, db2admin.WORK_ITEM_T.CREATION_TIME, db2admin.WORK_ITEM_T.QIID, db2admin.WORK_ITEM_T.KIND
 FROM db2admin.WORK_ITEM_T, db2admin.RETRIEVED_USER_T
 WHERE db2admin.WORK_ITEM_T.AUTH_INFO = 6 AND db2admin.WORK_ITEM_T.QIID = db2admin.RETRIEVED_USER_T.QIID
 UNION ALL SELECT db2admin.WORK_ITEM_T.WIID, db2admin.WORK_ITEM_T.OWNER_ID, db2admin.RETRIEVED_GROUP_T.GROUP_NAME, db2admin.WORK_ITEM_T.EVERYBODY, db2admin.WORK_ITEM_T.OBJECT_TYPE, db2admin.WORK_ITEM_T.OBJECT_ID, db2admin.WORK_ITEM_T.ASSOCIATED_OBJECT_TYPE, db2admin.WORK_ITEM_T.ASSOCIATED_OID, db2admin.WORK_ITEM_T.REASON, db2admin.WORK_ITEM_T.CREATION_TIME, db2admin.WORK_ITEM_T.QIID, db2admin.WORK_ITEM_T.KIND
 FROM db2admin.WORK_ITEM_T, db2admin.RETRIEVED_GROUP_T
 WHERE db2admin.WORK_ITEM_T.AUTH_INFO = 6 AND db2admin.WORK_ITEM_T.QIID = db2admin.RETRIEVED_GROUP_T.QIID;

-- View: SharedWorkItem
CREATE VIEW db2admin.SHARED_WORK_ITEM(WSID, OWNER_ID, GROUP_NAME, EVERYBODY, REASON ) AS
 SELECT db2admin.SWI_T.WSID, db2admin.SWI_T.OWNER_ID, db2admin.SWI_T.GROUP_NAME, db2admin.SWI_T.EVERYBODY, db2admin.SWI_T.REASON
 FROM db2admin.SWI_T
 WHERE db2admin.SWI_T.AUTH_INFO IN ( 1, 2, 3 )
 UNION ALL SELECT db2admin.SWI_T.WSID, db2admin.RETRIEVED_USER_T.OWNER_ID, db2admin.SWI_T.GROUP_NAME, db2admin.SWI_T.EVERYBODY, db2admin.SWI_T.REASON
 FROM db2admin.SWI_T, db2admin.RETRIEVED_USER_T
 WHERE db2admin.SWI_T.QIID = db2admin.RETRIEVED_USER_T.QIID AND db2admin.SWI_T.AUTH_INFO IN (0, 4)
 UNION ALL SELECT db2admin.SWI_T.WSID, db2admin.SWI_T.OWNER_ID, db2admin.RETRIEVED_GROUP_T.GROUP_NAME, db2admin.SWI_T.EVERYBODY, db2admin.SWI_T.REASON
 FROM db2admin.SWI_T, db2admin.RETRIEVED_GROUP_T
 WHERE db2admin.SWI_T.QIID = db2admin.RETRIEVED_GROUP_T.QIID AND db2admin.SWI_T.AUTH_INFO IN (4, 6);

-- View: ActivityService
CREATE VIEW db2admin.ACTIVITY_SERVICE(EIID, AIID, PIID, VTID, PORT_TYPE, NAME_SPACE_URI, OPERATION, WSID_1, WSID_2 ) AS
 SELECT db2admin.EVENT_INSTANCE_B_T.EIID, db2admin.EVENT_INSTANCE_B_T.AIID, db2admin.EVENT_INSTANCE_B_T.PIID, db2admin.EVENT_INSTANCE_B_T.VTID, db2admin.SERVICE_TEMPLATE_B_T.PORT_TYPE_NAME, db2admin.URI_TEMPLATE_B_T.URI, db2admin.SERVICE_TEMPLATE_B_T.OPERATION_NAME, db2admin.EVENT_INSTANCE_B_T.WSID_1, db2admin.EVENT_INSTANCE_B_T.WSID_2
 FROM db2admin.EVENT_INSTANCE_B_T, db2admin.SERVICE_TEMPLATE_B_T, db2admin.URI_TEMPLATE_B_T
 WHERE db2admin.EVENT_INSTANCE_B_T.STATE = 2 AND db2admin.EVENT_INSTANCE_B_T.VTID = db2admin.SERVICE_TEMPLATE_B_T.VTID AND db2admin.SERVICE_TEMPLATE_B_T.PORT_TYPE_UTID = db2admin.URI_TEMPLATE_B_T.UTID;

-- View: QueryProperty
CREATE VIEW db2admin.QUERY_PROPERTY(PIID, VARIABLE_NAME, NAME, NAMESPACE, GENERIC_VALUE, STRING_VALUE, NUMBER_VALUE, DECIMAL_VALUE, TIMESTAMP_VALUE, WSID_1, WSID_2 ) AS
 SELECT db2admin.QUERYABLE_VARIABLE_INSTANCE_T.PIID, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.VARIABLE_NAME, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.PROPERTY_NAME, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.PROPERTY_NAMESPACE, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.GENERIC_VALUE, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.STRING_VALUE, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.NUMBER_VALUE, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.DECIMAL_VALUE, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.TIMESTAMP_VALUE, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.WSID_1, db2admin.QUERYABLE_VARIABLE_INSTANCE_T.WSID_2
 FROM db2admin.QUERYABLE_VARIABLE_INSTANCE_T;

-- View: QueryPropTempl
CREATE VIEW db2admin.QUERY_PROP_TEMPL(PTID, NAME, PROPERTY_NAME, URI, QUERY_TYPE, JAVA_TYPE ) AS
 SELECT db2admin.QUERYABLE_VARIABLE_TEMPLATE_T.PTID, db2admin.VARIABLE_TEMPLATE_B_T.NAME, db2admin.PROPERTY_ALIAS_TEMPLATE_B_T.PROPERTY_NAME, db2admin.URI_TEMPLATE_B_T.URI, db2admin.QUERYABLE_VARIABLE_TEMPLATE_T.QUERY_TYPE, db2admin.PROPERTY_ALIAS_TEMPLATE_B_T.JAVA_TYPE
 FROM db2admin.QUERYABLE_VARIABLE_TEMPLATE_T, db2admin.VARIABLE_TEMPLATE_B_T, db2admin.PROPERTY_ALIAS_TEMPLATE_B_T, db2admin.URI_TEMPLATE_B_T
 WHERE db2admin.QUERYABLE_VARIABLE_TEMPLATE_T.CTID = db2admin.VARIABLE_TEMPLATE_B_T.CTID AND db2admin.QUERYABLE_VARIABLE_TEMPLATE_T.PAID = db2admin.PROPERTY_ALIAS_TEMPLATE_B_T.PAID AND db2admin.PROPERTY_ALIAS_TEMPLATE_B_T.PROPERTY_UTID = db2admin.URI_TEMPLATE_B_T.UTID;

-- View: MigrationFront
CREATE VIEW db2admin.MIGRATION_FRONT(PIID, AIID, SOURCE_PTID, TARGET_PTID, STATE, SUB_STATE, STOP_REASON, SOURCE_ATID, TARGET_ATID, MIGRATION_TIME, WSID_1, WSID_2 ) AS
 SELECT db2admin.MIGRATION_FRONT_T.PIID, db2admin.MIGRATION_FRONT_T.AIID, db2admin.MIGRATION_PLAN_TEMPLATE_T.SOURCE_PTID, db2admin.MIGRATION_PLAN_TEMPLATE_T.TARGET_PTID, db2admin.MIGRATION_FRONT_T.STATE, db2admin.MIGRATION_FRONT_T.SUB_STATE, db2admin.MIGRATION_FRONT_T.STOP_REASON, db2admin.MIGRATION_FRONT_T.SOURCE_ATID, db2admin.MIGRATION_FRONT_T.TARGET_ATID, db2admin.MIGRATION_FRONT_T.MIGRATION_TIME, db2admin.MIGRATION_FRONT_T.WSID_1, db2admin.MIGRATION_FRONT_T.WSID_2
 FROM db2admin.MIGRATION_FRONT_T, db2admin.MIGRATION_PLAN_TEMPLATE_T
 WHERE db2admin.MIGRATION_FRONT_T.MPTID = db2admin.MIGRATION_PLAN_TEMPLATE_T.MPTID;

-- View: AuditLog
CREATE VIEW db2admin.AUDIT_LOG(ALID, EVENT_TIME, EVENT_TIME_UTC, AUDIT_EVENT, PTID, PIID, AIID, SIID, SCOPE_NAME, PROCESS_TEMPL_NAME, PROCESS_INST_NAME, TOP_LEVEL_PI_NAME, TOP_LEVEL_PIID, PARENT_PI_NAME, PARENT_PIID, VALID_FROM, VALID_FROM_UTC, ACTIVITY_NAME, ACTIVITY_KIND, ACTIVITY_STATE, CONTROL_LINK_NAME, IMPL_NAME, PRINCIPAL, TERMINAL_NAME, VARIABLE_DATA, EXCEPTION_TEXT, DESCRIPTION, CORR_SET_INFO, USER_NAME, ATID, ADDITIONAL_INFO, OBJECT_META_TYPE ) AS
 SELECT db2admin.AUDIT_LOG_T.ALID, db2admin.AUDIT_LOG_T.EVENT_TIME, db2admin.AUDIT_LOG_T.EVENT_TIME_UTC, db2admin.AUDIT_LOG_T.AUDIT_EVENT, db2admin.AUDIT_LOG_T.PTID, db2admin.AUDIT_LOG_T.PIID, db2admin.AUDIT_LOG_T.AIID, db2admin.AUDIT_LOG_T.SIID, db2admin.AUDIT_LOG_T.VARIABLE_NAME, db2admin.AUDIT_LOG_T.PROCESS_TEMPL_NAME, db2admin.AUDIT_LOG_T.PROCESS_INST_NAME, db2admin.AUDIT_LOG_T.TOP_LEVEL_PI_NAME, db2admin.AUDIT_LOG_T.TOP_LEVEL_PIID, db2admin.AUDIT_LOG_T.PARENT_PI_NAME, db2admin.AUDIT_LOG_T.PARENT_PIID, db2admin.AUDIT_LOG_T.VALID_FROM, db2admin.AUDIT_LOG_T.VALID_FROM_UTC, db2admin.AUDIT_LOG_T.ACTIVITY_NAME, db2admin.AUDIT_LOG_T.ACTIVITY_KIND, db2admin.AUDIT_LOG_T.ACTIVITY_STATE, db2admin.AUDIT_LOG_T.CONTROL_LINK_NAME, db2admin.AUDIT_LOG_T.IMPL_NAME, db2admin.AUDIT_LOG_T.PRINCIPAL, db2admin.AUDIT_LOG_T.IMPL_NAME, db2admin.AUDIT_LOG_T.VARIABLE_DATA, db2admin.AUDIT_LOG_T.EXCEPTION_TEXT, db2admin.AUDIT_LOG_T.DESCRIPTION, db2admin.AUDIT_LOG_T.CORR_SET_INFO, db2admin.AUDIT_LOG_T.USER_NAME, db2admin.AUDIT_LOG_T.ATID, db2admin.AUDIT_LOG_T.ADDITIONAL_INFO, db2admin.AUDIT_LOG_T.OBJECT_META_TYPE
 FROM db2admin.AUDIT_LOG_T;

-- View: AuditLogB
CREATE VIEW db2admin.AUDIT_LOG_B(ALID, EVENT_TIME, EVENT_TIME_UTC, AUDIT_EVENT, PTID, PIID, AIID, SIID, VARIABLE_NAME, PROCESS_TEMPL_NAME, TOP_LEVEL_PIID, PARENT_PIID, VALID_FROM, VALID_FROM_UTC, ATID, ACTIVITY_NAME, ACTIVITY_KIND, ACTIVITY_STATE, CONTROL_LINK_NAME, PRINCIPAL, VARIABLE_DATA, EXCEPTION_TEXT, DESCRIPTION, CORR_SET_INFO, USER_NAME, ADDITIONAL_INFO, SNAPSHOT_ID, SNAPSHOT_NAME, PROCESS_APP_ACRONYM ) AS
 SELECT db2admin.AUDIT_LOG_T.ALID, db2admin.AUDIT_LOG_T.EVENT_TIME, db2admin.AUDIT_LOG_T.EVENT_TIME_UTC, db2admin.AUDIT_LOG_T.AUDIT_EVENT, db2admin.AUDIT_LOG_T.PTID, db2admin.AUDIT_LOG_T.PIID, db2admin.AUDIT_LOG_T.AIID, db2admin.AUDIT_LOG_T.SIID, db2admin.AUDIT_LOG_T.VARIABLE_NAME, db2admin.AUDIT_LOG_T.PROCESS_TEMPL_NAME, db2admin.AUDIT_LOG_T.TOP_LEVEL_PIID, db2admin.AUDIT_LOG_T.PARENT_PIID, db2admin.AUDIT_LOG_T.VALID_FROM, db2admin.AUDIT_LOG_T.VALID_FROM_UTC, db2admin.AUDIT_LOG_T.ATID, db2admin.AUDIT_LOG_T.ACTIVITY_NAME, db2admin.AUDIT_LOG_T.ACTIVITY_KIND, db2admin.AUDIT_LOG_T.ACTIVITY_STATE, db2admin.AUDIT_LOG_T.CONTROL_LINK_NAME, db2admin.AUDIT_LOG_T.PRINCIPAL, db2admin.AUDIT_LOG_T.VARIABLE_DATA, db2admin.AUDIT_LOG_T.EXCEPTION_TEXT, db2admin.AUDIT_LOG_T.DESCRIPTION, db2admin.AUDIT_LOG_T.CORR_SET_INFO, db2admin.AUDIT_LOG_T.USER_NAME, db2admin.AUDIT_LOG_T.ADDITIONAL_INFO, db2admin.AUDIT_LOG_T.SNAPSHOT_ID, db2admin.AUDIT_LOG_T.TERMINAL_NAME, db2admin.AUDIT_LOG_T.PROCESS_APP_ACRONYM
 FROM db2admin.AUDIT_LOG_T
 WHERE db2admin.AUDIT_LOG_T.OBJECT_META_TYPE = 1;

-- View: ApplicationComp
CREATE VIEW db2admin.APPLICATION_COMP(ACOID, BUSINESS_RELEVANCE, NAME, SUPPORT_AUTOCLAIM, SUPPORT_CLAIM_SUSP, SUPPORT_DELEGATION, SUPPORT_SUB_TASK, SUPPORT_FOLLOW_ON ) AS
 SELECT db2admin.APPLICATION_COMPONENT_T.ACOID, db2admin.APPLICATION_COMPONENT_T.BUSINESS_RELEVANCE, db2admin.APPLICATION_COMPONENT_T.NAME, db2admin.APPLICATION_COMPONENT_T.SUPPORTS_AUTO_CLAIM, db2admin.APPLICATION_COMPONENT_T.SUPPORTS_CLAIM_SUSPENDED, db2admin.APPLICATION_COMPONENT_T.SUPPORTS_DELEGATION, db2admin.APPLICATION_COMPONENT_T.SUPPORTS_SUB_TASK, db2admin.APPLICATION_COMPONENT_T.SUPPORTS_FOLLOW_ON_TASK
 FROM db2admin.APPLICATION_COMPONENT_T;

-- View: Task
CREATE VIEW db2admin.TASK(TKIID, ACTIVATED, APPLIC_DEFAULTS_ID, APPLIC_NAME, BUSINESS_RELEVANCE, COMPLETED, CONTAINMENT_CTX_ID, CTX_AUTHORIZATION, DUE, EXPIRES, FIRST_ACTIVATED, FOLLOW_ON_TKIID, IS_AD_HOC, IS_ESCALATED, IS_INLINE, IS_WAIT_FOR_SUB_TK, KIND, LAST_MODIFIED, LAST_STATE_CHANGE, NAME, NAME_SPACE, ORIGINATOR, OWNER, PARENT_CONTEXT_ID, PRIORITY, STARTED, STARTER, STATE, SUPPORT_AUTOCLAIM, SUPPORT_CLAIM_SUSP, SUPPORT_DELEGATION, SUPPORT_SUB_TASK, SUPPORT_FOLLOW_ON, HIERARCHY_POSITION, IS_CHILD, SUSPENDED, TKTID, TOP_TKIID, TYPE, RESUMES, ASSIGNMENT_TYPE, INHERITED_AUTH, INVOKED_INSTANCE_ID, INVOKED_INSTANCE_TYPE, WORK_BASKET, IS_READ, IS_TRANSFERRED_TO_WORK_BASKET, WSID_1, WSID_2, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT db2admin.TASK_INSTANCE_T.TKIID, db2admin.TASK_INSTANCE_T.ACTIVATION_TIME, db2admin.TASK_INSTANCE_T.APPLICATION_DEFAULTS_ID, db2admin.TASK_INSTANCE_T.APPLICATION_NAME, db2admin.TASK_INSTANCE_T.BUSINESS_RELEVANCE, db2admin.TASK_INSTANCE_T.COMPLETION_TIME, db2admin.TASK_INSTANCE_T.CONTAINMENT_CONTEXT_ID, db2admin.TASK_INSTANCE_T.CONTEXT_AUTHORIZATION, db2admin.TASK_INSTANCE_T.DUE_TIME, db2admin.TASK_INSTANCE_T.EXPIRATION_TIME, db2admin.TASK_INSTANCE_T.FIRST_ACTIVATION_TIME, db2admin.TASK_INSTANCE_T.FOLLOW_ON_TKIID, db2admin.TASK_INSTANCE_T.IS_AD_HOC, db2admin.TASK_INSTANCE_T.IS_ESCALATED, db2admin.TASK_INSTANCE_T.IS_INLINE, db2admin.TASK_INSTANCE_T.IS_WAITING_FOR_SUBTASK, db2admin.TASK_INSTANCE_T.KIND, db2admin.TASK_INSTANCE_T.LAST_MODIFICATION_TIME, db2admin.TASK_INSTANCE_T.LAST_STATE_CHANGE_TIME, db2admin.TASK_INSTANCE_T.NAME, db2admin.TASK_INSTANCE_T.NAMESPACE, db2admin.TASK_INSTANCE_T.ORIGINATOR, db2admin.TASK_INSTANCE_T.OWNER, db2admin.TASK_INSTANCE_T.PARENT_CONTEXT_ID, db2admin.TASK_INSTANCE_T.PRIORITY, db2admin.TASK_INSTANCE_T.START_TIME, db2admin.TASK_INSTANCE_T.STARTER, db2admin.TASK_INSTANCE_T.STATE, db2admin.TASK_INSTANCE_T.SUPPORTS_AUTO_CLAIM, db2admin.TASK_INSTANCE_T.SUPPORTS_CLAIM_SUSPENDED, db2admin.TASK_INSTANCE_T.SUPPORTS_DELEGATION, db2admin.TASK_INSTANCE_T.SUPPORTS_SUB_TASK, db2admin.TASK_INSTANCE_T.SUPPORTS_FOLLOW_ON_TASK, db2admin.TASK_INSTANCE_T.HIERARCHY_POSITION, db2admin.TASK_INSTANCE_T.IS_CHILD, db2admin.TASK_INSTANCE_T.IS_SUSPENDED, db2admin.TASK_INSTANCE_T.TKTID, db2admin.TASK_INSTANCE_T.TOP_TKIID, db2admin.TASK_INSTANCE_T.TYPE, db2admin.TASK_INSTANCE_T.RESUMES, db2admin.TASK_INSTANCE_T.ASSIGNMENT_TYPE, db2admin.TASK_INSTANCE_T.INHERITED_AUTH, db2admin.TASK_INSTANCE_T.INVOKED_INSTANCE_ID, db2admin.TASK_INSTANCE_T.INVOKED_INSTANCE_TYPE, db2admin.TASK_INSTANCE_T.WORK_BASKET, db2admin.TASK_INSTANCE_T.IS_READ, db2admin.TASK_INSTANCE_T.IS_TRANSFERRED_TO_WORK_BASKET, db2admin.TASK_INSTANCE_T.WSID_1, db2admin.TASK_INSTANCE_T.WSID_2, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT1, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT2, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT3, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT4, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT5, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT6, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT7, db2admin.TASK_INSTANCE_T.CUSTOM_TEXT8
 FROM db2admin.TASK_INSTANCE_T;

-- View: TaskTempl
CREATE VIEW db2admin.TASK_TEMPL(TKTID, APPLIC_DEFAULTS_ID, APPLIC_NAME, BUSINESS_RELEVANCE, CONTAINMENT_CTX_ID, CTX_AUTHORIZATION, DEFINITION_NAME, DEFINITION_NS, IS_AD_HOC, IS_INLINE, KIND, NAME, NAMESPACE, PRIORITY, STATE, SUPPORT_AUTOCLAIM, SUPPORT_CLAIM_SUSP, SUPPORT_DELEGATION, SUPPORT_SUB_TASK, SUPPORT_FOLLOW_ON, TYPE, VALID_FROM, AUTONOMY, ASSIGNMENT_TYPE, INHERITED_AUTH, WORK_BASKET, SNAPSHOT_ID, SNAPSHOT_NAME, TOP_LEVEL_TOOLKIT_ACRONYM, TOP_LEVEL_TOOLKIT_NAME, TRACK_NAME, PROCESS_APP_NAME, PROCESS_APP_ACRONYM, TOOLKIT_SNAPSHOT_ID, TOOLKIT_SNAPSHOT_NAME, TOOLKIT_NAME, TOOLKIT_ACRONYM, IS_TIP, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8 ) AS
 SELECT db2admin.TASK_TEMPLATE_T.TKTID, db2admin.TASK_TEMPLATE_T.APPLICATION_DEFAULTS_ID, db2admin.TASK_TEMPLATE_T.APPLICATION_NAME, db2admin.TASK_TEMPLATE_T.BUSINESS_RELEVANCE, db2admin.TASK_TEMPLATE_T.CONTAINMENT_CONTEXT_ID, db2admin.TASK_TEMPLATE_T.CONTEXT_AUTHORIZATION, db2admin.TASK_TEMPLATE_T.DEFINITION_NAME, db2admin.TASK_TEMPLATE_T.TARGET_NAMESPACE, db2admin.TASK_TEMPLATE_T.IS_AD_HOC, db2admin.TASK_TEMPLATE_T.IS_INLINE, db2admin.TASK_TEMPLATE_T.KIND, db2admin.TASK_TEMPLATE_T.NAME, db2admin.TASK_TEMPLATE_T.NAMESPACE, db2admin.TASK_TEMPLATE_T.PRIORITY, db2admin.TASK_TEMPLATE_T.STATE, db2admin.TASK_TEMPLATE_T.SUPPORTS_AUTO_CLAIM, db2admin.TASK_TEMPLATE_T.SUPPORTS_CLAIM_SUSPENDED, db2admin.TASK_TEMPLATE_T.SUPPORTS_DELEGATION, db2admin.TASK_TEMPLATE_T.SUPPORTS_SUB_TASK, db2admin.TASK_TEMPLATE_T.SUPPORTS_FOLLOW_ON_TASK, db2admin.TASK_TEMPLATE_T.TYPE, db2admin.TASK_TEMPLATE_T.VALID_FROM, db2admin.TASK_TEMPLATE_T.AUTONOMY, db2admin.TASK_TEMPLATE_T.ASSIGNMENT_TYPE, db2admin.TASK_TEMPLATE_T.INHERITED_AUTH, db2admin.TASK_TEMPLATE_T.WORK_BASKET, db2admin.PC_VERSION_TEMPLATE_T.SNAPSHOT_ID, db2admin.PC_VERSION_TEMPLATE_T.SNAPSHOT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_ACRONYM, db2admin.PC_VERSION_TEMPLATE_T.TOP_LEVEL_TOOLKIT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TRACK_NAME, db2admin.PC_VERSION_TEMPLATE_T.PROCESS_APP_NAME, db2admin.PC_VERSION_TEMPLATE_T.PROCESS_APP_ACRONYM, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_ID, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_SNAPSHOT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_NAME, db2admin.PC_VERSION_TEMPLATE_T.TOOLKIT_ACRONYM, db2admin.PC_VERSION_TEMPLATE_T.IS_TIP, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT1, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT2, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT3, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT4, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT5, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT6, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT7, db2admin.TASK_TEMPLATE_T.CUSTOM_TEXT8
 FROM db2admin.TASK_TEMPLATE_T LEFT JOIN db2admin.PC_VERSION_TEMPLATE_T ON (db2admin.PC_VERSION_TEMPLATE_T.CONTAINMENT_CONTEXT_ID = db2admin.TASK_TEMPLATE_T.TKTID);

-- View: Escalation
CREATE VIEW db2admin.ESCALATION(ESIID, ACTION, ACTIVATION_STATE, ACTIVATION_TIME, ESCALATION_TIME, AT_LEAST_EXP_STATE, ESTID, FIRST_ESIID, INCREASE_PRIORITY, NAME, STATE, TKIID, WSID_1, WSID_2 ) AS
 SELECT db2admin.ESCALATION_INSTANCE_T.ESIID, db2admin.ESCALATION_INSTANCE_T.ACTION, db2admin.ESCALATION_INSTANCE_T.ACTIVATION_STATE, db2admin.ESCALATION_INSTANCE_T.ACTIVATION_TIME, db2admin.ESCALATION_INSTANCE_T.ESCALATION_TIME, db2admin.ESCALATION_INSTANCE_T.AT_LEAST_EXPECTED_STATE, db2admin.ESCALATION_INSTANCE_T.ESTID, db2admin.ESCALATION_INSTANCE_T.FIRST_ESIID, db2admin.ESCALATION_INSTANCE_T.INCREASE_PRIORITY, db2admin.ESCALATION_INSTANCE_T.NAME, db2admin.ESCALATION_INSTANCE_T.STATE, db2admin.ESCALATION_INSTANCE_T.TKIID, db2admin.ESCALATION_INSTANCE_T.WSID_1, db2admin.ESCALATION_INSTANCE_T.WSID_2
 FROM db2admin.ESCALATION_INSTANCE_T;

-- View: EscTempl
CREATE VIEW db2admin.ESC_TEMPL(ESTID, FIRST_ESTID, PREVIOUS_ESTID, TKTID, CONTAINMENT_CTX_ID, NAME, ACTIVATION_STATE, AT_LEAST_EXP_STATE, INCREASE_PRIORITY, ACTION ) AS
 SELECT db2admin.ESCALATION_TEMPLATE_T.ESTID, db2admin.ESCALATION_TEMPLATE_T.FIRST_ESTID, db2admin.ESCALATION_TEMPLATE_T.PREVIOUS_ESTID, db2admin.ESCALATION_TEMPLATE_T.TKTID, db2admin.ESCALATION_TEMPLATE_T.CONTAINMENT_CONTEXT_ID, db2admin.ESCALATION_TEMPLATE_T.NAME, db2admin.ESCALATION_TEMPLATE_T.ACTIVATION_STATE, db2admin.ESCALATION_TEMPLATE_T.AT_LEAST_EXPECTED_STATE, db2admin.ESCALATION_TEMPLATE_T.INCREASE_PRIORITY, db2admin.ESCALATION_TEMPLATE_T.ACTION
 FROM db2admin.ESCALATION_TEMPLATE_T;

-- View: EscTemplDesc
CREATE VIEW db2admin.ESC_TEMPL_DESC(ESTID, LOCALE, TKTID, DISPLAY_NAME, DESCRIPTION ) AS
 SELECT db2admin.ESC_TEMPL_LDESC_T.ESTID, db2admin.ESC_TEMPL_LDESC_T.LOCALE, db2admin.ESC_TEMPL_LDESC_T.TKTID, db2admin.ESC_TEMPL_LDESC_T.DISPLAY_NAME, db2admin.ESC_TEMPL_LDESC_T.DESCRIPTION
 FROM db2admin.ESC_TEMPL_LDESC_T;

-- View: TaskTemplCProp
CREATE VIEW db2admin.TASK_TEMPL_CPROP(TKTID, NAME, DATA_TYPE, STRING_VALUE ) AS
 SELECT db2admin.TASK_TEMPL_CPROP_T.TKTID, db2admin.TASK_TEMPL_CPROP_T.NAME, db2admin.TASK_TEMPL_CPROP_T.DATA_TYPE, db2admin.TASK_TEMPL_CPROP_T.STRING_VALUE
 FROM db2admin.TASK_TEMPL_CPROP_T;

-- View: EscTemplCProp
CREATE VIEW db2admin.ESC_TEMPL_CPROP(ESTID, NAME, TKTID, DATA_TYPE, VALUE ) AS
 SELECT db2admin.ESC_TEMPL_CPROP_T.ESTID, db2admin.ESC_TEMPL_CPROP_T.NAME, db2admin.ESC_TEMPL_CPROP_T.TKTID, db2admin.ESC_TEMPL_CPROP_T.DATA_TYPE, db2admin.ESC_TEMPL_CPROP_T.STRING_VALUE
 FROM db2admin.ESC_TEMPL_CPROP_T;

-- View: TaskTemplDesc
CREATE VIEW db2admin.TASK_TEMPL_DESC(TKTID, LOCALE, DESCRIPTION, DISPLAY_NAME ) AS
 SELECT db2admin.TASK_TEMPL_LDESC_T.TKTID, db2admin.TASK_TEMPL_LDESC_T.LOCALE, db2admin.TASK_TEMPL_LDESC_T.DESCRIPTION, db2admin.TASK_TEMPL_LDESC_T.DISPLAY_NAME
 FROM db2admin.TASK_TEMPL_LDESC_T;

-- View: TaskCProp
CREATE VIEW db2admin.TASK_CPROP(TKIID, NAME, DATA_TYPE, STRING_VALUE, WSID_1, WSID_2 ) AS
 SELECT db2admin.TASK_INST_CPROP_T.TKIID, db2admin.TASK_INST_CPROP_T.NAME, db2admin.TASK_INST_CPROP_T.DATA_TYPE, db2admin.TASK_INST_CPROP_T.STRING_VALUE, db2admin.TASK_INST_CPROP_T.WSID_1, db2admin.TASK_INST_CPROP_T.WSID_2
 FROM db2admin.TASK_INST_CPROP_T;

-- View: TaskDesc
CREATE VIEW db2admin.TASK_DESC(TKIID, LOCALE, DESCRIPTION, DISPLAY_NAME, WSID_1, WSID_2 ) AS
 SELECT db2admin.TASK_INST_LDESC_T.TKIID, db2admin.TASK_INST_LDESC_T.LOCALE, db2admin.TASK_INST_LDESC_T.DESCRIPTION, db2admin.TASK_INST_LDESC_T.DISPLAY_NAME, db2admin.TASK_INST_LDESC_T.WSID_1, db2admin.TASK_INST_LDESC_T.WSID_2
 FROM db2admin.TASK_INST_LDESC_T;

-- View: EscalationCProp
CREATE VIEW db2admin.ESCALATION_CPROP(ESIID, NAME, DATA_TYPE, STRING_VALUE, WSID_1, WSID_2 ) AS
 SELECT db2admin.ESC_INST_CPROP_T.ESIID, db2admin.ESC_INST_CPROP_T.NAME, db2admin.ESC_INST_CPROP_T.DATA_TYPE, db2admin.ESC_INST_CPROP_T.STRING_VALUE, db2admin.ESC_INST_CPROP_T.WSID_1, db2admin.ESC_INST_CPROP_T.WSID_2
 FROM db2admin.ESC_INST_CPROP_T;

-- View: TaskHistory
CREATE VIEW db2admin.TASK_HISTORY(TKIID, ESIID, PARENT_TKIID, EVENT, REASON, EVENT_TIME, NEXT_TIME, PRINCIPAL, WORK_ITEM_KIND, FROM_ID, TO_ID, WSID_1, WSID_2 ) AS
 SELECT db2admin.TASK_HISTORY_T.TKIID, db2admin.TASK_HISTORY_T.ESIID, db2admin.TASK_HISTORY_T.PARENT_TKIID, db2admin.TASK_HISTORY_T.EVENT, db2admin.TASK_HISTORY_T.REASON, db2admin.TASK_HISTORY_T.EVENT_TIME, db2admin.TASK_HISTORY_T.NEXT_TIME, db2admin.TASK_HISTORY_T.PRINCIPAL, db2admin.TASK_HISTORY_T.WORK_ITEM_KIND, db2admin.TASK_HISTORY_T.FROM_ID, db2admin.TASK_HISTORY_T.TO_ID, db2admin.TASK_HISTORY_T.WSID_1, db2admin.TASK_HISTORY_T.WSID_2
 FROM db2admin.TASK_HISTORY_T;

-- View: EscalationDesc
CREATE VIEW db2admin.ESCALATION_DESC(ESIID, LOCALE, DESCRIPTION, DISPLAY_NAME, WSID_1, WSID_2 ) AS
 SELECT db2admin.ESC_INST_LDESC_T.ESIID, db2admin.ESC_INST_LDESC_T.LOCALE, db2admin.ESC_INST_LDESC_T.DESCRIPTION, db2admin.ESC_INST_LDESC_T.DISPLAY_NAME, db2admin.ESC_INST_LDESC_T.WSID_1, db2admin.ESC_INST_LDESC_T.WSID_2
 FROM db2admin.ESC_INST_LDESC_T;

-- View: TaskAuditLog
CREATE VIEW db2admin.TASK_AUDIT_LOG(ALID, AUDIT_EVENT, CONTAINMENT_CTX_ID, ESIID, ESTID, EVENT_TIME, FAULT_NAME, FAULT_TYPE_NAME, FAULT_NAME_SPACE, FOLLOW_ON_TKIID, NAME, NAMESPACE, NEW_USER, OLD_USER, PARENT_CONTEXT_ID, PARENT_TASK_NAME, PARENT_TASK_NAMESP, PARENT_TKIID, PRINCIPAL, TASK_KIND, TASK_STATE, TKIID, TKTID, TOP_TKIID, VAILD_FROM, WORK_ITEM_REASON, USERS, DESCRIPTION, MESSAGE_DATA, SNAPSHOT_ID, SNAPSHOT_NAME, PROCESS_APP_ACRONYM ) AS
 SELECT db2admin.TASK_AUDIT_LOG_T.ALID, db2admin.TASK_AUDIT_LOG_T.AUDIT_EVENT, db2admin.TASK_AUDIT_LOG_T.CONTAINMENT_CONTEXT_ID, db2admin.TASK_AUDIT_LOG_T.ESIID, db2admin.TASK_AUDIT_LOG_T.ESTID, db2admin.TASK_AUDIT_LOG_T.EVENT_TIME_UTC, db2admin.TASK_AUDIT_LOG_T.FAULT_NAME, db2admin.TASK_AUDIT_LOG_T.FAULT_TYPE_NAME, db2admin.TASK_AUDIT_LOG_T.FAULT_NAMESPACE, db2admin.TASK_AUDIT_LOG_T.FOLLOW_ON_TKIID, db2admin.TASK_AUDIT_LOG_T.NAME, db2admin.TASK_AUDIT_LOG_T.NAMESPACE, db2admin.TASK_AUDIT_LOG_T.NEW_USER, db2admin.TASK_AUDIT_LOG_T.OLD_USER, db2admin.TASK_AUDIT_LOG_T.PARENT_CONTEXT_ID, db2admin.TASK_AUDIT_LOG_T.PARENT_TASK_NAME, db2admin.TASK_AUDIT_LOG_T.PARENT_TASK_NAMESPACE, db2admin.TASK_AUDIT_LOG_T.PARENT_TKIID, db2admin.TASK_AUDIT_LOG_T.PRINCIPAL, db2admin.TASK_AUDIT_LOG_T.TASK_KIND, db2admin.TASK_AUDIT_LOG_T.TASK_STATE, db2admin.TASK_AUDIT_LOG_T.TKIID, db2admin.TASK_AUDIT_LOG_T.TKTID, db2admin.TASK_AUDIT_LOG_T.TOP_TKIID, db2admin.TASK_AUDIT_LOG_T.VALID_FROM_UTC, db2admin.TASK_AUDIT_LOG_T.WI_REASON, db2admin.TASK_AUDIT_LOG_T.USERS, db2admin.TASK_AUDIT_LOG_T.DESCRIPTION, db2admin.TASK_AUDIT_LOG_T.MESSAGE_DATA, db2admin.TASK_AUDIT_LOG_T.SNAPSHOT_ID, db2admin.TASK_AUDIT_LOG_T.SNAPSHOT_NAME, db2admin.TASK_AUDIT_LOG_T.PROCESS_APP_ACRONYM
 FROM db2admin.TASK_AUDIT_LOG_T;

-- View: WorkBasket
CREATE VIEW db2admin.WORK_BASKET(WBID, NAME, TYPE, OWNER, DEFAULT_QUERY_TABLE, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8, CREATED, LAST_MODIFIED, WSID_1, WSID_2 ) AS
 SELECT db2admin.WORK_BASKET_T.WBID, db2admin.WORK_BASKET_T.NAME, db2admin.WORK_BASKET_T.TYPE, db2admin.WORK_BASKET_T.OWNER, db2admin.WORK_BASKET_T.DEFAULT_QUERY_TABLE, db2admin.WORK_BASKET_T.CUSTOM_TEXT1, db2admin.WORK_BASKET_T.CUSTOM_TEXT2, db2admin.WORK_BASKET_T.CUSTOM_TEXT3, db2admin.WORK_BASKET_T.CUSTOM_TEXT4, db2admin.WORK_BASKET_T.CUSTOM_TEXT5, db2admin.WORK_BASKET_T.CUSTOM_TEXT6, db2admin.WORK_BASKET_T.CUSTOM_TEXT7, db2admin.WORK_BASKET_T.CUSTOM_TEXT8, db2admin.WORK_BASKET_T.CREATION_TIME, db2admin.WORK_BASKET_T.LAST_MODIFICATION_TIME, db2admin.WORK_BASKET_T.WSID_1, db2admin.WORK_BASKET_T.WSID_2
 FROM db2admin.WORK_BASKET_T;

-- View: WorkBasketLDesc
CREATE VIEW db2admin.WORK_BASKET_LDESC(WBID, LOCALE, DISPLAY_NAME, DESCRIPTION, WSID_1, WSID_2 ) AS
 SELECT db2admin.WORK_BASKET_LDESC_T.WBID, db2admin.WORK_BASKET_LDESC_T.LOCALE, db2admin.WORK_BASKET_LDESC_T.DISPLAY_NAME, db2admin.WORK_BASKET_LDESC_T.DESCRIPTION, db2admin.WORK_BASKET_LDESC_T.WSID_1, db2admin.WORK_BASKET_LDESC_T.WSID_2
 FROM db2admin.WORK_BASKET_LDESC_T;

-- View: WorkBasketDistTarget
CREATE VIEW db2admin.WORK_BASKET_DIST_TARGET(WBID, NAME, TYPE, OWNER, DEFAULT_QUERY_TABLE, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8, CREATED, LAST_MODIFIED, SOURCE_WBID, WSID_1, WSID_2 ) AS
 SELECT db2admin.WORK_BASKET_DIST_TARGET_T.TARGET_WBID, db2admin.WORK_BASKET_T.NAME, db2admin.WORK_BASKET_T.TYPE, db2admin.WORK_BASKET_T.OWNER, db2admin.WORK_BASKET_T.DEFAULT_QUERY_TABLE, db2admin.WORK_BASKET_T.CUSTOM_TEXT1, db2admin.WORK_BASKET_T.CUSTOM_TEXT2, db2admin.WORK_BASKET_T.CUSTOM_TEXT3, db2admin.WORK_BASKET_T.CUSTOM_TEXT4, db2admin.WORK_BASKET_T.CUSTOM_TEXT5, db2admin.WORK_BASKET_T.CUSTOM_TEXT6, db2admin.WORK_BASKET_T.CUSTOM_TEXT7, db2admin.WORK_BASKET_T.CUSTOM_TEXT8, db2admin.WORK_BASKET_T.CREATION_TIME, db2admin.WORK_BASKET_T.LAST_MODIFICATION_TIME, db2admin.WORK_BASKET_DIST_TARGET_T.SOURCE_WBID, db2admin.WORK_BASKET_T.WSID_1, db2admin.WORK_BASKET_T.WSID_2
 FROM db2admin.WORK_BASKET_DIST_TARGET_T, db2admin.WORK_BASKET_T
 WHERE db2admin.WORK_BASKET_T.WBID = db2admin.WORK_BASKET_DIST_TARGET_T.TARGET_WBID;

-- View: BusinessCategory
CREATE VIEW db2admin.BUSINESS_CATEGORY(BCID, PARENT_BCID, NAME, PRIORITY, DEFAULT_QUERY_TABLE, CUSTOM_TEXT1, CUSTOM_TEXT2, CUSTOM_TEXT3, CUSTOM_TEXT4, CUSTOM_TEXT5, CUSTOM_TEXT6, CUSTOM_TEXT7, CUSTOM_TEXT8, CREATED, LAST_MODIFIED, WSID_1, WSID_2 ) AS
 SELECT db2admin.BUSINESS_CATEGORY_T.BCID, db2admin.BUSINESS_CATEGORY_T.PARENT_BCID, db2admin.BUSINESS_CATEGORY_T.NAME, db2admin.BUSINESS_CATEGORY_T.PRIORITY, db2admin.BUSINESS_CATEGORY_T.DEFAULT_QUERY_TABLE, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT1, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT2, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT3, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT4, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT5, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT6, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT7, db2admin.BUSINESS_CATEGORY_T.CUSTOM_TEXT8, db2admin.BUSINESS_CATEGORY_T.CREATION_TIME, db2admin.BUSINESS_CATEGORY_T.LAST_MODIFICATION_TIME, db2admin.BUSINESS_CATEGORY_T.WSID_1, db2admin.BUSINESS_CATEGORY_T.WSID_2
 FROM db2admin.BUSINESS_CATEGORY_T;

-- View: BusinessCategoryLDesc
CREATE VIEW db2admin.BUSINESS_CATEGORY_LDESC(BCID, LOCALE, DISPLAY_NAME, DESCRIPTION, WSID_1, WSID_2 ) AS
 SELECT db2admin.BUSINESS_CATEGORY_LDESC_T.BCID, db2admin.BUSINESS_CATEGORY_LDESC_T.LOCALE, db2admin.BUSINESS_CATEGORY_LDESC_T.DISPLAY_NAME, db2admin.BUSINESS_CATEGORY_LDESC_T.DESCRIPTION, db2admin.BUSINESS_CATEGORY_LDESC_T.WSID_1, db2admin.BUSINESS_CATEGORY_LDESC_T.WSID_2
 FROM db2admin.BUSINESS_CATEGORY_LDESC_T;


-- start import scheduler DDL: createSchemaDB2.ddl


CREATE TABLE db2admin."SCHED_TASK" ("TASKID" BIGINT NOT NULL ,
              "VERSION" VARCHAR(5) NOT NULL ,
              "ROW_VERSION" INTEGER NOT NULL ,
              "TASKTYPE" INTEGER NOT NULL ,
              "TASKSUSPENDED" SMALLINT NOT NULL ,
              "CANCELLED" SMALLINT NOT NULL ,
              "NEXTFIRETIME" BIGINT NOT NULL ,
              "STARTBYINTERVAL" VARCHAR(254) ,
              "STARTBYTIME" BIGINT ,
              "VALIDFROMTIME" BIGINT ,
              "VALIDTOTIME" BIGINT ,
              "REPEATINTERVAL" VARCHAR(254) ,
              "MAXREPEATS" INTEGER NOT NULL ,
              "REPEATSLEFT" INTEGER NOT NULL ,
              "TASKINFO" BLOB(102400) LOGGED NOT COMPACT ,
              "NAME" VARCHAR(254) NOT NULL ,
              "AUTOPURGE" INTEGER NOT NULL ,
              "FAILUREACTION" INTEGER ,
              "MAXATTEMPTS" INTEGER ,
              "QOS" INTEGER ,
              "PARTITIONID" INTEGER ,
              "OWNERTOKEN" VARCHAR(200) NOT NULL ,
              "CREATETIME" BIGINT NOT NULL ) ;

ALTER TABLE db2admin."SCHED_TASK" ADD PRIMARY KEY ("TASKID");

CREATE INDEX db2admin."SCHED_TASK_IDX1" ON db2admin."SCHED_TASK" ("TASKID",
              "OWNERTOKEN") ;

CREATE INDEX db2admin."SCHED_TASK_IDX2" ON db2admin."SCHED_TASK" ("NEXTFIRETIME" ASC,
               "REPEATSLEFT",
               "PARTITIONID") CLUSTER;

CREATE TABLE db2admin."SCHED_TREG" ("REGKEY" VARCHAR(254) NOT NULL ,
              "REGVALUE" VARCHAR(254) );

ALTER TABLE db2admin."SCHED_TREG" ADD PRIMARY KEY ("REGKEY");

CREATE TABLE db2admin."SCHED_LMGR" (LEASENAME VARCHAR(254) NOT NULL,
               LEASEOWNER VARCHAR(254) NOT NULL,
               LEASE_EXPIRE_TIME  BIGINT,
              DISABLED VARCHAR(5));

ALTER TABLE db2admin."SCHED_LMGR" ADD PRIMARY KEY ("LEASENAME");

CREATE TABLE db2admin."SCHED_LMPR" (LEASENAME VARCHAR(254) NOT NULL,
              NAME VARCHAR(254) NOT NULL,
              VALUE VARCHAR(254) NOT NULL);

CREATE INDEX db2admin."SCHED_LMPR_IDX1" ON db2admin."SCHED_LMPR" (LEASENAME,
               NAME);

-- end import scheduler DDL: createSchemaDB2.ddl

-- BEGIN COPYRIGHT
-- *************************************************************************
-- 
--  Licensed Materials - Property of IBM
--  5725-C94, 5725-C95, 5725-C96
--  (C) Copyright IBM Corporation 2006, 2013. All Rights Reserved.
--  US Government Users Restricted Rights- Use, duplication or disclosure
--  restricted by GSA ADP Schedule Contract with IBM Corp.
-- 
-- *************************************************************************
-- END COPYRIGHT

CREATE TABLE db2admin.PERSISTENTLOCK (
  LOCKID INTEGER NOT NULL,
  SEQUENCEID INTEGER NOT NULL,
  OWNER INTEGER NOT NULL,
  MODULENAME VARCHAR(250),
  COMPNAME VARCHAR(250),
  METHOD VARCHAR(250),
  MSGHANDLESTRING VARCHAR(128))
  ;

ALTER TABLE db2admin.PERSISTENTLOCK
  ADD CONSTRAINT PK_PERSISTENTLOCK PRIMARY KEY (LOCKID, SEQUENCEID)
  ;
  
   
  -- *******************************************
  -- create table FailedEvents and indexes
  -- *******************************************
  CREATE TABLE db2admin.FailedEvents
    (MsgId			VARCHAR (255) NOT NULL,
     Destination_Module_Name	VARCHAR (255),
     Destination_Component_Name	VARCHAR (255),
     Destination_Method_Name	VARCHAR (255),
     Source_Module_Name		VARCHAR (255),
     Source_Component_Name	VARCHAR (255),
     ResubmitDestination		VARCHAR (512),
     InteractionType		VARCHAR (128),
     ExceptionDetails		VARCHAR (1024),
     SessionId			VARCHAR (255),
     CorrelationId		VARCHAR (255),
     DeploymentTarget		VARCHAR (200),
     FailureTime			TIMESTAMP NOT NULL,
     Status			INTEGER NOT NULL,
     EsQualified			SMALLINT,
     EventType		VARCHAR (10))
     ;
  
  ALTER TABLE db2admin.FailedEvents
     ADD CONSTRAINT PK_FailedEvents PRIMARY KEY (MsgId)
     ;
  
  CREATE INDEX db2admin.INX_FEDest ON db2admin.FailedEvents
    (Destination_Module_Name,
     Destination_Component_Name,
     Destination_Method_Name)
     ;
  
  CREATE INDEX db2admin.INX_FESrc ON db2admin.FailedEvents
    (Source_Module_Name,
     Source_Component_Name)
     ;
  
  CREATE INDEX db2admin.INX_FESID ON db2admin.FailedEvents (SessionId)
  ;
  
  CREATE INDEX db2admin.INX_FEFTime ON db2admin.FailedEvents (FailureTime)
  ;
  
  CREATE INDEX db2admin.INX_FEESQualified ON db2admin.FailedEvents (EsQualified)
  ;
  
  CREATE INDEX db2admin.INX_FEEventType ON db2admin.FailedEvents (EventType)
  ;
  
  
  -- *******************************************
  -- create table FailedEventBOTypes and indexes
  -- *******************************************
  CREATE TABLE db2admin.FailedEventBOTypes
    (MsgId		VARCHAR (255) NOT NULL,
     BOType		VARCHAR (255) NOT NULL,
     Argument_Position	INTEGER NOT NULL)
     ;
  
  ALTER TABLE db2admin.FailedEventBOTypes
     ADD CONSTRAINT PK_FailedEventBO PRIMARY KEY (MsgId, Argument_Position)
     ;
  
  ALTER TABLE db2admin.FailedEventBOTypes
     ADD CONSTRAINT FK_FailedEventBO FOREIGN KEY (MsgId) REFERENCES db2admin.FailedEvents(MsgId)
     ;
 
  CREATE INDEX db2admin.FailedEventBOTp ON db2admin.FailedEventBOTypes (BOType)
  ;
  
  -- *******************************************
  -- create table FailedEventMessage and indexes
  -- *******************************************
  CREATE TABLE db2admin.FailedEventMessage
    (MsgId		VARCHAR (255) NOT NULL,
     JserviceMessage	BLOB (1G))
     ;
  
  ALTER TABLE db2admin.FailedEventMessage
     ADD CONSTRAINT PK_FailedEventMSG PRIMARY KEY (MsgId)
     ;
  
  ALTER TABLE db2admin.FailedEventMessage
     ADD CONSTRAINT FK_FailedEventMSG FOREIGN KEY (MsgId) REFERENCES db2admin.FailedEvents(MsgId)
     ;
  
  -- *******************************************
  -- create table FailedEventDetail and indexes
  -- *******************************************
  CREATE TABLE db2admin.FailedEventDetail
    (MsgId		VARCHAR (255) NOT NULL,
     Message		BLOB(1G),
     Parameters		BLOB(1G),
     ExceptionDetail	BLOB(10M),
     WrapperType          SMALLINT,
     ApplicationName	VARCHAR(255),
     CEITraceControl	VARCHAR(255),
     UserIdentity		VARCHAR(128),
     ExpirationTime	TIMESTAMP)
     ;
  
  ALTER TABLE db2admin.FailedEventDetail
     ADD CONSTRAINT PK_FailedEventDTL PRIMARY KEY (MsgId)
     ;
  
  ALTER TABLE db2admin.FailedEventDetail
   ADD CONSTRAINT FK_FailedEventDTL FOREIGN KEY (MsgId) REFERENCES db2admin.FailedEvents(MsgId)
   ;
