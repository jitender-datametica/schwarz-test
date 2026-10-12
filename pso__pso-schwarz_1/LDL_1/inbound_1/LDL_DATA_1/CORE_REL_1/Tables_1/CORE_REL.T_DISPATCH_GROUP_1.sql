
/* --------------------------------------------------------------------------------
   DDL for table: t_dispatch_group_1
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:43
*/ --------------------------------------------------------------------------------
CREATE TABLE CORE_REL.T_DISPATCH_GROUP_1 
(DISPATCH_GRP_NR VARCHAR(20) NOT NULL COMMENT 'The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.',
INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	DISPATCH_GRP_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the dispatch group.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	CONSTRAINT PK_T_DISPATCH_GROUP PRIMARY KEY (DISPATCH_GRP_NR, INT_ORG_SID, LANG_CD)
)COMMENT='A dispatch group defines a group of products which are handled together in the logistics process.';