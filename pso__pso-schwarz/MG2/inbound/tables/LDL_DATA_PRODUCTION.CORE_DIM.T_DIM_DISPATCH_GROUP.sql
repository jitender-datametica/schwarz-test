create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_DISPATCH_GROUP (
	DISPATCH_GRP_NR VARCHAR(20) NOT NULL COMMENT 'The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.',
	COUNTRY_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the country organization.',
	DISPATCH_GRP_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the dispatch group. (Description in group language, i.e. in German)',
	DISPATCH_GRP_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the dispatch group. (Description in German)',
	DISPATCH_GRP_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the dispatch group. (Description in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_DISPATCH_GROUP primary key (DISPATCH_GRP_NR, COUNTRY_ORG_SID)
)COMMENT='A dispatch group defines a group of products which are handled together in the logistics process.'
;