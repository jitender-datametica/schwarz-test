CREATE TABLE CORE.T_DIM_RVM_CLEANING_STATUS (
	CLEANING_STATUS_CD VARCHAR(50) NOT NULL COMMENT 'The code for the cleaning status',
	CLEANING_STATUS_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the cleaning status in German',
	CLEANING_STATUS_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the cleaning status in English',
	CLEANING_STATUS_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the cleaning status in German',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_RVM_CLEANING_STATUS PRIMARY KEY (CLEANING_STATUS_CD)
)COMMENT='This minor dimension defines the cleaning status of deposit machines'
;