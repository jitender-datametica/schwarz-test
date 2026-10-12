create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_RVM_ACTIVITY_INFORMATION_1 (
	RVM_ACTIVE_ID NUMBER(38,0) NOT NULL COMMENT 'The id showing the activity state of the deposit machine.',
	RVM_ACTIVE_NAME VARCHAR(100) NOT NULL COMMENT 'A textual default description for the activity state of a deposit machine in German.',
	RVM_ACTIVE_NAME_EN VARCHAR(100) NOT NULL COMMENT 'A textual description for the activity state of a deposit machine in English.',
	RVM_ACTIVE_NAME_DE VARCHAR(100) NOT NULL COMMENT 'A textual description for the activity state of a deposit machine in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	SRC_1_TMSP TIMESTAMP_TZ(9) NOT NULL COMMENT 'The identifier for the first source the table refers to.',
	constraint PK_T_DIM_RVM_ACTIVITY_INFORMATION primary key (RVM_ACTIVE_ID)
)COMMENT='This minor dimension describes the activity state of the Deposit Machine.'
;