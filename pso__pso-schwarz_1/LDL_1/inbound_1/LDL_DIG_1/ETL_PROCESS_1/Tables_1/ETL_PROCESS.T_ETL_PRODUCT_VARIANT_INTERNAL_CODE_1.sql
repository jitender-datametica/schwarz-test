CREATE TABLE ETL_PROCESS.T_ETL_PRODUCT_VARIANT_INTERNAL_CODE_1 (
	PROD_VARIANT_INTERNAL_CD VARCHAR(20) NOT NULL COMMENT 'prod_variant_internal_cd',
	PROD_VARIANT_CD VARCHAR(20) COMMENT 'prod_variant_cd',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_ETL_PRODUCT_VARIANT_INTERNAL_CODE PRIMARY KEY (PROD_VARIANT_INTERNAL_CD)
)COMMENT='This ETL table to support brickcode .'
;