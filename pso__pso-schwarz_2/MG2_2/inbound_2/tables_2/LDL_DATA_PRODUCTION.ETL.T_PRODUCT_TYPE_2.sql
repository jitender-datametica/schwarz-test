create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_TYPE_2 (
	PROD_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for products.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the discriminator for products.',
	constraint PK_T_PRODUCT_TYPE primary key (PROD_TYPE_CD, LANG_CD)
);