create or replace TABLE SZD_PRODUCTION.ETL.T_DIM_RVM_WINDING_TEMP_1 (
	RVM_WINDING_CD VARCHAR(16777216) NOT NULL COMMENT 'The code for the deposit machine background system winding',
	RVM_WINDING_DESCR VARCHAR(100) NOT NULL COMMENT 'The textual default description for the deposit machine background system winding in German',
	RVM_WINDING_DESCR_DE VARCHAR(100) NOT NULL COMMENT 'The textual description for the deposit machine background system winding in German',
	RVM_WINDING_DESCR_EN VARCHAR(100) NOT NULL COMMENT 'The textual description for the deposit machine background system winding in English',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	constraint PK_T_DIM_RVM_WINDING primary key (RVM_WINDING_CD)
);