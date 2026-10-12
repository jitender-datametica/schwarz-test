create or replace TABLE LDL_DIG_PRODUCTION.ETL_PROCESS.T_ETL_PRODUCT_VARIANT_REL_2 (
	PRIMARY_SRC_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the primary source system.',
	PRIMARY_PROD_VARIANT_NR VARCHAR(100) NOT NULL COMMENT 'Product variant number from the primary source.',
	SECONDARY_SRC_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the secondary source system.',
	SECONDARY_PROD_VARIANT_NR VARCHAR(100) NOT NULL COMMENT 'Product variant number from the secondary source.',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source table',
	constraint PK_T_ETL_PRODUCT_VARIANT_REL primary key (PRIMARY_SRC_NAME, PRIMARY_PROD_VARIANT_NR, SECONDARY_SRC_NAME, SECONDARY_PROD_VARIANT_NR)
)COMMENT='An ETL table that relates natural keys for product variants (prod_variant_nr) between different source systems.'
;