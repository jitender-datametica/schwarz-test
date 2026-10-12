CREATE TABLE ETL.T_PRODUCT_GROUP_TYPE (
	PROD_GRP_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminator for product groups.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	PROD_GRP_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the discriminator for product groups.',
	CONSTRAINT PK_T_PRODUCT_GROUP_TYPE PRIMARY KEY (PROD_GRP_TYPE_CD, LANG_CD)
);
