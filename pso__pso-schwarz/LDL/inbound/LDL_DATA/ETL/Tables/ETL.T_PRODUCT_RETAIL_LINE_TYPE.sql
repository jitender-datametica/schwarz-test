CREATE TABLE ETL.T_PRODUCT_RETAIL_LINE_TYPE (
	PROD_RETAIL_LINE_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the subtype discriminator for product retail lines.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_RETAIL_LINE_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the subtype discriminator for product retail lines.',
	CONSTRAINT PK_T_PRODUCT_RETAIL_LINE_TYPE PRIMARY KEY (PROD_RETAIL_LINE_TYPE_CD, LANG_CD)
);
