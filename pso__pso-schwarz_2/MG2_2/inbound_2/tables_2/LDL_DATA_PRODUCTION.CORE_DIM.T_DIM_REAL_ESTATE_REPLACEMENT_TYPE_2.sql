create or replace TABLE LDL_DATA_PRODUCTION.CORE_DIM.T_DIM_REAL_ESTATE_REPLACEMENT_TYPE_2 (
	REAL_ESTATE_REPLACEMENT_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.',
	REAL_ESTATE_REPLACEMENT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the way, how a real estate object can replace another object. (Description in group language, i.e. in German)',
	REAL_ESTATE_REPLACEMENT_TYPE_DESCR_DE VARCHAR(250) COMMENT 'A textual description for the way, how a real estate object can replace another object. (Description in German)',
	REAL_ESTATE_REPLACEMENT_TYPE_DESCR_EN VARCHAR(250) COMMENT 'A textual description for the way, how a real estate object can replace another object. (Description in English)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_DIM_REAL_ESTATE_REPLACEMENT_TYPE primary key (REAL_ESTATE_REPLACEMENT_TYPE_CD)
)COMMENT='This minor dimension defines the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.'
;