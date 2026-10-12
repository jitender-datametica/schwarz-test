create or replace TABLE LDL_DIG_PRODUCTION.CORE.T_REL_PRODUCT_ADDITIONAL_NUMBER_2 (
	PROD_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product',
	PROD_ADD_NR_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The type of of industry and lidl product numbers assigned (gtin, ean_2, producer numbers etc )',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	DWH_VALID_FG BOOLEAN NOT NULL COMMENT 'An indicator showing the current record in history.',
	PROD_ADD_NR VARCHAR(20) NOT NULL COMMENT 'A product number ( ean_2 , gtin , producer number , etc)',
	IS_MAIN_FG BOOLEAN NOT NULL COMMENT 'Flag indicating if number is considered as main at a given point in time',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	SRC_TABLE_NAME VARCHAR(100) COMMENT 'The name of the source tables',
	DWH_SRC_FILE_NAME VARCHAR(255) COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
	PROD_NR VARCHAR(20) COMMENT 'The number for internal onlineshop product, which is country_2 independent',
	constraint PK_T_REL_PRODUCT_ADDITIONAL_NUMBER primary key (PROD_SID, PROD_ADD_NR_TYPE_CD, DWH_VALID_FROM_TMSP, PROD_ADD_NR)
)COMMENT='A list of industry and lidl product numbers assigned to a product ( including gtin, ean_2 and producer numbers).'
;