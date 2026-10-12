CREATE TABLE ETL_PROCESS.T_ETL_BRICK_ATTRIBUTE_1 (
	ATTRIBUTE_INTERNAL_CD VARCHAR(20) NOT NULL,
	ATTRIBUTE_EXTERNAL_CD VARCHAR(20),
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_ETL_BRICK_ATTRIBUTE PRIMARY KEY (ATTRIBUTE_INTERNAL_CD)
)COMMENT='This ETL table to support brickcode .'
;