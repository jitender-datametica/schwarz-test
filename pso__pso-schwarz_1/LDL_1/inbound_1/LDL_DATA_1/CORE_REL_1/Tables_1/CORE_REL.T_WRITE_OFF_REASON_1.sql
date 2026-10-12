CREATE  TABLE CORE_REL.T_WRITE_OFF_REASON_1 (
	WRITE_OFF_REASON_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier for the reason why products are written off.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	WRITE_OFF_REASON_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the reason why products are written off.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
	CONSTRAINT PK_T_WRITE_OFF_REASON PRIMARY KEY (WRITE_OFF_REASON_ID, LANG_CD)
)COMMENT='This minor entity defines the reason why products are written off.'
;