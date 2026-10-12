CREATE TABLE CORE.T_DIM_PRODUCT_BRICK_CODE_LVL1_2 (
	PROD_GS1_LVL1_BRICK_CD VARCHAR(40) NOT NULL COMMENT 'The code of the first/highest/least granular level of the GS1 article categorization system.  ',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	PROD_GS1_LVL1_BRICK_DESCR VARCHAR(250) COMMENT 'Textual representation of the first/highest/least granular level of the GS1 article categorization system.  ',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	CONSTRAINT PK_T_DIM_PRODUCT_BRICK_CODE_LVL1 PRIMARY KEY (PROD_GS1_LVL1_BRICK_CD, DWH_VALID_FROM_TMSP)
)COMMENT='This minor dimension defines the brickcode , that is a unique standardized code of all categories in the GS1 article categorization system on level 4 and is maintained for every article in SAP. '
;