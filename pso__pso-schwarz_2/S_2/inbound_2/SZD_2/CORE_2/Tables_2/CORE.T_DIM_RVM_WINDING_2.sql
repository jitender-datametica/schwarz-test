CREATE TABLE CORE.T_DIM_RVM_WINDING_2 (
	RVM_WINDING_CD VARCHAR(50) NOT NULL COMMENT 'The code for the deposit machine background system winding',
	RVM_WINDING_DESCR VARCHAR(250) NOT NULL COMMENT 'The textual default description for the deposit machine background system winding in German',
	RVM_WINDING_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'The textual description for the deposit machine background system winding in German',
	RVM_WINDING_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'The textual description for the deposit machine background system winding in English',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_RVM_WINDING PRIMARY KEY (RVM_WINDING_CD)
)COMMENT='This minor dimension defines the winding of a reusable background system e.g. straight'
;