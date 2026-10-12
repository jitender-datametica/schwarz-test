CREATE TABLE CORE.T_DIM_RVM_CLEANING_TYPE_1 (
	CLEANING_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the cleaning type',
	CLEANING_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A  textual default description for the cleaning type in German',
	CLEANING_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the cleaning type in English',
	CLEANING_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A  textual description for the cleaning type in German',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_RVM_CLEANING_TYPE PRIMARY KEY (CLEANING_TYPE_CD)
)COMMENT='This minor dimension defines the cleaning type of deposit machines'
;