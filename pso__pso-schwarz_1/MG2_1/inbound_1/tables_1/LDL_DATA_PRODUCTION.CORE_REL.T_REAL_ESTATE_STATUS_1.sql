create or replace TABLE LDL_DATA_PRODUCTION.CORE_REL.T_REAL_ESTATE_STATUS_1 (
	REAL_ESTATE_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
	REAL_ESTATE_STATUS_CATEG_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the kind of status_1 lifecycle for real estate objects.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
	REAL_ESTATE_STATUS_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status_1 for real estate objects. The status_1 code is related to a given status_1 category.',
	REAL_ESTATE_STATUS_REASON_CD VARCHAR(20) COMMENT 'The code identifying the reason why the status_1 of a real estate object has changed.',
	COMMENT_TXT VARCHAR(1000) COMMENT 'A free text comment further detailing the status_1 and/or the reason for the status_1 change.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	constraint PK_T_REAL_ESTATE_STATUS primary key (REAL_ESTATE_SID, REAL_ESTATE_STATUS_CATEG_CD, DWH_VALID_FROM_TMSP)
)COMMENT='This entity tracks the lifecycle status_1 of a real estate object.'
;