create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_INTRASTAT_CLASS (
	INTRASTAT_NR VARCHAR(20) NOT NULL COMMENT 'The Intrastat number which identifies a certain class of products.',
	INTRASTAT_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the Intrastat number.',
	PARENT_INTRASTAT_NR VARCHAR(20) COMMENT 'Intrastat numbers form a hierarchy. This is the upper level element in the hierarchy.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_INTRASTAT_CLASS primary key (INTRASTAT_NR)
)COMMENT='This minor entity contains the product classification codes according to Intrastat. (EU regulation 638/2004)'
;