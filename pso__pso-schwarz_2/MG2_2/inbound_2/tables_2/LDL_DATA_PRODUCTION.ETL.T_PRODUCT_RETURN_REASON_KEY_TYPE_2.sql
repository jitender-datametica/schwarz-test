create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_RETURN_REASON_KEY_TYPE_2 (
	PROD_RETURN_REASON_KEY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the type of natural key which identifies the Product Return Reason.',
	PROD_RETURN_REASON_KEY_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the type of natural key which identifies the Product Return Reason.',
	PROD_RETURN_REASON_KEY_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
	constraint PK_T_PRODUCT_RETURN_REASON_KEY_TYPE primary key (PROD_RETURN_REASON_KEY_TYPE_CD)
);