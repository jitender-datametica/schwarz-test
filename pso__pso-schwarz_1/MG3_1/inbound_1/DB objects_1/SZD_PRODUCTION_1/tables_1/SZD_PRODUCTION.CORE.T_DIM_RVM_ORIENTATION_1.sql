create or replace TABLE SZD_PRODUCTION.CORE.T_DIM_RVM_ORIENTATION_1 (
	RVM_ORIENTATION_CD VARCHAR(50) NOT NULL COMMENT 'The code for the deposit machine background system orientation',
	RVM_ORIENTATION_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the deposit machine background system orientation in English.',
	RVM_ORIENTATION_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the deposit machine background system orientation in German.',
	RVM_ORIENTATION_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the deposit machine background system orientation in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_RVM_ORIENTATION primary key (RVM_ORIENTATION_CD)
)COMMENT='This minor dimension defines the orientation of a reusable background system e.g. left'
;