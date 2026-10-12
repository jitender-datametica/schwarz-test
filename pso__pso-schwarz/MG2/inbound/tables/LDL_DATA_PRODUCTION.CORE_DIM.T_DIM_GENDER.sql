create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_GENDER (
	GENDER_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the gender.',
	GENDER_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the gender. (Name in group language, i.e. in German)',
	GENDER_NAME_DE VARCHAR(100) COMMENT 'The name for the gender. (Name in German)',
	GENDER_NAME_EN VARCHAR(100) COMMENT 'The name for the gender. (Name in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_GENDER primary key (GENDER_CD)
)COMMENT='This minor dimension defines the gender of a person. (i.e. male / female / ...)'
;