CREATE TABLE ETL.T_PRODUCT_VARIANT_KEY_TYPE_2 (
	PROD_VARIANT_KEY_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the type of natural key which identifies the Product VARIANT.',
	PROD_VARIANT_KEY_TYPE_NAME VARCHAR(100) NOT NULL COMMENT 'The name of the type of natural key which identifies the Product VARIANT.',
	PROD_VARIANT_KEY_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
	CONSTRAINT PK_T_PROD_VARIANT_KEY_TYPE PRIMARY KEY (PROD_VARIANT_KEY_TYPE_CD)
);
