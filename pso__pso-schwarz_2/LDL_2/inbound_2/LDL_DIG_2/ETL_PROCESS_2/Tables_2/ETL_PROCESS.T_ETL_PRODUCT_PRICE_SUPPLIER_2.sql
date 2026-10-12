CREATE TABLE ETL_PROCESS.T_ETL_PRODUCT_PRICE_SUPPLIER_2 (
	CONDITION_NUMBER_CD VARCHAR(20),
	PURCH_ORG_TYPE_CD VARCHAR(20) NOT NULL,
	SUPPLIER_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for supplier_2',
	PROD_VARIANT_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant',
	PRICE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'Code of type of the price - IVP , regular VKP ( standard price) , promotion/campaign price , etc',
	PRICE_GROUP_CD VARCHAR(20) COMMENT 'Code of pricing group - internal or customer facing',
	ACTIVE_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The first date from when this record became valid from a business perspective,',
	ACTIVE_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The last date up to when this record was valid from a business perspective,',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	DWH_SRC_FILE_NAME VARCHAR(255) NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
	SRC_FILE_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
	CONSTRAINT PK_T_ETL_PRODUCT_PRICE_SUPPLIER PRIMARY KEY (PURCH_ORG_TYPE_CD, PROD_VARIANT_SID, SUPPLIER_SID, PRICE_TYPE_CD, ACTIVE_FROM_TMSP)
)COMMENT='ETL Support table -  fact for prices on supplier_2 level (Purchase price, Additional freight costs, etc)'
;