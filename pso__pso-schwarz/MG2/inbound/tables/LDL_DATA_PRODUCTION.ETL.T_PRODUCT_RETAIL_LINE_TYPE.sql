create or replace TABLE LDL_DATA_PRODUCTION.ETL.T_PRODUCT_RETAIL_LINE_TYPE (
	PROD_RETAIL_LINE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for product retail lines.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_RETAIL_LINE_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for product retail lines.',
	constraint PK_T_PRODUCT_RETAIL_LINE_TYPE primary key (PROD_RETAIL_LINE_TYPE_CD, LANG_CD)
);