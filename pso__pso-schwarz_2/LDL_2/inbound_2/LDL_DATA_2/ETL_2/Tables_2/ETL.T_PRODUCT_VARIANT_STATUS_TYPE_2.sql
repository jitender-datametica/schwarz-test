CREATE TABLE ETL.T_PRODUCT_VARIANT_STATUS_TYPE_2 (
	PROD_VARIANT_STATUS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The numeric identifier for the lifecycle status_2 for product variants.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_VARIANT_STATUS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status_2 for product variants.',
	CONSTRAINT PK_T_PRODUCT_VARIANT_STATUS_TYPE PRIMARY KEY (PROD_VARIANT_STATUS_TYPE_CD, LANG_CD)
);
