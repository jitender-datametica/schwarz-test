create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_DIM_BRAND_1 (
	BRAND_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for brand_1',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	BRAND_NR VARCHAR(20) COMMENT 'Account_1 number of brand_1 from the source system',
	BRAND_NAME VARCHAR(100) COMMENT 'Full company name of the brand_1',
	BRAND_CLASS_CD VARCHAR(5) COMMENT 'The code for the indicating if product is classified as a Lidl own brand_1 or not',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	constraint PK_T_DIM_BRAND primary key (BRAND_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Brand_1 '
;