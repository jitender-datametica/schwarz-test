CREATE TABLE CORE.T_DIM_RVM_PACK_TYPE_1 (
	RVM_PACK_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the deposit machine background system packtype',
	RVM_PACK_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the deposit machine background system packtype in English.',
	RVM_PACK_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textua defaultl description for the deposit machine background system packtype in German.',
	RVM_PACK_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the deposit machine background system packtype in German.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_RVM_PACK_TYPE PRIMARY KEY (RVM_PACK_TYPE_CD)
)COMMENT='This minor dimension defines the packtype of a reusable background system e.g. Dualsort'
;